Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E180C5326AB;
	Wed, 30 Sep 2026 17:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789725; cv=none; b=D07fpo8FuMuGcLUNriUW9DEACXjAQYXFCj5J0iZ5JtQwIEqGqqnUQk/PMFVD5aiSPr6CAq0zlJmCuhKNwDzga0ty6KVze7tyBRU7nbbQ/+fZosWroXaIU5R83lZuc0Rx4R2EqUpmO+CZ6/oT601uMIpq7j7LQDW7kevqd7z30TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789725; c=relaxed/simple;
	bh=zKtNwVBJVgi7IOuErU9cG/5nhCgtk1QSLI68BGIyvJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mENpzMKlUkpjaJjaPGKHytbu+vj6eHgjTgPm4REUmRcPX7Rrha5dnxbjSNltXUAhcU/cPVdioSdJ8ZsIOI4w+/9KHDodOKhbrR09XYLBIEhEpTMsgEeWPONVLLAPSANku4K2qezqMOII3kqsZJIDeMYQteforJu+qTWDfzPlvts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=atlSVjX+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="atlSVjX+"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UE5go01336090;
	Wed, 30 Sep 2026 17:34:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WsFkEY+zfDq6VsR6R
	x0dXoJ0hhKn6axgxWeSoz+JVsI=; b=atlSVjX+CckyUBatzRdaLT8l4gjKyEA6q
	Gg1J4z8clB4NjY6ap1Pu39fAcS+h6x/ICA+Q4yjE2QiHDuKjj+iqxglKoCmQJBln
	incSvtCg5fCZFJQJ1TBpqqGik4oKfA6VE7z0xjMK40QDVKmklarSR0qRjAdha89x
	y5g6Hj+rmVhSICW2ef1138uhlyGDwKTPWdLXxoqg4z5tGAE28LUjm0O9haqYrTvv
	10OSzCaeQQIWB+aJKzVuZucxocimqm5FCi3/1bcDzGW6cMH3SN9XBZTkTINlDV5u
	/BIzx7zSlij2OZsFXdHlw0nJKjRCS/TxYlnPfRWTYkm1uEXut6VXQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qrehc6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:34:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68UE38Tu3541488;
	Wed, 30 Sep 2026 17:34:54 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0hfpcyve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:34:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68UHYnMB50921752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Sep 2026 17:34:49 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4906720049;
	Wed, 30 Sep 2026 17:34:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ECF3820065;
	Wed, 30 Sep 2026 17:34:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Sep 2026 17:34:48 +0000 (GMT)
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
Subject: [PATCH v9 20/24] KVM: s390: arm64: Implement required functions
Date: Wed, 30 Sep 2026 19:34:35 +0200
Message-ID: <20260930173441.66762-21-seiden@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2OCBTYWx0ZWRfX87F2cnE2Mh4/
 IFNOlYOsoFTNwCKM1YIJ2QbDiZtisA4HZtecQN5gedWc9ksA0pYj2bBXiWRGwD0mp/IwUMDCIQF
 abyZRT8rdw7EGBXAmwAprP9k5agbeZMMwD7y/8PUyOrqkIcm206B/smqmg2LY90Qcdgfx4jk+Bg
 Jao0qj5Db9/xyiwOj2a9eEu3rTDRiiEhGotHPlL36OkJRvo1hfrsE6taxF+q/Qb1DoZY+U1ncJv
 zoifsTOYSLVCVFb+A3UnGmhMpehYI03geUcpcqOvQDLHsBBKDsLwYfTZP7JmsDqm8laDohor0nX
 M0Y4QdLzccVFoxOZHdgtcduIIfYdKR+2KzBHEVeNYTpaTJaSW+iyURAthGcf3A3iqxtYYwTmGHi
 q7RLG4G1lWMZyedYhGGjmq5qPASCN3nH45pIAH43fWMs+SHWBm+67eEtQMxH/6XBHFluRtmSw9Y
 n4BsmSqGb9l5KRpkzmQ==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6abd483f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=aBOitRegfcjIfz6fJ64A:9
X-Proofpoint-ORIG-GUID: H7N1L2XPlXpdI6FvnX0L1cpdih5gsW4E
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2OCBTYWx0ZWRfX8oQKg2B1sarG
 APHVVRMX7/lWGAUIzyM8433dwooSMzQ4RK2vPwGdHNidDHrMNjtoW2jQXKmV1sXX+te1+bfwzBh
 JxYJVlEUztLoPh3bLjTVZzVE7c/OSWQ=
X-Proofpoint-GUID: 2bHMe6gQkVF4XWWExD4GMilj1FKwbsI-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300068

Implement the mostly trivial functions that the shared arm64 (kvm)
code & headers oblige s390 to implement.

