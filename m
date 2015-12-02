From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 04/23] KVM: s390: rewrite vcpu_post_run and drop out early
Date: Wed,  2 Dec 2015 12:06:05 +0100
Message-ID: <1449054384-76374-5-git-send-email-borntraeger@de.ibm.com>
References: <1449054384-76374-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1449054384-76374-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Let's rewrite this function to better reflect how we actually handle
exit_code. By dropping out early we can save a few cycles. This
especially speeds up sie exits caused by host irqs.

Also, let's move the special -EOPNOTSUPP for intercepts to
the place where it belongs and convert it to -EREMOTE.

Reviewed-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/intercept.c |  7 +++---
 arch/s390/kvm/kvm-s390.c  | 59 +++++++++++++++++------------------------------
 2 files changed, 24 insertions(+), 42 deletions(-)

diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index b4a5aa1..d53c107 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -54,9 +54,6 @@ void kvm_s390_rewind_psw(struct kvm_vcpu *vcpu, int ilc)
 static int handle_noop(struct kvm_vcpu *vcpu)
 {
 	switch (vcpu->arch.sie_block->icptcode) {
-	case 0x0:
-		vcpu->stat.exit_null++;
-		break;
 	case 0x10:
 		vcpu->stat.exit_external_request++;
 		break;
@@ -338,8 +335,10 @@ static int handle_partial_execution(struct kvm_vcpu *vcpu)
 
 int kvm_handle_sie_intercept(struct kvm_vcpu *vcpu)
 {
+	if (kvm_is_ucontrol(vcpu->kvm))
+		return -EOPNOTSUPP;
+
 	switch (vcpu->arch.sie_block->icptcode) {
-	case 0x00:
 	case 0x10:
 	case 0x18:
 		return handle_noop(vcpu);
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 8465892..5c36c8e 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2071,8 +2071,6 @@ static int vcpu_post_run_fault_in_sie(struct kvm_vcpu *vcpu)
 
 static int vcpu_post_run(struct kvm_vcpu *vcpu, int exit_reason)
 {
-	int rc = -1;
-
 	VCPU_EVENT(vcpu, 6, "exit sie icptcode %d",
 		   vcpu->arch.sie_block->icptcode);
 	trace_kvm_s390_sie_exit(vcpu, vcpu->arch.sie_block->icptcode);
@@ -2080,40 +2078,35 @@ static int vcpu_post_run(struct kvm_vcpu *vcpu, int exit_reason)
 	if (guestdbg_enabled(vcpu))
 		kvm_s390_restore_guest_per_regs(vcpu);
 
-	if (exit_reason >= 0) {
-		rc = 0;
+	memcpy(&vcpu->run->s.regs.gprs[14], &vcpu->arch.sie_block->gg14, 16);
+
+	if (vcpu->arch.sie_block->icptcode > 0) {
+		int rc = kvm_handle_sie_intercept(vcpu);
+
+		if (rc != -EOPNOTSUPP)
+			return rc;
+		vcpu->run->exit_reason = KVM_EXIT_S390_SIEIC;
+		vcpu->run->s390_sieic.icptcode = vcpu->arch.sie_block->icptcode;
+		vcpu->run->s390_sieic.ipa = vcpu->arch.sie_block->ipa;
+		vcpu->run->s390_sieic.ipb = vcpu->arch.sie_block->ipb;
+		return -EREMOTE;
+	} else if (exit_reason != -EFAULT) {
+		vcpu->stat.exit_null++;
+		return 0;
 	} else if (kvm_is_ucontrol(vcpu->kvm)) {
 		vcpu->run->exit_reason = KVM_EXIT_S390_UCONTROL;
 		vcpu->run->s390_ucontrol.trans_exc_code =
 						current->thread.gmap_addr;
 		vcpu->run->s390_ucontrol.pgm_code = 0x10;
-		rc = -EREMOTE;
-
+		return -EREMOTE;
 	} else if (current->thread.gmap_pfault) {
 		trace_kvm_s390_major_guest_pfault(vcpu);
 		current->thread.gmap_pfault = 0;
-		if (kvm_arch_setup_async_pf(vcpu)) {
-			rc = 0;
-		} else {
-			gpa_t gpa = current->thread.gmap_addr;
-			rc = kvm_arch_fault_in_page(vcpu, gpa, 1);
-		}
+		if (kvm_arch_setup_async_pf(vcpu))
+			return 0;
+		return kvm_arch_fault_in_page(vcpu, current->thread.gmap_addr, 1);
 	}
-
-	if (rc == -1)
-		rc = vcpu_post_run_fault_in_sie(vcpu);
-
-	memcpy(&vcpu->run->s.regs.gprs[14], &vcpu->arch.sie_block->gg14, 16);
-
-	if (rc == 0) {
-		if (kvm_is_ucontrol(vcpu->kvm))
-			/* Don't exit for host interrupts. */
-			rc = vcpu->arch.sie_block->icptcode ? -EOPNOTSUPP : 0;
-		else
-			rc = kvm_handle_sie_intercept(vcpu);
-	}
-
-	return rc;
+	return vcpu_post_run_fault_in_sie(vcpu);
 }
 
 static int __vcpu_run(struct kvm_vcpu *vcpu)
@@ -2233,18 +2226,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 		rc = 0;
 	}
 
-	if (rc == -EOPNOTSUPP) {
-		/* intercept cannot be handled in-kernel, prepare kvm-run */
-		kvm_run->exit_reason         = KVM_EXIT_S390_SIEIC;
-		kvm_run->s390_sieic.icptcode = vcpu->arch.sie_block->icptcode;
-		kvm_run->s390_sieic.ipa      = vcpu->arch.sie_block->ipa;
-		kvm_run->s390_sieic.ipb      = vcpu->arch.sie_block->ipb;
-		rc = 0;
-	}
-
 	if (rc == -EREMOTE) {
-		/* intercept was handled, but userspace support is needed
-		 * kvm_run has been prepared by the handler */
+		/* userspace support is needed, kvm_run has been prepared */
 		rc = 0;
 	}
 
-- 
2.3.0
