Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6DA437479;
	Fri, 31 Jul 2026 13:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503390; cv=none; b=VhkcHWVOQbVkOBJ+nDYPHqjrxecui98DB/vaVUAqb0pVfTSgc6daFulo7ddr3M/EB9caW1HxvrdFdUmUVvAohqjzlT+a/GJrreszxmA3yjrw3ensHhgeSOQaoGKXEC++v0t9gZXY24acMqgFIpqK5n88TTUvIlSlVZx+Q2NfrdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503390; c=relaxed/simple;
	bh=ld7BUcMoOwh9V+yhJl9PZx76dO3q4UmbfU8y6dNclAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qgd/0MczTZybb44Ce5rr+wgI6vJwAFBOjRO7hrcwA126QPPC4qI7Do54669RCaxaASBh0wfeU2F6YOE8St/BfJkPOYQ4qK0Yg2uPZbqsFR+0eW97QW0nEEwAQSsN74ojYmVHbMt25U+LTRvj9NhrHOMoWVqQqk2OS3rCmyQzpwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ooQ+oTCq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ooQ+oTCq"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBmNVr4074123;
	Fri, 31 Jul 2026 13:09:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=h2+waxdEvTNIqlbAD
	ePHLSFBRTAz1IY4S1NyMs1J5x0=; b=ooQ+oTCqUWnwb0fjXX7SZnTLIFYJ9jOYX
	QnalYhXciKV8OeuXSxmIt51g/Xsa2Fybm3Kq2854llWPUC2oltxeZp5xmjI/+9fb
	NaXzMRDkQSOjFwr9Kz2Bzu3HPdOtmxZt/tM2IbYHykEuRjCYWuGsa2++0+6iTNvY
	oL9loEyjmBBMndqvZJ5TfaEFTgHr6u6wAlA2RfMdQp38ErenYAXqGYhHbL9hkllg
	4drB6+aN1FGPboHGRH2p4GinxAAnIqICCaCFuCZ4pVCLZn4LQdXnYFJ2gJm3+UWI
	cSfiSfjEWoMEgGu4VwXLve8+SKi5nnZPcjpRFxPyLvStYvGRBWNcQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycw2p8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VCuL9i021043;
	Fri, 31 Jul 2026 13:09:21 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fqr562-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VD9Fjf29819576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 13:09:15 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B91A20040;
	Fri, 31 Jul 2026 13:09:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C85AF2004D;
	Fri, 31 Jul 2026 13:09:14 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 13:09:14 +0000 (GMT)
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
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v5 27/31] KVM: s390: arm64: Implement required functions
Date: Fri, 31 Jul 2026 15:08:55 +0200
Message-ID: <20260731130902.654679-28-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731130902.654679-1-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: Cxzd3_uRKTTRyixBU45-D-BgLuqyw3D7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX32uxRSJoWVx+
 DVUfCpiNr+9xgpel3PqmlR6DPzHAaBuhjE/41BHe3yqB00yXAaKRSpo4pE+yUhzIKO3flzinckD
 h9NXmJaJ4P1gV/cxdFZ9cqlFG44SpUXe9Gaq1hRBFgS6qrWX0Cr0sKWKmic8e1Z1XFcW6odg3gR
 XAVVMC+arZfLIYQgiWSbdOcOR2yQSPGhoOdaUr35Vx+22VYxs/ypyKsSBzV7RCu5O6ykKWmyfwQ
 tJf2y+Xyg5TifeXuRgg8WxX7u6Ja40dn7kIkdmruTXhplRXkGMN4UmopHI4qpzdgrcg/nicLqSY
 DB+AZ0YTnC7Bs+CTvfVMf1rI7PF9/wtoGVPdqjR7MXZARHN73l+a0SqeiMfl7/QGvJIK+KGEPmu
 mApRBQIwLJsDxQmMZs50farGUIyPUmgPlFN2M+OSp/enyJ+cQFxGkN2+AhYN2QrIGTEvTKnRgx2
 06VYVNxMDce/qgmMzTw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfXwndo019t3Dks
 SkF4y+F/NOiB4M5xU80WLXTO+S/tJIQMwI5xQArAwRdAFuDqeE5PRo5VPRNPCF2wWQwO2ti9mT/
 AUWG+XBy9BxawUpxREWMK9PUOnZ4Khg=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6c9e83 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=FvtiEy3qvhp2I5fuxrcA:9
X-Proofpoint-GUID: uEEY0HOeUFHCpCP4HXysKM0OeTjNPaus
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310096

Implement the mostly trivial functions that the shared arm64 (kvm)
code & headers oblige s390 to implement.

Implement a very basic smccc handler that (non-compliantly) is just able
to stop a vcpu.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/arm64/kvm_emulate.h | 102 ++++++++++++++++++++++++++
 arch/s390/include/arm64/kvm_nested.h  |  11 +++
 arch/s390/include/arm64/ptrace.h      |  11 +++
 arch/s390/include/arm64/sysreg.h      |  13 ++++
 arch/s390/kvm/arm64/handle_exit.c     |  98 +++++++++++++++++++++++++
 arch/s390/kvm/arm64/inject_fault.c    |  21 ++++++
 6 files changed, 256 insertions(+)
 create mode 100644 arch/s390/include/arm64/kvm_emulate.h
 create mode 100644 arch/s390/include/arm64/kvm_nested.h
 create mode 100644 arch/s390/include/arm64/ptrace.h
 create mode 100644 arch/s390/include/arm64/sysreg.h
 create mode 100644 arch/s390/kvm/arm64/handle_exit.c
 create mode 100644 arch/s390/kvm/arm64/inject_fault.c

diff --git a/arch/s390/include/arm64/kvm_emulate.h b/arch/s390/include/arm64/kvm_emulate.h
new file mode 100644
index 000000000000..c02a6fdeb9ab
--- /dev/null
+++ b/arch/s390/include/arm64/kvm_emulate.h
@@ -0,0 +1,102 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __S390_ARM64_KVM_EMULATE_H__
+#define __S390_ARM64_KVM_EMULATE_H__
+
+#include <asm/fault.h>
+#include <asm/ptrace.h>
+#include <linux/kvm_host.h>
+
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
+	*vcpu_cpsr(vcpu) &= ~SPSR_EL1_SS;
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
index 000000000000..b00653bf97da
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
+exit_handle_fn arm_exit_handlers[ESR_ELx_EC_MAX + 1];
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
+exit_handle_fn arm_exit_handlers[] = {
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

