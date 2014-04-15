From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 44/47] KVM: s390: no timer interrupts when single-stepping a guest
Date: Tue, 15 Apr 2014 14:00:47 +0200
Message-ID: <1397563250-3089-45-git-send-email-borntraeger@de.ibm.com>
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

When a guest is single-stepped, we want to disable timer interrupts. Otherwise,
the guest will continuously execute the external interrupt handler and make
debugging of code where timer interrupts are enabled almost impossible.

The delivery of timer interrupts can be enforced in such sections by setting a
breakpoint and continuing execution.

In order to disable timer interrupts, they are disabled in the control register
of the guest just before SIE entry and are suppressed in the interrupt
check/delivery methods.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/guestdbg.c  | 2 ++
 arch/s390/kvm/interrupt.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/guestdbg.c
index 100e99d..757ccef 100644
--- a/arch/s390/kvm/guestdbg.c
+++ b/arch/s390/kvm/guestdbg.c
@@ -155,6 +155,8 @@ void kvm_s390_patch_guest_per_regs(struct kvm_vcpu *vcpu)
 	 */
 
 	if (guestdbg_sstep_enabled(vcpu)) {
+		/* disable timer (clock-comparator) interrupts */
+		vcpu->arch.sie_block->gcr[0] &= ~0x800ul;
 		vcpu->arch.sie_block->gcr[9] |= PER_EVENT_IFETCH;
 		vcpu->arch.sie_block->gcr[10] = 0;
 		vcpu->arch.sie_block->gcr[11] = PSW_ADDR_INSN;
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 0165f1b..d020c5f 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -61,6 +61,9 @@ static int ckc_interrupts_enabled(struct kvm_vcpu *vcpu)
 	if (psw_extint_disabled(vcpu) ||
 	    !(vcpu->arch.sie_block->gcr[0] & 0x800ul))
 		return 0;
+	if (guestdbg_enabled(vcpu) && guestdbg_sstep_enabled(vcpu))
+		/* No timer interrupts when single stepping */
+		return 0;
 	return 1;
 }
 
-- 
1.8.4.2
