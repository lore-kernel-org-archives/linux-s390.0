From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 6/9] KVM: s390: sigp: separate preparation handlers
Date: Tue, 28 Oct 2014 20:39:56 +0100
Message-ID: <1414525199-53989-7-git-send-email-borntraeger@de.ibm.com>
References: <1414525199-53989-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1414525199-53989-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

This patch introduces in preparation for further code changes separate handler
functions for:
- SIGP (RE)START - will not be allowed to terminate pending orders
- SIGP (INITIAL) CPU RESET - will be allowed to terminate certain pending orders
- unknown sigp orders

All sigp orders that require user space intervention are logged.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/sigp.h |  1 +
 arch/s390/kvm/sigp.c         | 47 ++++++++++++++++++++++++++++++--------------
 2 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/arch/s390/include/asm/sigp.h b/arch/s390/include/asm/sigp.h
index 4957611..fad4ae2 100644
--- a/arch/s390/include/asm/sigp.h
+++ b/arch/s390/include/asm/sigp.h
@@ -10,6 +10,7 @@
 #define SIGP_RESTART		      6
 #define SIGP_STOP_AND_STORE_STATUS    9
 #define SIGP_INITIAL_CPU_RESET	     11
+#define SIGP_CPU_RESET		     12
 #define SIGP_SET_PREFIX		     13
 #define SIGP_STORE_STATUS_AT_ADDRESS 14
 #define SIGP_SET_ARCHITECTURE	     18
diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index 660a945..a9e1739 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -284,11 +284,12 @@ static int __sigp_sense_running(struct kvm_vcpu *vcpu,
 	return rc;
 }
 
-/* Test whether the destination CPU is available and not busy */
-static int sigp_check_callable(struct kvm_vcpu *vcpu, struct kvm_vcpu *dst_vcpu)
+static int __prepare_sigp_re_start(struct kvm_vcpu *vcpu,
+				   struct kvm_vcpu *dst_vcpu, u8 order_code)
 {
 	struct kvm_s390_local_interrupt *li = &dst_vcpu->arch.local_int;
-	int rc = SIGP_CC_ORDER_CODE_ACCEPTED;
+	/* handle (RE)START in user space */
+	int rc = -EOPNOTSUPP;
 
 	spin_lock(&li->lock);
 	if (li->action_bits & ACTION_STOP_ON_STOP)
@@ -298,6 +299,20 @@ static int sigp_check_callable(struct kvm_vcpu *vcpu, struct kvm_vcpu *dst_vcpu)
 	return rc;
 }
 
+static int __prepare_sigp_cpu_reset(struct kvm_vcpu *vcpu,
+				    struct kvm_vcpu *dst_vcpu, u8 order_code)
+{
+	/* handle (INITIAL) CPU RESET in user space */
+	return -EOPNOTSUPP;
+}
+
+static int __prepare_sigp_unknown(struct kvm_vcpu *vcpu,
+				  struct kvm_vcpu *dst_vcpu)
+{
+	/* handle unknown orders in user space */
+	return -EOPNOTSUPP;
+}
+
 static int handle_sigp_dst(struct kvm_vcpu *vcpu, u8 order_code,
 			   u16 cpu_addr, u32 parameter, u64 *status_reg)
 {
@@ -350,25 +365,27 @@ static int handle_sigp_dst(struct kvm_vcpu *vcpu, u8 order_code,
 		rc = __sigp_sense_running(vcpu, dst_vcpu, status_reg);
 		break;
 	case SIGP_START:
-		rc = sigp_check_callable(vcpu, dst_vcpu);
-		if (rc == SIGP_CC_ORDER_CODE_ACCEPTED)
-			rc = -EOPNOTSUPP;    /* Handle START in user space */
+		rc = __prepare_sigp_re_start(vcpu, dst_vcpu, order_code);
 		break;
 	case SIGP_RESTART:
 		vcpu->stat.instruction_sigp_restart++;
-		rc = sigp_check_callable(vcpu, dst_vcpu);
-		if (rc == SIGP_CC_ORDER_CODE_ACCEPTED) {
-			VCPU_EVENT(vcpu, 4,
-				   "sigp restart %x to handle userspace",
-				   cpu_addr);
-			/* user space must know about restart */
-			rc = -EOPNOTSUPP;
-		}
+		rc = __prepare_sigp_re_start(vcpu, dst_vcpu, order_code);
+		break;
+	case SIGP_INITIAL_CPU_RESET:
+		rc = __prepare_sigp_cpu_reset(vcpu, dst_vcpu, order_code);
+		break;
+	case SIGP_CPU_RESET:
+		rc = __prepare_sigp_cpu_reset(vcpu, dst_vcpu, order_code);
 		break;
 	default:
-		rc = -EOPNOTSUPP;
+		rc = __prepare_sigp_unknown(vcpu, dst_vcpu);
 	}
 
+	if (rc == -EOPNOTSUPP)
+		VCPU_EVENT(vcpu, 4,
+			   "sigp order %u -> cpu %x: handled in user space",
+			   order_code, dst_vcpu->vcpu_id);
+
 	return rc;
 }
 
-- 
1.9.3
