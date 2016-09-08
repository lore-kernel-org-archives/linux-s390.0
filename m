From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 01/11] KVM: s390: generate facility mask from readable list
Date: Thu,  8 Sep 2016 14:00:13 +0200
Message-ID: <1473336023-15522-2-git-send-email-borntraeger@de.ibm.com>
References: <1473336023-15522-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1473336023-15522-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Automatically generate the KVM facility mask out of a readable list.
Manually changing the masks is very error prone, especially if the
special IBM bit numbering has to be considered.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/facilities_src.h | 24 ++++++++++++++++++++++++
 arch/s390/kvm/kvm-s390.c               |  5 +----
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/facilities_src.h b/arch/s390/include/asm/facilities_src.h
index 4917728..3b758f6 100644
--- a/arch/s390/include/asm/facilities_src.h
+++ b/arch/s390/include/asm/facilities_src.h
@@ -55,4 +55,28 @@ static struct facility_def facility_defs[] = {
 			-1 /* END */
 		}
 	},
+	{
+		.name = "FACILITIES_KVM",
+		.bits = (int[]){
+			0,  /* N3 instructions */
+			1,  /* z/Arch mode installed */
+			2,  /* z/Arch mode active */
+			3,  /* DAT-enhancement */
+			4,  /* idte segment table */
+			5,  /* idte region table */
+			6,  /* ASN-and-LX reuse */
+			7,  /* stfle */
+			8,  /* enhanced-DAT 1 */
+			9,  /* sense-running-status */
+			10, /* conditional sske */
+			13, /* ipte-range */
+			14, /* nonquiescing key-setting */
+			73, /* transactional execution */
+			75, /* access-exception-fetch/store indication */
+			76, /* msa extension 3 */
+			77, /* msa extension 4 */
+			78, /* enhanced-DAT 2 */
+			-1  /* END */
+		}
+	},
 };
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 3f3ae48..4f484e0 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -132,10 +132,7 @@ module_param(nested, int, S_IRUGO);
 MODULE_PARM_DESC(nested, "Nested virtualization support");
 
 /* upper facilities limit for kvm */
-unsigned long kvm_s390_fac_list_mask[16] = {
-	0xffe6000000000000UL,
-	0x005e000000000000UL,
-};
+unsigned long kvm_s390_fac_list_mask[16] = { FACILITIES_KVM };
 
 unsigned long kvm_s390_fac_list_mask_size(void)
 {
-- 
2.5.5
