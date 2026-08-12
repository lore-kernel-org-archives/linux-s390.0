Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1C34746D8;
	Wed, 12 Aug 2026 15:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549066; cv=none; b=olL8lC0havEXWjrXf4/YtbQ1GRKpz/nDTUH3pGbenmlzispL+OJlz/mSbeXelWms6XRNDzQ09KIHTARzAbTwzTLcoDP6SMLhLpVHecJNt037JjU24wH+YH6Q1d0PIko1d5BPBXCJl1k5i4oV2wqySTeQ6Cd2R4TAA0LgbZRyU/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549066; c=relaxed/simple;
	bh=kJ55o+4Q9xcB6jQUsMiFUNt3LZUMxrT6yQkicjYYRRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqcCNb/EZVIIHpWtjtzcc/8kweOoID5rmVgD1qSK2aRNOuzbX+Wrxar/mYj19f0gh8ZXd10nHp12Fi9vS9DCiG8hqbXK6mx10RT0qkwwE3Nt2JcntdNlZKGes9suJcXdbE6dCnDWEaMfmhGwtN3Jmc+41BaoIgOqjaekHw9ipvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Lxw7lvFU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Lxw7lvFU"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CE1X9Y3686574;
	Wed, 12 Aug 2026 15:36:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7zNHdVTpKc06XwSZL
	oZvd60RBGRQIkYoYWkcmnFYkuQ=; b=Lxw7lvFUjpotvN6qbg745i/6FSVKqW8Ua
	RMTlrdSQGiMLOWwMP44OxA0qHMRMNV2XgmzQgFv4N8MGzpUWV2HY4xJmcl1LB4Hy
	R27wRaIMI9jbdLySAjUiFIi/OLErUciJQ551swyzYYdm0OI1lDtgxWgOLg2DtBsg
	ZcPaFccnrdoRz4h3qNKeq876sSn5gBjoGeZ7eOH1sNChSTpbfQjGMwA+Ae7SwxZP
	CvELDZFwqMB0Cca4O2K7fsy4A9kBvkQqFypBv67FNfUBq0BLpvBtFC7HXqSWwPJ7
	UDiI4Ki+ycjAiUDfkrRPewDa3ZBF4z6NFYl6oloDmIleI12e5sFyQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9u9uv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:36:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CFQLCF021738;
	Wed, 12 Aug 2026 15:36:48 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy6g4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:36:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CFaiYZ36503828
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 15:36:44 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09C6720049;
	Wed, 12 Aug 2026 15:36:44 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A18A2004E;
	Wed, 12 Aug 2026 15:36:43 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 15:36:43 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v6 31/33] KVM: s390: arm64: Implement vCPU IOCTLs
Date: Wed, 12 Aug 2026 17:36:27 +0200
Message-ID: <20260812153631.3376090-32-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812153631.3376090-1-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfX+E5G2GINJymg
 u1nQ7mckqC2k6m6but/kgXbZZDmB6sjDlFHFJLKmldd6Qt9W7Zi/Wgh7MzbYjb2Tf0SOzYjRBEg
 rjXP+VWk1QLte/eLp6XWl3P9TF2jzghPeeERelKoQLv7ESPcvrBhZAVAxv0B7ZHfxsEKtDuSZVr
 l5OPKk5heGqUYDIGkF8njNY0I+6wfWs0V/h8j5qgtywfXYBSwp5hfWXul+GFxdGJFIwuCYRWoGq
 3ebOR3u3tJa6SMMNKUCazgVkWyUPIkBHQ4xcv4nZQmop8y9eOZ/iLx2oGNKIjZlgoRTxagYSIHx
 B3YtB74SHOdbU7amuBPjsyq6Jqx2yQl5zVgwXVuS4jZZoNQZgs96k4I30V/1/651udUa1aC4qYB
 TIl/TycTZGw9PVXxT2kcp1ri5IJs3OhuZft21QWSHSE409P8fUQA0qkA8OdF9QUClMmozx5/i+R
 rW+iwMZt9BzYk5gcgtg==
