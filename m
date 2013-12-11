From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PULL 4/6] KVM: s390: Reworked SIGP RESTART order
Date: Wed, 11 Dec 2013 19:57:47 +0100
Message-ID: <1386788269-20249-5-git-send-email-cornelia.huck@de.ibm.com>
References: <1386788269-20249-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1386788269-20249-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, Thomas Huth <thuth@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Huth <thuth@linux.vnet.ibm.com>

When SIGP RESTART detected an illegal CPU address, there is no need to
drop to userspace, we can return CC3 to the guest directly instead.
Also renamed __sigp_restart() to sigp_check_callable() (since this
is a better description of what the function is really doing) and
moved a string specific to RESTART to the calling place instead, so
that this function gets usable by other SIGP orders, too.

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/sigp.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index eee1402..509547d 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -363,7 +363,8 @@ static int __sigp_sense_running(struct kvm_vcpu *vcpu, u16 cpu_addr,
 	return rc;
 }
 
-static int __sigp_restart(struct kvm_vcpu *vcpu, u16 cpu_addr)
+/* Test whether the destination CPU is available and not busy */
+static int sigp_check_callable(struct kvm_vcpu *vcpu, u16 cpu_addr)
 {
 	struct kvm_s390_float_interrupt *fi = &vcpu->kvm->arch.float_int;
 	struct kvm_s390_local_interrupt *li;
@@ -382,9 +383,6 @@ static int __sigp_restart(struct kvm_vcpu *vcpu, u16 cpu_addr)
 	spin_lock_bh(&li->lock);
 	if (li->action_bits & ACTION_STOP_ON_STOP)
 		rc = SIGP_CC_BUSY;
-	else
-		VCPU_EVENT(vcpu, 4, "sigp restart %x to handle userspace",
-			cpu_addr);
 	spin_unlock_bh(&li->lock);
 out:
 	spin_unlock(&fi->lock);
@@ -459,10 +457,15 @@ int kvm_s390_handle_sigp(struct kvm_vcpu *vcpu)
 		break;
 	case SIGP_RESTART:
 		vcpu->stat.instruction_sigp_restart++;
-		rc = __sigp_restart(vcpu, cpu_addr);
-		if (rc == SIGP_CC_BUSY)
-			break;
-		/* user space must know about restart */
+		rc = sigp_check_callable(vcpu, cpu_addr);
+		if (rc == SIGP_CC_ORDER_CODE_ACCEPTED) {
+			VCPU_EVENT(vcpu, 4,
+				   "sigp restart %x to handle userspace",
+				   cpu_addr);
+			/* user space must know about restart */
+			rc = -EOPNOTSUPP;
+		}
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
1.7.9.5
