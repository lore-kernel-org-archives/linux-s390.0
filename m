Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368E2530E17;
	Wed, 30 Sep 2026 17:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789726; cv=none; b=oDzZ81IIH3MSjZaC5u/0do8VA+IpSR21ipORiv2Bo0YS6sGdgYgE8GVyzIFq4nrTJhxak5poTq4l1IAq1U7PSZKMrGWMizElje2dQnJmOmWuF+xD2BXlvHBwyY6mH9ck4FeJFc8U7c5dhrG2ALJK01XUsrR9212aomnFIZ2Hcp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789726; c=relaxed/simple;
	bh=I/w79hGRa4XHiX86+66RWCUf+NAYEVXXGp3p1FSUXxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJ8aYzdnZgRGAlKwN4dj8a0+lrHB12Uo6+VGgTCcPrwbXL7GrTIk8sNeHeEDod0eOfZyDdf8gIt3h979qfaEo9t8i6jl5BX0WDGCwm+x0eRsuuilGiMv7Y2XchDI4u9v5+lFKdOvTZGfomzBek2m8C8ZfkeeiLg4Ku4+Ot9m1Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZIqAceSO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZIqAceSO"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UE5Sox1932756;
	Wed, 30 Sep 2026 17:35:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=SiTi+7rcAQeYYVDmC
	GDf+kODylyWLkkf7JL/G5DJwK8=; b=ZIqAceSOrFKoT5gI9a36Em0AVgKZ9Np6M
	tc+Ti+seUXljeZsTvBN/iT9TWbYhp2GWy0TeXqmX0Gyw7pYMwFMeRRXPrpFunwlW
	9kUB6ZaVgXk072SbGvUi94Sv6PlmmgRguSAgyMIqit6SP08zZiekRaFk0+y/bz1o
	aRc3RqfjjyqNpyQ8yGVNznJKasYQS10124DCJTATarvgpaS+15DoGL/dQO4w2I5P
	XrwM9nYEMC0gte17VgmpjSgoSVIxzu5pceTK4xHhmPVVVp0DL56kqPbdxIZ5dATZ
	yE7bbEAEmfNQmKmHfnZTo77ebqKrDLZ/Wd/bCl3mTVlPqXeMWOLQg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fedn4q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:35:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68UHYJT02287764;
	Wed, 30 Sep 2026 17:35:01 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0q4pbmm3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:35:01 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68UHYv6C43712884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Sep 2026 17:34:57 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CE632005A;
	Wed, 30 Sep 2026 17:34:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2C1D20065;
	Wed, 30 Sep 2026 17:34:47 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Sep 2026 17:34:47 +0000 (GMT)
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
Subject: [PATCH v9 17/24] KVM: s390: arm64: Introduce host definitions
Date: Wed, 30 Sep 2026 19:34:32 +0200
Message-ID: <20260930173441.66762-18-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930173441.66762-1-seiden@linux.ibm.com>
References: <20260930173441.66762-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abd4846 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=NkYWUXnGwG2_pH3cPtwA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA3MCBTYWx0ZWRfX/AeFbKwhfISp
 B2J4ji9fwZ5dCWpW2d+uk47mWG+J6FDTIj3lYp5zo40aWIJ+YFGSqyo2u/3CZOTh+GnHAroG3CU
 xj+fk4phnLe8vW45qZWlJ/AiUj57RqE=
