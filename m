Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47844 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726808AbfK2OVo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 29 Nov 2019 09:21:44 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xATEIamC044787
        for <linux-s390@vger.kernel.org>; Fri, 29 Nov 2019 09:21:43 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wjvfgh896-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 29 Nov 2019 09:21:43 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Fri, 29 Nov 2019 14:21:41 -0000
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH] KVM: s390: Add new reset vcpu API
Date: Fri, 29 Nov 2019 09:21:22 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20191129142122.21528-1-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, mihajlov@linux.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org

The architecture states that we need to reset local IRQs for all CPU
resets. Because the old reset interface did not support the normal CPU
reset we never did that.

Now that we have a new interface, let's properly clear out local IRQs
and let this commit be a reminder.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 25 ++++++++++++++++++++++++-
 include/uapi/linux/kvm.h |  7 +++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index d9e6bf3d54f0..2f74ff46b176 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -529,6 +529,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_S390_CMMA_MIGRATION:
 	case KVM_CAP_S390_AIS:
 	case KVM_CAP_S390_AIS_MIGRATION:
+	case KVM_CAP_S390_VCPU_RESETS:
 		r = 1;
 		break;
 	case KVM_CAP_S390_HPAGE_1M:
@@ -3293,6 +3294,25 @@ static int kvm_arch_vcpu_ioctl_initial_reset(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+static int kvm_arch_vcpu_ioctl_reset(struct kvm_vcpu *vcpu, unsigned long type)
+{
+	int rc = -EINVAL;
+
+	switch (type) {
+	case KVM_S390_VCPU_RESET_NORMAL:
+		rc = 0;
+		kvm_clear_async_pf_completion_queue(vcpu);
+		kvm_s390_clear_local_irqs(vcpu);
+		break;
+	case KVM_S390_VCPU_RESET_INITIAL:
+		/* fallthrough */
+	case KVM_S390_VCPU_RESET_CLEAR:
+		rc = kvm_arch_vcpu_ioctl_initial_reset(vcpu);
+		break;
+	}
+	return rc;
+}
+
 int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
 	vcpu_load(vcpu);
@@ -4364,7 +4384,10 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		break;
 	}
 	case KVM_S390_INITIAL_RESET:
-		r = kvm_arch_vcpu_ioctl_initial_reset(vcpu);
+		arg = KVM_S390_VCPU_RESET_INITIAL;
+		/* fallthrough */
+	case KVM_S390_VCPU_RESET:
+		r = kvm_arch_vcpu_ioctl_reset(vcpu, arg);
 		break;
 	case KVM_SET_ONE_REG:
 	case KVM_GET_ONE_REG: {
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 52641d8ca9e8..6da16b1f2c86 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1000,6 +1000,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_PMU_EVENT_FILTER 173
 #define KVM_CAP_ARM_IRQ_LINE_LAYOUT_2 174
 #define KVM_CAP_HYPERV_DIRECT_TLBFLUSH 175
+#define KVM_CAP_S390_VCPU_RESETS 180
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1461,6 +1462,12 @@ struct kvm_enc_region {
 /* Available with KVM_CAP_ARM_SVE */
 #define KVM_ARM_VCPU_FINALIZE	  _IOW(KVMIO,  0xc2, int)
 
+#define KVM_S390_VCPU_RESET_NORMAL	0
+#define KVM_S390_VCPU_RESET_INITIAL	1
+#define KVM_S390_VCPU_RESET_CLEAR	2
+
+#define KVM_S390_VCPU_RESET    _IO(KVMIO,   0xc3)
+
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
 	/* Guest initialization commands */
-- 
2.20.1