MAINTAINERS: Add arch/s390/include/arm64/* to KVM/s390

Implement a very basic smccc handler that (non-compliantly) is just able
to stop a vcpu.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 MAINTAINERS                           |   1 +
 arch/s390/include/arm64/kvm_emulate.h | 130 ++++++++++++++++++++++++++
 arch/s390/include/arm64/kvm_nested.h  |  11 +++
 arch/s390/include/arm64/ptrace.h      |  11 +++
 arch/s390/include/arm64/sysreg.h      |  13 +++
 arch/s390/kvm/arm64/handle_exit.c     | 127 +++++++++++++++++++++++++
 arch/s390/kvm/arm64/inject_fault.c    |  21 +++++
 7 files changed, 314 insertions(+)
 create mode 100644 arch/s390/include/arm64/kvm_emulate.h
 create mode 100644 arch/s390/include/arm64/kvm_nested.h
 create mode 100644 arch/s390/include/arm64/ptrace.h
 create mode 100644 arch/s390/include/arm64/sysreg.h
 create mode 100644 arch/s390/kvm/arm64/handle_exit.c
 create mode 100644 arch/s390/kvm/arm64/inject_fault.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 72294ddfa5b7..22327e180c6b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14374,6 +14374,7 @@ L:	kvm@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git
 F:	Documentation/virt/kvm/s390*
+F:	arch/s390/include/arm64/*
 F:	arch/s390/include/asm/gmap_helpers.h
 F:	arch/s390/include/asm/kvm*
 F:	arch/s390/include/uapi/asm/kvm*
diff --git a/arch/s390/include/arm64/kvm_emulate.h b/arch/s390/include/arm64/kvm_emulate.h
new file mode 100644
index 000000000000..416c4f96db05
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
+static __always_inline u32 *vcpu_fpsr(struct kvm_vcpu *vcpu)
+{
+	return &vcpu->arch.sae_block.fpsr;
+}
+
+static __always_inline u32 *vcpu_fpcr(struct kvm_vcpu *vcpu)
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
+	return vcpu->arch.sae_block.hai.esr_el2;
+}
+
+static inline unsigned long *vcpu_hcr(struct kvm_vcpu *vcpu)
+{
+	return (unsigned long *)&vcpu->arch.hcr_el2;
+}
+
+static __always_inline unsigned long kvm_vcpu_get_hfar(const struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.sae_block.hai.far_el2;
+}
+
+static __always_inline phys_addr_t kvm_vcpu_get_fault_ipa(const struct kvm_vcpu *vcpu)
+{
+	return gfn_to_gpa(vcpu->arch.sae_block.hai.teid.addr);
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
index 000000000000..07d8d7a53702
--- /dev/null
+++ b/arch/s390/kvm/arm64/handle_exit.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/kvm_host.h>
+
+#include <arm64/esr.h>
+#include <arm64/kvm_emulate.h>
+
+typedef int (*exit_handle_fn)(struct kvm_vcpu *);
+
+#define PSCI_0_2_FN_SYSTEM_OFF		0x84000008
+#define PSCI_RET_NOT_SUPPORTED		-1
+#define PSCI_RET_INTERNAL_FAILURE	-6
+/*
+ * Temporary smc/hvc handler. Non-compliant implementation (features missing).
+ * Implements only system off so that test programs are able to end their execution.
+ * Multi-vCPU power state management and KVM_REQ_SLEEP handling are deferred
+ * to future SMP series.
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
+static int kvm_handle_unknown_ec(struct kvm_vcpu *vcpu)
+{
+	u64 esr = kvm_vcpu_get_esr(vcpu);
+
+	kvm_pr_unimpl("Unknown exception class: esr: %#016llx -- %s\n",
+		      esr, esr_get_class_string(esr));
+
+	kvm_inject_undefined(vcpu);
+	return 1;
+}
+
+static exit_handle_fn arm_exit_handlers[] = {
+	[0 ... ESR_ELx_EC_MAX]	= kvm_handle_unknown_ec,
+	[ESR_ELx_EC_HVC64]	= handle_hvc,
+};
+
+static exit_handle_fn kvm_get_exit_handler(struct kvm_vcpu *vcpu)
+{
+	u64 esr = kvm_vcpu_get_esr(vcpu);
+	u8 esr_ec = ESR_ELx_EC(esr);
+
+	return arm_exit_handlers[esr_ec];
+}
+
+/*
+ * We may be single-stepping an emulated instruction. If the emulation
+ * has been completed in the kernel, we can return to userspace with a
+ * KVM_EXIT_DEBUG, otherwise userspace needs to complete its
+ * emulation first.
+ */
+static int handle_trap_exceptions(struct kvm_vcpu *vcpu)
+{
+	exit_handle_fn exit_handler;
+
+	exit_handler = kvm_get_exit_handler(vcpu);
+	return exit_handler(vcpu);
+}
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

