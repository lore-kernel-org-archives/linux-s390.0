Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F111366074;
	Thu,  2 Apr 2026 04:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775103726; cv=none; b=ot/LAOFH1CVnnyM2JsOF8YFqJErH3YXXPwuIRYB9kWjGbD4wno8ey1qS72pojrBpuUNGxI5PIq0tchhMl6Yoq6cuNae5ue6Y3AdB3uFDL4zMfXybV8cmRZ5NfSNRAb2DfGJP3rsJ4Hr80DVdyAznRNzVe9Na5DAHDsu+uDs8NUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775103726; c=relaxed/simple;
	bh=x4is2TiPqNm0YppKoWJ+IyedaSs4gUpLFuZmmWaWM/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JBwBItl6sCtiz+KiJoXFCoTidbtLls6a/yzeXckvAjPjexWo4hXmH9LMH8SZreyCWP1AyktkxqFDCYq0FLJr0sBRdKgGlcSUdv8d6NTL5JBRYNJZ2GGnMtGV2b16jJLS1v97peCm/64FGiEVgxBR3wBSS79CXeNpaZ1f2g9/zoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IwA1LLT9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IwA1LLT9"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631J1LD73905677;
	Thu, 2 Apr 2026 04:21:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pk88CTrbw0xE/m+yV
	Yw+gA+Oshb0YV/HLun58YTC1vo=; b=IwA1LLT9XQjFKyNZf5MCrZr/RzmhV2cQY
	2N8Kwt/vtheIgIfOTFfGee7er1zlxFohW0MTGH6xNTRfeilq8vZaueW95y2Wsaat
	QmnJ6P9NkKOq96Wn1ghVkBb2Svnuo50g3NFmdWrjBtjJ0Ow3mkpKiVvKlz5ZdPnD
	HayYu4g/SYL3EB7+I5f3Ey+17jCMJisjnBXIfB92eMX+vMDCo3RBJL+r1VjB17y5
	Svy9Y53iahXaLfG0hH/1w8yO7NeLRMq/fXqR4WoebIFpQY9HFppBHC2WIM1FJdJ5
	KuR+vZMOhe8E5bq9OaQOwjtLz0ibNsaPNNmzQYhk27ch906lgvR8g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d64dgtjgx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 04:21:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6321E7Ao030952;
	Thu, 2 Apr 2026 04:21:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhk0eea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 04:21:37 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6324LXxx51052830
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 04:21:33 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B2D42004B;
	Thu,  2 Apr 2026 04:21:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44CA52004E;
	Thu,  2 Apr 2026 04:21:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 04:21:33 +0000 (GMT)
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
Subject: [PATCH v1 20/27] KVM: s390: arm64: Introduce host definitions
Date: Thu,  2 Apr 2026 06:21:16 +0200
Message-ID: <20260402042125.3948963-21-seiden@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDAzNCBTYWx0ZWRfX1engdWKV1r2c
 ct/0BsvQ0xenbWTkPosQulIZ58VMAweb4QV9G+6rU0DMw0aEknvpZzjPHJmJYgT3gp/axMh8J0s
 eSW7qymzWj+fRTrfrTPkgCzoUwjZs3Qa0iKS7Wmjv5w0yCDi3OBDlIR7BBQ7OKdPcB6btczbFmF
 2pzVKrWMM7b28jnOgQxFxN2CY/c6KZ9sPbj2NgsX2GFtaGYf0hWXQYx2dBt8mPx+CS0Ofjqfe2a
 pLLvNobf7OJW1lTIv0KXdstNMKcgKmHDa6Vf9XiUI/txcH45diAhZcn7gxbhKQnrs92Ljmottqw
 N6B71aAuQxOEK4mFnH2Cr945+SfAuMhqRle7VicLX5DTQ4uqUFAuJGiqbhvFJUIkJugFePU0xdF
 IcyxQXfqiK6YFOV2MVsdvjIS4NjWr45LeVhWY3LZaY9BM5dS8/h8u/AWFJuSBD9TkvrfitbLKkn
 /8C51LcXp4PbhBJkBmA==
X-Authority-Analysis: v=2.4 cv=QKZlhwLL c=1 sm=1 tr=0 ts=69cdeed2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=B7VBJslARfhn5cFe4oQA:9
X-Proofpoint-GUID: JEYXJ_K9Bg6Odbr3JUL-XbgipHVntgfo
X-Proofpoint-ORIG-GUID: JEYXJ_K9Bg6Odbr3JUL-XbgipHVntgfo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020034

