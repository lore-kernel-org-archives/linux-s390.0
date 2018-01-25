From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v2 12/12] KVM: s390: introduce the format-1 GISA
Date: Thu, 25 Jan 2018 14:28:48 +0100
Message-ID: <20180125132848.175942-13-borntraeger@de.ibm.com>
References: <20180125132848.175942-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180125132848.175942-1-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Mueller <mimu@linux.vnet.ibm.com>

The patch modifies the previously defined GISA data structure to be
able to store two GISA formats, format-0 and format-1. Additionally,
it verifies the availability of the GISA format facility and enables
the use of a format-1 GISA in the SIE control block accordingly.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 44 +++++++++++++++++++++++++++++++---------
 arch/s390/kvm/kvm-s390.c         |  2 ++
 2 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 6802d5d..287c99b 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -228,6 +228,7 @@ struct kvm_s390_sie_block {
 	__u8    epdx;			/* 0x0069 */
 	__u8    reserved6a[2];		/* 0x006a */
 	__u32	todpr;			/* 0x006c */
+#define GISA_FORMAT1 0x00000001
 	__u32	gd;			/* 0x0070 */
 	__u8	reserved74[12];		/* 0x0074 */
 	__u64	mso;			/* 0x0080 */
@@ -706,15 +707,38 @@ struct kvm_s390_crypto_cb {
 };
 
 struct kvm_s390_gisa {
-	u32 next_alert;
-	u8 ipm;
-	u8 reserved01;
-	u8 : 6;
-	u8 g : 1;
-	u8 c : 1;
-	u8 iam;
-	u8 reserved02[4];
-	u32 airq_count;
+	union {
+		struct { /* common to all formats */
+			u32 next_alert;
+			u8  ipm;
+			u8  reserved01[2];
+			u8  iam;
+		};
+		struct { /* format 0 */
+			u32 next_alert;
+			u8  ipm;
+			u8  reserved01;
+			u8  : 6;
+			u8  g : 1;
+			u8  c : 1;
+			u8  iam;
+			u8  reserved02[4];
+			u32 airq_count;
+		} g0;
+		struct { /* format 1 */
+			u32 next_alert;
+			u8  ipm;
+			u8  simm;
+			u8  nimm;
+			u8  iam;
+			u8  aism[8];
+			u8  : 6;
+			u8  g : 1;
+			u8  c : 1;
+			u8  reserved03[11];
+			u32 airq_count;
+		} g1;
+	};
 };
 
 /*
@@ -725,7 +749,7 @@ struct sie_page2 {
 	__u64 fac_list[S390_ARCH_FAC_LIST_SIZE_U64];	/* 0x0000 */
 	struct kvm_s390_crypto_cb crycb;		/* 0x0800 */
 	struct kvm_s390_gisa gisa;			/* 0x0900 */
-	u8 reserved910[0x1000 - 0x910];			/* 0x0910 */
+	u8 reserved920[0x1000 - 0x920];			/* 0x0920 */
 };
 
 struct kvm_s390_vsie {
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 68d7eef..efde264 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2518,6 +2518,8 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm,
 	vcpu->arch.sie_block->icpua = id;
 	spin_lock_init(&vcpu->arch.local_int.lock);
 	vcpu->arch.sie_block->gd = (u32)(u64)kvm->arch.gisa;
+	if (vcpu->arch.sie_block->gd && sclp.has_gisaf)
+		vcpu->arch.sie_block->gd |= GISA_FORMAT1;
 	seqcount_init(&vcpu->arch.cputm_seqcount);
 
 	rc = kvm_vcpu_init(vcpu, kvm, id);
-- 
2.9.4
