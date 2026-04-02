Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EA938A717;
	Thu,  2 Apr 2026 04:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775103781; cv=none; b=OlaV8R05cRP7Q92KTcfm1GHUqkwwXsMfaCGjCgn0bYnPCvc4hxiOV60/zu3Z/x/1m2rALxpNPiXs5y/XaCMBkgvUBqj6bHwGuHvrLehPGYQWJhnfoNNIcCM+dq5+J8pBmxoejH86YizmZWnxLga9EJPs+bOId2GHHuye5fpWNNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775103781; c=relaxed/simple;
	bh=i1FFoQ7xIbR9G9aGBqmtZalenV3Uo4ivqpTf/Ddw9cY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VMaqhmGt7D8xjDDI+N5jIO8rui/FOCmuR2FpPmkv92pXwbIzixdgcpjFzvrIzdYg5zz9Hb6M2L+pZQBIWvaV2Ovh9kVCds44IIJPpR352rQuP14SrCfZBTo7qgybYNu7+H96V+ORsuf4wWeBBVpU8l7TS1AFF4CaLuNJTShKpHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PZNFWZW2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PZNFWZW2"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63226SWt347700;
	Thu, 2 Apr 2026 04:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dfpeDiOLbB9LC72WM
	LRPo+cTbLKFPC8cNXN+bNeCzIQ=; b=PZNFWZW2oDl3vOT3iLCjSgBPCDhuW4IXd
	8gk9OLxeIImtws1YzJschL16UsGEUfwEP0qx/zGuksD/5tay3vWIhSsw+K1bsFXz
	DHQWAPDf2sb/YSitIuFb+86CpeISkrOa/yw63E702GFWkCDT1AvdgGO09+DF7ahu
	lq/tltDIDXyF+GycdBO1QhFlyl5rttMQZnKZBny975iwkN5fLjF/cnB8XMiqryEn
	Zj3QQogPF/M8J9mB22bfHO3sg9TeBt7pxk0sgGLLRVQ7sgIX3otwabsVK2rRUu6u
	J1Wyk6a+JXooLyJuMCEn5J5FJuwz31smxZB4qoZzrs9/WAZ/1PRWA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66q3b7dw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 04:21:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6320EZDr005757;
	Thu, 2 Apr 2026 04:21:39 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6spy8q9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 04:21:39 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6324LZWf24576530
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 04:21:35 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6622220040;
	Thu,  2 Apr 2026 04:21:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 127AD20043;
	Thu,  2 Apr 2026 04:21:35 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 04:21:35 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Andreas Grapentin <Andreas.Grapentin@ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v1 25/27] KVM: s390: arm64: Implement vCPU IOCTLs
Date: Thu,  2 Apr 2026 06:21:21 +0200
Message-ID: <20260402042125.3948963-26-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260402042125.3948963-1-seiden@linux.ibm.com>
References: <20260402042125.3948963-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 58J4F6Y13THvgjXjLjLDpDQaHV_AMVmE
X-Authority-Analysis: v=2.4 cv=frzRpV4f c=1 sm=1 tr=0 ts=69cdeed4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=G8_6HCemxdKf7YMAXCQA:9
X-Proofpoint-ORIG-GUID: 58J4F6Y13THvgjXjLjLDpDQaHV_AMVmE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDAzNCBTYWx0ZWRfX2LDw26+sGJEl
 LBjIDcYPbP0zh8nIhEIgYQPSNf0pxe/Xvwc/R1Kt6zBjyjkG1E+VGBgGlMqfJj7Pk8u8kEmq3ir
 mzyHBLAyKzrjYpLZgRc7gC5X9DznmEgbBium+HgA3hTrrQIcYfLxMZy5WLKVWcfEqm7bL6ybetf
 KuY6YHNTNzps77qu/W8aHYpZErAD9S9eNNcuU7w1Kw20VB9Rw6QP5N/Ai3vH976VdScuoxMMtpi
 xPXOkG5DvA30XRF5abFYtfQYAUrQmM82CEr9gstI1VieiJrXaf9WOjyrWKbIetxfLYL9dWZvvN3
 AZHX2EmGfGc3CkrDX7VBxUNIMuVyjI+QYi44K4gY6SUQ9/g0P+v+q1kQoZsPLQM3YkX5Bs6V28r
 tnVvIZ5wPAH4wL0clgza16XtNjmA4/kCZYwOss6STO1oEg/apxMK7BCAq+/Nq8O6CJdpVWRpL7J
 eow1mToJbolXBXKcLXQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020034

