From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 3/8] KVM: s390: Push run loop into __vcpu_run
Date: Thu, 12 Sep 2013 10:33:44 +0200
Message-ID: <1378974829-46578-4-git-send-email-borntraeger@de.ibm.com>
References: <1378974829-46578-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1378974829-46578-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Huth <thuth@linux.vnet.ibm.com>

Moved the do-while loop from kvm_arch_vcpu_ioctl_run into __vcpu_run
and the calling of kvm_handle_sie_intercept() into vcpu_post_run()
(so we can add the srcu locks in a proper way in the next patch).

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 49 ++++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 69c7592..8eec7ab 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -738,6 +738,13 @@ static int vcpu_post_run(struct kvm_vcpu *vcpu, int exit_reason)
 
 	memcpy(&vcpu->run->s.regs.gprs[14], &vcpu->arch.sie_block->gg14, 16);
 
+	if (rc == 0) {
+		if (kvm_is_ucontrol(vcpu->kvm))
+			rc = -EOPNOTSUPP;
+		else
+			rc = kvm_handle_sie_intercept(vcpu);
+	}
+
 	return rc;
 }
 
@@ -745,21 +752,24 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
 {
 	int rc, exit_reason;
 
-	rc = vcpu_pre_run(vcpu);
-	if (rc)
-		return rc;
-
-	/*
-	 * As PF_VCPU will be used in fault handler, between guest_enter
-	 * and guest_exit should be no uaccess.
-	 */
-	preempt_disable();
-	kvm_guest_enter();
-	preempt_enable();
-	exit_reason = sie64a(vcpu->arch.sie_block, vcpu->run->s.regs.gprs);
-	kvm_guest_exit();
+	do {
+		rc = vcpu_pre_run(vcpu);
+		if (rc)
+			break;
 
-	rc = vcpu_post_run(vcpu, exit_reason);
+		/*
+		 * As PF_VCPU will be used in fault handler, between
+		 * guest_enter and guest_exit should be no uaccess.
+		 */
+		preempt_disable();
+		kvm_guest_enter();
+		preempt_enable();
+		exit_reason = sie64a(vcpu->arch.sie_block,
+				     vcpu->run->s.regs.gprs);
+		kvm_guest_exit();
+
+		rc = vcpu_post_run(vcpu, exit_reason);
+	} while (!signal_pending(current) && !rc);
 
 	return rc;
 }
@@ -801,16 +811,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 	}
 
 	might_fault();
-
-	do {
-		rc = __vcpu_run(vcpu);
-		if (rc)
-			break;
-		if (kvm_is_ucontrol(vcpu->kvm))
-			rc = -EOPNOTSUPP;
-		else
-			rc = kvm_handle_sie_intercept(vcpu);
-	} while (!signal_pending(current) && !rc);
+	rc = __vcpu_run(vcpu);
 
 	if (signal_pending(current) && !rc) {
 		kvm_run->exit_reason = KVM_EXIT_INTR;
-- 
1.8.3.1
