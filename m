Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBE63F4DF2;
	Fri, 29 May 2026 15:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780069911; cv=none; b=bYzErZqAuXIsSrkXpab0+LcgeGzyrZDj+09ErHoZPP8A73oJHm1LEEAUk8phn0bUxUS7h1Kmi83Y5SpMYKD3rdiNPHGAvnpWmTX/Aiv9fSESejoD92uLPuEhyfBGzVFPrk7sc0d4hVToxK8vl9MfE4XnJJpMkNW92Gvi9b4zBQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780069911; c=relaxed/simple;
	bh=xIkC/EGoox4EapI+n5FHDKN89nHGOwWXVWRnuaYFipI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h2jkFS+93hncPQoeCHdMO1jmRCyPO30gNcVrxY5znzNLT1mLdERa4r7OPbVaKEcCz2qzPkfmriZs0jVX1UlRjitA3kUPcMEAcH4xsAuyuoKQXfaLF8IdIT3VNkV8ldhx2KDunB58iISx4A1q9PD4QcYgeyMsT3+z4pX4xkZH9zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F7NANxc4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F7NANxc4"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TFEPUj2776290;
	Fri, 29 May 2026 15:51:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GZM/VlrYedx5aAVYq
	3tlSoktt/aKa43kRQCtJ2o6NN8=; b=F7NANxc4EsMliBb3uGjuGpiXeRpgMZKow
	0+RTqZxFNdVIhzVLOtrLzABJA+N50Pte3dLZMlGIXVdvAkwfT1KgWrGLcl1P/PkX
	mVo/aTgHp+O0uECKg8/l9CW1195gK39sHEBVHpVw5khtUz1T5JT/uO0LvoSTjOfU
	A5kti9SDolNqMRbzfvPAbbMAqoV2PqF3vqRkH4i+DB9sExDaCoDlOKpHxDILUFHO
	Zyfcf2cmwRg2CIGKOP2o+sj+86dBR47bTAe3gh+mBNRvWnpbOqMddbwJhUDQJ6iB
	dGImNIQ9tgqGC9oO+Eb7YoV20IdD0Zpnx8n1KVhU21KAvr6Rr+Z/g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee889kw27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:51:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TFd648024371;
	Fri, 29 May 2026 15:51:05 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrbgft5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:51:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TFow8q52494830
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 15:50:58 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DE5D2004B;
	Fri, 29 May 2026 15:50:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D145B20043;
	Fri, 29 May 2026 15:50:57 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 15:50:57 +0000 (GMT)
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
        Friedrich Welter <fritz@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v3 20/27] KVM: s390: arm64: Introduce host definitions
Date: Fri, 29 May 2026 17:50:34 +0200
Message-ID: <20260529155050.2902245-21-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529155050.2902245-1-seiden@linux.ibm.com>
References: <20260529155050.2902245-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: saKnF3P7neqNaemL9fDGp2gqpxlFTOCw
X-Proofpoint-GUID: saKnF3P7neqNaemL9fDGp2gqpxlFTOCw
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a19b5e9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=DaSJ6kklOhazPQzp40AA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE1NiBTYWx0ZWRfX/tcWzOOGZQJ0
 t7OanAK9fJFMlP8Qq5ahjHHqt5c2+GKljCpblMRKKW+pGYE+SmSWNIquYQexCcPn6n+vzTXO89i
 Vmm8AM681jM15m50OYGyOmv7f4GJlZpSySMfYPvkWZfxivPd8DdKspDJIkeoCIwXrRcrlv7ik+i
 8af1ZiqAhYbcAn0wHORsAeLCZx+PnD6BglA2BvyxfnsXLdo4Ur1hpgf5N3lbfkDcCcSHBX8L8sY
 tCdE4lRlY+GywKHVNuU/adQWBYl36wyr0vQm318TNOdqCSYW51pfJVXmeY3TnBOPKS4NLXWhX6p
 x7Z8fNp8EptKcUOCTrpsDtFBhIMQ0H9OnOEHJy/i2cqkxa6ybzTmRsq5yUiK9Sw9f1xNPJvrUTo
 Gmro/q2Y/A44AxkoPLMgr7WuK3csuC+ID3QVye4D2FMcVS+a/zerD2Sd/i7k0feubcw6bSym+du
 FrKmvG3CZcbuu8fkQTQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290156

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
 arch/s390/include/asm/kvm_host_arm64.h | 212 +++++++++++++++++++++++++
 3 files changed, 227 insertions(+)
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
index 000000000000..8c3214c5b004
--- /dev/null
+++ b/arch/s390/include/asm/kvm_host_arm64.h
@@ -0,0 +1,212 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef ASM_KVM_HOST_ARM64_H
+#define ASM_KVM_HOST_ARM64_H
+
+#include <linux/bug.h>
+
+#include <asm/kvm_host_arm64_types.h>
+#include <asm/debug.h>
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
+/* Minimal (=no) vgic definitions */
+#define KVM_IRQCHIP_NUM_PINS 1
+#define irqchip_in_kernel(_v) false;
+
+#define __ctxt_sys_reg(ctx, reg) NULL
+struct kvm_cpu_context {
+	/*
+	 * These are just for 32 bit, which we don't have, making them RES0.
+	 * They are exposed to user space.
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
+static inline bool __vcpu_has_feature(const struct kvm_arch *ka, int feature)
+{
+	return test_bit(feature, ka->vcpu_features);
+}
+
+#define vcpu_has_feature(v, f)	__vcpu_has_feature(&(v)->kvm->arch, (f))
+
+struct kvm_vm_stat {
+	struct kvm_vm_stat_generic generic;
+};
+
+#define kvm_vm_is_protected(_kvm)	false
+
+#define vcpu_is_loaded(_vcpu) (_vcpu->cpu != -1)
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
2.53.0

