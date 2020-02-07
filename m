Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37662 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727114AbgBGLkI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 7 Feb 2020 06:40:08 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 28/35] KVM: s390: protvirt: UV calls diag308 0, 1
Date: Fri,  7 Feb 2020 06:39:51 -0500
Message-Id: <20200207113958.7320-29-borntraeger@de.ibm.com>
In-Reply-To: <20200207113958.7320-1-borntraeger@de.ibm.com>
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

From: Janosch Frank <frankja@linux.ibm.com>

diag 308 subcode 0 and 1 require KVM and Ultravisor interaction, since
the cpus have to be set into multiple reset states.

* All cpus need to be stopped
* The "unshare all" UVC needs to be executed
* The "perform reset" UVC needs to be executed
* The cpus need to be reset via the "set cpu state" UVC
* The issuing cpu needs to set state 5 via "set cpu state"

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
[borntraeger@de.ibm.com: patch merging, splitting, fixing]
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/uv.h | 25 +++++++++++++++++++++++++
 arch/s390/kvm/diag.c       |  1 +
 arch/s390/kvm/kvm-s390.c   | 28 ++++++++++++++++++++++++++++
 arch/s390/kvm/kvm-s390.h   |  1 +
 include/uapi/linux/kvm.h   |  2 ++
 5 files changed, 57 insertions(+)

diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
index 7c21d55d2e49..237d0b417d07 100644
--- a/arch/s390/include/asm/uv.h
+++ b/arch/s390/include/asm/uv.h
@@ -36,6 +36,12 @@
 #define UVC_CMD_SET_SEC_CONF_PARAMS	0x0300
 #define UVC_CMD_UNPACK_IMG		0x0301
 #define UVC_CMD_VERIFY_IMG		0x0302
+#define UVC_CMD_CPU_RESET		0x0310
+#define UVC_CMD_CPU_RESET_INITIAL	0x0311
+#define UVC_CMD_PREPARE_RESET		0x0320
+#define UVC_CMD_CPU_RESET_CLEAR		0x0321
+#define UVC_CMD_CPU_SET_STATE		0x0330
+#define UVC_CMD_SET_UNSHARED_ALL	0x0340
 #define UVC_CMD_PIN_PAGE_SHARED		0x0341
 #define UVC_CMD_UNPIN_PAGE_SHARED	0x0342
 #define UVC_CMD_SET_SHARED_ACCESS	0x1000
@@ -56,6 +62,12 @@ enum uv_cmds_inst {
 	BIT_UVC_CMD_SET_SEC_PARMS = 11,
 	BIT_UVC_CMD_UNPACK_IMG = 13,
 	BIT_UVC_CMD_VERIFY_IMG = 14,
+	BIT_UVC_CMD_CPU_RESET = 15,
+	BIT_UVC_CMD_CPU_RESET_INITIAL = 16,
+	BIT_UVC_CMD_CPU_SET_STATE = 17,
+	BIT_UVC_CMD_PREPARE_RESET = 18,
+	BIT_UVC_CMD_CPU_PERFORM_CLEAR_RESET = 19,
+	BIT_UVC_CMD_UNSHARE_ALL = 20,
 	BIT_UVC_CMD_PIN_PAGE_SHARED = 21,
 	BIT_UVC_CMD_UNPIN_PAGE_SHARED = 22,
 };
@@ -160,6 +172,19 @@ struct uv_cb_unp {
 	u64 reserved38[3];
 } __packed __aligned(8);
 
+#define PV_CPU_STATE_OPR	1
+#define PV_CPU_STATE_STP	2
+#define PV_CPU_STATE_CHKSTP	3
+
+struct uv_cb_cpu_set_state {
+	struct uv_cb_header header;
+	u64 reserved08[2];
+	u64 cpu_handle;
+	u8  reserved20[7];
+	u8  state;
+	u64 reserved28[5];
+};
+
 /*
  * A common UV call struct for calls that take no payload
  * Examples:
diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index 3fb54ec2cf3e..390830385b9f 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -13,6 +13,7 @@
 #include <asm/pgalloc.h>
 #include <asm/gmap.h>
 #include <asm/virtio-ccw.h>
+#include <asm/uv.h>
 #include "kvm-s390.h"
 #include "trace.h"
 #include "trace-s390.h"
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 4afa44e3d1ed..0be18ac1afb5 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2280,6 +2280,34 @@ static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)
 			 ret >> 16, ret & 0x0000ffff);
 		break;
 	}
+	case KVM_PV_VM_PREP_RESET: {
+		u32 ret;
+
+		r = -EINVAL;
+		if (!kvm_s390_pv_is_protected(kvm))
+			break;
+
+		r = uv_cmd_nodata(kvm_s390_pv_handle(kvm),
+				  UVC_CMD_PREPARE_RESET,
+				  &ret);
+		VM_EVENT(kvm, 3, "PROTVIRT PREP RESET: rc %x rrc %x",
+			 ret >> 16, ret & 0x0000ffff);
+		break;
+	}
+	case KVM_PV_VM_UNSHARE_ALL: {
+		u32 ret;
+
+		r = -EINVAL;
+		if (!kvm_s390_pv_is_protected(kvm))
+			break;
+
+		r = uv_cmd_nodata(kvm_s390_pv_handle(kvm),
+				  UVC_CMD_SET_UNSHARED_ALL,
+				  &ret);
+		VM_EVENT(kvm, 3, "PROTVIRT UNSHARE: %d rc %x rrc %x",
+			 r, ret >> 16, ret & 0x0000ffff);
+		break;
+	}
 	default:
 		return -ENOTTY;
 	}
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 32c0c01d5df0..7530042a44e9 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -207,6 +207,7 @@ int kvm_s390_pv_set_sec_parms(struct kvm *kvm, void *hdr, u64 length);
 int kvm_s390_pv_unpack(struct kvm *kvm, unsigned long addr, unsigned long size,
 		       unsigned long tweak);
 int kvm_s390_pv_verify(struct kvm *kvm);
+int kvm_s390_pv_set_cpu_state(struct kvm_vcpu *vcpu, u8 state);
 
 static inline bool kvm_s390_pv_is_protected(struct kvm *kvm)
 {
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 51d4018c3be3..864e73bd40e4 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1500,6 +1500,8 @@ enum pv_cmd_id {
 	KVM_PV_VM_SET_SEC_PARMS,
 	KVM_PV_VM_UNPACK,
 	KVM_PV_VM_VERIFY,
+	KVM_PV_VM_PREP_RESET,
+	KVM_PV_VM_UNSHARE_ALL,
 	KVM_PV_VCPU_CREATE,
 	KVM_PV_VCPU_DESTROY,
 };
-- 
2.24.0
