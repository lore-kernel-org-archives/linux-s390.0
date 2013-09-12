From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 2/8] KVM: s390: Split up __vcpu_run into three parts
Date: Thu, 12 Sep 2013 10:33:43 +0200
Message-ID: <1378974829-46578-3-git-send-email-borntraeger@de.ibm.com>
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

In preparation for the following patch (which will change the indentation
of __vcpu_run quite a bit), this patch puts most of the code from __vcpu_run
into separate functions. The first function handles the code that runs
before the SIE instruction and the other one handles the code that runs
afterwards.

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 54 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 17 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index e3e7ff7..69c7592 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -689,9 +689,9 @@ static int kvm_s390_handle_requests(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-static int __vcpu_run(struct kvm_vcpu *vcpu)
+static int vcpu_pre_run(struct kvm_vcpu *vcpu)
 {
-	int rc;
+	int rc, cpuflags;
 
 	memcpy(&vcpu->arch.sie_block->gg14, &vcpu->run->s.regs.gprs[14], 16);
 
@@ -709,28 +709,24 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
 		return rc;
 
 	vcpu->arch.sie_block->icptcode = 0;
-	VCPU_EVENT(vcpu, 6, "entering sie flags %x",
-		   atomic_read(&vcpu->arch.sie_block->cpuflags));
-	trace_kvm_s390_sie_enter(vcpu,
-				 atomic_read(&vcpu->arch.sie_block->cpuflags));
+	cpuflags = atomic_read(&vcpu->arch.sie_block->cpuflags);
+	VCPU_EVENT(vcpu, 6, "entering sie flags %x", cpuflags);
+	trace_kvm_s390_sie_enter(vcpu, cpuflags);
 
-	/*
-	 * As PF_VCPU will be used in fault handler, between guest_enter
-	 * and guest_exit should be no uaccess.
-	 */
-	preempt_disable();
-	kvm_guest_enter();
-	preempt_enable();
-	rc = sie64a(vcpu->arch.sie_block, vcpu->run->s.regs.gprs);
-	kvm_guest_exit();
+	return 0;
+}
+
+static int vcpu_post_run(struct kvm_vcpu *vcpu, int exit_reason)
+{
+	int rc;
 
 	VCPU_EVENT(vcpu, 6, "exit sie icptcode %d",
 		   vcpu->arch.sie_block->icptcode);
 	trace_kvm_s390_sie_exit(vcpu, vcpu->arch.sie_block->icptcode);
 
-	if (rc > 0)
+	if (exit_reason >= 0) {
 		rc = 0;
-	if (rc < 0) {
+	} else {
 		if (kvm_is_ucontrol(vcpu->kvm)) {
 			rc = SIE_INTERCEPT_UCONTROL;
 		} else {
@@ -741,6 +737,30 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
 	}
 
 	memcpy(&vcpu->run->s.regs.gprs[14], &vcpu->arch.sie_block->gg14, 16);
+
+	return rc;
+}
+
+static int __vcpu_run(struct kvm_vcpu *vcpu)
+{
+	int rc, exit_reason;
+
+	rc = vcpu_pre_run(vcpu);
+	if (rc)
+		return rc;
+
+	/*
+	 * As PF_VCPU will be used in fault handler, between guest_enter
+	 * and guest_exit should be no uaccess.
+	 */
+	preempt_disable();
+	kvm_guest_enter();
+	preempt_enable();
+	exit_reason = sie64a(vcpu->arch.sie_block, vcpu->run->s.regs.gprs);
+	kvm_guest_exit();
+
+	rc = vcpu_post_run(vcpu, exit_reason);
+
 	return rc;
 }
 
-- 
1.8.3.1
