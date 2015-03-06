From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 09/20] KVM: s390: Nullify instruction for certain program exceptions
Date: Fri,  6 Mar 2015 14:16:41 +0100
Message-ID: <1425647812-61838-10-git-send-email-borntraeger@de.ibm.com>
References: <1425647812-61838-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1425647812-61838-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Huth <thuth@linux.vnet.ibm.com>

When certain program exceptions (e.g. DAT access exceptions) occur,
the current instruction has to be nullified, i.e. the old PSW that
gets written into the low-core has to point to the beginning of the
instruction again, and not to the beginning of the next instruction.
Thus we have to rewind the PSW before writing it into the low-core.
The list of nullifying exceptions can be found in the POP, chapter 6,
figure 6-1 ("Interruption Action").

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Reviewed-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index e7a46e8..98a3131 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -484,7 +484,7 @@ static int __must_check __deliver_prog(struct kvm_vcpu *vcpu)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 	struct kvm_s390_pgm_info pgm_info;
-	int rc = 0;
+	int rc = 0, nullifying = false;
 	u16 ilc = get_ilc(vcpu);
 
 	spin_lock(&li->lock);
@@ -509,6 +509,8 @@ static int __must_check __deliver_prog(struct kvm_vcpu *vcpu)
 	case PGM_LX_TRANSLATION:
 	case PGM_PRIMARY_AUTHORITY:
 	case PGM_SECONDARY_AUTHORITY:
+		nullifying = true;
+		/* fall through */
 	case PGM_SPACE_SWITCH:
 		rc = put_guest_lc(vcpu, pgm_info.trans_exc_code,
 				  (u64 *)__LC_TRANS_EXC_CODE);
@@ -521,6 +523,7 @@ static int __must_check __deliver_prog(struct kvm_vcpu *vcpu)
 	case PGM_EXTENDED_AUTHORITY:
 		rc = put_guest_lc(vcpu, pgm_info.exc_access_id,
 				  (u8 *)__LC_EXC_ACCESS_ID);
+		nullifying = true;
 		break;
 	case PGM_ASCE_TYPE:
 	case PGM_PAGE_TRANSLATION:
@@ -534,6 +537,7 @@ static int __must_check __deliver_prog(struct kvm_vcpu *vcpu)
 				   (u8 *)__LC_EXC_ACCESS_ID);
 		rc |= put_guest_lc(vcpu, pgm_info.op_access_id,
 				   (u8 *)__LC_OP_ACCESS_ID);
+		nullifying = true;
 		break;
 	case PGM_MONITOR:
 		rc = put_guest_lc(vcpu, pgm_info.mon_class_nr,
@@ -551,6 +555,15 @@ static int __must_check __deliver_prog(struct kvm_vcpu *vcpu)
 		rc |= put_guest_lc(vcpu, pgm_info.exc_access_id,
 				   (u8 *)__LC_EXC_ACCESS_ID);
 		break;
+	case PGM_STACK_FULL:
+	case PGM_STACK_EMPTY:
+	case PGM_STACK_SPECIFICATION:
+	case PGM_STACK_TYPE:
+	case PGM_STACK_OPERATION:
+	case PGM_TRACE_TABEL:
+	case PGM_CRYPTO_OPERATION:
+		nullifying = true;
+		break;
 	}
 
 	if (pgm_info.code & PGM_PER) {
@@ -564,6 +577,9 @@ static int __must_check __deliver_prog(struct kvm_vcpu *vcpu)
 				   (u8 *) __LC_PER_ACCESS_ID);
 	}
 
+	if (nullifying && vcpu->arch.sie_block->icptcode == ICPT_INST)
+		kvm_s390_rewind_psw(vcpu, ilc);
+
 	rc |= put_guest_lc(vcpu, ilc, (u16 *) __LC_PGM_ILC);
 	rc |= put_guest_lc(vcpu, pgm_info.code,
 			   (u16 *)__LC_PGM_INT_CODE);
-- 
2.3.0
