From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 1/5] KVM: s390: make cmma usage conditionally
Date: Wed,  2 Apr 2014 11:24:44 +0200
Message-ID: <1396430688-53629-2-git-send-email-borntraeger@de.ibm.com>
References: <1396430688-53629-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1396430688-53629-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Dominik Dingel <dingel@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Dominik Dingel <dingel@linux.vnet.ibm.com>

Old userspace versions could reset the guest, without notifying kvm,
which could result in a cmma state unknow to the guest, resulting
in data corruption. Lets only enable CMMA if userspace understands
when it needs to reset the usage state.

CMMA should be enabled on vCPU creation, if it is already enabled
for the complete vm, if this fails, the creation should fail, to
be sure we have a consistent state.

Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
[Remove now unnecessary calls to page_table_reset_pgste]
---
 arch/s390/include/asm/kvm_host.h |  1 +
 arch/s390/kvm/diag.c             |  6 ---
 arch/s390/kvm/kvm-s390.c         | 60 +++++++++++++++++++-----------
 arch/s390/kvm/kvm-s390.h         |  6 ++-
 arch/s390/kvm/priv.c             | 80 ++++++++++++++++++++--------------------
 5 files changed, 84 insertions(+), 69 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index da93b6e..9f2f45d 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -290,6 +290,7 @@ struct kvm_arch{
 	struct gmap *gmap;
 	int css_support;
 	int use_irqchip;
+	int use_cmma;
 	struct s390_io_adapter *adapters[MAX_S390_IO_ADAPTERS];
 	struct kvm_s390_config *cfg;
 };
diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index 08dfc83..ff768f1 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -167,17 +167,11 @@ static int __diag_ipl_functions(struct kvm_vcpu *vcpu)
 
 	VCPU_EVENT(vcpu, 5, "diag ipl functions, subcode %lx", subcode);
 	switch (subcode) {
-	case 0:
-	case 1:
-		page_table_reset_pgste(current->mm, 0, TASK_SIZE);
-		return -EOPNOTSUPP;
 	case 3:
 		vcpu->run->s390_reset_flags = KVM_S390_RESET_CLEAR;
-		page_table_reset_pgste(current->mm, 0, TASK_SIZE);
 		break;
 	case 4:
 		vcpu->run->s390_reset_flags = 0;
-		page_table_reset_pgste(current->mm, 0, TASK_SIZE);
 		break;
 	default:
 		return -EOPNOTSUPP;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 4504015..fcb1c32 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -340,9 +340,8 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 	if (kvm_is_ucontrol(vcpu->kvm))
 		gmap_free(vcpu->arch.gmap);
 
-	if (vcpu->arch.sie_block->cbrlo)
-		__free_page(__pfn_to_page(
-				vcpu->arch.sie_block->cbrlo >> PAGE_SHIFT));
+	if (kvm_s390_cmma_enabled(vcpu->kvm))
+		kvm_s390_vcpu_unsetup_cmma(vcpu);
 	free_page((unsigned long)(vcpu->arch.sie_block));
 
 	kvm_vcpu_uninit(vcpu);
@@ -457,10 +456,31 @@ int kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
+void kvm_s390_vcpu_unsetup_cmma(struct kvm_vcpu *vcpu)
+{
+	if (vcpu->arch.sie_block->cbrlo) {
+		__free_page(__pfn_to_page(vcpu->arch.sie_block->cbrlo >>
+					  PAGE_SHIFT));
+		vcpu->arch.sie_block->cbrlo = 0;
+	}
+}
+
+bool kvm_s390_vcpu_activate_cmma(struct kvm_vcpu *vcpu)
 {
 	struct page *cbrl;
 
+	vcpu->arch.sie_block->ecb2 |= 0x80;
+	vcpu->arch.sie_block->ecb2 &= ~0x08;
+	cbrl = alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (!cbrl)
+		return false;
+
+	vcpu->arch.sie_block->cbrlo = page_to_phys(cbrl);
+	return true;
+}
+
+int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
+{
 	atomic_set(&vcpu->arch.sie_block->cpuflags, CPUSTAT_ZARCH |
 						    CPUSTAT_SM |
 						    CPUSTAT_STOPPED |
@@ -472,13 +492,9 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 	vcpu->arch.sie_block->ecb2  = 8;
 	vcpu->arch.sie_block->eca   = 0xC1002001U;
 	vcpu->arch.sie_block->fac   = (int) (long) vfacilities;
-	if (kvm_enabled_cmma()) {
-		cbrl = alloc_page(GFP_KERNEL | __GFP_ZERO);
-		if (cbrl) {
-			vcpu->arch.sie_block->ecb2 |= 0x80;
-			vcpu->arch.sie_block->ecb2 &= ~0x08;
-			vcpu->arch.sie_block->cbrlo = page_to_phys(cbrl);
-		}
+	if (kvm_s390_cmma_enabled(vcpu->kvm)) {
+		if (!kvm_s390_vcpu_activate_cmma(vcpu))
+			return -ENOMEM;
 	}
 	hrtimer_init(&vcpu->arch.ckc_timer, CLOCK_REALTIME, HRTIMER_MODE_ABS);
 	tasklet_init(&vcpu->arch.tasklet, kvm_s390_tasklet,
@@ -793,6 +809,18 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 	return -EINVAL; /* not implemented yet */
 }
 
+bool kvm_s390_cmma_enabled(struct kvm *kvm)
+{
+	if (!MACHINE_IS_LPAR)
+		return false;
+	/* only enable for z10 and later */
+	if (!MACHINE_HAS_EDAT1)
+		return false;
+	if (!kvm->arch.use_cmma)
+		return false;
+	return true;
+}
+
 static int kvm_s390_handle_requests(struct kvm_vcpu *vcpu)
 {
 	/*
@@ -975,16 +1003,6 @@ static int vcpu_post_run(struct kvm_vcpu *vcpu, int exit_reason)
 	return rc;
 }
 
-bool kvm_enabled_cmma(void)
-{
-	if (!MACHINE_IS_LPAR)
-		return false;
-	/* only enable for z10 and later */
-	if (!MACHINE_HAS_EDAT1)
-		return false;
-	return true;
-}
-
 static int __vcpu_run(struct kvm_vcpu *vcpu)
 {
 	int rc, exit_reason;
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 50185a3..bc66c45 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -158,8 +158,10 @@ void s390_vcpu_block(struct kvm_vcpu *vcpu);
 void s390_vcpu_unblock(struct kvm_vcpu *vcpu);
 void exit_sie(struct kvm_vcpu *vcpu);
 void exit_sie_sync(struct kvm_vcpu *vcpu);
-/* are we going to support cmma? */
-bool kvm_enabled_cmma(void);
+bool kvm_s390_vcpu_activate_cmma(struct kvm_vcpu *vcpu);
+void kvm_s390_vcpu_unsetup_cmma(struct kvm_vcpu *vcpu);
+/* is cmma enabled */
+bool kvm_s390_cmma_enabled(struct kvm *kvm);
 /* implemented in diag.c */
 int kvm_s390_handle_diag(struct kvm_vcpu *vcpu);
 
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 4e5fba5..8f5e111 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -558,6 +558,46 @@ static int handle_epsw(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+static int handle_essa(struct kvm_vcpu *vcpu)
+{
+	/* entries expected to be 1FF */
+	int entries = (vcpu->arch.sie_block->cbrlo & ~PAGE_MASK) >> 3;
+	unsigned long *cbrlo, cbrle;
+	struct gmap *gmap;
+	int i;
+
+	VCPU_EVENT(vcpu, 5, "cmma release %d pages", entries);
+	gmap = vcpu->arch.gmap;
+	vcpu->stat.instruction_essa++;
+	if (!kvm_s390_cmma_enabled(vcpu->kvm))
+		return kvm_s390_inject_program_int(vcpu, PGM_OPERATION);
+
+	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
+		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
+
+	if (((vcpu->arch.sie_block->ipb & 0xf0000000) >> 28) > 6)
+		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
+
+	/* Rewind PSW to repeat the ESSA instruction */
+	vcpu->arch.sie_block->gpsw.addr =
+		__rewind_psw(vcpu->arch.sie_block->gpsw, 4);
+	vcpu->arch.sie_block->cbrlo &= PAGE_MASK;	/* reset nceo */
+	cbrlo = phys_to_virt(vcpu->arch.sie_block->cbrlo);
+	down_read(&gmap->mm->mmap_sem);
+	for (i = 0; i < entries; ++i) {
+		cbrle = cbrlo[i];
+		if (unlikely(cbrle & ~PAGE_MASK || cbrle < 2 * PAGE_SIZE))
+			/* invalid entry */
+			break;
+		/* try to free backing */
+		__gmap_zap(cbrle, gmap);
+	}
+	up_read(&gmap->mm->mmap_sem);
+	if (i < entries)
+		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
+	return 0;
+}
+
 #define PFMF_RESERVED   0xfffc0101UL
 #define PFMF_SK         0x00020000UL
 #define PFMF_CF         0x00010000UL
@@ -635,46 +675,6 @@ static int handle_pfmf(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-static int handle_essa(struct kvm_vcpu *vcpu)
-{
-	/* entries expected to be 1FF */
-	int entries = (vcpu->arch.sie_block->cbrlo & ~PAGE_MASK) >> 3;
-	unsigned long *cbrlo, cbrle;
-	struct gmap *gmap;
-	int i;
-
-	VCPU_EVENT(vcpu, 5, "cmma release %d pages", entries);
-	gmap = vcpu->arch.gmap;
-	vcpu->stat.instruction_essa++;
-	if (!kvm_enabled_cmma() || !vcpu->arch.sie_block->cbrlo)
-		return kvm_s390_inject_program_int(vcpu, PGM_OPERATION);
-
-	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
-		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
-
-	if (((vcpu->arch.sie_block->ipb & 0xf0000000) >> 28) > 6)
-		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
-
-	/* Rewind PSW to repeat the ESSA instruction */
-	vcpu->arch.sie_block->gpsw.addr =
-		__rewind_psw(vcpu->arch.sie_block->gpsw, 4);
-	vcpu->arch.sie_block->cbrlo &= PAGE_MASK;	/* reset nceo */
-	cbrlo = phys_to_virt(vcpu->arch.sie_block->cbrlo);
-	down_read(&gmap->mm->mmap_sem);
-	for (i = 0; i < entries; ++i) {
-		cbrle = cbrlo[i];
-		if (unlikely(cbrle & ~PAGE_MASK || cbrle < 2 * PAGE_SIZE))
-			/* invalid entry */
-			break;
-		/* try to free backing */
-		__gmap_zap(cbrle, gmap);
-	}
-	up_read(&gmap->mm->mmap_sem);
-	if (i < entries)
-		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
-	return 0;
-}
-
 static const intercept_handler_t b9_handlers[256] = {
 	[0x8d] = handle_epsw,
 	[0xab] = handle_essa,
-- 
1.8.4.2
