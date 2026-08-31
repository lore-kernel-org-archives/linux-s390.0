Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63CE374A1D;
	Mon, 31 Aug 2026 14:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788187718; cv=none; b=cAsXTnX+s4oMxSjEGKbL2/rk2qJmj4qn8pKBKz0vp4ERqsN5SVtWo/BV7TU8drAA1qfukmIYbYE3pdU8Oa5GJ1YsSRqEpLsgvndxZdQK+7h5xNclvpWd/nRLCttRfVD4/3W0jyhaJiWDRtwHEEdGL+opCYfH1cLCR6dti5Ih8Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788187718; c=relaxed/simple;
	bh=uAFcd8HQIqh0gz9X0Fd7BXVaB2dY5KFUiz6/VWzDECI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jnXNZ9d68xVZbQSrtlOn4PPPWgVVbKVqAujcYVI3B8TeMSUPW2urtEpZ2rxVb/2EIhp+SOUcVjGgf/9DHFO4zbpZRaT/T+41ya05kgNvCspjkrJFD4LrqEeaP3zfK8gNUAxkdPWJFAugwcGTkl+CukmYesowhHsF37UC6AxJmZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WF3oihdM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WF3oihdM"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZBwB1398300;
	Mon, 31 Aug 2026 14:48:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Hkd03Tw3GQhq5aCfJ
	fTH2yNNeWWRwh+ubgEBypEn00Y=; b=WF3oihdMCht2FvJxrlHga8YU8W8+3SD0i
	vsNPgGBvlEvi9Cp+C7PMxaxuTWosWA3sZ1tZ6CQ8CCiVqGlpTCApp+mlHa0T02ml
	v4h7nSe477EF9iKCGCFaUP3/cmO5RMHX9uXp878YDocW0hVfc5akAlvRBps/13p9
	cor/tfjai1grkzotHsYWghzvXbfrrpyJj0TSqi812eMgIdj/xZc/SbmdJ8iEfzcP
	x8bNCkGmCydhWv7oLvVjNTq+Wz930sJp7u++pdK1hNSquN3FlR+5oyVUZH3nQQVd
	G+5R++WapPOQX/WbIPLNTukH0tnciY7T0aYHCxsr5wYTxVbJnxmgg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnudhysc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:48:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEfe53029556;
	Mon, 31 Aug 2026 14:48:14 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gccexx7nu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:48:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VEmAgf42926508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 14:48:10 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C8462004B;
	Mon, 31 Aug 2026 14:48:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E63D82004F;
	Mon, 31 Aug 2026 14:48:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 14:48:09 +0000 (GMT)
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
Subject: [PATCH v7 16/23] KVM: s390: arm64: Introduce host definitions
Date: Mon, 31 Aug 2026 16:47:53 +0200
Message-ID: <20260831144802.834315-17-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831144802.834315-1-seiden@linux.ibm.com>
References: <20260831144802.834315-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: dOXOye89J-4tGjxxIHRLSN1sL3Ey_WZP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX+45iQunjxgxh
 ODJCEvJWxRkbZ1c2NJJ91i7LVMmRTXOSz7zMQlFEM0tBKC2Qm8nOt+Ue8jYOZi9Ji/J51bLWdHD
 RY+GZgtQ/Xl2ZuKv4thraMvGAVwbcDd4OdtLCjtVEgkAlVvgAutD/gOB7zioh4xLuu9jMBZYlf2
 BciB137T3jSm8QGfwJtihpsDukPNbCYRVW9oYXRAAGo2ccLLOqq9eJQa1OiM502lbXCUTxyr1rL
 Cbn/Mvq/Mlu/6D93ocUoR0245RGyRVtAzzx0xUvJZ4qFdPoYhc3LDhStZMY1vmU7nhmHtwzrDJx
 X037CgST1voGIgiA+cYVKJmz3bWVixe2fV4bMm54tibjSQBHAT0euTUHcp7bEh7dhUvxTihYGD3
 ttoTtu2GrbW5kc29ZV+6/yGLY7rRb9zYtQjrIslOYv3n4soVwYskyyfXv27p98Y0Hwotr0JgaGV
 wVBF0Z3yeFsJqK/EO+Q==
X-Proofpoint-ORIG-GUID: YFM_mUXa0ArZzfUnEE5hMEgweSV6CH0a
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX6MJCeZJx11Sf
 ET4+JZ4Y2+wMm269RAHZCf+mKSyWXDYPnOpJympH3ZHZLTVPrcUFTiTGL6KbCD0J/pQmOg3FhP5
 njWAabiRDW2NAWCrIm9MmwYERHQ1Zv8=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a95942f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=NkYWUXnGwG2_pH3cPtwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310125

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
 arch/s390/include/asm/kvm_host_arm64.h | 211 +++++++++++++++++++++++++
 3 files changed, 226 insertions(+)
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
index 147325978225..cd6d572883ab 100644
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
 
 #define PGM_OPERATION			0x01
 #define PGM_PRIVILEGED_OP		0x02
diff --git a/arch/s390/include/asm/kvm_host_arm64.h b/arch/s390/include/asm/kvm_host_arm64.h
new file mode 100644
index 000000000000..b8a689c649bd
--- /dev/null
+++ b/arch/s390/include/asm/kvm_host_arm64.h
@@ -0,0 +1,211 @@
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
+#define KVM_S390_ARM64_IMPL_FEATURES \
+	(BIT(KVM_ARM_VCPU_PTRAUTH_ADDRESS) | BIT(KVM_ARM_VCPU_PTRAUTH_GENERIC))
+
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
+#define KVM_HVA_ERR_BAD		-1UL
+#define KVM_HVA_ERR_RO_BAD	-2UL
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

