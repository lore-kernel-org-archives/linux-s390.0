Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C630744D02A;
	Tue, 28 Apr 2026 16:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777392365; cv=none; b=kCA9k+RkPyOKOwxRztL4RYTZlR1p+6tuymNmeC+WXBTeTYQGvcice0IktrE/fPNVBmq2T0YkCVRZR57slb3r9ik/u7MUV3Dka6wh0+qKoWYzqrz7Ibi092PZMScifSCOh+v9W8Oe09sf3nuEQB+nLsKsrtJwXj6WvdUXpMqH1ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777392365; c=relaxed/simple;
	bh=UHUPTJgCO88BceuQ/8M54+kWBLHIcrrnnkwLkkzNREk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qFy7fp/CICQfd0FT9JlrsBb+JaABxqv3QBZ52aBcPlvjNznRGL4H3G/WYrDN2pkJAokXvdPR7LM4hDQb+3Esbb1BqweJeg05nqQX45EV7tlUY52zBqxrjLwTbza/bW7CBpqxrnHYsxfdT2q+gDldlvMpAvTlpI/YzQMVpbUF8Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UKT0ZJtf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UKT0ZJtf"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SG1ItB2955381;
	Tue, 28 Apr 2026 16:05:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cahm49lBXji0UeJSH
	YE2GrQL3ZhEHnJeclytYzBSYqA=; b=UKT0ZJtf7ZH4Ga+G/KOiuJ9Z1GKwY5GwO
	vihDXPb7V6suzYaDDadpS8k7gLgcKSI+0+lcrp/QFm7+b1bArQTepOIW/bSpUej9
	wmES6Vo6rSi8uNZ0kZpElq7cOJxnMF7sPqSFbok6NENsX6A5vIwNK39LXHdxLyeU
	CwM1VRUkt5az8a1KdSBNMAZb1G3KizvNGryo5nmZ1AXrphOJpRGlm4v8yYATLlic
	XoM4zy5+BPTA8aZexpvd47SThTjMM9bqHDe4V/hlT14cQe3bJ7RU+YcsDgJ2Hr5h
	iVUhZ5qfdmSuZvQLWUN7ODEEFPCsJWiyM+4HL5NQfmgPQeLLbcQpg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drk1jnec0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 16:05:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SFrqfk001950;
	Tue, 28 Apr 2026 16:05:39 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsa5ga9er-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 16:05:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63SG5Zxx56885552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 16:05:35 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B688120040;
	Tue, 28 Apr 2026 16:05:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66CCA2004B;
	Tue, 28 Apr 2026 16:05:35 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Apr 2026 16:05:35 +0000 (GMT)
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
Subject: [RFC PATCH v2 22/28] KVM: s390: arm64: Introduce host definitions
Date: Tue, 28 Apr 2026 18:05:19 +0200
Message-ID: <20260428160527.1378085-23-seiden@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE1MSBTYWx0ZWRfXzgStfskqyX/E
 cPxl7X6sxE8Ebufe5hitwntiOH9uYC3TCBKu0J/qL/Zfi9QBe83waLgra9sswT0puqk0O3bhFPy
 VJ3d2keFd/ifpwLIHEIrPHJBKuPqlVlcfPKXIC7qAfwbymx5rfmHFZG9hkTtp9z5AU7PXuRQBun
 6hN/O2pgpOFRWN6yl4JSir4eZmurvumI+Gn7BlKTtMiNdCGXX00xRNGCPW8ErGLFDxnMUMM2BL8
 PK3wTclA4yQU/GAwZ4k2F6wUja1Tv+c35oT6dyRLrc0LGCxu+NMsUriZ7Iw/WhpSgXf5W/aD/ZS
 heAthMJ1Hsm0+j8tFlB3auS+x7fiqqCWrTdyXqD//3+DtkVb9Wgzu/cEOVevtlsF6wKEk5BLkwQ
 O7ewaLD4Tb09dS97goJM89JfUQcUemBN8SMD9m1NY9Qur1jVsbIafZpb5OYznajFnTmr/druKG1
 X8wv1dg8/sRG77CVs4g==
X-Proofpoint-GUID: RqTNeVUYIy0MJvIMGH2MkH8zZnACQ5yM
X-Proofpoint-ORIG-GUID: RqTNeVUYIy0MJvIMGH2MkH8zZnACQ5yM
X-Authority-Analysis: v=2.4 cv=MohiLWae c=1 sm=1 tr=0 ts=69f0dad4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=DaSJ6kklOhazPQzp40AA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280151

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
 arch/s390/include/asm/kvm_host_arm64.h | 202 +++++++++++++++++++++++++
 3 files changed, 217 insertions(+)
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
index 000000000000..08fbb2a75778
--- /dev/null
+++ b/arch/s390/include/asm/kvm_host_arm64.h
@@ -0,0 +1,202 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef ASM_KVM_HOST_ARM64_H
+#define ASM_KVM_HOST_ARM64_H
+
+#include <linux/bug.h>
+
+#include <asm/kvm_host_arm64_types.h>
+#include <asm/debug.h>
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
+#define vcpu_has_sve(_vcpu) false
+#define vcpu_has_ptrauth(_vcpu) false
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
+#define kvm_supports_32bit_el0() false
+
+#endif /* ASM_KVM_HOST_ARM64_H */
-- 
2.51.0