Implement all vCPU IOCTLs.

Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/arm64/arm.c   | 361 ++++++++++++++++++++++++++++++++++++
 arch/s390/kvm/arm64/guest.c |  71 ++++++-
 arch/s390/kvm/arm64/guest.h |   5 +
 arch/s390/kvm/arm64/reset.c |  42 +++++
 arch/s390/kvm/arm64/reset.h |  11 ++
 5 files changed, 488 insertions(+), 2 deletions(-)
 create mode 100644 arch/s390/kvm/arm64/reset.c
 create mode 100644 arch/s390/kvm/arm64/reset.h

diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
index 962d23f4e469..71562a0c438c 100644
--- a/arch/s390/kvm/arm64/arm.c
+++ b/arch/s390/kvm/arm64/arm.c
@@ -8,7 +8,15 @@
 #include <linux/kvm_types.h>
 #include <linux/kvm_host.h>
 
+#include <asm/access-regs.h>
+#include <asm/kvm_emulate.h>
+#include <asm/sae.h>
+
+#include <kvm/arm64/handle_exit.h>
+#include "kvm/arm64/kvm_emulate.h"
+
 #include "arm.h"
+#include "guest.h"
 #include "reset.h"
 #include "gmap.h"
 
@@ -167,6 +175,22 @@ void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu)
 {
 }
 
+void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
+{
+	save_access_regs(&vcpu->arch.host_acrs[0]);
+	vcpu->cpu = cpu;
+
+	lasrm(&vcpu->arch.save_area);
+}
+
+void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
+{
+	stiasrm(&vcpu->arch.save_area);
+
+	vcpu->cpu = -1;
+	restore_access_regs(&vcpu->arch.host_acrs[0]);
+}
+
 int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
 				    struct kvm_mp_state *mp_state)
 {
@@ -190,12 +214,349 @@ unsigned long system_supported_vcpu_features(void)
 	return KVM_VCPU_VALID_FEATURES;
 }
 
+bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu)
+{
+	return vcpu_mode_priv(vcpu);
+}
+
+int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu)
+{
+	if (!kvm_vcpu_initialized(vcpu))
+		return -ENOEXEC;
+
+	if (!kvm_arm_vcpu_is_finalized(vcpu))
+		return -EPERM;
+
+	if (likely(READ_ONCE(vcpu->pid)))
+		return 0;
+
+	return 0;
+}
+
+/**
+ * check_vcpu_requests - check and handle pending vCPU requests
+ * @vcpu:	the VCPU pointer
+ *
+ * Return: 1 if we should enter the guest
+ *	   0 if we should exit to userspace
+ *	   < 0 if we should exit to userspace, where the return value indicates
+ *	   an error
+ */
+static int check_vcpu_requests(struct kvm_vcpu *vcpu)
+{
+	if (kvm_request_pending(vcpu)) {
+		if (kvm_check_request(KVM_REQ_VCPU_RESET, vcpu))
+			kvm_reset_vcpu(vcpu);
+		/*
+		 * Clear IRQ_PENDING requests that were made to guarantee
+		 * that a VCPU sees new virtual interrupts.
+		 */
+		kvm_check_request(KVM_REQ_IRQ_PENDING, vcpu);
+	}
+
+	return 1;
+}
+
+static int kvm_vcpu_initialize(struct kvm_vcpu *vcpu,
+				 const struct kvm_vcpu_init *init)
+{
+	unsigned long features = init->features[0];
+	struct kvm *kvm = vcpu->kvm;
+	int ret = -EINVAL;
+
+	mutex_lock(&kvm->arch.config_lock);
+
+	if (test_bit(KVM_ARCH_FLAG_VCPU_FEATURES_CONFIGURED, &kvm->arch.flags) &&
+	    kvm_vcpu_init_changed(vcpu, init))
+		goto out_unlock;
+
+	bitmap_copy(kvm->arch.vcpu_features, &features, KVM_VCPU_MAX_FEATURES);
+
+	kvm_reset_vcpu(vcpu);
+
+	set_bit(KVM_ARCH_FLAG_VCPU_FEATURES_CONFIGURED, &kvm->arch.flags);
+	vcpu_set_flag(vcpu, VCPU_INITIALIZED);
+
+	if (kvm_vcpu_init_changed(vcpu, init))
+		goto out_unlock;
+
+	ret = 0;
+out_unlock:
+	mutex_unlock(&kvm->arch.config_lock);
+	return ret;
+}
+
+static int kvm_vcpu_set_target(struct kvm_vcpu *vcpu,
+			       const struct kvm_vcpu_init *init)
+{
+	int ret;
+
+	if (init->target != KVM_ARM_TARGET_GENERIC_V8)
+		return -EINVAL;
+
+	ret = kvm_vcpu_init_check_features(vcpu, init);
+	if (ret)
+		return ret;
+
+	if (!kvm_vcpu_initialized(vcpu))
+		return kvm_vcpu_initialize(vcpu, init);
+
+	kvm_reset_vcpu(vcpu);
+
+	return 0;
+}
+
+static int kvm_arch_vcpu_ioctl_vcpu_init(struct kvm_vcpu *vcpu,
+					 struct kvm_vcpu_init *init)
+{
+	struct kvm_sae_save_area *save_area = &vcpu->arch.save_area;
+	struct kvm_sae_block *sae_block = &vcpu->arch.sae_block;
+	bool power_off = false;
+	int ret;
+
+	sae_block->save_area = virt_to_phys(save_area);
+	save_area->sdo = virt_to_phys(sae_block);
+
+	if (init->features[0] & BIT(KVM_ARM_VCPU_POWER_OFF)) {
+		init->features[0] &= ~BIT(KVM_ARM_VCPU_POWER_OFF);
+		power_off = true;
+	}
+
+	vcpu_load(vcpu);
+
+	ret = kvm_vcpu_set_target(vcpu, init);
+	if (ret)
+		goto out_put;
+
+	vcpu_reset_hcr(vcpu);
+
+	spin_lock(&vcpu->arch.mp_state_lock);
+	WRITE_ONCE(vcpu->arch.mp_state.mp_state, KVM_MP_STATE_RUNNABLE);
+	spin_unlock(&vcpu->arch.mp_state_lock);
+
+	ret = 0;
+out_put:
+	vcpu_put(vcpu);
+	return ret;
+}
+
 int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_level,
 			  bool line_status)
 {
 	return 0;
 }
 
