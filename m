From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 06/11] KVM: s390: external param not valid for cpu timer and ckc
Date: Fri, 28 Nov 2014 14:25:34 +0100
Message-ID: <1417181139-25623-7-git-send-email-borntraeger@de.ibm.com>
References: <1417181139-25623-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1417181139-25623-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

The 32bit external interrupt parameter is only valid for timing-alert and
service-signal interrupts.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 8f50f8c..bccda76 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -345,12 +345,12 @@ static int __must_check __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 		break;
 	case KVM_S390_INT_CLOCK_COMP:
 		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
-						 inti->ext.ext_params, 0);
+						 0, 0);
 		rc = deliver_ckc_interrupt(vcpu);
 		break;
 	case KVM_S390_INT_CPU_TIMER:
 		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
-						 inti->ext.ext_params, 0);
+						 0, 0);
 		rc  = put_guest_lc(vcpu, EXT_IRQ_CPU_TIMER,
 				   (u16 *)__LC_EXT_INT_CODE);
 		rc |= write_guest_lc(vcpu, __LC_EXT_OLD_PSW,
@@ -358,8 +358,6 @@ static int __must_check __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 				     sizeof(psw_t));
 		rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW,
 				    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-		rc |= put_guest_lc(vcpu, inti->ext.ext_params,
-				   (u32 *)__LC_EXT_PARAMS);
 		break;
 	case KVM_S390_INT_SERVICE:
 		VCPU_EVENT(vcpu, 4, "interrupt: sclp parm:%x",
-- 
1.9.3
