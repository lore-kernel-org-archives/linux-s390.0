From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 9/9] KVM: s390: sigp: split handling of SIGP STOP (AND STORE STATUS)
Date: Tue, 28 Oct 2014 20:39:59 +0100
Message-ID: <1414525199-53989-10-git-send-email-borntraeger@de.ibm.com>
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

In preparation for further code changes (e.g. getting rid of action_flags),
this patch splits the handling of the two sigp orders SIGP STOP and SIGP STOP
AND STORE STATUS by introducing a separate handler function for SIGP STOP AND
STORE STATUS.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/sigp.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index 1b330d4..f7cd3f7 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -147,15 +147,27 @@ out:
 	return rc;
 }
 
-static int __sigp_stop(struct kvm_vcpu *vcpu, struct kvm_vcpu *dst_vcpu,
-		       int action)
+static int __sigp_stop(struct kvm_vcpu *vcpu, struct kvm_vcpu *dst_vcpu)
 {
 	int rc;
 
-	rc = __inject_sigp_stop(dst_vcpu, action);
+	rc = __inject_sigp_stop(dst_vcpu, ACTION_STOP_ON_STOP);
 	VCPU_EVENT(vcpu, 4, "sent sigp stop to cpu %x", dst_vcpu->vcpu_id);
 
-	if ((action & ACTION_STORE_ON_STOP) != 0 && rc == -ESHUTDOWN) {
+	return rc;
+}
+
+static int __sigp_stop_and_store_status(struct kvm_vcpu *vcpu,
+					struct kvm_vcpu *dst_vcpu, u64 *reg)
+{
+	int rc;
+
+	rc = __inject_sigp_stop(dst_vcpu, ACTION_STOP_ON_STOP |
+					      ACTION_STORE_ON_STOP);
+	VCPU_EVENT(vcpu, 4, "sent sigp stop and store status to cpu %x",
+		   dst_vcpu->vcpu_id);
+
+	if (rc == -ESHUTDOWN) {
 		/* If the CPU has already been stopped, we still have
 		 * to save the status when doing stop-and-store. This
 		 * has to be done after unlocking all spinlocks. */
@@ -347,12 +359,11 @@ static int handle_sigp_dst(struct kvm_vcpu *vcpu, u8 order_code,
 		break;
 	case SIGP_STOP:
 		vcpu->stat.instruction_sigp_stop++;
-		rc = __sigp_stop(vcpu, dst_vcpu, ACTION_STOP_ON_STOP);
+		rc = __sigp_stop(vcpu, dst_vcpu);
 		break;
 	case SIGP_STOP_AND_STORE_STATUS:
 		vcpu->stat.instruction_sigp_stop_store_status++;
-		rc = __sigp_stop(vcpu, dst_vcpu, ACTION_STORE_ON_STOP |
-						 ACTION_STOP_ON_STOP);
+		rc = __sigp_stop_and_store_status(vcpu, dst_vcpu, status_reg);
 		break;
 	case SIGP_STORE_STATUS_AT_ADDRESS:
 		vcpu->stat.instruction_sigp_store_status++;
-- 
1.9.3
