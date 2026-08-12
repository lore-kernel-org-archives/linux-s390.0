Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDB94582F7;
	Wed, 12 Aug 2026 15:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549051; cv=none; b=X8m7dMXMAmV6h2aasAqY19ohBwbvWOt1OYj/3cQQGS7VEbb9bVTtIFCG1/5RK1A5CSRfmopbxUx3Jehs0W1CSkaYCGT2tyiCNRyMI1QYoEsrKYlOO6YILxKXJZ+M58H8B0Zvk9kmlA46c7p0gQ2QgrXkWjP6R/378d6bjDGnGBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549051; c=relaxed/simple;
	bh=Vqp6INyP6Prq4vau1DL00nlrCkUyPcqlRdcrADAzn3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PjouWIEULG0pI4038UZAuYgkpKou5EaBUG8n972Z5zCMRMU7hgU0fX8T4Ozjmrf34Ww48ULYQaWSt43ZEGLGCMNq169CagD28MnUrNbV26qeGPDVpsXm8+EPVtby+Ocbfmdf3RkaT7xupmz3tcbYtsLZNTwhEh/3O3IQmXHqCOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tX7N93Eg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tX7N93Eg"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CE1pHD3640585;
	Wed, 12 Aug 2026 15:36:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=DBTFroyfL0MElbYeL
	wi6dbzynFuGif5TH6/KOYyRyXE=; b=tX7N93EgaZuAFzLSD9Q9855IDmeGZR3ZT
	GQ8vuubZ4HKkiG8r49nxo5rz6RVDyZ6QbRPDNH3/xY5TpWg1t4FL88iY60GP+4G2
	/gmMRzOkv0hJp83Tz9YG8Q1oPHM8Bydl9URIObOmJf148O1umTpJaHcz2U7OMciq
	H+x4Pu9U8lV6G9Ars3w1y4lMn/fdnBOwT1cBv839GZTAbx0sHiII5DxAd9stEukZ
	66gegO3EpDopa7z1IGRyUA2/BnMugOfeT1DY43UuhpZLb+pe3yuTpX/jBv5MBuKz
	/oqHqJQy9Y4CstulXk+/YnwQDb1JKKucZHHuahE6gd2nrKZqzJLwg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9k7cu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:36:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CFBGfL018618;
	Wed, 12 Aug 2026 15:36:47 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5w6tdk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:36:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CFahTv42074518
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 15:36:43 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 35DBF2004F;
	Wed, 12 Aug 2026 15:36:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D26D02004B;
	Wed, 12 Aug 2026 15:36:42 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 15:36:42 +0000 (GMT)
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
Subject: [PATCH v6 29/33] KVM: s390: arm64: Implement required functions
Date: Wed, 12 Aug 2026 17:36:25 +0200
Message-ID: <20260812153631.3376090-30-seiden@linux.ibm.com>
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
X-Proofpoint-GUID: McwIXT2T-3HfZpc1tEkRZCAfqqd3TfEB
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7c9311 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=FvtiEy3qvhp2I5fuxrcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfX9P2NdrHhks0M
 V8isYreBxBSuYTYSAegKA+COltRFIPnaga9ZIN2BEyEfBeh+h5eQoW+SFuCknZDs9xyAP/VTb2n
 aNpdGrHInBOC7TEDvhwgyJV1I2/6B2At6vI0J3p2q5ZS/3AsaQ+7KeKjWZTlWUqwEB8JN7qEf9f
 fwignUh7MfQ55b6QeW2Gd0VALMPOibKeIa6Gb+qmIpjQG8yby7oxtlRNalkk2lQdTbmr28juFNi
 71LoKeKdlmrtAJoxF8hQ7tl4+7+ngp81LXaqG7FGnJYzb32Onbz9Zxmql7yDoJ4pe4hkdkp406c
 n74nkIa/20B8w/Nwhd1yR6zVyz5GGCrVB8vsIMYTG63FOBbjRjBGcAriYdYUAPU6OwsW8Mqxt9c
 0ppCgjlD07eXqV9oiz1nMVn7OfkZZEcNUUR9+p1HQ93Zsah25QLH6CXBW9WJELDdyVM7K/XNPfA
 17jPMBwpuY+PXqH6Btw==
X-Proofpoint-ORIG-GUID: tdXtZcf_EKpf50SqA_ffBuXxURSLiB-i
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfX+nAGu4Q7hZB9
 N86ddfqB+MSRUo0TRBSz+L5JYdvIB345mPQal7+v8t0eS0e3uwPXTKC+qYo71ZmJLDkp31bWZRP
 r3ejfCeW6vhRBk60qz6UsL86YaCwnXw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120126

Implement the mostly trivial functions that the shared arm64 (kvm)
code & headers oblige s390 to implement.

