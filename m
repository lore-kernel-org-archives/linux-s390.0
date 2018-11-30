From: Michael Mueller <mimu@linux.ibm.com>
Date: Fri, 30 Nov 2018 14:32:10 +0000
Subject: [PATCH v4 05/10] KVM: s390: add kvm reference to struct sie_page2
Message-Id: <20181130143215.69496-6-mimu@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Adding the kvm reference to struct sie_page2 will allow to
determine the kvm a given gisa belongs to:

  container_of(gisa, struct sie_page2, gisa)->kvm

This functionality will be required to process a gisa in
gib alert interruption context.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/include/asm/kvm_host.h | 3 ++-
 arch/s390/kvm/kvm-s390.c         | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 537e5e59f27e..0deba3ae8bc7 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -802,7 +802,8 @@ struct sie_page2 {
 	__u64 fac_list[S390_ARCH_FAC_LIST_SIZE_U64];	/* 0x0000 */
 	struct kvm_s390_crypto_cb crycb;		/* 0x0800 */
 	struct kvm_s390_gisa gisa;			/* 0x0900 */
-	u8 reserved920[0x1000 - 0x920];			/* 0x0920 */
+	struct kvm *kvm;				/* 0x0920 */
+	u8 reserved928[0x1000 - 0x928];			/* 0x0928 */
 };
 
 struct kvm_s390_vsie {
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 7bc24e16a31d..2d10e175862c 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2220,6 +2220,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	if (!kvm->arch.sie_page2)
 		goto out_err;
 
+	kvm->arch.sie_page2->kvm = kvm;
 	kvm->arch.model.fac_list = kvm->arch.sie_page2->fac_list;
 
 	for (i = 0; i < kvm_s390_fac_size(); i++) {
-- 
2.13.4
