From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 1/8] KVM: s390: Remove dead "rerun vcpu" code
Date: Thu, 12 Sep 2013 10:33:42 +0200
Message-ID: <1378974829-46578-2-git-send-email-borntraeger@de.ibm.com>
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

The need for SIE_INTERCEPT_RERUNVCPU has been removed long ago already,
with the following commit:
	f7850c92884b40915001e332a0a33ed4f10158e8
	[S390] remove kvm mmu reload on s390
Since the remainders are dead code, they are now removed by this patch.

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 1 -
 arch/s390/kvm/intercept.c        | 6 ------
 arch/s390/kvm/kvm-s390.c         | 4 ----
 arch/s390/kvm/kvm-s390.h         | 3 +--
 4 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index e87ecaa..6a0e27b 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -220,7 +220,6 @@ struct kvm_s390_interrupt_info {
 /* for local_interrupt.action_flags */
 #define ACTION_STORE_ON_STOP		(1<<0)
 #define ACTION_STOP_ON_STOP		(1<<1)
-#define ACTION_RELOADVCPU_ON_STOP	(1<<2)
 
 struct kvm_s390_local_interrupt {
 	spinlock_t lock;
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 5ee56e5..5ddbbde 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -62,12 +62,6 @@ static int handle_stop(struct kvm_vcpu *vcpu)
 
 	trace_kvm_s390_stop_request(vcpu->arch.local_int.action_bits);
 
-	if (vcpu->arch.local_int.action_bits & ACTION_RELOADVCPU_ON_STOP) {
-		vcpu->arch.local_int.action_bits &= ~ACTION_RELOADVCPU_ON_STOP;
-		rc = SIE_INTERCEPT_RERUNVCPU;
-		vcpu->run->exit_reason = KVM_EXIT_INTR;
-	}
-
 	if (vcpu->arch.local_int.action_bits & ACTION_STOP_ON_STOP) {
 		atomic_set_mask(CPUSTAT_STOPPED,
 				&vcpu->arch.sie_block->cpuflags);
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 776dafe..e3e7ff7 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -749,7 +749,6 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 	int rc;
 	sigset_t sigsaved;
 
-rerun_vcpu:
 	if (vcpu->sigset_active)
 		sigprocmask(SIG_SETMASK, &vcpu->sigset, &sigsaved);
 
@@ -793,9 +792,6 @@ rerun_vcpu:
 			rc = kvm_handle_sie_intercept(vcpu);
 	} while (!signal_pending(current) && !rc);
 
-	if (rc == SIE_INTERCEPT_RERUNVCPU)
-		goto rerun_vcpu;
-
 	if (signal_pending(current) && !rc) {
 		kvm_run->exit_reason = KVM_EXIT_INTR;
 		rc = -EINTR;
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index dc99f1c..a307a85 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -28,8 +28,7 @@ typedef int (*intercept_handler_t)(struct kvm_vcpu *vcpu);
 extern unsigned long *vfacilities;
 
 /* negativ values are error codes, positive values for internal conditions */
-#define SIE_INTERCEPT_RERUNVCPU		(1<<0)
-#define SIE_INTERCEPT_UCONTROL		(1<<1)
+#define SIE_INTERCEPT_UCONTROL		(1<<0)
 int kvm_handle_sie_intercept(struct kvm_vcpu *vcpu);
 
 #define VM_EVENT(d_kvm, d_loglevel, d_string, d_args...)\
-- 
1.8.3.1
