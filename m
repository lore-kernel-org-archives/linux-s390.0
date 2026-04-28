Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741E444D688;
	Tue, 28 Apr 2026 16:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777392366; cv=none; b=akvoXbr3SecsO6O6qGPCkfsaeWTbMeJEe1c+Kx+iP/fIQQg9mEdhBjruHAlVmMwjV1XwtZxaKTCxSU9YsMC7nO+J+VB6xOAQTWPlBgOyFi18vk5oO3Ve+1d+FKavO+ISZUgNec7eZs7reup6qUSLa2c7lGL+7I7or0OGTeqPCuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777392366; c=relaxed/simple;
	bh=ObwfFGRphQ13mkyOHTMspp9hf9HWVfJsaNBvb6E83sE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ftgUapm2p09bPXJe3hrbNPysrrxdPJDpU05QLNuoAM3J0MoFPF4a/bvT9wMgnOcCXhoT1L1i5c7YSLBwFgN1RZuTMIXrXLHHdLHI5WRFqjYn9Bryt6j+rM2/hZ8aZ9RgZeRLjE0YeVHboqw8pYjfPuANv8vzruuDm+KvneL6Fiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iEP31epF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iEP31epF"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S6Yfnb2886656;
	Tue, 28 Apr 2026 16:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=70TCS0+s1BCejrRCo
	sTCo903U1lWFHqC550aLg29Jck=; b=iEP31epFJyPPaBwSKpj/I5xWoUPutm8B/
	HKb3pAt3/m9ypKP5r7WSGtrs4SjsBMrrmC5yQyLusE9X9943GJkkByChhQPylj/d
	sjuj5/LZiLSJnKrTMkIXvpCO4F09R640nGHgCg4OtIKGApb342SZC3Zq5K5u2yEH
	f7Orofu/qTrhTp+zLzV0yGNgOhcEx6lBDwGhemIt03YQLtJw9OzCXHM+OGZKa6/n
	32ECaWKRBlWSwoDPds1eYvP64D6+u1keimFx3cXjuWEVTF55ym8aYV8DDEHwNACK
	IibmR/Ow+32T0WIVmHg9tOpsICMs3MySEnsDIQ/KFie2cooHYO2rw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9r6dq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 16:05:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SFrnXA006517;
	Tue, 28 Apr 2026 16:05:41 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ds7xqajbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 16:05:40 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63SG5bUG44433770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 16:05:37 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FE6D20043;
	Tue, 28 Apr 2026 16:05:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C40D92004B;
	Tue, 28 Apr 2026 16:05:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Apr 2026 16:05:36 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
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
Subject: [RFC PATCH v2 26/28] KVM: s390: arm64: Implement vCPU IOCTLs
Date: Tue, 28 Apr 2026 18:05:23 +0200
Message-ID: <20260428160527.1378085-27-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260428160527.1378085-1-seiden@linux.ibm.com>
References: <20260428160527.1378085-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Akmz1qGUBGGWaemYgfAoTAUdFkTCrVcA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE1MSBTYWx0ZWRfX1+zohPxNEQ66
 cbCfW6HuoM1IgVpnIAUyayoFSzXvt3mSZvID0D8NQcQYLUyTZ7LQ9+KkhlAm1VND28AYQ3E9vDO
 W0ePJrpgpJKiXaFizEi0g3d5Y8pU3i/9uFmUCEASH2luWbfbyi+BCni+QLaoyhqsPDC7C8lBO16
 /XyNu1IsjLkPEdLJmUGI+a/5VYVsba8YvT7zJpUu7UiAIEzbd4ICHH0zaM61lIrej8/hXsdT/N+
 FTqCLgDxOI2veWFpit2BldF5TN7fvlGaU9B8UKndJX3Ei2BjCOYZpAMpc14/uTDy8jfvDwoXYVx
 9QhV9bfmrxRpYuyGxLgtJFElQ3/rfvUCWVTpJGiFxsRLLK5BBs8qgsnwfmTw7Yhskh+/imSIOGh
 eLF4bO8DDp4pJ3J/ZJ6Fa2FRpbfs2J/6QAZ8cF7btUtA5r0T4k97CqUEY+TnHkKuFxhQE2Fe2Ex
 0WGmvB5QjiKLSBjgg6A==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69f0dad6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=duHCEdAOebdA3afscLwA:9
X-Proofpoint-ORIG-GUID: Akmz1qGUBGGWaemYgfAoTAUdFkTCrVcA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280151

Implement all vCPU IOCTLs.

Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/arm64/arm.c   | 354 ++++++++++++++++++++++++++++++++++++
 arch/s390/kvm/arm64/guest.c |  71 +++++++-
 arch/s390/kvm/arm64/guest.h |   5 +
 arch/s390/kvm/arm64/reset.c |  45 +++++
 arch/s390/kvm/arm64/reset.h |  11 ++
 5 files changed, 484 insertions(+), 2 deletions(-)
 create mode 100644 arch/s390/kvm/arm64/reset.c
 create mode 100644 arch/s390/kvm/arm64/reset.h

diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
index 77bc4a8841df..b629bef84eda 100644
--- a/arch/s390/kvm/arm64/arm.c
+++ b/arch/s390/kvm/arm64/arm.c
@@ -8,9 +8,17 @@
 #include <linux/kvm_types.h>
 #include <linux/kvm_host.h>
 
+#include <asm/access-regs.h>
+#include <asm/kvm_emulate.h>
+#include <asm/sae.h>
+
+#include <kvm/arm64/handle_exit.h>
+#include <kvm/arm64/kvm_emulate.h>
+
 #include <gmap.h>
 
 #include "arm.h"
+#include "guest.h"
 #include "reset.h"
 
 int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
@@ -168,6 +176,22 @@ void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu)
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
@@ -191,12 +215,342 @@ unsigned long system_supported_vcpu_features(void)
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
+	if (kvm_vcpu_init_changed(vcpu, init))
+		return -EINVAL;
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
+	int ret;
+
+	sae_block->save_area = virt_to_phys(save_area);
+	save_area->sdo = virt_to_phys(sae_block);
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
+	if (vcpu_get_flag(vcpu, INCREMENT_PC)) {
+		kvm_skip_instr(vcpu);
+		vcpu_clear_flag(vcpu, INCREMENT_PC);
+	}
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
index 000000000000..9a12d5f19f6a
--- /dev/null
+++ b/arch/s390/kvm/arm64/reset.c
@@ -0,0 +1,45 @@
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
+		vcpu_clear_flag(vcpu, PENDING_EXCEPTION);
+		vcpu_clear_flag(vcpu, EXCEPT_MASK);
+		vcpu_clear_flag(vcpu, INCREMENT_PC);
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

