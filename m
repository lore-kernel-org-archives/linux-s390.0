From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 02/16] KVM: s390: filter space-switch events when PER is enforced
Date: Wed, 29 Jul 2015 11:05:52 +0200
Message-ID: <1438160766-108179-3-git-send-email-borntraeger@de.ibm.com>
References: <1438160766-108179-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1438160766-108179-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

When guest debugging is active, space-switch events might be enforced
by PER. While the PER events are correctly filtered out,
space-switch-events could be forwarded to the guest, although from a
guest point of view, they should not have been reported.

Therefore we have to filter out space-switch events being concurrently
reported with a PER event, if the PER event got filtered out. To do so,
we theoretically have to know which instruction was responsible for the
event. As the applicable instructions modify the PSW address, the
address space set in the PSW and even the address space in cr1, we
can't figure out the instruction that way.

For this reason, we have to rely on the information about the old and
new address space, in order to guess the responsible instruction type
and do appropriate checks for space-switch events.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/guestdbg.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/guestdbg.c
index e97b345..47518a3 100644
--- a/arch/s390/kvm/guestdbg.c
+++ b/arch/s390/kvm/guestdbg.c
@@ -473,10 +473,45 @@ static void filter_guest_per_event(struct kvm_vcpu *vcpu)
 		vcpu->arch.sie_block->iprcc &= ~PGM_PER;
 }
 
+#define pssec(vcpu) (vcpu->arch.sie_block->gcr[1] & _ASCE_SPACE_SWITCH)
+#define hssec(vcpu) (vcpu->arch.sie_block->gcr[13] & _ASCE_SPACE_SWITCH)
+#define old_ssec(vcpu) ((vcpu->arch.sie_block->tecmc >> 31) & 0x1)
+#define old_as_is_home(vcpu) !(vcpu->arch.sie_block->tecmc & 0xffff)
+
 void kvm_s390_handle_per_event(struct kvm_vcpu *vcpu)
 {
+	int new_as;
+
 	if (debug_exit_required(vcpu))
 		vcpu->guest_debug |= KVM_GUESTDBG_EXIT_PENDING;
 
 	filter_guest_per_event(vcpu);
+
+	/*
+	 * Only RP, SAC, SACF, PT, PTI, PR, PC instructions can trigger
+	 * a space-switch event. PER events enforce space-switch events
+	 * for these instructions. So if no PER event for the guest is left,
+	 * we might have to filter the space-switch element out, too.
+	 */
+	if (vcpu->arch.sie_block->iprcc == PGM_SPACE_SWITCH) {
+		vcpu->arch.sie_block->iprcc = 0;
+		new_as = psw_bits(vcpu->arch.sie_block->gpsw).as;
+
+		/*
+		 * If the AS changed from / to home, we had RP, SAC or SACF
+		 * instruction. Check primary and home space-switch-event
+		 * controls. (theoretically home -> home produced no event)
+		 */
+		if (((new_as == PSW_AS_HOME) ^ old_as_is_home(vcpu)) &&
+		     (pssec(vcpu) || hssec(vcpu)))
+			vcpu->arch.sie_block->iprcc = PGM_SPACE_SWITCH;
+
+		/*
+		 * PT, PTI, PR, PC instruction operate on primary AS only. Check
+		 * if the primary-space-switch-event control was or got set.
+		 */
+		if (new_as == PSW_AS_PRIMARY && !old_as_is_home(vcpu) &&
+		    (pssec(vcpu) || old_ssec(vcpu)))
+			vcpu->arch.sie_block->iprcc = PGM_SPACE_SWITCH;
+	}
 }
-- 
2.3.0
