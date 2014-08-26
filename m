From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 02/15] KVM: s390: factor out get_ilc() function
Date: Tue, 26 Aug 2014 10:28:14 +0200
Message-ID: <1409041707-39938-3-git-send-email-borntraeger@de.ibm.com>
References: <1409041707-39938-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1409041707-39938-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jens Freimann <jfrei@linux.vnet.ibm.com>

Let's make this a reusable function.

Signed-off-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 6c9428e..71bf7e7 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -206,11 +206,30 @@ static void __set_intercept_indicator(struct kvm_vcpu *vcpu,
 	}
 }
 
+static u16 get_ilc(struct kvm_vcpu *vcpu)
+{
+	const unsigned short table[] = { 2, 4, 4, 6 };
+
+	switch (vcpu->arch.sie_block->icptcode) {
+	case ICPT_INST:
+	case ICPT_INSTPROGI:
+	case ICPT_OPEREXC:
+	case ICPT_PARTEXEC:
+	case ICPT_IOINST:
+		/* last instruction only stored for these icptcodes */
+		return table[vcpu->arch.sie_block->ipa >> 14];
+	case ICPT_PROGI:
+		return vcpu->arch.sie_block->pgmilc;
+	default:
+		return 0;
+	}
+}
+
 static int __deliver_prog_irq(struct kvm_vcpu *vcpu,
 			      struct kvm_s390_pgm_info *pgm_info)
 {
-	const unsigned short table[] = { 2, 4, 4, 6 };
 	int rc = 0;
+	u16 ilc = get_ilc(vcpu);
 
 	switch (pgm_info->code & ~PGM_PER) {
 	case PGM_AFX_TRANSLATION:
@@ -277,25 +296,7 @@ static int __deliver_prog_irq(struct kvm_vcpu *vcpu,
 				   (u8 *) __LC_PER_ACCESS_ID);
 	}
 
-	switch (vcpu->arch.sie_block->icptcode) {
-	case ICPT_INST:
-	case ICPT_INSTPROGI:
-	case ICPT_OPEREXC:
-	case ICPT_PARTEXEC:
-	case ICPT_IOINST:
-		/* last instruction only stored for these icptcodes */
-		rc |= put_guest_lc(vcpu, table[vcpu->arch.sie_block->ipa >> 14],
-				   (u16 *) __LC_PGM_ILC);
-		break;
-	case ICPT_PROGI:
-		rc |= put_guest_lc(vcpu, vcpu->arch.sie_block->pgmilc,
-				   (u16 *) __LC_PGM_ILC);
-		break;
-	default:
-		rc |= put_guest_lc(vcpu, 0,
-				   (u16 *) __LC_PGM_ILC);
-	}
-
+	rc |= put_guest_lc(vcpu, ilc, (u16 *) __LC_PGM_ILC);
 	rc |= put_guest_lc(vcpu, pgm_info->code,
 			   (u16 *)__LC_PGM_INT_CODE);
 	rc |= write_guest_lc(vcpu, __LC_PGM_OLD_PSW,
-- 
1.8.4.2
