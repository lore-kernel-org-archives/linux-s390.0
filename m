From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 14 Mar 2018 19:28:50 +0000
Subject: [GIT PULL 02/10] KVM: s390: Refactor host cmma and pfmfi interpretation controls
Message-Id: <20180314192858.172855-3-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Janosch Frank <frankja@linux.vnet.ibm.com>

use_cmma in kvm_arch means that the KVM hypervisor is allowed to use
cmma, whereas use_cmma in the mm context means cmm has been used before.
Let's rename the context one to uses_cmm, as the vm does use
collaborative memory management but the host uses the cmm assist
(interpretation facility).

Also let's introduce use_pfmfi, so we can remove the pfmfi disablement
when we activate cmma and rather not activate it in the first place.

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Message-Id: <1518779775-256056-2-git-send-email-frankja@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h    |  1 +
 arch/s390/include/asm/mmu.h         |  4 ++--
 arch/s390/include/asm/mmu_context.h |  2 +-
 arch/s390/kvm/kvm-s390.c            | 23 ++++++++++++-----------
 arch/s390/kvm/priv.c                |  4 ++--
 5 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index afb0f08b8021..27918b15a8ba 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -792,6 +792,7 @@ struct kvm_arch{
 	int css_support;
 	int use_irqchip;
 	int use_cmma;
+	int use_pfmfi;
 	int user_cpu_state_ctrl;
 	int user_sigp;
 	int user_stsi;
diff --git a/arch/s390/include/asm/mmu.h b/arch/s390/include/asm/mmu.h
index db35c41a59d5..c639c95850e4 100644
--- a/arch/s390/include/asm/mmu.h
+++ b/arch/s390/include/asm/mmu.h
@@ -22,8 +22,8 @@ typedef struct {
 	unsigned int has_pgste:1;
 	/* The mmu context uses storage keys. */
 	unsigned int use_skey:1;
-	/* The mmu context uses CMMA. */
-	unsigned int use_cmma:1;
+	/* The mmu context uses CMM. */
+	unsigned int uses_cmm:1;
 } mm_context_t;
 
 #define INIT_MM_CONTEXT(name)						   \
diff --git a/arch/s390/include/asm/mmu_context.h b/arch/s390/include/asm/mmu_context.h
index 65154eaa3714..d3ebfa8f8a9f 100644
--- a/arch/s390/include/asm/mmu_context.h
+++ b/arch/s390/include/asm/mmu_context.h
@@ -31,7 +31,7 @@ static inline int init_new_context(struct task_struct *tsk,
 		(current->mm && current->mm->context.alloc_pgste);
 	mm->context.has_pgste = 0;
 	mm->context.use_skey = 0;
-	mm->context.use_cmma = 0;
+	mm->context.uses_cmm = 0;
 #endif
 	switch (mm->context.asce_limit) {
 	case _REGION2_SIZE:
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 56061cf82f01..957be1c51a4b 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -699,6 +699,8 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
 		mutex_lock(&kvm->lock);
 		if (!kvm->created_vcpus) {
 			kvm->arch.use_cmma = 1;
+			/* Not compatible with cmma. */
+			kvm->arch.use_pfmfi = 0;
 			ret = 0;
 		}
 		mutex_unlock(&kvm->lock);
@@ -1603,7 +1605,7 @@ static int kvm_s390_get_cmma_bits(struct kvm *kvm,
 		return -EINVAL;
 	/* CMMA is disabled or was not used, or the buffer has length zero */
 	bufsize = min(args->count, KVM_S390_CMMA_SIZE_MAX);
-	if (!bufsize || !kvm->mm->context.use_cmma) {
+	if (!bufsize || !kvm->mm->context.uses_cmm) {
 		memset(args, 0, sizeof(*args));
 		return 0;
 	}
@@ -1680,7 +1682,7 @@ static int kvm_s390_get_cmma_bits(struct kvm *kvm,
 /*
  * This function sets the CMMA attributes for the given pages. If the input
  * buffer has zero length, no action is taken, otherwise the attributes are
- * set and the mm->context.use_cmma flag is set.
+ * set and the mm->context.uses_cmm flag is set.
  */
 static int kvm_s390_set_cmma_bits(struct kvm *kvm,
 				  const struct kvm_s390_cmma_log *args)
@@ -1730,9 +1732,9 @@ static int kvm_s390_set_cmma_bits(struct kvm *kvm,
 	srcu_read_unlock(&kvm->srcu, srcu_idx);
 	up_read(&kvm->mm->mmap_sem);
 
-	if (!kvm->mm->context.use_cmma) {
+	if (!kvm->mm->context.uses_cmm) {
 		down_write(&kvm->mm->mmap_sem);
-		kvm->mm->context.use_cmma = 1;
+		kvm->mm->context.uses_cmm = 1;
 		up_write(&kvm->mm->mmap_sem);
 	}
 out:
@@ -2043,6 +2045,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 	kvm->arch.css_support = 0;
 	kvm->arch.use_irqchip = 0;
+	kvm->arch.use_pfmfi = sclp.has_pfmfi;
 	kvm->arch.epoch = 0;
 
 	spin_lock_init(&kvm->arch.start_stop_lock);
@@ -2469,8 +2472,6 @@ int kvm_s390_vcpu_setup_cmma(struct kvm_vcpu *vcpu)
 	vcpu->arch.sie_block->cbrlo = get_zeroed_page(GFP_KERNEL);
 	if (!vcpu->arch.sie_block->cbrlo)
 		return -ENOMEM;
-
-	vcpu->arch.sie_block->ecb2 &= ~ECB2_PFMFI;
 	return 0;
 }
 
@@ -2506,7 +2507,7 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 	if (test_kvm_facility(vcpu->kvm, 73))
 		vcpu->arch.sie_block->ecb |= ECB_TE;
 
-	if (test_kvm_facility(vcpu->kvm, 8) && sclp.has_pfmfi)
+	if (test_kvm_facility(vcpu->kvm, 8) && vcpu->kvm->arch.use_pfmfi)
 		vcpu->arch.sie_block->ecb2 |= ECB2_PFMFI;
 	if (test_kvm_facility(vcpu->kvm, 130))
 		vcpu->arch.sie_block->ecb2 |= ECB2_IEP;
@@ -3038,7 +3039,7 @@ static int kvm_s390_handle_requests(struct kvm_vcpu *vcpu)
 
 	if (kvm_check_request(KVM_REQ_START_MIGRATION, vcpu)) {
 		/*
-		 * Disable CMMA virtualization; we will emulate the ESSA
+		 * Disable CMM virtualization; we will emulate the ESSA
 		 * instruction manually, in order to provide additional
 		 * functionalities needed for live migration.
 		 */
@@ -3048,11 +3049,11 @@ static int kvm_s390_handle_requests(struct kvm_vcpu *vcpu)
 
 	if (kvm_check_request(KVM_REQ_STOP_MIGRATION, vcpu)) {
 		/*
-		 * Re-enable CMMA virtualization if CMMA is available and
-		 * was used.
+		 * Re-enable CMM virtualization if CMMA is available and
+		 * CMM has been used.
 		 */
 		if ((vcpu->kvm->arch.use_cmma) &&
-		    (vcpu->kvm->mm->context.use_cmma))
+		    (vcpu->kvm->mm->context.uses_cmm))
 			vcpu->arch.sie_block->ecb2 |= ECB2_CMMA;
 		goto retry;
 	}
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index f0b4185158af..ebfa0442e569 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -1078,9 +1078,9 @@ static int handle_essa(struct kvm_vcpu *vcpu)
 		 * value really needs to be written to; if the value is
 		 * already correct, we do nothing and avoid the lock.
 		 */
-		if (vcpu->kvm->mm->context.use_cmma == 0) {
+		if (vcpu->kvm->mm->context.uses_cmm == 0) {
 			down_write(&vcpu->kvm->mm->mmap_sem);
-			vcpu->kvm->mm->context.use_cmma = 1;
+			vcpu->kvm->mm->context.uses_cmm = 1;
 			up_write(&vcpu->kvm->mm->mmap_sem);
 		}
 		/*
-- 
2.14.3