X-Proofpoint-ORIG-GUID: Lo-QgZ3-q7QgKcVZ2fi8vzlfgJYP72GM
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfX3xsU+Xe4BVSw
 u3z9wWGtF3ro4ya7GIm5ywro2mEuftInces5AeGnAV/X2F6tM9Uw++xM0mcVA/dgjKX9Ie6WJEH
 LkhisvjMzQb51K4PtUCTNAhfqNPw270=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7c9311 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=u96BciJK5rm203yUjl8A:9
X-Proofpoint-GUID: 8XBm1cCN1PeMEVJkLxAIN_bPFylD-ieJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120126

Implement all required vCPU IOCTLs.

Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/arm64/arm.c         | 392 ++++++++++++++++++++++++++++++
 arch/s390/kvm/arm64/guest.c       |  47 +++-
 arch/s390/kvm/arm64/handle_exit.c |  31 +++
 arch/s390/kvm/arm64/handle_exit.h |   9 +
 arch/s390/kvm/arm64/reset.c       |  73 ++++++
 arch/s390/kvm/arm64/reset.h       |  11 +
 arch/s390/kvm/arm64/trace.h       |   2 +-
 7 files changed, 562 insertions(+), 3 deletions(-)
 create mode 100644 arch/s390/kvm/arm64/handle_exit.h
 create mode 100644 arch/s390/kvm/arm64/reset.c
 create mode 100644 arch/s390/kvm/arm64/reset.h

diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
index 69d43066f9e1..ef941f408744 100644
--- a/arch/s390/kvm/arm64/arm.c
+++ b/arch/s390/kvm/arm64/arm.c
@@ -7,11 +7,20 @@
 #include <linux/kvm.h>
 #include <linux/kvm_types.h>
 #include <linux/kvm_host.h>
+#include <linux/cleanup.h>
+#include <linux/fpu.h>
+
+#include <asm/access-regs.h>
+
+#include <arm64/kvm_emulate.h>
+#include <arm64/sysreg.h>
 
 #include <gmap.h>
 #include <kvm_mmu.h>
 
 #include "arm.h"
+#include "handle_exit.h"
+#include "reset.h"
 
 #define CREATE_TRACE_POINTS
 #include "trace.h"
@@ -200,6 +209,22 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 	VCPU_EVENT(vcpu, 3, "%s", "free cpu");
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
@@ -225,6 +250,373 @@ static unsigned long system_supported_vcpu_features(void)
 	return features;
 }
 
+bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu)
+{
+	return vcpu_mode_priv(vcpu);
+}
+
+int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu)
+{
+	struct kvm *kvm = vcpu->kvm;
+
+	if (!kvm_vcpu_initialized(vcpu))
+		return -ENOEXEC;
+
+	if (!kvm_arm_vcpu_is_finalized(vcpu))
+		return -EPERM;
+
+	if (likely(READ_ONCE(vcpu->pid)))
+		return 0;
+
+	scoped_guard(mutex, &kvm->arch.config_lock)
+		set_bit(KVM_ARCH_FLAG_HAS_RAN_ONCE, &kvm->arch.flags);
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
+			       const struct kvm_vcpu_init *init)
+{
+	unsigned long features = init->features[0];
+	struct kvm *kvm = vcpu->kvm;
+
+	scoped_guard(mutex, &kvm->arch.config_lock) {
+		if (test_bit(KVM_ARCH_FLAG_VCPU_FEATURES_CONFIGURED,
+			     &kvm->arch.flags) &&
+		    kvm_vcpu_init_changed(vcpu, init))
+			return -EINVAL;
+
+		bitmap_copy(kvm->arch.vcpu_features, &features,
+			    KVM_VCPU_MAX_FEATURES);
+
+		kvm_reset_vcpu(vcpu);
+
+		set_bit(KVM_ARCH_FLAG_VCPU_FEATURES_CONFIGURED,
+			&kvm->arch.flags);
+		vcpu_set_flag(vcpu, VCPU_INITIALIZED);
+	}
+
+	return 0;
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
+	ret = kvm_vcpu_set_target(vcpu, init);
+	if (ret)
+		return ret;
+
+	scoped_guard(spinlock, &vcpu->arch.mp_state_lock) {
+		WRITE_ONCE(vcpu->arch.mp_state.mp_state, KVM_MP_STATE_RUNNABLE);
+	}
+
+	return 0;
+}
+
+int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_level,
+			  bool line_status)
+{
+	/* stub for now*/
+	return -EINVAL;
+}
+
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
+	DECLARE_KERNEL_FPU_ONSTACK32(fpu_save);
+	struct kvm_run *kvm_run = vcpu->run;
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
+	kernel_fpu_begin(&fpu_save, KERNEL_FPC | KERNEL_VXR);
+	load_vx_regs((vcpu->arch.ctxt.vregs));
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
+		ret = handle_exit(vcpu);
+
+	} while (ret > 0);
+
+	kvm_sigset_deactivate(vcpu);
+out:
+	if (unlikely(vcpu_get_flag(vcpu, INCREMENT_PC)))
+		adjust_pc(vcpu);
+
+	save_vx_regs(vcpu->arch.ctxt.vregs);
+	kernel_fpu_end(&fpu_save, KERNEL_FPC | KERNEL_VXR);
+	vcpu_put(vcpu);
+
+	return ret;
+}
+
+static int kvm_arm_vcpu_set_attr(struct kvm_vcpu *vcpu,
+				 struct kvm_device_attr *attr)
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
+static int kvm_arm_vcpu_get_attr(struct kvm_vcpu *vcpu,
+				 struct kvm_device_attr *attr)
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
+static int kvm_arm_vcpu_has_attr(struct kvm_vcpu *vcpu,
+				 struct kvm_device_attr *attr)
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
index fd6442d9e4f4..4ea6fe2c270d 100644
--- a/arch/s390/kvm/arm64/guest.c
+++ b/arch/s390/kvm/arm64/guest.c
@@ -5,8 +5,6 @@
 #include <arm64/kvm_emulate.h>
 #include <arm64/kvm_nested.h>
 
