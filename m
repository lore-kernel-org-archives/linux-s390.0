Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A92E4DB546;
	Mon,  6 Jul 2026 08:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783328005; cv=none; b=HJqE1pEBafphF13bsrYzts+fRqwrcrjEKkpiAY3+VKjCLN0QbUQyDVHmm0tUGZx2N0S6y4Pn25mfoor8TU9bB6QTAGgHhzHBFReZnP3kdHZ1eoeTRwPXbg0YIZ6hlZBDuo8eezz+hu7XeAjFgdI/mEKZ1lj7vaI/PQX185QJCCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783328005; c=relaxed/simple;
	bh=LypmQw2EOYEjAWTs5atNuSkn/v0hsXpNjxKdHXFKNdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rhqT480HQst+wWvN0iiKB4jdSHHZJEM+zef3Ty2UM+xubD18mUrqM5SQGQFFBafkBgM4U7/5gp5ld3KIwZpRChH/Zkk/5tkNoidz6NQDK9wMAxhLbu2cnpGPYugGIWgVU3W9EesOavC/FW1nj1PfqIObYTHdPQ8LML2Si3MDrJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BLObMJRJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BLObMJRJ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665MIOSH2427751;
	Mon, 6 Jul 2026 08:52:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=XUSKG99j0KzuJ/skl
	NtagPdDt5mexvfSVmaEucE661Y=; b=BLObMJRJA9pX/j29WnhOgNfA9MsvQXo60
	z+O+CNV1XNHHSmhdjO0PuNwSXHudC9Vfu2nZopEaRfou8nWxIo5LOxnA6Tx6zZKF
	44VeU5C2S5sfOSkH9VN3eESdmhhdqgQsgXEJJvudh46JXgZRTfDfZ/OK+TFHa4fi
	PdO9kfnsgdQR/X9lYMszCM9JQyp9jGF0Qn8UkcaQl/Vvras2B5y5q+aBt8fRgGUo
	bFG39zhdrfkQJf+9zTznJ2VPfIAC9PdBlIbzLutnsL9L47zhzabGAUv6z3loftae
	2O7l0CKab3uqVEXI1+oL3X736gLyXF0xK1qs6ne6OOz+za1JvyQeQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6suqgfqv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:52:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6668nio9022743;
	Mon, 6 Jul 2026 08:52:46 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0h4qe3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:52:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6668qcqw31720156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 08:52:38 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D4DD20043;
	Mon,  6 Jul 2026 08:52:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BF4B2004D;
	Mon,  6 Jul 2026 08:52:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 08:52:37 +0000 (GMT)
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
Subject: [PATCH v4 20/27] KVM: s390: arm64: Introduce host definitions
Date: Mon,  6 Jul 2026 10:52:20 +0200
Message-ID: <20260706085229.979525-21-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706085229.979525-1-seiden@linux.ibm.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfX2DKcYQDGqTyY
 toZNv/xTJHsEKlYWsvay5s35zkFHshrDmvPp5fatVYxerAeAYGAfXTPFDTVj6oy7fRNCsUEklck
 G2Jauh6avnvFJpGCtPPC6nJV7HncIqQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfX0rz5HN9ZH/sP
 NXhtjBH9fTKj+N4bNRPC/9tdFYNSFzd2rcbYACJuveILU+JnyOLHrElbmQV8L32wXHf5A919Tum
 cskZTMKLqYZ6fTGTdEM/MLAVxtwqssk1PiYrofeO1zCFctgnCQwu2BB+MyHPci4nn9GRLCsj9Yz
 Wl6j15yhxq0fHELwlS8SYJ22Us0WI6fdFrvbXQWGmRHTrMQyXQcY1JwTvEdwCnXfz1HlLY4Cx8U
 UFnG9WMf6HTVTyqq/D4h0QRAHGRfMYQgGnWuJFNMD/g1SLG1RKR1o7Uf3gHJxQbIE3F7F8PR+TT
 FEC8oVJMovcm3t6e/q5df0IvHEn8yo3E7Z+fu0W/yYhwCslGho1qAlyJin/RxToGKsgOk6odqk1
 vFI5i89LU5OL0Yc6L3nRfsqXC+S7kVzdOk1g1K0mIdR1+hE8yonFiLlniVPrFNjYt5KHp22aBTk
 uQtJ9rZ728ZGywBszbg==
X-Proofpoint-GUID: JtMRzzNND23ygsGzn8lcuHI7NEHqwxGU
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4b6cdf cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=DaSJ6kklOhazPQzp40AA:9
X-Proofpoint-ORIG-GUID: JtMRzzNND23ygsGzn8lcuHI7NEHqwxGU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060088

Add all basic definitions the arm on s390 KVM host requires. Including,
but not limited to, struct kvm*arch definitions, various functions (to
be implemented in the following patches), and various defines required
to run arm64 guests.

Enlighten asm/kvm_host.h for the new header variant. The new
header is chosen instead of asm/kvm_host_s390.h if KVM_S390_ARM64
is defined.

Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/kvm.h            |   6 +
 arch/s390/include/asm/kvm_host.h       |   9 ++
 arch/s390/include/asm/kvm_host_arm64.h | 210 +++++++++++++++++++++++++
 3 files changed, 225 insertions(+)
 create mode 100644 arch/s390/include/asm/kvm.h
 create mode 100644 arch/s390/include/asm/kvm_host_arm64.h

diff --git a/arch/s390/include/asm/kvm.h b/arch/s390/include/asm/kvm.h
new file mode 100644
index 000000000000..aeb11dc631d5
--- /dev/null
+++ b/arch/s390/include/asm/kvm.h
@@ -0,0 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifdef KVM_S390_ARM64
+#include <uapi/arm64/kvm.h>
+#else
+#include <uapi/asm/kvm.h>
+#endif
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 33af8842a71c..0c22cc42be7e 100644
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
index 000000000000..6d08856fe395
--- /dev/null
+++ b/arch/s390/include/asm/kvm_host_arm64.h
@@ -0,0 +1,210 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef ASM_KVM_HOST_ARM64_H
+#define ASM_KVM_HOST_ARM64_H
+
+#include <linux/bug.h>
+
+#include <asm/kvm_host_types.h>
+#include <asm/debug.h>
+
+#define vcpu_gp_regs(v)		((v)->arch.sae_block.gpr)
+
+#define HAVE_KVM_MMIO
+
+#include <arm64/kvm_host.h>
+#include <asm/sae.h>
+
+#define KVM_HAVE_MMU_RWLOCK
+#define KVM_MAX_VCPUS 1
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
+#define vcpu_is_loaded(_vcpu) ((_vcpu)->cpu != -1)
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

