From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 1/8] KVM: s390: move kvm_guest_enter,exit closer to sie
Date: Fri, 26 Jul 2013 15:04:00 +0200
Message-ID: <1374843847-5046-2-git-send-email-borntraeger@de.ibm.com>
References: <1374843847-5046-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1374843847-5046-1-git-send-email-borntraeger@de.ibm.com>
Sender: stable-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Dominik Dingel <dingel@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, stable@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Dominik Dingel <dingel@linux.vnet.ibm.com>

Any uaccess between guest_enter and guest_exit could trigger a page fault,
the page fault handler would handle it as a guest fault and translate a
user address as guest address.

Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
CC: stable@vger.kernel.org
---
 arch/s390/kvm/kvm-s390.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index a3d797b..39894aa 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -702,14 +702,25 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
 		return rc;
 
 	vcpu->arch.sie_block->icptcode = 0;
-	preempt_disable();
-	kvm_guest_enter();
-	preempt_enable();
 	VCPU_EVENT(vcpu, 6, "entering sie flags %x",
 		   atomic_read(&vcpu->arch.sie_block->cpuflags));
 	trace_kvm_s390_sie_enter(vcpu,
 				 atomic_read(&vcpu->arch.sie_block->cpuflags));
+
+	/*
+	 * As PF_VCPU will be used in fault handler, between guest_enter
+	 * and guest_exit should be no uaccess.
+	 */
+	preempt_disable();
+	kvm_guest_enter();
+	preempt_enable();
 	rc = sie64a(vcpu->arch.sie_block, vcpu->run->s.regs.gprs);
+	kvm_guest_exit();
+
+	VCPU_EVENT(vcpu, 6, "exit sie icptcode %d",
+		   vcpu->arch.sie_block->icptcode);
+	trace_kvm_s390_sie_exit(vcpu, vcpu->arch.sie_block->icptcode);
+
 	if (rc > 0)
 		rc = 0;
 	if (rc < 0) {
@@ -721,10 +732,6 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
 			rc = kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 		}
 	}
-	VCPU_EVENT(vcpu, 6, "exit sie icptcode %d",
-		   vcpu->arch.sie_block->icptcode);
-	trace_kvm_s390_sie_exit(vcpu, vcpu->arch.sie_block->icptcode);
-	kvm_guest_exit();
 
 	memcpy(&vcpu->run->s.regs.gprs[14], &vcpu->arch.sie_block->gg14, 16);
 	return rc;
-- 
1.8.3.1