-#include "guest.h"
-
 #define __INCL_GEN_ARM_FILE
 #include "generated/guest.inc"
 #undef __INCL_GEN_ARM_FILE
@@ -47,6 +45,51 @@ const struct kvm_stats_header kvm_vcpu_stats_header = {
 		       sizeof(kvm_vcpu_stats_desc),
 };
 
+int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
+{
+	int ret;
+
+	ret = copy_core_reg_indices(vcpu, uindices);
+	if (ret < 0)
+		return ret;
+	uindices += ret;
+
+	return 0;
+}
+
+unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu)
+{
+	return num_core_regs(vcpu);
+}
+
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
 int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
 	return -EINVAL;
diff --git a/arch/s390/kvm/arm64/handle_exit.c b/arch/s390/kvm/arm64/handle_exit.c
index ed872cd804dc..1286a64783e0 100644
--- a/arch/s390/kvm/arm64/handle_exit.c
+++ b/arch/s390/kvm/arm64/handle_exit.c
@@ -5,6 +5,8 @@
 #include <arm64/esr.h>
 #include <arm64/kvm_emulate.h>
 
+#include "handle_exit.h"
+
 typedef int (*exit_handle_fn)(struct kvm_vcpu *);
 static exit_handle_fn arm_exit_handlers[ESR_ELx_EC_MAX + 1];
 
@@ -55,6 +57,35 @@ static exit_handle_fn arm_exit_handlers[] = {
 	[ESR_ELx_EC_HVC64]	= handle_hvc,
 };
 
