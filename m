From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: [PATCH 1/3] KVM: s390: Refactor host cmma and pfmfi interpretation controls
Date: Thu, 15 Feb 2018 16:43:20 +0100
Message-ID: <1518709402-91101-2-git-send-email-frankja@linux.vnet.ibm.com>
References: <28551222-18a6-4566-0b7a-acc366c860c3@redhat.com>
 <1518709402-91101-1-git-send-email-frankja@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1518709402-91101-1-git-send-email-frankja@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

use_cmma in kvm_arch means that the vm is allowed to use cmma, whereas
use_cmma in the mm context means it has been used before. Let's rename
the kvm_arch one to has_cmma

Also let's introduce has_pfmfi, so we can remove the pfmfi disablement
when we activate cmma and rather not activate it in the first place.

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  3 ++-
 arch/s390/kvm/kvm-s390.c         | 25 +++++++++++++------------
 arch/s390/kvm/priv.c             |  2 +-
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index afb0f08..b768754 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -791,7 +791,8 @@ struct kvm_arch{
 	unsigned long mem_limit;
 	int css_support;
 	int use_irqchip;
-	int use_cmma;
+	int has_cmma;
+	int has_pfmfi;
 	int user_cpu_state_ctrl;
 	int user_sigp;
 	int user_stsi;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 4a2d68c..781aaf0 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -655,7 +655,9 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
 		VM_EVENT(kvm, 3, "%s", "ENABLE: CMMA support");
 		mutex_lock(&kvm->lock);
 		if (!kvm->created_vcpus) {
-			kvm->arch.use_cmma = 1;
+			kvm->arch.has_cmma = 1;
+			/* Not compatible with cmma. */
+			kvm->arch.has_pfmfi = 0;
 			ret = 0;
 		}
 		mutex_unlock(&kvm->lock);
@@ -665,7 +667,7 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
 		if (!sclp.has_cmma)
 			break;
 		ret = -EINVAL;
-		if (!kvm->arch.use_cmma)
+		if (!kvm->arch.has_cmma)
 			break;
 
 		VM_EVENT(kvm, 3, "%s", "RESET: CMMA states");
@@ -810,7 +812,7 @@ static int kvm_s390_vm_start_migration(struct kvm *kvm)
 		return -ENOMEM;
 	kvm->arch.migration_state = mgs;
 
-	if (kvm->arch.use_cmma) {
+	if (kvm->arch.has_cmma) {
 		/*
 		 * Get the first slot. They are reverse sorted by base_gfn, so
 		 * the first slot is also the one at the end of the address
@@ -855,7 +857,7 @@ static int kvm_s390_vm_stop_migration(struct kvm *kvm)
 	mgs = kvm->arch.migration_state;
 	kvm->arch.migration_state = NULL;
 
-	if (kvm->arch.use_cmma) {
+	if (kvm->arch.has_cmma) {
 		kvm_s390_sync_request_broadcast(kvm, KVM_REQ_STOP_MIGRATION);
 		/* We have to wait for the essa emulation to finish */
 		synchronize_srcu(&kvm->srcu);
@@ -1551,7 +1553,7 @@ static int kvm_s390_get_cmma_bits(struct kvm *kvm,
 	cur = args->start_gfn;
 	i = next = pgstev = 0;
 
-	if (unlikely(!kvm->arch.use_cmma))
+	if (unlikely(!kvm->arch.has_cmma))
 		return -ENXIO;
 	/* Invalid/unsupported flags were specified */
 	if (args->flags & ~KVM_S390_CMMA_PEEK)
@@ -1650,7 +1652,7 @@ static int kvm_s390_set_cmma_bits(struct kvm *kvm,
 
 	mask = args->mask;
 
-	if (!kvm->arch.use_cmma)
+	if (!kvm->arch.has_cmma)
 		return -ENXIO;
 	/* invalid/unsupported flags */
 	if (args->flags != 0)
@@ -2007,6 +2009,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 	kvm->arch.css_support = 0;
 	kvm->arch.use_irqchip = 0;
+	kvm->arch.has_pfmfi = sclp.has_pfmfi;
 	kvm->arch.epoch = 0;
 
 	spin_lock_init(&kvm->arch.start_stop_lock);
@@ -2045,7 +2048,7 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 	if (kvm_is_ucontrol(vcpu->kvm))
 		gmap_remove(vcpu->arch.gmap);
 
-	if (vcpu->kvm->arch.use_cmma)
+	if (vcpu->kvm->arch.has_cmma)
 		kvm_s390_vcpu_unsetup_cmma(vcpu);
 	free_page((unsigned long)(vcpu->arch.sie_block));
 
@@ -2431,8 +2434,6 @@ int kvm_s390_vcpu_setup_cmma(struct kvm_vcpu *vcpu)
 	vcpu->arch.sie_block->cbrlo = get_zeroed_page(GFP_KERNEL);
 	if (!vcpu->arch.sie_block->cbrlo)
 		return -ENOMEM;
-
-	vcpu->arch.sie_block->ecb2 &= ~ECB2_PFMFI;
 	return 0;
 }
 
@@ -2468,7 +2469,7 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 	if (test_kvm_facility(vcpu->kvm, 73))
 		vcpu->arch.sie_block->ecb |= ECB_TE;
 
-	if (test_kvm_facility(vcpu->kvm, 8) && sclp.has_pfmfi)
+	if (test_kvm_facility(vcpu->kvm, 8) && vcpu->kvm->arch.has_pfmfi)
 		vcpu->arch.sie_block->ecb2 |= ECB2_PFMFI;
 	if (test_kvm_facility(vcpu->kvm, 130))
 		vcpu->arch.sie_block->ecb2 |= ECB2_IEP;
@@ -2502,7 +2503,7 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 	else
 		vcpu->arch.sie_block->ictl |= ICTL_ISKE | ICTL_SSKE | ICTL_RRBE;
 
-	if (vcpu->kvm->arch.use_cmma) {
+	if (vcpu->kvm->arch.has_cmma) {
 		rc = kvm_s390_vcpu_setup_cmma(vcpu);
 		if (rc)
 			return rc;
@@ -3013,7 +3014,7 @@ static int kvm_s390_handle_requests(struct kvm_vcpu *vcpu)
 		 * Re-enable CMMA virtualization if CMMA is available and
 		 * was used.
 		 */
-		if ((vcpu->kvm->arch.use_cmma) &&
+		if ((vcpu->kvm->arch.has_cmma) &&
 		    (vcpu->kvm->mm->context.use_cmma))
 			vcpu->arch.sie_block->ecb2 |= ECB2_CMMA;
 		goto retry;
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index c4c4e15..908b579 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -1050,7 +1050,7 @@ static int handle_essa(struct kvm_vcpu *vcpu)
 	VCPU_EVENT(vcpu, 4, "ESSA: release %d pages", entries);
 	gmap = vcpu->arch.gmap;
 	vcpu->stat.instruction_essa++;
-	if (!vcpu->kvm->arch.use_cmma)
+	if (!vcpu->kvm->arch.has_cmma)
 		return kvm_s390_inject_program_int(vcpu, PGM_OPERATION);
 
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
-- 
2.7.4
