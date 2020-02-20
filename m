Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9646 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727592AbgBTKka (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 20 Feb 2020 05:40:30 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v3 28/37] KVM: s390: protvirt: UV calls in support of diag308 0, 1
Date: Thu, 20 Feb 2020 05:40:11 -0500
Message-Id: <20200220104020.5343-29-borntraeger@de.ibm.com>
In-Reply-To: <20200220104020.5343-1-borntraeger@de.ibm.com>
References: <20200220104020.5343-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

From: Janosch Frank <frankja@linux.ibm.com>

diag 308 subcode 0 and 1 require several KVM and Ultravisor interactions.
Specific to these "soft" reboots are

* The "unshare all" UVC
* The "prepare for reset" UVC

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
[borntraeger@de.ibm.com: patch merging, splitting, fixing]
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/uv.h |  4 ++++
 arch/s390/kvm/kvm-s390.c   | 22 ++++++++++++++++++++++
 include/uapi/linux/kvm.h   |  2 ++
 3 files changed, 28 insertions(+)

diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
index 09dc6dba94a4..a7595c647759 100644
--- a/arch/s390/include/asm/uv.h
+++ b/arch/s390/include/asm/uv.h
@@ -36,6 +36,8 @@
 #define UVC_CMD_SET_SEC_CONF_PARAMS	0x0300
 #define UVC_CMD_UNPACK_IMG		0x0301
 #define UVC_CMD_VERIFY_IMG		0x0302
+#define UVC_CMD_PREPARE_RESET		0x0320
+#define UVC_CMD_SET_UNSHARE_ALL		0x0340
 #define UVC_CMD_PIN_PAGE_SHARED		0x0341
 #define UVC_CMD_UNPIN_PAGE_SHARED	0x0342
 #define UVC_CMD_SET_SHARED_ACCESS	0x1000
@@ -56,6 +58,8 @@ enum uv_cmds_inst {
 	BIT_UVC_CMD_SET_SEC_PARMS = 11,
 	BIT_UVC_CMD_UNPACK_IMG = 13,
 	BIT_UVC_CMD_VERIFY_IMG = 14,
+	BIT_UVC_CMD_PREPARE_RESET = 18,
+	BIT_UVC_CMD_UNSHARE_ALL = 20,
 	BIT_UVC_CMD_PIN_PAGE_SHARED = 21,
 	BIT_UVC_CMD_UNPIN_PAGE_SHARED = 22,
 };
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 303f994f3d03..9ac73b717e25 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2310,6 +2310,28 @@ static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)
 			     cmd->rrc);
 		break;
 	}
+	case KVM_PV_VM_PREP_RESET: {
+		r = -EINVAL;
+		if (!kvm_s390_pv_is_protected(kvm))
+			break;
+
+		r = uv_cmd_nodata(kvm_s390_pv_get_handle(kvm),
+				  UVC_CMD_PREPARE_RESET, &cmd->rc, &cmd->rrc);
+		KVM_UV_EVENT(kvm, 3, "PROTVIRT PREP RESET: rc %x rrc %x",
+			     cmd->rc, cmd->rrc);
+		break;
+	}
+	case KVM_PV_VM_UNSHARE_ALL: {
+		r = -EINVAL;
+		if (!kvm_s390_pv_is_protected(kvm))
+			break;
+
+		r = uv_cmd_nodata(kvm_s390_pv_get_handle(kvm),
+				  UVC_CMD_SET_UNSHARE_ALL, &cmd->rc, &cmd->rrc);
+		KVM_UV_EVENT(kvm, 3, "PROTVIRT UNSHARE: rc %x rrc %x",
+			     cmd->rc, cmd->rrc);
+		break;
+	}
 	default:
 		return -ENOTTY;
 	}
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 69ccbbabfc03..60efbbc86209 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1500,6 +1500,8 @@ enum pv_cmd_id {
 	KVM_PV_VM_SET_SEC_PARMS,
 	KVM_PV_VM_UNPACK,
 	KVM_PV_VM_VERIFY,
+	KVM_PV_VM_PREP_RESET,
+	KVM_PV_VM_UNSHARE_ALL,
 };
 
 struct kvm_pv_cmd {
-- 
2.25.0
