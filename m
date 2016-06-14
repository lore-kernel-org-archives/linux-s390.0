From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 14 Jun 2016 18:56:57 +0000
Subject: [GIT PULL 20/52] KVM: s390: handle missing 64-bit-SCAO facility
Message-Id: <201606141857.u5EIs14G040004@mx0b-001b2d01.pphosted.com>
In-Reply-To: <201606141857.u5EIs0ZL135578@mx0a-001b2d01.pphosted.com>
References: <201606141857.u5EIs0ZL135578@mx0a-001b2d01.pphosted.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Without that facility, we may only use scaol. So fallback
to DMA allocation in that case, so we won't overwrite random memory
via the SIE.

Also disallow ESCA, so we don't have to handle that allocation case.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index f746a35..efb902c 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -317,8 +317,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		break;
 	case KVM_CAP_NR_VCPUS:
 	case KVM_CAP_MAX_VCPUS:
-		r = sclp.has_esca ? KVM_S390_ESCA_CPU_SLOTS
-				  : KVM_S390_BSCA_CPU_SLOTS;
+		r = KVM_S390_BSCA_CPU_SLOTS;
+		if (sclp.has_esca && sclp.has_64bscao)
+			r = KVM_S390_ESCA_CPU_SLOTS;
 		break;
 	case KVM_CAP_NR_MEMSLOTS:
 		r = KVM_USER_MEM_SLOTS;
@@ -1295,6 +1296,7 @@ static void sca_dispose(struct kvm *kvm)
 
 int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 {
+	gfp_t alloc_flags = GFP_KERNEL;
 	int i, rc;
 	char debug_name[16];
 	static unsigned long sca_offset;
@@ -1319,8 +1321,10 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	ratelimit_state_init(&kvm->arch.sthyi_limit, 5 * HZ, 500);
 
 	kvm->arch.use_esca = 0; /* start with basic SCA */
+	if (!sclp.has_64bscao)
+		alloc_flags |= GFP_DMA;
 	rwlock_init(&kvm->arch.sca_lock);
-	kvm->arch.sca = (struct bsca_block *) get_zeroed_page(GFP_KERNEL);
+	kvm->arch.sca = (struct bsca_block *) get_zeroed_page(alloc_flags);
 	if (!kvm->arch.sca)
 		goto out_err;
 	spin_lock(&kvm_lock);
@@ -1567,7 +1571,7 @@ static int sca_can_add_vcpu(struct kvm *kvm, unsigned int id)
 
 	if (id < KVM_S390_BSCA_CPU_SLOTS)
 		return true;
-	if (!sclp.has_esca)
+	if (!sclp.has_esca || !sclp.has_64bscao)
 		return false;
 
 	mutex_lock(&kvm->lock);
-- 
2.5.5