Add all basic definitions the arm on s390 KVM host requires.
Including, but not limited to:
	- struct kvm*arch definitions
	- various functions (to be implemented in the following patches)
	- various defines required to run arm64 guests

Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/kvm.h            |   6 +
 arch/s390/include/asm/kvm_host.h       |   9 ++
 arch/s390/include/asm/kvm_host_arm64.h | 199 +++++++++++++++++++++++++
 3 files changed, 214 insertions(+)
 create mode 100644 arch/s390/include/asm/kvm.h
 create mode 100644 arch/s390/include/asm/kvm_host_arm64.h

diff --git a/arch/s390/include/asm/kvm.h b/arch/s390/include/asm/kvm.h
new file mode 100644
index 000000000000..d9e727d2378c
--- /dev/null
+++ b/arch/s390/include/asm/kvm.h
@@ -0,0 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifdef KVM_S390_ARM64
+#include <uapi/arch/arm64/asm/kvm.h>
+#else
+#include <uapi/asm/kvm.h>
+#endif
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 1c20168a3ef5..0330d3e503d8 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -3,7 +3,16 @@
 #ifndef ASM_KVM_HOST_H
 #define ASM_KVM_HOST_H
 
+#ifdef KVM_S390_ARM64
+#include <asm/kvm_host_arm64.h>
+#else
 #include <asm/kvm_host_s390.h>
+#endif
+
+static inline  bool kvm_arch_pmi_in_guest(struct kvm_vcpu *vcpu)
+{
+	return false;
+}
 
 #define PGM_PROTECTION			0x04
 #define PGM_ADDRESSING			0x05
