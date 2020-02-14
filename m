Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5614 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728143AbgBNW1j (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 14 Feb 2020 17:27:39 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v2 35/42] KVM: s390: protvirt: Add UV cpu reset calls
Date: Fri, 14 Feb 2020 17:26:51 -0500
Message-Id: <20200214222658.12946-36-borntraeger@de.ibm.com>
In-Reply-To: <20200214222658.12946-1-borntraeger@de.ibm.com>
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

From: Janosch Frank <frankja@linux.ibm.com>

For protected VMs, the VCPU resets are done by the Ultravisor, as KVM
has no access to the VCPU registers.

Note that the ultravisor will only accept a call for the exact reset
that has been requested.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
[borntraeger@de.ibm.com: patch merging, splitting, fixing]
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/uv.h |  6 ++++++
 arch/s390/kvm/kvm-s390.c   | 20 ++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
index d59825d95b9d..d4fb54231932 100644
--- a/arch/s390/include/asm/uv.h
+++ b/arch/s390/include/asm/uv.h
@@ -36,7 +36,10 @@
 #define UVC_CMD_SET_SEC_CONF_PARAMS	0x0300
 #define UVC_CMD_UNPACK_IMG		0x0301
 #define UVC_CMD_VERIFY_IMG		0x0302
+#define UVC_CMD_CPU_RESET		0x0310
+#define UVC_CMD_CPU_RESET_INITIAL	0x0311
 #define UVC_CMD_PREPARE_RESET		0x0320
+#define UVC_CMD_CPU_RESET_CLEAR		0x0321
 #define UVC_CMD_CPU_SET_STATE		0x0330
 #define UVC_CMD_SET_UNSHARE_ALL		0x0340
 #define UVC_CMD_PIN_PAGE_SHARED		0x0341
@@ -59,8 +62,11 @@ enum uv_cmds_inst {
 	BIT_UVC_CMD_SET_SEC_PARMS = 11,
 	BIT_UVC_CMD_UNPACK_IMG = 13,
 	BIT_UVC_CMD_VERIFY_IMG = 14,
+	BIT_UVC_CMD_CPU_RESET = 15,
+	BIT_UVC_CMD_CPU_RESET_INITIAL = 16,
 	BIT_UVC_CMD_CPU_SET_STATE = 17,
 	BIT_UVC_CMD_PREPARE_RESET = 18,
+	BIT_UVC_CMD_CPU_PERFORM_CLEAR_RESET = 19,
 	BIT_UVC_CMD_UNSHARE_ALL = 20,
 	BIT_UVC_CMD_PIN_PAGE_SHARED = 21,
 	BIT_UVC_CMD_UNPIN_PAGE_SHARED = 22,
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 16af4d1a2c29..932f7f32e82f 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -4695,6 +4695,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	void __user *argp = (void __user *)arg;
 	int idx;
 	long r;
+	u16 rc, rrc;
 
 	vcpu_load(vcpu);
 
@@ -4716,14 +4717,33 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	case KVM_S390_CLEAR_RESET:
 		r = 0;
 		kvm_arch_vcpu_ioctl_clear_reset(vcpu);
+		if (kvm_s390_pv_handle_cpu(vcpu)) {
+			r = uv_cmd_nodata(kvm_s390_pv_handle_cpu(vcpu),
+					  UVC_CMD_CPU_RESET_CLEAR, &rc, &rrc);
+			VCPU_EVENT(vcpu, 3, "PROTVIRT RESET CLEAR VCPU: rc %x rrc %x",
+				   rc, rrc);
+		}
 		break;
 	case KVM_S390_INITIAL_RESET:
 		r = 0;
 		kvm_arch_vcpu_ioctl_initial_reset(vcpu);
+		if (kvm_s390_pv_handle_cpu(vcpu)) {
+			r = uv_cmd_nodata(kvm_s390_pv_handle_cpu(vcpu),
+					  UVC_CMD_CPU_RESET_INITIAL,
+					  &rc, &rrc);
+			VCPU_EVENT(vcpu, 3, "PROTVIRT RESET INITIAL VCPU: rc %x rrc %x",
+				   rc, rrc);
+		}
 		break;
 	case KVM_S390_NORMAL_RESET:
 		r = 0;
 		kvm_arch_vcpu_ioctl_normal_reset(vcpu);
+		if (kvm_s390_pv_handle_cpu(vcpu)) {
+			r = uv_cmd_nodata(kvm_s390_pv_handle_cpu(vcpu),
+					  UVC_CMD_CPU_RESET, &rc, &rrc);
+			VCPU_EVENT(vcpu, 3, "PROTVIRT RESET NORMAL VCPU: rc %x rrc %x",
+				   rc, rrc);
+		}
 		break;
 	case KVM_SET_ONE_REG:
 	case KVM_GET_ONE_REG: {
-- 
2.25.0
