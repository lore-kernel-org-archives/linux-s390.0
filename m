From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 05/11] KVM: s390: Support Configuration z/Architecture Mode
Date: Mon, 28 Aug 2017 10:07:28 +0200
Message-ID: <1503907651-65296-2-git-send-email-borntraeger@de.ibm.com>
References: <1503907651-65296-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1503907651-65296-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>

kvm has always supported the concept of starting in z/Arch mode so let's
reflect the feature bit to the guest.

Also, we change sigp set architecture to reject any request to change
architecture modes.

Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/sigp.c             | 36 +++++++++++++++++-------------------
 arch/s390/tools/gen_facilities.c |  1 +
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index 1a252f5..11d3845 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -155,29 +155,26 @@ static int __sigp_stop_and_store_status(struct kvm_vcpu *vcpu,
 	return rc;
 }
 
-static int __sigp_set_arch(struct kvm_vcpu *vcpu, u32 parameter)
+static int __sigp_set_arch(struct kvm_vcpu *vcpu, u32 parameter,
+			   u64 *status_reg)
 {
-	int rc;
 	unsigned int i;
 	struct kvm_vcpu *v;
+	bool all_stopped = true;
 
-	switch (parameter & 0xff) {
-	case 0:
-		rc = SIGP_CC_NOT_OPERATIONAL;
-		break;
-	case 1:
-	case 2:
-		kvm_for_each_vcpu(i, v, vcpu->kvm) {
-			v->arch.pfault_token = KVM_S390_PFAULT_TOKEN_INVALID;
-			kvm_clear_async_pf_completion_queue(v);
-		}
-
-		rc = SIGP_CC_ORDER_CODE_ACCEPTED;
-		break;
-	default:
-		rc = -EOPNOTSUPP;
+	kvm_for_each_vcpu(i, v, vcpu->kvm) {
+		if (v == vcpu)
+			continue;
+		if (!is_vcpu_stopped(v))
+			all_stopped = false;
 	}
-	return rc;
+
+	*status_reg &= 0xffffffff00000000ULL;
+
+	/* Reject set arch order, with czam we're always in z/Arch mode. */
+	*status_reg |= (all_stopped ? SIGP_STATUS_INVALID_PARAMETER :
+					SIGP_STATUS_INCORRECT_STATE);
+	return SIGP_CC_STATUS_STORED;
 }
 
 static int __sigp_set_prefix(struct kvm_vcpu *vcpu, struct kvm_vcpu *dst_vcpu,
@@ -446,7 +443,8 @@ int kvm_s390_handle_sigp(struct kvm_vcpu *vcpu)
 	switch (order_code) {
 	case SIGP_SET_ARCHITECTURE:
 		vcpu->stat.instruction_sigp_arch++;
-		rc = __sigp_set_arch(vcpu, parameter);
+		rc = __sigp_set_arch(vcpu, parameter,
+				     &vcpu->run->s.regs.gprs[r1]);
 		break;
 	default:
 		rc = handle_sigp_dst(vcpu, order_code, cpu_addr,
diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
index 025ea20..181db5b 100644
--- a/arch/s390/tools/gen_facilities.c
+++ b/arch/s390/tools/gen_facilities.c
@@ -80,6 +80,7 @@ static struct facility_def facility_defs[] = {
 			78, /* enhanced-DAT 2 */
 			130, /* instruction-execution-protection */
 			131, /* enhanced-SOP 2 and side-effect */
+			138, /* configuration z/architecture mode (czam) */
 			146, /* msa extension 8 */
 			-1  /* END */
 		}
-- 
2.7.4
