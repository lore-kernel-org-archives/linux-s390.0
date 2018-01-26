From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 22/22] KVM: s390: introduce the format-1 GISA
Date: Fri, 26 Jan 2018 16:53:34 +0100
Message-ID: <20180126155334.52956-23-borntraeger@de.ibm.com>
References: <20180126155334.52956-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180126155334.52956-1-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Mueller <mimu@linux.vnet.ibm.com>

The patch modifies the previously defined GISA data structure to be
able to store two GISA formats, format-0 and format-1. Additionally,
it verifies the availability of the GISA format facility and enables
the use of a format-1 GISA in the SIE control block accordingly.

A format-1 can do everything that format-0 can and we will need it
for real HW passthrough. As there are systems with only format-0
we keep both variants.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 44 +++++++++++++++++++++++++++++++---------
 arch/s390/kvm/interrupt.c        |  4 +---
 arch/s390/kvm/kvm-s390.c         |  2 ++
 3 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 76d6f0ef3dbdc..59dd46adf0e86 100644
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
@@ -719,15 +720,38 @@ struct kvm_s390_crypto_cb {
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
@@ -738,7 +762,7 @@ struct sie_page2 {
 	__u64 fac_list[S390_ARCH_FAC_LIST_SIZE_U64];	/* 0x0000 */
 	struct kvm_s390_crypto_cb crycb;		/* 0x0800 */
 	struct kvm_s390_gisa gisa;			/* 0x0900 */
-	u8 reserved910[0x1000 - 0x910];			/* 0x0910 */
+	u8 reserved920[0x1000 - 0x920];			/* 0x0920 */
 };
 
 struct kvm_s390_vsie {
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 488ecc7ea2a18..aabf46f5f883d 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2842,9 +2842,7 @@ void kvm_s390_gisa_clear(struct kvm *kvm)
 
 void kvm_s390_gisa_init(struct kvm *kvm)
 {
-	if (!css_general_characteristics.aiv)
-		kvm->arch.gisa = NULL;
-	else {
+	if (css_general_characteristics.aiv) {
 		kvm->arch.gisa = &kvm->arch.sie_page2->gisa;
 		VM_EVENT(kvm, 3, "gisa 0x%pK initialized", kvm->arch.gisa);
 		kvm_s390_gisa_clear(kvm);
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 2c5e25b394352..f85a405e2595a 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2531,6 +2531,8 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm,
 	vcpu->arch.sie_block->icpua = id;
 	spin_lock_init(&vcpu->arch.local_int.lock);
 	vcpu->arch.sie_block->gd = (u32)(u64)kvm->arch.gisa;
+	if (vcpu->arch.sie_block->gd && sclp.has_gisaf)
+		vcpu->arch.sie_block->gd |= GISA_FORMAT1;
 	seqcount_init(&vcpu->arch.cputm_seqcount);
 
 	rc = kvm_vcpu_init(vcpu, kvm, id);
-- 
2.13.4