X-Proofpoint-ORIG-GUID: Liz0RMYyQiHsP4mXc0sqK2b-MFy_7AbB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA3MCBTYWx0ZWRfXz7ayy/RJ39nU
 08Y2PoWJ/7eTW6nV8p+Fa60yZlMaOREzMKmraLyc/UHWoaqTWBCmZigZin4KE6eqE0PUlAdWlFI
 kgGUSCdPmD2YL5ydddPME5R0qNCjB6C4cYE8p7g7nBfEYS0kmjaTPU5y2pktafRphwHA+gcSMSD
 kVymiYq0SowISM5QRmuFNqrATe0sLRfcLyoOQJ8LPGoCfkj34WppZk3KBjVwNVb9soqY9r877+a
 JuuN/BFanqUNYJp3G2S4psKgPq7c3xjZWuxgdHn7/9/efrE6bS65zrYI+AGKesPt4fLUkYNlBhi
 e85stF39n4MiBsyYb57ALVRBWhmhWSnLkBDa1IC8OhU8CJsBlNuSoCkjlxz608eyBbhIV5e6lLD
 M2vQ6XL8vn9A6kc1xGH7ttFnFUCGs9vS3svd88YXqwiYawLqwkrvXRF+nQs0TgoKwOuNZwf1hKC
 IxWCrEBxD968Ldp2pwA==
X-Proofpoint-GUID: kdTNcEVm0I7eL9cNqcNpa4amZaX390eY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300070

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
 arch/s390/include/asm/kvm_host.h       |   4 +
 arch/s390/include/asm/kvm_host_arm64.h | 209 +++++++++++++++++++++++++
 3 files changed, 219 insertions(+)
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
index 147325978225..ac3440a617c1 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -3,7 +3,11 @@
 #ifndef ASM_KVM_HOST_H
 #define ASM_KVM_HOST_H
 
+#ifdef KVM_S390_ARM64
+#include <asm/kvm_host_arm64.h>
+#else
 #include <asm/kvm_host_s390.h>
+#endif
 
 #define PGM_OPERATION			0x01
 #define PGM_PRIVILEGED_OP		0x02
diff --git a/arch/s390/include/asm/kvm_host_arm64.h b/arch/s390/include/asm/kvm_host_arm64.h
new file mode 100644
index 000000000000..ab77865a74dc
--- /dev/null
+++ b/arch/s390/include/asm/kvm_host_arm64.h
@@ -0,0 +1,209 @@
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
+#include <arm64/kvm_host.h>
+#include <arm64/ptrace.h>
+
+#include <asm/sae.h>
+
+#define KVM_HAVE_MMU_RWLOCK
+#define KVM_MAX_VCPUS 1
+#define KVM_VCPU_RUN_PID_CHANGE
+
+#define KVM_S390_ARM64_IMPL_FEATURES 0
+#define KVM_HALT_POLL_NS_DEFAULT 50000
+
+#define KVM_S390_MANAGES_S390_GUEST 0
+
+/* Minimal (=no) vgic definitions */
+#define KVM_IRQCHIP_NUM_PINS 1
+#define irqchip_in_kernel(_k) false
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
+	u64 hcr_el2;
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
+struct kvm_vm_stat {
+	struct kvm_vm_stat_generic generic;
+};
+
+static inline bool system_has_full_ptr_auth(void)
+{
+	return true;
+}
+
+#define kvm_vm_is_protected(_kvm) false
+#define vcpu_is_protected(_vcpu) false
+
+#define vcpu_is_loaded(_vcpu) ((_vcpu)->cpu != -1)
+
+#define KVM_HVA_ERR_BAD		(-1UL)
+#define KVM_HVA_ERR_RO_BAD	(-2UL)
+
+static inline bool kvm_is_error_hva(unsigned long addr)
+{
+	return IS_ERR_VALUE(addr);
+}
+
+u32 get_kvm_ipa_limit(void);
+
+/* unused, but required functions */
+static inline void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot) {}
+static inline void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen) {}
+static inline void kvm_arch_flush_shadow_all(struct kvm *kvm) {}
+static inline void kvm_arch_flush_shadow_memslot(struct kvm *kvm, struct kvm_memory_slot *slot) {}
+static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu) {}
+static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {}
+static inline void kvm_arch_sync_events(struct kvm *kvm) {}
+static inline void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu) {}
+static inline void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
+							   struct kvm_memory_slot *slot,
+							   gfn_t gfn_offset,
+							   unsigned long mask) {}
+
+int kvm_handle_guest_abort(struct kvm_vcpu *vcpu);
+void kvm_reset_vcpu(struct kvm_vcpu *vcpu);
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