+static void adjust_pc(struct kvm_vcpu *vcpu)
+{
+	if (vcpu_get_flag(vcpu, INCREMENT_PC))
+		kvm_skip_instr(vcpu);
+}
+
+static void arm_vcpu_run(struct kvm_vcpu *vcpu)
+{
+	struct kvm_sae_block *sae_block = &vcpu->arch.sae_block;
+
+	adjust_pc(vcpu);
+
+	local_irq_disable();
+	guest_enter_irqoff();
+	local_irq_enable();
+
+	sae_block->icptr = 0;
+
+	sae64a(sae_block);
+
+	local_irq_disable();
+	guest_exit_irqoff();
+	local_irq_enable();
+}
+
+/** kvm_arch_vcpu_ioctl_run() - run arm64 vCPU
+ *
+ * Execute arm64 guest instructions using SAE.
+ *
+ * Returns:
+ * 1 enter the guest (should not be observed by userspace)
+ * 0 exit to userspace
+ * < 0 exit to userspace, where the return value indicates n error
+ *
+ *
+ */
+int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
+{
+	struct kvm_run *kvm_run = vcpu->run;
+	u8 icptr;
+	int ret;
+
+	if (kvm_run->exit_reason == KVM_EXIT_MMIO) {
+		ret = kvm_handle_mmio_return(vcpu);
+		if (ret <= 0)
+			return ret;
+	}
+
+	vcpu_load(vcpu);
+
+	if (!vcpu->wants_to_run) {
+		ret = -EINTR;
+		goto out;
+	}
+
+	kvm_sigset_activate(vcpu);
+
+	might_fault();
+
+	ret = 1;
+	do {
+		if (signal_pending(current)) {
+			kvm_run->exit_reason = KVM_EXIT_INTR;
+			ret = -EINTR;
+			continue;
+		}
+
+		if (need_resched())
+			schedule();
+
+		if (ret > 0)
+			ret = check_vcpu_requests(vcpu);
+
+		if (kvm_request_pending(vcpu))
+			continue;
+
+		vcpu->arch.sae_block.icptr = 0;
+
+		arm_vcpu_run(vcpu);
+
+		icptr = vcpu->arch.sae_block.icptr;
+		switch (icptr) {
+		case SAE_ICPTR_SPURIOUS:
+			break;
+		case SAE_ICPTR_VALIDITY:
+			WARN_ONCE(true, "SAE: validity intercept. vir: 0x%04x",
+				  vcpu->arch.sae_block.vir);
+			ret = -EINVAL;
+			break;
+		case SAE_ICPTR_SYNCHRONOUS_EXCEPTION:
+			ret = handle_trap_exceptions(vcpu);
+			break;
+		default:
+			WARN_ONCE(true, "SAE: unknown interception reason 0x%02x", icptr);
+			ret = -EINVAL;
+		}
+	} while (ret > 0);
+
+	kvm_sigset_deactivate(vcpu);
+out:
+	if (unlikely(vcpu_get_flag(vcpu, INCREMENT_PC)))
+		adjust_pc(vcpu);
+
+	vcpu_put(vcpu);
+
+	return ret;
+}
+
+long kvm_arch_vcpu_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
+{
+	struct kvm_vcpu *vcpu = filp->private_data;
+	void __user *argp = (void __user *)arg;
+	struct kvm_device_attr attr;
+	int ret;
+
+	switch (ioctl) {
+	case KVM_ARM_VCPU_INIT: {
+		struct kvm_vcpu_init init;
+
+		ret = -EFAULT;
+		if (copy_from_user(&init, argp, sizeof(init)))
+			break;
+
+		ret = kvm_arch_vcpu_ioctl_vcpu_init(vcpu, &init);
+		break;
+	}
+	case KVM_SET_ONE_REG:
+	case KVM_GET_ONE_REG: {
+		struct kvm_one_reg reg;
+
+		ret = -ENOEXEC;
+		if (unlikely(!kvm_vcpu_initialized(vcpu)))
+			break;
+
+		ret = -EFAULT;
+		if (copy_from_user(&reg, argp, sizeof(reg)))
+			break;
+
+		if (kvm_check_request(KVM_REQ_VCPU_RESET, vcpu))
+			kvm_reset_vcpu(vcpu);
+
+		if (ioctl == KVM_SET_ONE_REG)
+			ret = kvm_arm_set_reg(vcpu, &reg);
+		else
+			ret = kvm_arm_get_reg(vcpu, &reg);
+		break;
+	}
+	case KVM_GET_REG_LIST: {
+		struct kvm_reg_list __user *user_list = argp;
+		struct kvm_reg_list reg_list;
+		unsigned int n;
+
+		ret = -ENOEXEC;
+		if (unlikely(!kvm_vcpu_initialized(vcpu)))
+			break;
+		ret = -EPERM;
+		if (!kvm_arm_vcpu_is_finalized(vcpu))
+			break;
+		ret = -EFAULT;
+		if (copy_from_user(&reg_list, user_list, sizeof(reg_list)))
+			break;
+		n = reg_list.n;
+		reg_list.n = kvm_arm_num_regs(vcpu);
+		if (copy_to_user(user_list, &reg_list, sizeof(reg_list)))
+			break;
+		ret = -E2BIG;
+		if (n < reg_list.n)
+			break;
+		ret = kvm_arm_copy_reg_indices(vcpu, user_list->reg);
+		break;
+	}
+	case KVM_ARM_VCPU_FINALIZE: {
+		int what;
+
+		if (!kvm_vcpu_initialized(vcpu))
+			return -ENOEXEC;
+
+		if (get_user(what, (const int __user *)argp))
+			return -EFAULT;
+
+		ret = kvm_arm_vcpu_finalize(vcpu, what);
+		break;
+	}
+	case KVM_SET_DEVICE_ATTR: {
+		ret = -EFAULT;
+		if (copy_from_user(&attr, argp, sizeof(attr)))
+			break;
+		ret = kvm_arm_vcpu_set_attr(vcpu, &attr);
+		break;
+	}
+	case KVM_GET_DEVICE_ATTR: {
+		ret = -EFAULT;
+		if (copy_from_user(&attr, argp, sizeof(attr)))
+			break;
+		ret = kvm_arm_vcpu_get_attr(vcpu, &attr);
+		break;
+	}
+	case KVM_HAS_DEVICE_ATTR: {
+		ret = -EFAULT;
+		if (copy_from_user(&attr, argp, sizeof(attr)))
+			break;
+		ret = kvm_arm_vcpu_has_attr(vcpu, &attr);
+		break;
+	}
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
 int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm,
 			       struct kvm_dirty_log *log)
 {
diff --git a/arch/s390/kvm/arm64/guest.c b/arch/s390/kvm/arm64/guest.c
index 00886755accf..893d48037292 100644
--- a/arch/s390/kvm/arm64/guest.c
+++ b/arch/s390/kvm/arm64/guest.c
@@ -4,7 +4,7 @@
 
 #include "guest.h"
 
-const struct _kvm_stats_desc kvm_vm_stats_desc[] = {
+const struct kvm_stats_desc kvm_vm_stats_desc[] = {
 	KVM_GENERIC_VM_STATS()
 };
 
@@ -17,7 +17,7 @@ const struct kvm_stats_header kvm_vm_stats_header = {
 		       sizeof(kvm_vm_stats_desc),
 };
 
-const struct _kvm_stats_desc kvm_vcpu_stats_desc[] = {
+const struct kvm_stats_desc kvm_vcpu_stats_desc[] = {
 	KVM_GENERIC_VCPU_STATS(),
 	/* ARM64 stats */
 	STATS_DESC_COUNTER(VCPU, hvc_exit_stat),
@@ -50,6 +50,73 @@ unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu)
 	return num_core_regs(vcpu);
 }
 
+int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
+{
+	/* We currently use nothing arch-specific in upper 32 bits */
+	if ((reg->id & ~KVM_REG_SIZE_MASK) >> 32 != KVM_REG_ARM64 >> 32)
+		return -EINVAL;
+
+	switch (reg->id & KVM_REG_ARM_COPROC_MASK) {
+	case KVM_REG_ARM_CORE:
+		return get_core_reg(vcpu, reg);
+	default:
+		return -EINVAL;
+	}
+}
+
+int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
+{
+	/* We currently use nothing arch-specific in upper 32 bits */
+	if ((reg->id & ~KVM_REG_SIZE_MASK) >> 32 != KVM_REG_ARM64 >> 32)
+		return -EINVAL;
+
+	switch (reg->id & KVM_REG_ARM_COPROC_MASK) {
+	case KVM_REG_ARM_CORE:
+		return set_core_reg(vcpu, reg);
+	default:
+		return -EINVAL;
+	}
+}
+
+int kvm_arm_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
+{
+	int ret;
+
+	switch (attr->group) {
+	default:
+		ret = -ENXIO;
+		break;
+	}
+
+	return ret;
+}
+
+int kvm_arm_vcpu_get_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
+{
+	int ret;
+
+	switch (attr->group) {
+	default:
+		ret = -ENXIO;
+		break;
+	}
+
+	return ret;
+}
+
+int kvm_arm_vcpu_has_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
+{
+	int ret;
+
+	switch (attr->group) {
+	default:
+		ret = -ENXIO;
+		break;
+	}
+
+	return ret;
+}
+
 int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
 	return -EINVAL;
diff --git a/arch/s390/kvm/arm64/guest.h b/arch/s390/kvm/arm64/guest.h
index db635d513c2c..847489fb81be 100644
--- a/arch/s390/kvm/arm64/guest.h
+++ b/arch/s390/kvm/arm64/guest.h
@@ -6,5 +6,10 @@
 #include <kvm/arm64/guest.h>
 
 unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu);
+int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
+int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
+int kvm_arm_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr);
+int kvm_arm_vcpu_get_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr);
+int kvm_arm_vcpu_has_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr);
 
 #endif /* KVM_ARM_GUEST_H */
