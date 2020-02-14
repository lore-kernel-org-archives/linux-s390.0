Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37384 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728090AbgBNW1f (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 14 Feb 2020 17:27:35 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v2 31/42] KVM: s390: protvirt: Report CPU state to Ultravisor
Date: Fri, 14 Feb 2020 17:26:47 -0500
Message-Id: <20200214222658.12946-32-borntraeger@de.ibm.com>
In-Reply-To: <20200214222658.12946-1-borntraeger@de.ibm.com>
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

From: Janosch Frank <frankja@linux.ibm.com>

VCPU states have to be reported to the ultravisor for SIGP
interpretation, kdump, kexec and reboot.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
[borntraeger@de.ibm.com: patch merging, splitting, fixing]
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/uv.h | 15 +++++++++++++++
 arch/s390/kvm/kvm-s390.c   |  7 ++++++-
 arch/s390/kvm/kvm-s390.h   |  2 ++
 arch/s390/kvm/pv.c         | 22 ++++++++++++++++++++++
 4 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
index 254d5769d136..7b82881ec3b4 100644
--- a/arch/s390/include/asm/uv.h
+++ b/arch/s390/include/asm/uv.h
@@ -37,6 +37,7 @@
 #define UVC_CMD_UNPACK_IMG		0x0301
 #define UVC_CMD_VERIFY_IMG		0x0302
 #define UVC_CMD_PREPARE_RESET		0x0320
+#define UVC_CMD_CPU_SET_STATE		0x0330
 #define UVC_CMD_SET_UNSHARE_ALL		0x0340
 #define UVC_CMD_PIN_PAGE_SHARED		0x0341
 #define UVC_CMD_UNPIN_PAGE_SHARED	0x0342
@@ -58,6 +59,7 @@ enum uv_cmds_inst {
 	BIT_UVC_CMD_SET_SEC_PARMS = 11,
 	BIT_UVC_CMD_UNPACK_IMG = 13,
 	BIT_UVC_CMD_VERIFY_IMG = 14,
+	BIT_UVC_CMD_CPU_SET_STATE = 17,
 	BIT_UVC_CMD_PREPARE_RESET = 18,
 	BIT_UVC_CMD_UNSHARE_ALL = 20,
 	BIT_UVC_CMD_PIN_PAGE_SHARED = 21,
@@ -164,6 +166,19 @@ struct uv_cb_unp {
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
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index ad84c1144908..5426b01e3da1 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -4396,6 +4396,7 @@ static void __enable_ibs_on_vcpu(struct kvm_vcpu *vcpu)
 void kvm_s390_vcpu_start(struct kvm_vcpu *vcpu)
 {
 	int i, online_vcpus, started_vcpus = 0;
+	u16 rc, rrc;
 
 	if (!is_vcpu_stopped(vcpu))
 		return;
@@ -4421,7 +4422,8 @@ void kvm_s390_vcpu_start(struct kvm_vcpu *vcpu)
 		 */
 		__disable_ibs_on_all_vcpus(vcpu->kvm);
 	}
-
+	/* Let's tell the UV that we want to start again */
+	kvm_s390_pv_set_cpu_state(vcpu, PV_CPU_STATE_OPR, &rc, &rrc);
 	kvm_s390_clear_cpuflags(vcpu, CPUSTAT_STOPPED);
 	/*
 	 * Another VCPU might have used IBS while we were offline.
@@ -4436,6 +4438,7 @@ void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu)
 {
 	int i, online_vcpus, started_vcpus = 0;
 	struct kvm_vcpu *started_vcpu = NULL;
+	u16 rc, rrc;
 
 	if (is_vcpu_stopped(vcpu))
 		return;
@@ -4449,6 +4452,8 @@ void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu)
 	kvm_s390_clear_stop_irq(vcpu);
 
 	kvm_s390_set_cpuflags(vcpu, CPUSTAT_STOPPED);
+	/* Let's tell the UV that we successfully stopped the vcpu */
+	kvm_s390_pv_set_cpu_state(vcpu, PV_CPU_STATE_STP, &rc, &rrc);
 	__disable_ibs_on_vcpu(vcpu);
 
 	for (i = 0; i < online_vcpus; i++) {
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index d5503dd0d1e4..1af1e30beead 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -218,6 +218,8 @@ int kvm_s390_pv_set_sec_parms(struct kvm *kvm, void *hdr, u64 length, u16 *rc,
 			      u16 *rrc);
 int kvm_s390_pv_unpack(struct kvm *kvm, unsigned long addr, unsigned long size,
 		       unsigned long tweak, u16 *rc, u16 *rrc);
+int kvm_s390_pv_set_cpu_state(struct kvm_vcpu *vcpu, u8 state, u16 *rc,
+			      u16 *rrc);
 
 static inline bool kvm_s390_pv_is_protected(struct kvm *kvm)
 {
diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
index 80169a9b43ec..b4bf6b6eb708 100644
--- a/arch/s390/kvm/pv.c
+++ b/arch/s390/kvm/pv.c
@@ -271,3 +271,25 @@ int kvm_s390_pv_unpack(struct kvm *kvm, unsigned long addr, unsigned long size,
 		KVM_UV_EVENT(kvm, 3, "%s", "PROTVIRT VM UNPACK: successful");
 	return ret;
 }
+
+int kvm_s390_pv_set_cpu_state(struct kvm_vcpu *vcpu, u8 state, u16 *rc,
+			      u16 *rrc)
+{
+	struct uv_cb_cpu_set_state uvcb = {
+		.header.cmd	= UVC_CMD_CPU_SET_STATE,
+		.header.len	= sizeof(uvcb),
+		.cpu_handle	= kvm_s390_pv_handle_cpu(vcpu),
+		.state		= state,
+	};
+	int cc;
+
+	if (!kvm_s390_pv_handle_cpu(vcpu))
+		return -EINVAL;
+
+	cc = uv_call(0, (u64)&uvcb);
+	*rc = uvcb.header.rc;
+	*rrc = uvcb.header.rrc;
+	if (cc)
+		return -EINVAL;
+	return 0;
+}
-- 
2.25.0
