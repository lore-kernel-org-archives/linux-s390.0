From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 43/47] KVM: s390: move timer interrupt checks into own functions
Date: Tue, 15 Apr 2014 14:00:46 +0200
Message-ID: <1397563250-3089-44-git-send-email-borntraeger@de.ibm.com>
References: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

This patch moves the checks for enabled timer (clock-comparator) interrupts and pending
timer interrupts into own functions, making the code better readable and easier to
maintain.

The method kvm_cpu_has_pending_timer is filled with life.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index f331014..0165f1b 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -56,6 +56,14 @@ static int psw_interrupts_disabled(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
+static int ckc_interrupts_enabled(struct kvm_vcpu *vcpu)
+{
+	if (psw_extint_disabled(vcpu) ||
+	    !(vcpu->arch.sie_block->gcr[0] & 0x800ul))
+		return 0;
+	return 1;
+}
+
 static u64 int_word_to_isc_bits(u32 int_word)
 {
 	u8 isc = (int_word & 0x38000000) >> 27;
@@ -466,14 +474,10 @@ static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 	}
 }
 
-static int __try_deliver_ckc_interrupt(struct kvm_vcpu *vcpu)
+static void deliver_ckc_interrupt(struct kvm_vcpu *vcpu)
 {
 	int rc;
 
-	if (psw_extint_disabled(vcpu))
-		return 0;
-	if (!(vcpu->arch.sie_block->gcr[0] & 0x800ul))
-		return 0;
 	rc  = put_guest_lc(vcpu, 0x1004, (u16 __user *)__LC_EXT_INT_CODE);
 	rc |= write_guest_lc(vcpu, __LC_EXT_OLD_PSW,
 			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
@@ -485,7 +489,6 @@ static int __try_deliver_ckc_interrupt(struct kvm_vcpu *vcpu)
 			"delivery, killing userspace\n");
 		do_exit(SIGKILL);
 	}
-	return 1;
 }
 
 int kvm_cpu_has_interrupt(struct kvm_vcpu *vcpu)
@@ -515,19 +518,20 @@ int kvm_cpu_has_interrupt(struct kvm_vcpu *vcpu)
 		spin_unlock(&fi->lock);
 	}
 
-	if ((!rc) && (vcpu->arch.sie_block->ckc <
-		get_tod_clock_fast() + vcpu->arch.sie_block->epoch)) {
-		if ((!psw_extint_disabled(vcpu)) &&
-			(vcpu->arch.sie_block->gcr[0] & 0x800ul))
-			rc = 1;
-	}
+	if (!rc && kvm_cpu_has_pending_timer(vcpu))
+		rc = 1;
 
 	return rc;
 }
 
 int kvm_cpu_has_pending_timer(struct kvm_vcpu *vcpu)
 {
-	return 0;
+	if (!(vcpu->arch.sie_block->ckc <
+	      get_tod_clock_fast() + vcpu->arch.sie_block->epoch))
+		return 0;
+	if (!ckc_interrupts_enabled(vcpu))
+		return 0;
+	return 1;
 }
 
 int kvm_s390_handle_wait(struct kvm_vcpu *vcpu)
@@ -550,8 +554,7 @@ int kvm_s390_handle_wait(struct kvm_vcpu *vcpu)
 		return -EOPNOTSUPP; /* disabled wait */
 	}
 
-	if (psw_extint_disabled(vcpu) ||
-	    (!(vcpu->arch.sie_block->gcr[0] & 0x800ul))) {
+	if (!ckc_interrupts_enabled(vcpu)) {
 		VCPU_EVENT(vcpu, 3, "%s", "enabled wait w/o timer");
 		goto no_timer;
 	}
@@ -663,9 +666,8 @@ void kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu)
 		} while (deliver);
 	}
 
-	if ((vcpu->arch.sie_block->ckc <
-		get_tod_clock_fast() + vcpu->arch.sie_block->epoch))
-		__try_deliver_ckc_interrupt(vcpu);
+	if (kvm_cpu_has_pending_timer(vcpu))
+		deliver_ckc_interrupt(vcpu);
 
 	if (atomic_read(&fi->active)) {
 		do {
-- 
1.8.4.2
