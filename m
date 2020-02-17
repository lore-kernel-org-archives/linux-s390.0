Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40464 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729304AbgBQOxM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 Feb 2020 09:53:12 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 2/2] merge vm/cpu create
Date: Mon, 17 Feb 2020 09:53:02 -0500
Message-Id: <20200217145302.19085-3-borntraeger@de.ibm.com>
In-Reply-To: <20200217145302.19085-1-borntraeger@de.ibm.com>
References: <c77dbb1b-0f4b-e40a-52a4-7110aec75e32@redhat.com>
 <20200217145302.19085-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: david@redhat.com
Cc: Ulrich.Weigand@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, frankja@linux.ibm.com, frankja@linux.vnet.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, mimu@linux.ibm.com, thuth@redhat.com

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 55 +++++++++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 15 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index a095d9695f18..10b20e17a7fe 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2171,9 +2171,41 @@ static int kvm_s390_set_cmma_bits(struct kvm *kvm,
 	return r;
 }
 
+static int kvm_s390_switch_from_pv(struct kvm *kvm, u16 *rc, u16 *rrc)
+{
+	int i, r = 0;
+
+	struct kvm_vcpu *vcpu;
+
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		r = kvm_s390_pv_destroy_cpu(vcpu, rc, rrc);
+		if (r)
+			break;
+	}
+	return r;
+}
+
+static int kvm_s390_switch_to_pv(struct kvm *kvm, u16 *rc, u16 *rrc)
+{
+	int i, r = 0;
+	u16 dummy;
+
+	struct kvm_vcpu *vcpu;
+
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		r = kvm_s390_pv_create_cpu(vcpu, rc, rrc);
+		if (r)
+			break;
+	}
+	if (r)
+		kvm_s390_switch_from_pv(kvm,&dummy, &dummy);
+	return r;
+}
+
 static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)
 {
 	int r = 0;
+	u16 dummy;
 	void __user *argp = (void __user *)cmd->data;
 
 	switch (cmd->cmd) {
@@ -2204,6 +2236,11 @@ static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)
 			break;
 		}
 		r = kvm_s390_pv_create_vm(kvm, &cmd->rc, &cmd->rrc);
+		if (!r)
+			r = kvm_s390_switch_to_pv(kvm, &cmd->rc, &cmd->rrc);
+		if (r)
+			kvm_s390_pv_destroy_vm(kvm, &dummy, &dummy);
+
 		kvm_s390_vcpu_unblock_all(kvm);
 		/* we need to block service interrupts from now on */
 		set_bit(IRQ_PEND_EXT_SERVICE, &kvm->arch.float_int.masked_irqs);
@@ -2215,7 +2252,9 @@ static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)
 			break;
 
 		kvm_s390_vcpu_block_all(kvm);
-		r = kvm_s390_pv_destroy_vm(kvm, &cmd->rc, &cmd->rrc);
+		r = kvm_s390_switch_from_pv(kvm, &cmd->rc, &cmd->rrc);
+		if (!r)
+			r = kvm_s390_pv_destroy_vm(kvm, &cmd->rc, &cmd->rrc);
 		if (!r)
 			kvm_s390_pv_dealloc_vm(kvm);
 		kvm_s390_vcpu_unblock_all(kvm);
@@ -4660,20 +4699,6 @@ static int kvm_s390_handle_pv_vcpu(struct kvm_vcpu *vcpu,
 		return -EINVAL;
 
 	switch (cmd->cmd) {
-	case KVM_PV_VCPU_CREATE: {
-		if (kvm_s390_pv_handle_cpu(vcpu))
-			return -EINVAL;
-
-		r = kvm_s390_pv_create_cpu(vcpu, &cmd->rc, &cmd->rrc);
-		break;
-	}
-	case KVM_PV_VCPU_DESTROY: {
-		if (!kvm_s390_pv_handle_cpu(vcpu))
-			return -EINVAL;
-
-		r = kvm_s390_pv_destroy_cpu(vcpu, &cmd->rc, &cmd->rrc);
-		break;
-	}
 	case KVM_PV_VCPU_SET_IPL_PSW: {
 		if (!kvm_s390_pv_handle_cpu(vcpu))
 			return -EINVAL;
-- 
2.25.0
