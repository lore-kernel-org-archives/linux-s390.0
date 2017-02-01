From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 02/12] KVM: s390: gaccess: add ESOP2 handling
Date: Wed,  1 Feb 2017 12:38:04 +0100
Message-ID: <1485949094-138708-3-git-send-email-borntraeger@de.ibm.com>
References: <1485949094-138708-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1485949094-138708-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

When we access guest memory and run into a protection exception, we
need to pass the exception data to the guest. ESOP2 provides detailed
information about all protection exceptions which ESOP1 only partially
provided.

The gaccess changes make sure, that the guest always gets all
available information.

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/gaccess.c          | 12 +++++++++---
 arch/s390/tools/gen_facilities.c |  1 +
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 4aa8a7e..6e94705 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -465,7 +465,9 @@ static int ar_translation(struct kvm_vcpu *vcpu, union asce *asce, ar_t ar,
 struct trans_exc_code_bits {
 	unsigned long addr : 52; /* Translation-exception Address */
 	unsigned long fsi  : 2;  /* Access Exception Fetch/Store Indication */
-	unsigned long	   : 6;
+	unsigned long	   : 2;
+	unsigned long b56  : 1;
+	unsigned long	   : 3;
 	unsigned long b60  : 1;
 	unsigned long b61  : 1;
 	unsigned long as   : 2;  /* ASCE Identifier */
@@ -497,14 +499,18 @@ static int trans_exc(struct kvm_vcpu *vcpu, int code, unsigned long gva,
 	switch (code) {
 	case PGM_PROTECTION:
 		switch (prot) {
+		case PROT_TYPE_LA:
+			tec->b56 = 1;
+			break;
+		case PROT_TYPE_KEYC:
+			tec->b60 = 1;
+			break;
 		case PROT_TYPE_ALC:
 			tec->b60 = 1;
 			/* FALL THROUGH */
 		case PROT_TYPE_DAT:
 			tec->b61 = 1;
 			break;
-		default: /* LA and KEYC set b61 to 0, other params undefined */
-			return code;
 		}
 		/* FALL THROUGH */
 	case PGM_ASCE_TYPE:
diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
index 8cc53b1..b6ac8df 100644
--- a/arch/s390/tools/gen_facilities.c
+++ b/arch/s390/tools/gen_facilities.c
@@ -80,6 +80,7 @@ static struct facility_def facility_defs[] = {
 			76, /* msa extension 3 */
 			77, /* msa extension 4 */
 			78, /* enhanced-DAT 2 */
+			131, /* enhanced-SOP 2 and side-effect */
 			-1  /* END */
 		}
 	},
-- 
2.7.4