+/*
+ * Return > 0 to return to guest, < 0 on error, 0 (and set exit_reason) on
+ * proper exit to userspace.
+ */
+int handle_exit(struct kvm_vcpu *vcpu)
+{
+	u8 icptr = vcpu->arch.sae_block.icptr;
+	int ret = 1;
+
+	switch (icptr) {
+	case SAE_ICPTR_SPURIOUS:
+		break;
+	case SAE_ICPTR_VALIDITY:
+		WARN_ONCE(true, "SAE: validity intercept. vir: 0x%04x",
+			  vcpu->arch.sae_block.vir);
+		ret = -EINVAL;
+		break;
+	case SAE_ICPTR_HOST_ACCESS_EXCEPTION:
+	case SAE_ICPTR_SYNCHRONOUS_EXCEPTION:
+		ret = handle_trap_exceptions(vcpu);
+		break;
+	default:
+		WARN_ONCE(true, "SAE: unknown interception reason 0x%02x",
+			  icptr);
+		ret = -EINVAL;
+	}
+	return ret;
+}
+
 /* manually copied from arch/arm64/kernel/traps.c */
 static const char * const esr_class_str[] = {
 	[0 ... ESR_ELx_EC_MAX]		= "UNRECOGNIZED EC",
diff --git a/arch/s390/kvm/arm64/handle_exit.h b/arch/s390/kvm/arm64/handle_exit.h
new file mode 100644
index 000000000000..65ae58721537
--- /dev/null
+++ b/arch/s390/kvm/arm64/handle_exit.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef KVM_ARM64_HANDLE_EXIT_H
+#define KVM_ARM64_HANDLE_EXIT_H
+
+#include <linux/kvm_host.h>
+
+int handle_exit(struct kvm_vcpu *vcpu);
+
+#endif /* KVM_ARM64_HANDLE_EXIT_H */
diff --git a/arch/s390/kvm/arm64/reset.c b/arch/s390/kvm/arm64/reset.c
new file mode 100644
index 000000000000..d107d2ae47f4
--- /dev/null
+++ b/arch/s390/kvm/arm64/reset.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/kvm_host.h>
+#include <linux/fpu.h>
+
+#include <arm64/kvm_emulate.h>
+#include <arm64/kvm_nested.h>
+
+#include "reset.h"
+
+bool kvm_arm_vcpu_is_finalized(struct kvm_vcpu *vcpu)
+{
+	return true;
+}
+
+static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.hcr_elz = HCR_EL2_E2H | HCR_EL2_RW | HCR_EL2_AMO |
+			     HCR_EL2_IMO | HCR_EL2_FMO | HCR_EL2_PTW;
+	/* traps */
+	vcpu->arch.hcr_elz |= HCR_EL2_TSC | HCR_EL2_TID1 | HCR_EL2_TID2 |
+			      HCR_EL2_TID3 | HCR_EL2_TID4 | HCR_EL2_TID5 |
+			      HCR_EL2_TIDCP;
+}
+
+void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_reset_state reset_state;
+	bool loaded;
+
+	scoped_guard(spinlock, &vcpu->arch.mp_state_lock) {
+		reset_state = vcpu->arch.reset_state;
+		vcpu->arch.reset_state.reset = false;
+	}
+
+	/*
+	 * Disable preemption around the vcpu reset as we might otherwise race with
+	 * preempt notifiers which call stiasrm/lasrm from put/load
+	 */
+	preempt_disable();
+
+	/* The reset must run with an unloaded save area */
+	loaded = vcpu_is_loaded(vcpu);
+	if (loaded)
+		vcpu_put(vcpu);
+
+	kvm_reset_vcpu_core(vcpu);
+
+	/* Reset special registers */
+	vcpu_reset_hcr(vcpu);
+
+	if (reset_state.reset) {
+		*vcpu_pc(vcpu) = reset_state.pc;
+		vcpu_clear_flag(vcpu, PENDING_EXCEPTION);
+		vcpu_clear_flag(vcpu, EXCEPT_MASK);
+		vcpu_clear_flag(vcpu, INCREMENT_PC);
+		vcpu_set_reg(vcpu, 0, reset_state.r0);
+	}
+
+	/* Load new vx-regs into HW if they are currently loaded */
+	if (current->thread.kfpu_flags)
+		load_vx_regs(vcpu->arch.ctxt.vregs);
+
+	if (loaded)
+		vcpu_load(vcpu);
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
diff --git a/arch/s390/kvm/arm64/trace.h b/arch/s390/kvm/arm64/trace.h
index 3a5dcd039c13..1e3cb6108196 100644
--- a/arch/s390/kvm/arm64/trace.h
+++ b/arch/s390/kvm/arm64/trace.h
@@ -5,7 +5,7 @@
 #include <linux/tracepoint.h>
 
 #undef TRACE_SYSTEM
-#define TRACE_SYSTEM kvm
+#define TRACE_SYSTEM kvm_arm64
 
 #endif /* KVM_ARM64_TRACE_KVM_H */
 
-- 
2.53.0

