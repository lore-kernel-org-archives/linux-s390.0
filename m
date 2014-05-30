From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 5/6] KVM: s390: a VCPU is already started when delivering interrupts
Date: Fri, 30 May 2014 11:00:11 +0200
Message-ID: <1401440412-20472-6-git-send-email-borntraeger@de.ibm.com>
References: <1401440412-20472-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1401440412-20472-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

This patch removes the start of a VCPU when delivering a RESTART interrupt.
Interrupt delivery is called from kvm_arch_vcpu_ioctl_run. So the VCPU is
already considered started - no need to call kvm_s390_vcpu_start. This function
will early exit anyway.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index bf0d9bc..90c8de2 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -442,7 +442,6 @@ static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 		rc |= read_guest_lc(vcpu, offsetof(struct _lowcore, restart_psw),
 				    &vcpu->arch.sie_block->gpsw,
 				    sizeof(psw_t));
-		kvm_s390_vcpu_start(vcpu);
 		break;
 	case KVM_S390_PROGRAM_INT:
 		VCPU_EVENT(vcpu, 4, "interrupt: pgm check code:%x, ilc:%x",
-- 
1.8.4.2