diff --git a/arch/s390/include/asm/kvm_host_arm64.h b/arch/s390/include/asm/kvm_host_arm64.h
new file mode 100644
index 000000000000..5a694c835dbb
--- /dev/null
+++ b/arch/s390/include/asm/kvm_host_arm64.h
@@ -0,0 +1,199 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef ASM_KVM_HOST_ARM64_H
+#define ASM_KVM_HOST_ARM64_H
+
+#include <linux/bug.h>
+
+#include <asm/kvm_host_arm64_types.h>
+#include "asm/debug.h"
+
+#include <kvm/arm_vgic.h>
+
+#define vcpu_gp_regs(v)		((v)->arch.sae_block.gpr)
+
+#define HAVE_KVM_MMIO
+
+#include <kvm/arm64/kvm_host.h>
+#include <asm/sae.h>
+
+#define KVM_HAVE_MMU_RWLOCK
+#define KVM_MAX_VCPUS 1
+
+#define KVM_VCPU_VALID_FEATURES 0
+
+#define KVM_HALT_POLL_NS_DEFAULT 50000
+
+#define __ctxt_sys_reg(ctx, reg) NULL
+struct kvm_cpu_context {
+	/*
+	 * These are just for 32 bit, which we don't have, making them RES0.
+	 * They are exposed to user space.
+	 * Arm KVM seemingly does not enforce RES0.
+	 */
+	u64	spsr_abt;
+	u64	spsr_und;
+	u64	spsr_irq;
+	u64	spsr_fiq;
+
+	__vector128 __aligned(16) vregs[32];
+};
+
+struct kvm_vcpu_arch {
+	struct kvm_sae_block sae_block;
+	struct kvm_sae_save_area save_area;
+	struct kvm_cpu_context ctxt;
+
+	u32 host_acrs[NUM_ACRS];
+
+	/* Hypervisor Configuration Register */
+	u64 hcr_elz;
+
+	/* Configuration flags, set once and for all before the vcpu can run */
+	u8 cflags;
+
+	/* Input flags to the hypervisor code, potentially cleared after use */
+	u8 iflags;
+
+	/* State flags for kernel bookkeeping, unused by the hypervisor code */
+	u8 sflags;
+
+	/*
+	 * Don't run the guest (internal implementation need).
+	 *
+	 * Contrary to the flags above, this is set/cleared outside of
+	 * a vcpu context, and thus cannot be mixed with the flags
+	 * themselves (or the flag accesses need to be made atomic).
+	 */
+	bool pause;
+
+	/* vcpu power state */
+	struct kvm_mp_state mp_state;
+	/* lock for mp_state & reset_state.reset */
+	spinlock_t mp_state_lock;
+
+	/* vcpu reset state */
+	struct vcpu_reset_state reset_state;
+
+	/* GMAP */
+	struct gmap *gmap;
+	struct kvm_s390_mmu_cache *mc;
+
+	void *debugfs_state_data;
+};
+
+struct kvm_vcpu_stat {
+	struct kvm_vcpu_stat_generic generic;
+	/* ARM64 stats */
+	u64 hvc_exit_stat;
+	u64 wfe_exit_stat;
+	u64 wfi_exit_stat;
+	u64 mmio_exit_user;
+	u64 mmio_exit_kernel;
+	u64 signal_exits;
+	u64 exits;
+	/* GMAP stats */
+	u64 pfault_sync;
+};
+
+#define kvm_vcpu_get_sp_el1(__vcpu) (&((__vcpu)->arch.sae_block.sp_el1))
+#define kvm_vcpu_get_vreg(__vcpu, _off) (&(__vcpu)->arch.ctxt.vregs[_off])
+#define kvm_vcpu_get_vregs(__vcpu) (&(__vcpu)->arch.ctxt.vregs)
+#define kvm_vcpu_get_fpsr(__vcpu) (&(__vcpu)->arch.sae_block.fpsr)
+#define kvm_vcpu_get_fpcr(__vcpu) (&(__vcpu)->arch.sae_block.fpcr)
+
+#define __vcpu_flags_preempt_disable()	preempt_disable()
+#define __vcpu_flags_preempt_enable()	preempt_enable()
+
+#define _vcpu_get_flag(v, flagset, ...)	\
+	__vcpu_get_flag(&(v)->arch.flagset, __VA_ARGS__)
+#define _vcpu_set_flag(v, flagset, ...)	\
+	__vcpu_set_flag(&(v)->arch.flagset, __VA_ARGS__)
+#define _vcpu_clear_flag(v, flagset, ...)	\
+	__vcpu_clear_flag(&(v)->arch.flagset, __VA_ARGS__)
+#define _vcpu_test_and_clear_flag(v, flagset, ...)	\
+	__vcpu_test_and_clear_flag(&(v)->arch.flagset, __VA_ARGS__)
+
+#define kvm_has_mte(_kvm) false
+#define vcpu_has_sve(vcpu) false
+
+struct kvm_arch_memory_slot {
+};
+
+struct kvm_arch {
+	struct gmap *gmap;
+	u64 guest_phys_size;
+
+	/* VM-wide vCPU feature set */
+	unsigned long flags;
+
+	/* Protects VM-scoped configuration data */
+	struct mutex config_lock;
+
+	debug_info_t *dbf;
+
+	DECLARE_BITMAP(vcpu_features, KVM_VCPU_MAX_FEATURES);
+
+	unsigned long mem_limit;
+};
+
+struct kvm_vm_stat {
+	struct kvm_vm_stat_generic generic;
+};
+
+#define kvm_vm_is_protected(_kvm)	false
+
+#define KVM_HVA_ERR_BAD		-1UL
+#define KVM_HVA_ERR_RO_BAD	-2UL
+
+#define kvm_phys_size(__kvm) ((__kvm)->arch.guest_phys_size)
+static inline bool kvm_is_error_hva(unsigned long addr)
+{
+	return IS_ERR_VALUE(addr);
+}
+
+u32 get_kvm_ipa_limit(void);
+
+static inline void kvm_arch_sync_events(struct kvm *kvm) {}
+static inline void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu) {}
+
+int kvm_handle_guest_abort(struct kvm_vcpu *vcpu);
+
+/* arm64 guests do not use async-pf. Defined because Kbuild requires it as s390 kvm turns it on. */
+#define ASYNC_PF_PER_VCPU 0
+struct kvm_arch_async_pf {
+	unsigned long pfault_token;
+};
+
+#define __unsupp_async_call(fn) WARN_ONCE(true, "async not supported on kvm-arm64 %s", fn)
+
+static inline bool kvm_arch_can_dequeue_async_page_present(struct kvm_vcpu *vcpu)
+{
+	__unsupp_async_call(__func__);
+	return false;
+};
+
+static inline void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu,
+					     struct kvm_async_pf *work)
+{
+	__unsupp_async_call(__func__);
+};
+
+static inline bool kvm_arch_async_page_not_present(struct kvm_vcpu *vcpu,
+						   struct kvm_async_pf *work)
+{
+	__unsupp_async_call(__func__);
+	return false;
+};
+
+static inline void kvm_arch_async_page_present(struct kvm_vcpu *vcpu,
+					       struct kvm_async_pf *work)
+{
+	__unsupp_async_call(__func__);
+};
+
+static inline void kvm_arch_async_page_present_queued(struct kvm_vcpu *vcpu)
+{
+	__unsupp_async_call(__func__);
+};
+
+#endif /* ASM_KVM_HOST_ARM64_H */
-- 
2.51.0

