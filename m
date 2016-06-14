From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 14 Jun 2016 18:57:04 +0000
Subject: [GIT PULL 27/52] KVM: s390: handle missing guest-storage-limit-suppression
Message-Id: <201606141857.u5EIs1Gn090496@mx0a-001b2d01.pphosted.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

If guest-storage-limit-suppression is not available, we would for now
have a valid guest address space with size 0. So let's simply set the
origin to 0 and the limit to hamax.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 4 +++-
 arch/s390/kvm/kvm-s390.c         | 4 ++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index b2a83a0..9eed5c1 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -186,7 +186,9 @@ struct kvm_s390_sie_block {
 	__u32	scaol;			/* 0x0064 */
 	__u8	reserved68[4];		/* 0x0068 */
 	__u32	todpr;			/* 0x006c */
-	__u8	reserved70[32];		/* 0x0070 */
+	__u8	reserved70[16];		/* 0x0070 */
+	__u64	mso;			/* 0x0080 */
+	__u64	msl;			/* 0x0088 */
 	psw_t	gpsw;			/* 0x0090 */
 	__u64	gg14;			/* 0x00a0 */
 	__u64	gg15;			/* 0x00a8 */
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index f695c6e..2a23955 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1897,6 +1897,10 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm,
 	vcpu->arch.sie_block = &sie_page->sie_block;
 	vcpu->arch.sie_block->itdba = (unsigned long) &sie_page->itdb;
 
+	/* the real guest size will always be smaller than msl */
+	vcpu->arch.sie_block->mso = 0;
+	vcpu->arch.sie_block->msl = sclp.hamax;
+
 	vcpu->arch.sie_block->icpua = id;
 	spin_lock_init(&vcpu->arch.local_int.lock);
 	vcpu->arch.local_int.float_int = &kvm->arch.float_int;
-- 
2.5.5