diff --git a/arch/s390/kvm/arm64/reset.c b/arch/s390/kvm/arm64/reset.c
new file mode 100644
index 000000000000..432c844ee858
--- /dev/null
+++ b/arch/s390/kvm/arm64/reset.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/kvm_host.h>
+#include <asm/kvm_emulate.h>
+#include <kvm/arm64/reset.h>
+
+#include "reset.h"
+
+bool kvm_arm_vcpu_is_finalized(struct kvm_vcpu *vcpu)
+{
+	return true;
+}
+
+void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_reset_state reset_state;
+
+	spin_lock(&vcpu->arch.mp_state_lock);
+	reset_state = vcpu->arch.reset_state;
+	vcpu->arch.reset_state.reset = false;
+	spin_unlock(&vcpu->arch.mp_state_lock);
+
+	/*
+	 * disable preemption around the vcpu reset as we might otherwise race with
+	 * preempt notifiers which call stiasrm/lasrm from put/load
+	 */
+	preempt_disable();
+
+	kvm_reset_vcpu_core_regs(vcpu);
+
+	if (reset_state.reset) {
+		*vcpu_pc(vcpu) = reset_state.pc;
+		vcpu_set_reg(vcpu, 0, reset_state.r0);
+	}
+
+	preempt_enable();
+}
+
+int kvm_arm_vcpu_finalize(struct kvm_vcpu *vcpu, int feature)
+{
+	return 0;
+}
diff --git a/arch/s390/kvm/arm64/reset.h b/arch/s390/kvm/arm64/reset.h
new file mode 100644
index 000000000000..a5c5304e47bc
--- /dev/null
+++ b/arch/s390/kvm/arm64/reset.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef KVM_ARM_RESET_H
+#define KVM_ARM_RESET_H
+
+#include <linux/kvm_host.h>
+
+bool kvm_arm_vcpu_is_finalized(struct kvm_vcpu *vcpu);
+void kvm_reset_vcpu(struct kvm_vcpu *vcpu);
+int kvm_arm_vcpu_finalize(struct kvm_vcpu *vcpu, int feature);
+
+#endif /* KVM_ARM_RESET_H */
-- 
2.51.0

