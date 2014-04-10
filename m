From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 2/3] kvm: s390: make cmma usage conditionally
Date: Thu, 10 Apr 2014 13:16:43 +0200
Message-ID: <1397128604-50161-3-git-send-email-borntraeger@de.ibm.com>
References: <1397128604-50161-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1397128604-50161-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Dominik Dingel <dingel@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Dominik Dingel <dingel@linux.vnet.ibm.com>

When userspace reset the guest without notifying kvm, the CMMA state
of the pages might be unused, resulting in guest data corruption.
To avoid this, CMMA must be enabled only if userspace understands
the implications.

CMMA must be enabled before vCPU creation. It can't be switched off
once enabled.  All subsequently created vCPUs will be enabled for
CMMA according to the CMMA state of the VM.

Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  1 +
 arch/s390/kvm/kvm-s390.c         | 59 +++++++++++++++++++++++++---------------
 arch/s390/kvm/kvm-s390.h         |  7 +++--
 arch/s390/kvm/priv.c             |  2 +-
 4 files changed, 44 insertions(+), 25 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index a993b6f..b61ac41 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -288,6 +288,7 @@ struct kvm_arch{
 	struct gmap *gmap;
 	int css_support;
 	int use_irqchip;
+	int use_cmma;
 	struct s390_io_adapter *adapters[MAX_S390_IO_ADAPTERS];
 };
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index c335a2e..fc2fe49 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -437,9 +437,8 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 	if (kvm_is_ucontrol(vcpu->kvm))
 		gmap_free(vcpu->arch.gmap);
 
-	if (vcpu->arch.sie_block->cbrlo)
-		__free_page(__pfn_to_page(
-				vcpu->arch.sie_block->cbrlo >> PAGE_SHIFT));
+	if (kvm_s390_cmma_enabled(vcpu->kvm))
+		kvm_s390_vcpu_unsetup_cmma(vcpu);
 	free_page((unsigned long)(vcpu->arch.sie_block));
 
 	kvm_vcpu_uninit(vcpu);
@@ -553,9 +552,26 @@ int kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+void kvm_s390_vcpu_unsetup_cmma(struct kvm_vcpu *vcpu)
+{
+	free_page(vcpu->arch.sie_block->cbrlo);
+	vcpu->arch.sie_block->cbrlo = 0;
+}
+
+int kvm_s390_vcpu_setup_cmma(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.sie_block->cbrlo = get_zeroed_page(GFP_KERNEL);
+	if (!vcpu->arch.sie_block->cbrlo)
+		return -ENOMEM;
+
+	vcpu->arch.sie_block->ecb2 |= 0x80;
+	vcpu->arch.sie_block->ecb2 &= ~0x08;
+	return 0;
+}
+
 int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 {
-	struct page *cbrl;
+	int rc = 0;
 
 	atomic_set(&vcpu->arch.sie_block->cpuflags, CPUSTAT_ZARCH |
 						    CPUSTAT_SM |
@@ -569,13 +585,10 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 	vcpu->arch.sie_block->eca   = 0xC1002001U;
 	vcpu->arch.sie_block->fac   = (int) (long) vfacilities;
 	vcpu->arch.sie_block->ictl |= ICTL_ISKE | ICTL_SSKE | ICTL_RRBE;
-	if (kvm_enabled_cmma()) {
-		cbrl = alloc_page(GFP_KERNEL | __GFP_ZERO);
-		if (cbrl) {
-			vcpu->arch.sie_block->ecb2 |= 0x80;
-			vcpu->arch.sie_block->ecb2 &= ~0x08;
-			vcpu->arch.sie_block->cbrlo = page_to_phys(cbrl);
-		}
+	if (kvm_s390_cmma_enabled(vcpu->kvm)) {
+		rc = kvm_s390_vcpu_setup_cmma(vcpu);
+		if (rc)
+			return rc;
 	}
 	hrtimer_init(&vcpu->arch.ckc_timer, CLOCK_REALTIME, HRTIMER_MODE_ABS);
 	tasklet_init(&vcpu->arch.tasklet, kvm_s390_tasklet,
@@ -583,7 +596,7 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 	vcpu->arch.ckc_timer.function = kvm_s390_idle_wakeup;
 	get_cpu_id(&vcpu->arch.cpu_id);
 	vcpu->arch.cpu_id.version = 0xff;
-	return 0;
+	return rc;
 }
 
 struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm,
@@ -890,6 +903,18 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
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
@@ -1072,16 +1097,6 @@ static int vcpu_post_run(struct kvm_vcpu *vcpu, int exit_reason)
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
index 3c1e227..460ccd8 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -158,8 +158,11 @@ void s390_vcpu_block(struct kvm_vcpu *vcpu);
 void s390_vcpu_unblock(struct kvm_vcpu *vcpu);
 void exit_sie(struct kvm_vcpu *vcpu);
 void exit_sie_sync(struct kvm_vcpu *vcpu);
-/* are we going to support cmma? */
-bool kvm_enabled_cmma(void);
+int kvm_s390_vcpu_setup_cmma(struct kvm_vcpu *vcpu);
+void kvm_s390_vcpu_unsetup_cmma(struct kvm_vcpu *vcpu);
+/* is cmma enabled */
+bool kvm_s390_cmma_enabled(struct kvm *kvm);
+
 /* implemented in diag.c */
 int kvm_s390_handle_diag(struct kvm_vcpu *vcpu);
 
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 8a63e99..9a04d74 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -656,7 +656,7 @@ static int handle_essa(struct kvm_vcpu *vcpu)
 	VCPU_EVENT(vcpu, 5, "cmma release %d pages", entries);
 	gmap = vcpu->arch.gmap;
 	vcpu->stat.instruction_essa++;
-	if (!kvm_enabled_cmma() || !vcpu->arch.sie_block->cbrlo)
+	if (!kvm_s390_cmma_enabled(vcpu->kvm))
 		return kvm_s390_inject_program_int(vcpu, PGM_OPERATION);
 
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
-- 
1.8.4.2
