From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 02/12] KVM: s390: define GISA format-0 data structure
Date: Tue, 16 Jan 2018 21:02:07 +0100
Message-ID: <20180116200217.211897-3-borntraeger@de.ibm.com>
References: <20180116200217.211897-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180116200217.211897-1-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Mueller <mimu@linux.vnet.ibm.com>

In preperation to support pass-through adapter interrupts, the Guest
Interruption State Area (GISA) and the Adapter Interruption Virtualization
(AIV) features will be introduced here.

This patch introduces format-0 GISA (that is defines the struct describing
the GISA, allocates storage for it, and introduces fields for the
GISA address in kvm_s390_sie_block and kvm_s390_vsie).

As the GISA requires storage below 2GB, it is put in sie_page2, which is
already allocated in ZONE_DMA. In addition, The GISA requires alignment to
its integral boundary.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 24 ++++++++++++++++++++----
 arch/s390/kvm/kvm-s390.c         |  1 +
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 9981721f258f..11f15a51bfc7 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -183,6 +183,7 @@ struct kvm_s390_sie_block {
 #define ECA_IB		0x40000000
 #define ECA_SIGPI	0x10000000
 #define ECA_MVPGI	0x01000000
+#define ECA_AIV		0x00200000
 #define ECA_VX		0x00020000
 #define ECA_PROTEXCI	0x00002000
 #define ECA_SII		0x00000001
@@ -227,7 +228,8 @@ struct kvm_s390_sie_block {
 	__u8    epdx;			/* 0x0069 */
 	__u8    reserved6a[2];		/* 0x006a */
 	__u32	todpr;			/* 0x006c */
-	__u8	reserved70[16];		/* 0x0070 */
+	__u32	gd;			/* 0x0070 */
+	__u8	reserved74[12];		/* 0x0074 */
 	__u64	mso;			/* 0x0080 */
 	__u64	msl;			/* 0x0088 */
 	psw_t	gpsw;			/* 0x0090 */
@@ -703,14 +705,27 @@ struct kvm_s390_crypto_cb {
 	struct kvm_s390_apcb1 apcb1;		/* 0x0080 */
 };
 
+struct kvm_s390_gisa {
+	u32 next_alert;
+	u8 ipm;
+	u8 reserved01;
+	u8:6;
+	u8 g:1;
+	u8 c:1;
+	u8 iam;
+	u8 reserved02[4];
+	u32 airq_count;
+};
+
 /*
- * sie_page2 has to be allocated as DMA because fac_list and crycb need
- * 31bit addresses in the sie control block.
+ * sie_page2 has to be allocated as DMA because fac_list, crycb and
+ * gisa need 31bit addresses in the sie control block.
  */
 struct sie_page2 {
 	__u64 fac_list[S390_ARCH_FAC_LIST_SIZE_U64];	/* 0x0000 */
 	struct kvm_s390_crypto_cb crycb;		/* 0x0800 */
-	u8 reserved900[0x1000 - 0x900];			/* 0x0900 */
+	struct kvm_s390_gisa gisa __aligned(sizeof(struct kvm_s390_gisa)); /* 0x0900 */
+	u8 reserved910[0x1000 - 0x910];			/* 0x0910 */
 };
 
 struct kvm_s390_vsie {
@@ -757,6 +772,7 @@ struct kvm_arch{
 	struct kvm_s390_migration_state *migration_state;
 	/* subset of available cpu features enabled by user space */
 	DECLARE_BITMAP(cpu_feat, KVM_S390_VM_CPU_FEAT_NR_BITS);
+	struct kvm_s390_gisa *gisa;
 };
 
 #define KVM_HVA_ERR_BAD		(-1UL)
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index de16c224319c..48f0099188df 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1915,6 +1915,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	if (!kvm->arch.dbf)
 		goto out_err;
 
+	BUILD_BUG_ON(sizeof(struct sie_page2) != 4096);
 	kvm->arch.sie_page2 =
 	     (struct sie_page2 *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!kvm->arch.sie_page2)
-- 
2.13.4