Implement a very basic smccc handler that (non-compliantly) is just able
to stop a vcpu.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/arm64/kvm_emulate.h | 130 ++++++++++++++++++++++++++
 arch/s390/include/arm64/kvm_nested.h  |  11 +++
 arch/s390/include/arm64/ptrace.h      |  11 +++
 arch/s390/include/arm64/sysreg.h      |  13 +++
 arch/s390/kvm/arm64/handle_exit.c     |  98 +++++++++++++++++++
 arch/s390/kvm/arm64/inject_fault.c    |  21 +++++
 6 files changed, 284 insertions(+)
 create mode 100644 arch/s390/include/arm64/kvm_emulate.h
 create mode 100644 arch/s390/include/arm64/kvm_nested.h
 create mode 100644 arch/s390/include/arm64/ptrace.h
 create mode 100644 arch/s390/include/arm64/sysreg.h
 create mode 100644 arch/s390/kvm/arm64/handle_exit.c
 create mode 100644 arch/s390/kvm/arm64/inject_fault.c

diff --git a/arch/s390/include/arm64/kvm_emulate.h b/arch/s390/include/arm64/kvm_emulate.h
new file mode 100644
index 000000000000..c1551e3da8f4
--- /dev/null
+++ b/arch/s390/include/arm64/kvm_emulate.h
@@ -0,0 +1,130 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __S390_ARM64_KVM_EMULATE_H__
+#define __S390_ARM64_KVM_EMULATE_H__
+
+#include <asm/fault.h>
+#include <linux/kvm_host.h>
+
+#include <arm64/kvm_nested.h>
+#include <arm64/ptrace.h>
+#include <arm64/kvm_arm.h>
+#include <arm64/sysreg.h>
+
+static __always_inline unsigned long *vcpu_pc(const struct kvm_vcpu *vcpu)
+{
+	return (unsigned long *)&vcpu->arch.sae_block.pc;
+}
+
+static __always_inline unsigned long *vcpu_cpsr(const struct kvm_vcpu *vcpu)
+{
+	return (unsigned long *)&vcpu->arch.sae_block.pstate;
+}
+
+static __always_inline unsigned long *vcpu_sp_el0(const struct kvm_vcpu *vcpu)
+{
+	return (unsigned long *)&vcpu->arch.sae_block.sp_el0;
+}
+
+static __always_inline u64 *vcpu_sp_el1(struct kvm_vcpu *vcpu)
+{
+	return &vcpu->arch.sae_block.sp_el1;
+}
+
+static __always_inline __vector128 *vcpu_vreg(struct kvm_vcpu *vcpu, int off)
+{
+	return &vcpu->arch.ctxt.vregs[off];
+}
+
+static __always_inline u64 *vcpu_fpsr(struct kvm_vcpu *vcpu)
+{
+	return &vcpu->arch.sae_block.fpsr;
+}
+
+static __always_inline u64 *vcpu_fpcr(struct kvm_vcpu *vcpu)
+{
+	return &vcpu->arch.sae_block.fpcr;
+}
+
+static __always_inline bool vcpu_mode_is_32bit(const struct kvm_vcpu *vcpu)
+{
+	return false;
+}
+
+static __always_inline u64 kvm_vcpu_get_esr(const struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.sae_block.hai.esr_elz;
+}
+
+static inline unsigned long *vcpu_hcr(struct kvm_vcpu *vcpu)
+{
+	return (unsigned long *)&vcpu->arch.hcr_elz;
+}
+
+static __always_inline unsigned long kvm_vcpu_get_hfar(const struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.sae_block.hai.far_elz;
+}
+
+static __always_inline phys_addr_t kvm_vcpu_get_fault_ipa(const struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.sae_block.hai.teid.addr * PAGE_SIZE;
+}
+
+static inline u16 kvm_vcpu_fault_pic(const struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.sae_block.hai.pic & PGM_INT_CODE_MASK;
+}
+
+static __always_inline
+bool kvm_vcpu_trap_is_permission_fault(const struct kvm_vcpu *vcpu)
+{
+	return kvm_vcpu_fault_pic(vcpu) == PGM_PROTECTION;
+}
+
+static __always_inline bool kvm_condition_valid(const struct kvm_vcpu *vcpu)
+{
+	return true;
+}
+
+static __always_inline bool vcpu_el1_is_32bit(struct kvm_vcpu *vcpu)
+{
+	return false;
+}
+
+static inline bool kvm_vcpu_is_be(struct kvm_vcpu *vcpu)
+{
+	return false;
+}
+
+static inline int kvm_vcpu_abt_gltl(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.sae_block.hai.gltl;
+}
+
+static inline bool vcpu_mode_priv(const struct kvm_vcpu *vcpu)
+{
+	u32 mode = *vcpu_cpsr(vcpu) & PSR_MODE_MASK;
+
+	return mode != PSR_MODE_EL0t;
+}
+
+static inline void kvm_skip_instr(struct kvm_vcpu *vcpu)
+{
+	*vcpu_pc(vcpu) += 4;
+	*vcpu_cpsr(vcpu) &= ~PSR_BTYPE_MASK;
+
+	/* advance the singlestep state machine */
+	*vcpu_cpsr(vcpu) &= ~SPSR_ELx_SS;
+}
+
+static inline void kvm_reset_fpsimd(struct kvm_vcpu *vcpu)
+{
+	memset(vcpu->arch.ctxt.vregs, 0, sizeof(vcpu->arch.ctxt.vregs));
+	vcpu->arch.sae_block.fpsr = 0;
+	vcpu->arch.sae_block.fpcr = 0;
+}
+
+#include <arm64/kvm_emulate-gen.h>
+
+#endif /* __S390_ARM64_KVM_EMULATE_H__ */
diff --git a/arch/s390/include/arm64/kvm_nested.h b/arch/s390/include/arm64/kvm_nested.h
new file mode 100644
index 000000000000..e950b1a10c41
--- /dev/null
+++ b/arch/s390/include/arm64/kvm_nested.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef ASM_KVM_NESTED_H
+#define ASM_KVM_NESTED_H
+
+static inline bool vcpu_has_nv(const struct kvm_vcpu *vcpu)
+{
+	return false;
+}
+
+#endif /* ASM_KVM_NESTED_H */
diff --git a/arch/s390/include/arm64/ptrace.h b/arch/s390/include/arm64/ptrace.h
new file mode 100644
index 000000000000..449b85582c97
--- /dev/null
+++ b/arch/s390/include/arm64/ptrace.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __S390_ARM64_PTRACE_H__
+#define __S390_ARM64_PTRACE_H__
+
+#include <arm64/sysreg.h>
+#include <uapi/arm64/ptrace.h>
+
+#include <arm64/ptrace-gen.h>
+
+#endif /* __S390_ARM64_PTRACE_H__ */
diff --git a/arch/s390/include/arm64/sysreg.h b/arch/s390/include/arm64/sysreg.h
new file mode 100644
index 000000000000..ac6b638fef56
--- /dev/null
+++ b/arch/s390/include/arm64/sysreg.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __S390_ARM64_SYSREG_H__
+#define __S390_ARM64_SYSREG_H__
+
+#include <linux/bits.h>
+#include <linux/stringify.h>
+#include <linux/kasan-tags.h>
+#include <linux/kconfig.h>
+
+#include <arm64/sysreg-gen.h>
+
+#endif /* __S390_ARM64_SYSREG_H__ */
diff --git a/arch/s390/kvm/arm64/handle_exit.c b/arch/s390/kvm/arm64/handle_exit.c
new file mode 100644
index 000000000000..ed872cd804dc
--- /dev/null
+++ b/arch/s390/kvm/arm64/handle_exit.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/kvm_host.h>
+
+#include <arm64/esr.h>
+#include <arm64/kvm_emulate.h>
+
+typedef int (*exit_handle_fn)(struct kvm_vcpu *);
+static exit_handle_fn arm_exit_handlers[ESR_ELx_EC_MAX + 1];
+
+#define __INCL_GEN_ARM_FILE
+#include "generated/handle_exit.inc"
+#undef __INCL_GEN_ARM_FILE
+
+#define PSCI_0_2_FN_SYSTEM_OFF		0x84000008
+#define PSCI_RET_NOT_SUPPORTED		-1
+#define PSCI_RET_INTERNAL_FAILURE	-6
+/*
+ * Temporary smc/hvc handler. Non-compliant implementation (features missing).
+ * Implements only system off so that test programs are able to end their execution
+ */
+static int kvm_smccc_call_handler(struct kvm_vcpu *vcpu)
+{
+	u32 func_id = vcpu_get_reg(vcpu, 0);
+	u64 val = PSCI_RET_NOT_SUPPORTED;
+	int ret = 1;
+
+	if (func_id == PSCI_0_2_FN_SYSTEM_OFF) {
+		scoped_guard(spinlock, &vcpu->arch.mp_state_lock) {
+			WRITE_ONCE(vcpu->arch.mp_state.mp_state, KVM_MP_STATE_STOPPED);
+		}
+		kvm_make_all_cpus_request(vcpu->kvm, KVM_REQ_SLEEP);
+		memset(&vcpu->run->system_event, 0,
+		       sizeof(vcpu->run->system_event));
+		vcpu->run->system_event.type = KVM_SYSTEM_EVENT_SHUTDOWN;
+		vcpu->run->system_event.ndata = 1;
+		vcpu->run->system_event.data[0] = 0;
+		vcpu->run->exit_reason = KVM_EXIT_SYSTEM_EVENT;
+		val = PSCI_RET_INTERNAL_FAILURE;
+		ret = 0;
+	}
+	vcpu_set_reg(vcpu, 0, val);
+
+	return ret;
+}
+
+static int handle_hvc(struct kvm_vcpu *vcpu)
+{
+	vcpu->stat.hvc_exit_stat++;
+	return kvm_smccc_call_handler(vcpu);
+}
+
+static exit_handle_fn arm_exit_handlers[] = {
+	[0 ... ESR_ELx_EC_MAX]	= kvm_handle_unknown_ec,
+	[ESR_ELx_EC_HVC64]	= handle_hvc,
+};
+
+/* manually copied from arch/arm64/kernel/traps.c */
+static const char * const esr_class_str[] = {
+	[0 ... ESR_ELx_EC_MAX]		= "UNRECOGNIZED EC",
+	[ESR_ELx_EC_UNKNOWN]		= "Unknown/Uncategorized",
+	[ESR_ELx_EC_WFx]		= "WFI/WFE",
+	[ESR_ELx_EC_FP_ASIMD]		= "ASIMD",
+	[ESR_ELx_EC_PAC]		= "PAC",
+	[ESR_ELx_EC_BTI]		= "BTI",
+	[ESR_ELx_EC_ILL]		= "PSTATE.IL",
+	[ESR_ELx_EC_SVC64]		= "SVC (AArch64)",
+	[ESR_ELx_EC_HVC64]		= "HVC (AArch64)",
+	[ESR_ELx_EC_SMC64]		= "SMC (AArch64)",
+	[ESR_ELx_EC_SYS64]		= "MSR/MRS (AArch64)",
+	[ESR_ELx_EC_SVE]		= "SVE",
+	[ESR_ELx_EC_ERET]		= "ERET/ERETAA/ERETAB",
+	[ESR_ELx_EC_FPAC]		= "FPAC",
+	[ESR_ELx_EC_SME]		= "SME",
+	[ESR_ELx_EC_IMP_DEF]		= "EL3 IMP DEF",
+	[ESR_ELx_EC_IABT_LOW]		= "IABT (lower EL)",
+	[ESR_ELx_EC_IABT_CUR]		= "IABT (current EL)",
+	[ESR_ELx_EC_PC_ALIGN]		= "PC Alignment",
+	[ESR_ELx_EC_DABT_LOW]		= "DABT (lower EL)",
+	[ESR_ELx_EC_DABT_CUR]		= "DABT (current EL)",
+	[ESR_ELx_EC_SP_ALIGN]		= "SP Alignment",
+	[ESR_ELx_EC_MOPS]		= "MOPS",
+	[ESR_ELx_EC_FP_EXC64]		= "FP (AArch64)",
+	[ESR_ELx_EC_GCS]		= "Guarded Control Stack",
+	[ESR_ELx_EC_SERROR]		= "SError",
+	[ESR_ELx_EC_BREAKPT_LOW]	= "Breakpoint (lower EL)",
+	[ESR_ELx_EC_BREAKPT_CUR]	= "Breakpoint (current EL)",
+	[ESR_ELx_EC_SOFTSTP_LOW]	= "Software Step (lower EL)",
+	[ESR_ELx_EC_SOFTSTP_CUR]	= "Software Step (current EL)",
+	[ESR_ELx_EC_WATCHPT_LOW]	= "Watchpoint (lower EL)",
+	[ESR_ELx_EC_WATCHPT_CUR]	= "Watchpoint (current EL)",
+	[ESR_ELx_EC_BRK64]		= "BRK (AArch64)",
+};
+
+const char *esr_get_class_string(unsigned long esr)
+{
+	return esr_class_str[ESR_ELx_EC(esr)];
+}
diff --git a/arch/s390/kvm/arm64/inject_fault.c b/arch/s390/kvm/arm64/inject_fault.c
new file mode 100644
index 000000000000..425dbeaa421c
--- /dev/null
+++ b/arch/s390/kvm/arm64/inject_fault.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <arm64/kvm_emulate.h>
+
+/**
+ * kvm_inject_undefined - inject an undefined instruction into the guest
+ * @vcpu: The vCPU in which to inject the exception
+ *
+ * It is assumed that this code is called from the VCPU thread and that the
+ * VCPU therefore is not currently executing guest code.
+ */
+void kvm_inject_undefined(struct kvm_vcpu *vcpu)
+{
+	/* Stub until s390 supports arm64 sysregs TODO sysregs*/
+}
+
+int kvm_inject_sea(struct kvm_vcpu *vcpu, bool iabt, u64 addr)
+{
+	/* Stub until s390 supports arm64 sysregs TODO sysregs*/
+	return 1;
+}
-- 
2.53.0

