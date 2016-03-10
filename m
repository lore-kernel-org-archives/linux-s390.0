From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 3/9] KVM: s390: abstract access to the VCPU cpu timer
Date: Thu, 10 Mar 2016 16:36:53 +0100
Message-ID: <1457624219-110920-4-git-send-email-borntraeger@de.ibm.com>
References: <1457624219-110920-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1457624219-110920-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

We want to manually step the cpu timer in certain scenarios in the future.
Let's abstract any access to the cpu timer, so we can hide the complexity
internally.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c |  5 +++--
 arch/s390/kvm/kvm-s390.c  | 31 +++++++++++++++++++++++--------
 arch/s390/kvm/kvm-s390.h  |  2 ++
 3 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 87e2d1a..4604e9a 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -182,8 +182,9 @@ static int cpu_timer_interrupts_enabled(struct kvm_vcpu *vcpu)
 
 static int cpu_timer_irq_pending(struct kvm_vcpu *vcpu)
 {
-	return (vcpu->arch.sie_block->cputm >> 63) &&
-	       cpu_timer_interrupts_enabled(vcpu);
+	if (!cpu_timer_interrupts_enabled(vcpu))
+		return 0;
+	return kvm_s390_get_cpu_timer(vcpu) >> 63;
 }
 
 static inline int is_ioirq(unsigned long irq_type)
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index bd5edb1..2118a22 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1429,6 +1429,18 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+/* set the cpu timer - may only be called from the VCPU thread itself */
+void kvm_s390_set_cpu_timer(struct kvm_vcpu *vcpu, __u64 cputm)
+{
+	vcpu->arch.sie_block->cputm = cputm;
+}
+
+/* get the cpu timer - can also be called from other VCPU threads */
+__u64 kvm_s390_get_cpu_timer(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.sie_block->cputm;
+}
+
 void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	/* Save host register state */
@@ -1476,7 +1488,7 @@ static void kvm_s390_vcpu_initial_reset(struct kvm_vcpu *vcpu)
 	vcpu->arch.sie_block->gpsw.mask = 0UL;
 	vcpu->arch.sie_block->gpsw.addr = 0UL;
 	kvm_s390_set_prefix(vcpu, 0);
-	vcpu->arch.sie_block->cputm     = 0UL;
+	kvm_s390_set_cpu_timer(vcpu, 0);
 	vcpu->arch.sie_block->ckc       = 0UL;
 	vcpu->arch.sie_block->todpr     = 0;
 	memset(vcpu->arch.sie_block->gcr, 0, 16 * sizeof(__u64));
@@ -1723,7 +1735,7 @@ static int kvm_arch_vcpu_ioctl_get_one_reg(struct kvm_vcpu *vcpu,
 			     (u64 __user *)reg->addr);
 		break;
 	case KVM_REG_S390_CPU_TIMER:
-		r = put_user(vcpu->arch.sie_block->cputm,
+		r = put_user(kvm_s390_get_cpu_timer(vcpu),
 			     (u64 __user *)reg->addr);
 		break;
 	case KVM_REG_S390_CLOCK_COMP:
@@ -1761,6 +1773,7 @@ static int kvm_arch_vcpu_ioctl_set_one_reg(struct kvm_vcpu *vcpu,
 					   struct kvm_one_reg *reg)
 {
 	int r = -EINVAL;
+	__u64 val;
 
 	switch (reg->id) {
 	case KVM_REG_S390_TODPR:
@@ -1772,8 +1785,9 @@ static int kvm_arch_vcpu_ioctl_set_one_reg(struct kvm_vcpu *vcpu,
 			     (u64 __user *)reg->addr);
 		break;
 	case KVM_REG_S390_CPU_TIMER:
-		r = get_user(vcpu->arch.sie_block->cputm,
-			     (u64 __user *)reg->addr);
+		r = get_user(val, (u64 __user *)reg->addr);
+		if (!r)
+			kvm_s390_set_cpu_timer(vcpu, val);
 		break;
 	case KVM_REG_S390_CLOCK_COMP:
 		r = get_user(vcpu->arch.sie_block->ckc,
@@ -2290,7 +2304,7 @@ static void sync_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 		kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
 	}
 	if (kvm_run->kvm_dirty_regs & KVM_SYNC_ARCH0) {
-		vcpu->arch.sie_block->cputm = kvm_run->s.regs.cputm;
+		kvm_s390_set_cpu_timer(vcpu, kvm_run->s.regs.cputm);
 		vcpu->arch.sie_block->ckc = kvm_run->s.regs.ckc;
 		vcpu->arch.sie_block->todpr = kvm_run->s.regs.todpr;
 		vcpu->arch.sie_block->pp = kvm_run->s.regs.pp;
@@ -2312,7 +2326,7 @@ static void store_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 	kvm_run->psw_addr = vcpu->arch.sie_block->gpsw.addr;
 	kvm_run->s.regs.prefix = kvm_s390_get_prefix(vcpu);
 	memcpy(&kvm_run->s.regs.crs, &vcpu->arch.sie_block->gcr, 128);
-	kvm_run->s.regs.cputm = vcpu->arch.sie_block->cputm;
+	kvm_run->s.regs.cputm = kvm_s390_get_cpu_timer(vcpu);
 	kvm_run->s.regs.ckc = vcpu->arch.sie_block->ckc;
 	kvm_run->s.regs.todpr = vcpu->arch.sie_block->todpr;
 	kvm_run->s.regs.pp = vcpu->arch.sie_block->pp;
@@ -2383,7 +2397,7 @@ int kvm_s390_store_status_unloaded(struct kvm_vcpu *vcpu, unsigned long gpa)
 	unsigned char archmode = 1;
 	freg_t fprs[NUM_FPRS];
 	unsigned int px;
-	u64 clkcomp;
+	u64 clkcomp, cputm;
 	int rc;
 
 	px = kvm_s390_get_prefix(vcpu);
@@ -2417,8 +2431,9 @@ int kvm_s390_store_status_unloaded(struct kvm_vcpu *vcpu, unsigned long gpa)
 			      &vcpu->run->s.regs.fpc, 4);
 	rc |= write_guest_abs(vcpu, gpa + __LC_TOD_PROGREG_SAVE_AREA,
 			      &vcpu->arch.sie_block->todpr, 4);
+	cputm = kvm_s390_get_cpu_timer(vcpu);
 	rc |= write_guest_abs(vcpu, gpa + __LC_CPU_TIMER_SAVE_AREA,
-			      &vcpu->arch.sie_block->cputm, 8);
+			      &cputm, 8);
 	clkcomp = vcpu->arch.sie_block->ckc >> 8;
 	rc |= write_guest_abs(vcpu, gpa + __LC_CLOCK_COMP_SAVE_AREA,
 			      &clkcomp, 8);
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 1c756c7..9787299 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -263,6 +263,8 @@ int kvm_s390_vcpu_setup_cmma(struct kvm_vcpu *vcpu);
 void kvm_s390_vcpu_unsetup_cmma(struct kvm_vcpu *vcpu);
 unsigned long kvm_s390_fac_list_mask_size(void);
 extern unsigned long kvm_s390_fac_list_mask[];
+void kvm_s390_set_cpu_timer(struct kvm_vcpu *vcpu, __u64 cputm);
+__u64 kvm_s390_get_cpu_timer(struct kvm_vcpu *vcpu);
 
 /* implemented in diag.c */
 int kvm_s390_handle_diag(struct kvm_vcpu *vcpu);
-- 
2.5.0
