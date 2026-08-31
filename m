Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46AD50C2AB;
	Mon, 31 Aug 2026 15:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188484; cv=none; b=QbHtgv6F0ervIC+ZwcxU0386HxoERlvYWZllOK2Xq0Frbd4zk7lZwPIDeri/ZjFRqKKH97iY83kdAcuvrWEK7VmZrz3YTESmUSAI5UsmcO8qZM9czjgTBLRVDYZh14XuBv9zPAM4Y5YBVJ+DEqFgGKUeGUTtpuYA7GuGUONuX7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188484; c=relaxed/simple;
	bh=CnHO77qKdQgZhX2nQ5cbWiH2SkqNmwpdrjhBl+C/guE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUkr9QwsVym4WRgIjM5Ta7w7G3FW5EJRJPFSo1Chr49lgcYRXxnrHne3C0AN2xEa2kP66+2XgPZQv5MdZwZMy2HfqMEo1nq3sSoyRYTblrAAsR98S3Ko5lFcUPH9bo1c4A8ci20f+MGvKYPzzPPIFleb1dKjOq2bqEeel3N3DgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cKzMbf8R; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cKzMbf8R"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZ7bF2525509;
	Mon, 31 Aug 2026 14:55:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ushIYmp3CivQhVdvT
	exddImWWQzEL5rUrGlxzXd6UDw=; b=cKzMbf8RmLyU0GxjOSm8MWoo7iYmlDTBu
	KKJClay1uO28xGMYF23v4GHrJ1iF/TJkuLOjY11oxFPm+UW9/6Z5crmy9y48Tmvx
	mpiEBMQpEALkcph5FYtHFv4bgAntlRSeYgNVpWs1xekpDdNDgGBBhKunf90VPrKa
	9Uzhq72UEITi1FFIqmoXOt5vbzRkpqhRIeCD/RQJM4+CA9QF9q2S3NmNic8MiYZG
	QmPl9DhsFKc22Qi8ojBgucRXVp/iWsnovs/hXaEhe4AIGVFVGYULijDsooNnxFyf
	iJgUBFzJsRCAf3Mqp1fZ5o1GCnoQEtn4P6fVUsBxTgNPnk74f7JpA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq54j0ta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:55:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEfgYD016964;
	Mon, 31 Aug 2026 14:55:53 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8h6dpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:55:52 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VEti9T15532526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 14:55:44 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FEFB20040;
	Mon, 31 Aug 2026 14:55:44 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8438F2004B;
	Mon, 31 Aug 2026 14:55:43 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 14:55:43 +0000 (GMT)
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
Subject: [PATCH v2 13/20] KVM: s390: arm64: Implement arm sysreg managing infrastructure
Date: Mon, 31 Aug 2026 16:55:28 +0200
Message-ID: <20260831145536.913567-14-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831145536.913567-1-seiden@linux.ibm.com>
References: <20260831145536.913567-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX374NYoJRWtFg
 9OhOH0e90yEIRipcGVxVES4LEGIj837wOz5tONQ0jqmHm45YWvNp4EIdGuzHXAevKxKyjwQD2TX
 zEdLIPcHnLlhjxdrv9u7lw408lGpMoS2byHuM/PFLeaIlg+GzQx/l9D4pGv8hUTGMLHzb++qwDG
 D0GmpqDnCQXzJGUqhIm/QnV9BDU5d8A1mn/t/GQ2G43XsmekgEs3f8ugHH65MODSETy/YNK4wvE
 pQ4Ol3HcB0JZNEbnzvaRSAAcCM5gC7hwRVWaMYYqDyEMvb6y84tdndnW3itlReJX1ps5Vshr76J
 U4M2KAFsJiqyWSa4io/PuJxgsD32OYEg2FDrKkb5+2DyQDYjwF5Whune0PPXV168V9+dRK/HGTu
 rEEQfET5hMuaYlt9d3Ijm+GNLcvN1veMAAnxH7JFn4yaDXMDFduKtmbm2INgECeDe+vbScewjoR
 Ol0ha9liWuh6H96Irpg==
X-Proofpoint-ORIG-GUID: VJ3tCxbC5ReJsT1TS3f9AOrpgocX8Dac
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a9595fb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=oZHtAar1Vk6HErUEWy4A:9
X-Proofpoint-GUID: 8eV9Kk5R85-Va2KLyLtZ83p3ieZt7K-Q
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX4kXuQrc6wMM5
 yqL1mPdiNFiQ2PnkheIXkskDhqLqUogENEtEIlMZPGebyeqAU+hd2cM5oOakag82v+EreLr+NBU
 f6dvr9WH+Rywtprrdpp8ackNvq2930A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310125

Implement the infrastructures for the s390 host to read and write the
arm64 guest system register. The host can access and modify (non-id)
system registers through the new instructions EASR/SASR or their
multiple variant. Guest accesses to ID registers are trapped and handled
by KVM. KVM gets the data form the result of QAAF and sanitizes it using
the shared infrastructure with arm64.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/arm64/kvm_hyp.h      |  18 +
 arch/s390/include/arm64/kvm_nested.h   |   5 +
 arch/s390/include/arm64/sys_regs.h     |   9 +
 arch/s390/include/asm/kvm_host_arm64.h | 204 ++++++-
 arch/s390/kvm/arm64/Makefile           |   2 +
 arch/s390/kvm/arm64/Makefile.gen       |   1 +
 arch/s390/kvm/arm64/spectre.c          |  14 +
 arch/s390/kvm/arm64/sys_regs.c         | 750 +++++++++++++++++++++++++
 arch/s390/kvm/arm64/trace.h            |  51 ++
 arch/s390/tools/Makefile.arm64h        |   4 +
 10 files changed, 1057 insertions(+), 1 deletion(-)
 create mode 100644 arch/s390/include/arm64/kvm_hyp.h
 create mode 100644 arch/s390/include/arm64/sys_regs.h
 create mode 100644 arch/s390/kvm/arm64/spectre.c
 create mode 100644 arch/s390/kvm/arm64/sys_regs.c

diff --git a/arch/s390/include/arm64/kvm_hyp.h b/arch/s390/include/arm64/kvm_hyp.h
new file mode 100644
index 000000000000..e425b7c3c80d
--- /dev/null
+++ b/arch/s390/include/arm64/kvm_hyp.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __S390_ARM64_KVM_HYP_H__
+#define __S390_ARM64_KVM_HYP_H__
+
+#include <linux/compiler.h>
+
+static __always_inline bool has_vhe(void)
+{
+	return true;
+}
+
+static __always_inline bool is_protected_kvm_enabled(void)
+{
+	return false;
+}
+
+#endif /* __S390_ARM64_KVM_HYP_H__ */
diff --git a/arch/s390/include/arm64/kvm_nested.h b/arch/s390/include/arm64/kvm_nested.h
index e950b1a10c41..9c02ac5c62cc 100644
--- a/arch/s390/include/arm64/kvm_nested.h
+++ b/arch/s390/include/arm64/kvm_nested.h
@@ -8,4 +8,9 @@ static inline bool vcpu_has_nv(const struct kvm_vcpu *vcpu)
 	return false;
 }
 
+static inline u64 limit_nv_id_reg(struct kvm *kvm, u32 id, u64 val)
+{
+	return val;
+}
+
 #endif /* ASM_KVM_NESTED_H */
diff --git a/arch/s390/include/arm64/sys_regs.h b/arch/s390/include/arm64/sys_regs.h
new file mode 100644
index 000000000000..dafb090ee1af
--- /dev/null
+++ b/arch/s390/include/arm64/sys_regs.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __S390_ARM64_SYS_REGS_H__
+#define __S390_ARM64_SYS_REGS_H__
+
+#include <arm64/cputype.h>
+#include <arm64/sys_regs-gen.h>
+
+#endif /* __S390_ARM64_SYS_REGS_H__ */
diff --git a/arch/s390/include/asm/kvm_host_arm64.h b/arch/s390/include/asm/kvm_host_arm64.h
index 22e4bf788fa2..65e5e0c48b07 100644
--- a/arch/s390/include/asm/kvm_host_arm64.h
+++ b/arch/s390/include/asm/kvm_host_arm64.h
@@ -3,11 +3,13 @@
 #define ASM_KVM_HOST_ARM64_H
 
 #include <linux/bug.h>
+#include <linux/bitfield.h>
 
 #include <asm/kvm_host_types.h>
 #include <asm/debug.h>
 
 #define vcpu_gp_regs(v)		((v)->arch.sae_block.gpr)
+enum vcpu_sysreg;
 
 #include <arm64/kvm_host.h>
 #include <arm64/ptrace.h>
@@ -40,7 +42,12 @@ bool cpus_have_final_cap(unsigned int num);
 #define KVM_IRQCHIP_NUM_PINS 1
 #define irqchip_in_kernel(_k) false
 
-#define __ctxt_sys_reg(ctx, reg) NULL
+#define __ctxt_sys_reg(ctx, reg)					\
+	({								\
+		BUILD_BUG_ON(!__builtin_constant_p(reg));		\
+		___ctxt_sys_reg(ctx, reg);				\
+	})
+
 struct kvm_cpu_context {
 	/*
 	 * These are just for 32 bit, which we don't have, making them RES0.
@@ -52,6 +59,10 @@ struct kvm_cpu_context {
 	u64	spsr_fiq;
 
 	__vector128 __aligned(16) vregs[32];
+
+	/* shadowed sysregs to comply with arm64 infrastructure */
+	u64 elr_el1;
+	u64 spsr_el1;
 };
 
 struct kvm_vcpu_arch {
@@ -59,10 +70,19 @@ struct kvm_vcpu_arch {
 	struct kvm_sae_save_area save_area;
 	struct kvm_cpu_context ctxt;
 
+	/* Guest system registers not part of save area or ID registers */
+	u64 sys_reg_clidr_el1;
+	u64 sys_reg_csselr_el1;
+	/* Per-vcpu CCSIDR override or NULL */
+	u32 *ccsidr;
+
 	u32 host_acrs[NUM_ACRS];
 
 	/* Hypervisor Configuration Register */
 	u64 hcr_elz;
+	u64 hcrx_elz;
+
+	u64 mpidr;
 
 	/* Configuration flags, set once and for all before the vcpu can run */
 	u8 cflags;
@@ -133,6 +153,9 @@ struct kvm_arch {
 	DECLARE_BITMAP(vcpu_features, KVM_VCPU_MAX_FEATURES);
 
 	unsigned long mem_limit;
+
+	/* Per-VM ID register storage */
+	struct kvm_vm_id_regs id_regs;
 };
 
 static inline bool __vcpu_has_feature(const struct kvm_arch *ka, int feature)
@@ -221,4 +244,183 @@ static inline void kvm_arch_async_page_present_queued(struct kvm_vcpu *vcpu)
 
 #define kvm_supports_32bit_el0() false
 
+#define __vcpu_sys_reg(__vcpu, __reg) \
+	vcpu_read_sys_reg(__vcpu, __reg)
+
+#define __vcpu_assign_sys_reg(__vcpu, __reg, __val) \
+	vcpu_write_sys_reg(__vcpu, __val, __reg)
+
+#define __vcpu_rmw_sys_reg(C, V, OP, R)		\
+({						\
+	u64 __val = vcpu_read_sys_reg(C, R);	\
+	__val OP V;				\
+	vcpu_write_sys_reg(C, __val, R);	\
+})
+
+/**
+ * _vcpu_read_sys_reg() - read a guest sysreg with easr
+ * - R - sysreg id; must be readable by easr; must be compile time constant
+ *
+ *   if SYSREGS_ON_CPU: proceed with flags = 0
+ *   otherwise:         proceed with either
+ *                         read:  flags = EASR_FLAG_SA
+ *                         write: flags = SASR_FLAG_INITIALIZED
+ *
+ */
+#define _vcpu_read_sys_reg(C, R) \
+	({	BUILD_BUG_ON(!__builtin_constant_p((R))); \
+		BUG_ON(vcpu_is_loaded(C) && smp_processor_id() != (C)->cpu); \
+		(vcpu_is_loaded(C)) \
+			? __vcpu_read_sr((C), (R), 0) \
+			: __vcpu_read_sr((C), (R), EASR_FLAG_SA); })
+
+/**
+ * _vcpu_write_sys_reg() - write a guest sysreg with sasr
+ * - R - sysreg id; must be readable by sasr; must be compile time constant
+
+ *   if SYSREGS_ON_CPU: proceed with flags = 0
+ *   otherwise:         proceed with either
+ *                         read:  flags = EASR_FLAG_SA
+ *                         write: flags = SASR_FLAG_INITIALIZED
+ */
+#define _vcpu_write_sys_reg(C, V, R) \
+	({	BUILD_BUG_ON(!__builtin_constant_p((R))); \
+		BUG_ON(vcpu_is_loaded(C) && smp_processor_id() != (C)->cpu); \
+		(vcpu_is_loaded(C)) \
+			? __vcpu_write_sr((C), (V), (R), 0) \
+			: __vcpu_write_sr((C), (V), (R), SASR_FLAG_INITIALIZED); })
+
+/* Forward to easr / sasr
+ * assert that F and R are constant
+ */
+#define __vcpu_read_sr(C, R, F) \
+	({	BUILD_BUG_ON(!__builtin_constant_p((R))); \
+		BUILD_BUG_ON(!__builtin_constant_p((F))); \
+		easr((R), &(C)->arch.save_area, (F)); })
+
+#define __vcpu_write_sr(C, V, R, F) \
+	({	BUILD_BUG_ON(!__builtin_constant_p((R))); \
+		BUILD_BUG_ON(!__builtin_constant_p((F))); \
+		sasr((R), (V), &(C)->arch.save_area, (F)); })
+
+#define SR_GROUP(NAME, ...)	\
+	__##NAME##_BEGIN__,	\
+	__VA_ARGS__		\
+	__##NAME##_END__
+
+/** enum vcpu_sysreg - available guest sysregs
+ *
+ * Contains all arm64 guest-syregs supported by s390.
+ */
+enum vcpu_sysreg {
+	__INVALID_SYSREG__, /* 0 is reserved as an invalid value */
+
+	/* EL 0,1 Register from state description in order of appearance */
+	SR_GROUP(STATE_DESC,
+	CNTP_CTL_EL0,
+	CNTV_CTL_EL0,
+	CONTEXTIDR_EL1,
+	SP_EL1,
+	),
+
+	/* EL 0,1 Register requiring special handling. */
+	SR_GROUP(SPECIAL,
+	CSSELR_EL1,
+	CLIDR_EL1,
+	MPIDR_EL1,
+	ELR_EL1,
+	SPSR_EL1,
+	),
+
+	/* EL 0,1 register from save area in order of appearance */
+	SR_GROUP(SAVE_AREA,
+	ACTLR_EL1,
+	AFSR0_EL1,
+	AFSR1_EL1,
+	CNTFRQ_EL0,
+	CNTP_CVAL_EL0,
+	CNTV_CVAL_EL0,
+	DISR_EL1,
+	MIDR_EL1,
+	OSLSR_EL1,
+	PAR_EL1,
+	OSLAR_EL1,
+	SCTLR_EL1,
+	CPACR_EL1,
+	VBAR_EL1,
+	ESR_EL1,
+	TCR_EL1,
+	MAIR_EL1,
+	TTBR0_EL1,
+	TTBR1_EL1,
+	FAR_EL1,
+	TPIDR_EL0,
+	TPIDR_EL1,
+	TPIDRRO_EL0,
+	CNTKCTL_EL1,
+	ZCR_EL1,
+	SCXTNUM_EL0,
+	SCXTNUM_EL1,
+	APIBKEYLO_EL1,
+	APIBKEYHI_EL1,
+	APIAKEYLO_EL1,
+	APIAKEYHI_EL1,
+	APGAKEYLO_EL1,
+	APGAKEYHI_EL1,
+	APDBKEYLO_EL1,
+	APDBKEYHI_EL1,
+	APDAKEYLO_EL1,
+	APDAKEYHI_EL1,
+	MDSCR_EL1,
+	),
+
+	NR_SYS_REGS /* Nothing after this line! */
+};
+
+static __always_inline u64 *___ctxt_sys_reg(struct kvm_cpu_context *ctxt,
+					    const enum vcpu_sysreg reg)
+{
+	switch (reg) {
+	case ELR_EL1:
+		return &ctxt->elr_el1;
+	case SPSR_EL1:
+		return &ctxt->spsr_el1;
+	default:
+		BUG();
+		break;
+	}
+}
+
+void vcpu_write_host_sys_reg(struct kvm_vcpu *vcpu, u64 val, int reg);
+u64 vcpu_read_host_sys_reg(const struct kvm_vcpu *vcpu, int reg);
+
+#define kvm_debug_handle_oslar(_v, _val) /* debug not implemented yet*/
+
+static inline u8 kvm_arm_pmu_get_pmuver_limit(void)
+{
+	return 0;
+}
+
+int __init kvm_sys_reg_table_init(void);
+
+static inline bool system_supports_poe(void)
+{
+	return false;
+}
+
+static inline bool vgic_host_has_gicv3(void)
+{
+	return false;
+}
+
+static inline bool vgic_host_has_gicv5(void)
+{
+	return false;
+}
+
+static inline bool has_broken_cntvoff(void)
+{
+	return false;
+}
+
 #endif /* ASM_KVM_HOST_ARM64_H */
diff --git a/arch/s390/kvm/arm64/Makefile b/arch/s390/kvm/arm64/Makefile
index 8c7110956573..e19040cdc27d 100644
--- a/arch/s390/kvm/arm64/Makefile
+++ b/arch/s390/kvm/arm64/Makefile
@@ -17,6 +17,8 @@ kvm-arm64-obj := \
 	mmu.o \
 	qaaf.o \
 	reset.o \
+	spectre.o \
+	sys_regs.o \
 
 kvm-arm64-obj += $(patsubst %.o,%-arm64.o,$(kvm-y))
 kvm-arm64-obj += $(patsubst %.o,%-arm64.o,$(gmap-y))
diff --git a/arch/s390/kvm/arm64/Makefile.gen b/arch/s390/kvm/arm64/Makefile.gen
index 6ac7602b57cb..99298dc49dcc 100644
--- a/arch/s390/kvm/arm64/Makefile.gen
+++ b/arch/s390/kvm/arm64/Makefile.gen
@@ -8,6 +8,7 @@ ARM64_CFILES := \
 	arm.c \
 	guest.c \
 	handle_exit.c \
+	sys_regs.c \
 	mmio.c \
 
 quiet_cmd_extract_inc = GEN     $@
diff --git a/arch/s390/kvm/arm64/spectre.c b/arch/s390/kvm/arm64/spectre.c
new file mode 100644
index 000000000000..dfe5b4be54d6
--- /dev/null
+++ b/arch/s390/kvm/arm64/spectre.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <arm64/spectre.h>
+
+enum mitigation_state arm64_get_spectre_v2_state(void)
+{
+	return SPECTRE_UNAFFECTED;
+}
+
+enum mitigation_state arm64_get_meltdown_state(void)
+{
+	return SPECTRE_UNAFFECTED;
+}
+
diff --git a/arch/s390/kvm/arm64/sys_regs.c b/arch/s390/kvm/arm64/sys_regs.c
new file mode 100644
index 000000000000..44ed8a203e93
--- /dev/null
+++ b/arch/s390/kvm/arm64/sys_regs.c
@@ -0,0 +1,750 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/kvm_host.h>
+#include <linux/printk.h>
+#include <linux/cpumask.h>
+
+#include <arm64/kvm_emulate.h>
+#include <arm64/sys_regs.h>
+#include <arm64/sysreg.h>
+#include <arm64/cputype.h>
+#include <arm64/cache.h>
+#include <arm64/kvm_nested.h>
+#include <arm64/spectre.h>
+#include <arm64/kvm_hyp.h>
+
+#include "feature.h"
+
+#include "trace.h"
+
+static int arm64_check_features(struct kvm_vcpu *vcpu,
+				const struct sys_reg_desc *rd, u64 val);
+static const struct sys_reg_desc sys_reg_descs[];
+static const size_t num_sys_reg_descs;
+static u64 __ro_after_init boot_cpu_midr_val;
+static u64 __ro_after_init boot_cpu_revidr_val;
+static u64 __ro_after_init boot_cpu_aidr_val;
+
+#define __INCL_GEN_ARM_FILE
+#include "generated/sys_regs.inc"
+#undef __INCL_GEN_ARM_FILE
+
+#define SR_INVALID 0x8badf00d8badf00d
+
+enum sr_loc_attr {
+	SR_LOC_SAVE_AREA,	/* Register on SA, loaded (on cpu) */
+	SR_LOC_SPECIAL,		/* Register in state description or Special care register*/
+	SR_LOC_INVALID,		/* Register is unknown */
+};
+
+struct sr_loc {
+	enum sr_loc_attr loc;
+};
+
+#define SREG_RANGE(NAME) __##NAME##_BEGIN__ + 1 ... __##NAME##_END__ - 1
+static __always_inline void locate_register(const struct kvm_vcpu *vcpu,
+					    enum vcpu_sysreg reg,
+					    struct sr_loc *loc)
+{
+	switch (reg) {
+	case SREG_RANGE(STATE_DESC):
+	case SREG_RANGE(SPECIAL):
+		loc->loc = SR_LOC_SPECIAL;
+		break;
+	case SREG_RANGE(SAVE_AREA):
+		loc->loc = SR_LOC_SAVE_AREA;
+		break;
+	default:
+		WARN(true, "%s wants to read invalid register %x", __func__, reg);
+		loc->loc = SR_LOC_INVALID;
+	}
+}
+
+static __always_inline u64 read_special_sr(const struct kvm_vcpu *vcpu,
+					   enum vcpu_sysreg reg)
+{
+	switch (reg) {
+	case CLIDR_EL1:		return vcpu->arch.sys_reg_clidr_el1;
+	case CSSELR_EL1:	return vcpu->arch.sys_reg_csselr_el1;
+	case MPIDR_EL1:		return vcpu->arch.mpidr;
+	case ELR_EL1:		return vcpu->arch.ctxt.elr_el1;
+	case SPSR_EL1:		return vcpu->arch.ctxt.spsr_el1;
+	case CNTP_CTL_EL0:	return vcpu->arch.sae_block.cntp_ctl;
+	case CNTV_CTL_EL0:	return vcpu->arch.sae_block.cntv_ctl;
+	case CONTEXTIDR_EL1:	return vcpu->arch.sae_block.contextidr_el1;
+	case SP_EL1:		return vcpu->arch.sae_block.sp_el1;
+	default:
+		WARN(true, "%s wants to read non-special register %x", __func__, reg);
+		return SR_INVALID;
+	}
+}
+
+static __always_inline u64 read_sr_from_vcpu(const struct kvm_vcpu *vcpu,
+					     enum vcpu_sysreg reg)
+{
+	switch (reg) {
+	case ACTLR_EL1:		return _vcpu_read_sys_reg(vcpu, SYS_ACTLR_EL1);
+	case AFSR0_EL1:		return _vcpu_read_sys_reg(vcpu, SYS_AFSR0_EL1);
+	case AFSR1_EL1:		return _vcpu_read_sys_reg(vcpu, SYS_AFSR1_EL1);
+	case CNTFRQ_EL0:	return _vcpu_read_sys_reg(vcpu, SYS_CNTFRQ_EL0);
+	case CNTP_CVAL_EL0:	return _vcpu_read_sys_reg(vcpu, SYS_CNTP_CVAL_EL0);
+	case CNTV_CVAL_EL0:	return _vcpu_read_sys_reg(vcpu, SYS_CNTV_CVAL_EL0);
+	case DISR_EL1:		return _vcpu_read_sys_reg(vcpu, SYS_DISR_EL1);
+	case MIDR_EL1:		return _vcpu_read_sys_reg(vcpu, SYS_MIDR_EL1);
+	case OSLSR_EL1:		return _vcpu_read_sys_reg(vcpu, SYS_OSLSR_EL1);
+	case PAR_EL1:		return _vcpu_read_sys_reg(vcpu, SYS_PAR_EL1);
+	case SCTLR_EL1:		return _vcpu_read_sys_reg(vcpu, SYS_SCTLR_EL1);
+	case CPACR_EL1:		return _vcpu_read_sys_reg(vcpu, SYS_CPACR_EL1);
+	case VBAR_EL1:		return _vcpu_read_sys_reg(vcpu, SYS_VBAR_EL1);
+	case ESR_EL1:		return _vcpu_read_sys_reg(vcpu, SYS_ESR_EL1);
+	case TCR_EL1:		return _vcpu_read_sys_reg(vcpu, SYS_TCR_EL1);
+	case MAIR_EL1:		return _vcpu_read_sys_reg(vcpu, SYS_MAIR_EL1);
+	case TTBR0_EL1:		return _vcpu_read_sys_reg(vcpu, SYS_TTBR0_EL1);
+	case TTBR1_EL1:		return _vcpu_read_sys_reg(vcpu, SYS_TTBR1_EL1);
+	case FAR_EL1:		return _vcpu_read_sys_reg(vcpu, SYS_FAR_EL1);
+	case TPIDR_EL0:		return _vcpu_read_sys_reg(vcpu, SYS_TPIDR_EL0);
+	case TPIDR_EL1:		return _vcpu_read_sys_reg(vcpu, SYS_TPIDR_EL1);
+	case TPIDRRO_EL0:	return _vcpu_read_sys_reg(vcpu, SYS_TPIDRRO_EL0);
+	case CNTKCTL_EL1:	return _vcpu_read_sys_reg(vcpu, SYS_CNTKCTL_EL1);
+	case ZCR_EL1:		return _vcpu_read_sys_reg(vcpu, SYS_ZCR_EL1);
+	case SCXTNUM_EL0:	return _vcpu_read_sys_reg(vcpu, SYS_SCXTNUM_EL0);
+	case SCXTNUM_EL1:	return _vcpu_read_sys_reg(vcpu, SYS_SCXTNUM_EL1);
+	case APIBKEYLO_EL1:	return _vcpu_read_sys_reg(vcpu, SYS_APIBKEYLO_EL1);
+	case APIBKEYHI_EL1:	return _vcpu_read_sys_reg(vcpu, SYS_APIBKEYHI_EL1);
+	case APIAKEYLO_EL1:	return _vcpu_read_sys_reg(vcpu, SYS_APIAKEYLO_EL1);
+	case APIAKEYHI_EL1:	return _vcpu_read_sys_reg(vcpu, SYS_APIAKEYHI_EL1);
+	case APGAKEYLO_EL1:	return _vcpu_read_sys_reg(vcpu, SYS_APGAKEYLO_EL1);
+	case APGAKEYHI_EL1:	return _vcpu_read_sys_reg(vcpu, SYS_APGAKEYHI_EL1);
+	case APDBKEYLO_EL1:	return _vcpu_read_sys_reg(vcpu, SYS_APDBKEYLO_EL1);
+	case APDBKEYHI_EL1:	return _vcpu_read_sys_reg(vcpu, SYS_APDBKEYHI_EL1);
+	case APDAKEYLO_EL1:	return _vcpu_read_sys_reg(vcpu, SYS_APDAKEYLO_EL1);
+	case APDAKEYHI_EL1:	return _vcpu_read_sys_reg(vcpu, SYS_APDAKEYHI_EL1);
+	case MDSCR_EL1:		return _vcpu_read_sys_reg(vcpu, SYS_MDSCR_EL1);
+	default:
+		WARN(true, "%s: failed to resolve %x", __func__,  reg);
+		return SR_INVALID;
+	}
+}
+
+u64 vcpu_read_sys_reg(const struct kvm_vcpu *vcpu, enum vcpu_sysreg reg)
+{
+	struct sr_loc loc = {};
+
+	locate_register(vcpu, reg, &loc);
+
+	if (unlikely(loc.loc == SR_LOC_INVALID)) {
+		WARN(true, "%s: failed to locate %u", __func__,  reg);
+		return SR_INVALID;
+	}
+
+	if (loc.loc == SR_LOC_SPECIAL)
+		return read_special_sr(vcpu, reg);
+
+	return read_sr_from_vcpu(vcpu, reg);
+}
+
+static __always_inline void write_special_sr(struct kvm_vcpu *vcpu, u64 val,
+					     enum vcpu_sysreg reg)
+{
+	switch (reg) {
+	case CLIDR_EL1:		vcpu->arch.sys_reg_clidr_el1 = val;		break;
+	case CSSELR_EL1:	vcpu->arch.sys_reg_csselr_el1 = val;		break;
+	case MPIDR_EL1:		vcpu->arch.mpidr = val;				break;
+	case CNTP_CTL_EL0:	vcpu->arch.sae_block.cntp_ctl = val;		break;
+	case CNTV_CTL_EL0:	vcpu->arch.sae_block.cntv_ctl = val;		break;
+	case CONTEXTIDR_EL1:	vcpu->arch.sae_block.contextidr_el1 = val;	break;
+	case SP_EL1:		vcpu->arch.sae_block.sp_el1 = val;		break;
+	case ELR_EL1:		vcpu->arch.ctxt.elr_el1 = val		;	break;
+	case SPSR_EL1:		vcpu->arch.ctxt.spsr_el1 = val;			break;
+	default:
+		WARN(true, "%s wants to write non-special register %x", __func__, reg);
+	}
+}
+
+static __always_inline void write_sr_to_vcpu(struct kvm_vcpu *vcpu, u64 val,
+					     enum vcpu_sysreg reg)
+{
+	switch (reg) {
+	case ACTLR_EL1:		_vcpu_write_sys_reg(vcpu, val, SYS_ACTLR_EL1);		break;
+	case AFSR0_EL1:		_vcpu_write_sys_reg(vcpu, val, SYS_AFSR0_EL1);		break;
+	case AFSR1_EL1:		_vcpu_write_sys_reg(vcpu, val, SYS_AFSR1_EL1);		break;
+	case CNTFRQ_EL0:	_vcpu_write_sys_reg(vcpu, val, SYS_CNTFRQ_EL0);		break;
+	case CNTP_CVAL_EL0:	_vcpu_write_sys_reg(vcpu, val, SYS_CNTP_CVAL_EL0);	break;
+	case CNTV_CVAL_EL0:	_vcpu_write_sys_reg(vcpu, val, SYS_CNTV_CVAL_EL0);	break;
+	case DISR_EL1:		_vcpu_write_sys_reg(vcpu, val, SYS_DISR_EL1);		break;
+	case MIDR_EL1:		_vcpu_write_sys_reg(vcpu, val, SYS_MIDR_EL1);		break;
+	case PAR_EL1:		_vcpu_write_sys_reg(vcpu, val, SYS_PAR_EL1);		break;
+	case OSLAR_EL1:		_vcpu_write_sys_reg(vcpu, val, SYS_OSLAR_EL1);		break;
+	case SCTLR_EL1:		_vcpu_write_sys_reg(vcpu, val, SYS_SCTLR_EL1);		break;
+	case CPACR_EL1:		_vcpu_write_sys_reg(vcpu, val, SYS_CPACR_EL1);		break;
+	case VBAR_EL1:		_vcpu_write_sys_reg(vcpu, val, SYS_VBAR_EL1);		break;
+	case ESR_EL1:		_vcpu_write_sys_reg(vcpu, val, SYS_ESR_EL1);		break;
+	case TCR_EL1:		_vcpu_write_sys_reg(vcpu, val, SYS_TCR_EL1);		break;
+	case MAIR_EL1:		_vcpu_write_sys_reg(vcpu, val, SYS_MAIR_EL1);		break;
+	case TTBR0_EL1:		_vcpu_write_sys_reg(vcpu, val, SYS_TTBR0_EL1);		break;
+	case TTBR1_EL1:		_vcpu_write_sys_reg(vcpu, val, SYS_TTBR1_EL1);		break;
+	case FAR_EL1:		_vcpu_write_sys_reg(vcpu, val, SYS_FAR_EL1);		break;
+	case TPIDR_EL0:		_vcpu_write_sys_reg(vcpu, val, SYS_TPIDR_EL0);		break;
+	case TPIDR_EL1:		_vcpu_write_sys_reg(vcpu, val, SYS_TPIDR_EL1);		break;
+	case TPIDRRO_EL0:	_vcpu_write_sys_reg(vcpu, val, SYS_TPIDRRO_EL0);	break;
+	case CNTKCTL_EL1:	_vcpu_write_sys_reg(vcpu, val, SYS_CNTKCTL_EL1);	break;
+	case ZCR_EL1:		_vcpu_write_sys_reg(vcpu, val, SYS_ZCR_EL1);		break;
+	case SCXTNUM_EL0:	_vcpu_write_sys_reg(vcpu, val, SYS_SCXTNUM_EL0);	break;
+	case SCXTNUM_EL1:	_vcpu_write_sys_reg(vcpu, val, SYS_SCXTNUM_EL1);	break;
+	case APIBKEYLO_EL1:	_vcpu_write_sys_reg(vcpu, val, SYS_APIBKEYLO_EL1);	break;
+	case APIBKEYHI_EL1:	_vcpu_write_sys_reg(vcpu, val, SYS_APIBKEYHI_EL1);	break;
+	case APIAKEYLO_EL1:	_vcpu_write_sys_reg(vcpu, val, SYS_APIAKEYLO_EL1);	break;
+	case APIAKEYHI_EL1:	_vcpu_write_sys_reg(vcpu, val, SYS_APIAKEYHI_EL1);	break;
+	case APGAKEYLO_EL1:	_vcpu_write_sys_reg(vcpu, val, SYS_APGAKEYLO_EL1);	break;
+	case APGAKEYHI_EL1:	_vcpu_write_sys_reg(vcpu, val, SYS_APGAKEYHI_EL1);	break;
+	case APDBKEYLO_EL1:	_vcpu_write_sys_reg(vcpu, val, SYS_APDBKEYLO_EL1);	break;
+	case APDBKEYHI_EL1:	_vcpu_write_sys_reg(vcpu, val, SYS_APDBKEYHI_EL1);	break;
+	case APDAKEYLO_EL1:	_vcpu_write_sys_reg(vcpu, val, SYS_APDAKEYLO_EL1);	break;
+	case APDAKEYHI_EL1:	_vcpu_write_sys_reg(vcpu, val, SYS_APDAKEYHI_EL1);	break;
+	case MDSCR_EL1:		_vcpu_write_sys_reg(vcpu, val, SYS_MDSCR_EL1);		break;
+	default:
+		WARN(true, "%s: failed to resolve %x", __func__,  reg);
+	}
+}
+
+void vcpu_write_sys_reg(struct kvm_vcpu *vcpu, u64 val, enum vcpu_sysreg reg)
+{
+	struct sr_loc loc = {};
+
+	locate_register(vcpu, reg, &loc);
+
+	if (unlikely(loc.loc == SR_LOC_INVALID)) {
+		WARN(true, "%s: failed to locate %u", __func__,  reg);
+		return;
+	}
+
+	if (loc.loc == SR_LOC_SPECIAL) {
+		write_special_sr(vcpu, val, reg);
+		return;
+	}
+
+	write_sr_to_vcpu(vcpu, val, reg);
+}
+
+u64 vcpu_read_host_sys_reg(const struct kvm_vcpu *vcpu, int reg)
+{
+	switch (reg) {
+	case SYS_ICH_LR0_EL2:	return vcpu->arch.sae_block.ic_regs.ich_lrn_el2[0];
+	case SYS_ICH_LR1_EL2:	return vcpu->arch.sae_block.ic_regs.ich_lrn_el2[1];
+	case SYS_ICH_LR2_EL2:	return vcpu->arch.sae_block.ic_regs.ich_lrn_el2[2];
+	case SYS_ICH_LR3_EL2:	return vcpu->arch.sae_block.ic_regs.ich_lrn_el2[3];
+	case SYS_ICH_HCR_EL2:	return vcpu->arch.sae_block.ic_regs.ich_hcr_el2;
+	case SYS_ICH_AP0R0_EL2:	return vcpu->arch.sae_block.ic_regs.ich_ap0r0_el2;
+	case SYS_ICH_AP1R0_EL2:	return vcpu->arch.sae_block.ic_regs.ich_ap1r0_el2;
+	case SYS_ICH_VMCR_EL2:	return vcpu->arch.sae_block.ic_regs.ich_vmcr_el2;
+	case SYS_VSESR_EL2:	return _vcpu_read_sys_reg(vcpu, SYS_VSESR_EL2);
+	case SYS_HCR_EL2:	return _vcpu_read_sys_reg(vcpu, SYS_HCR_EL2);
+	case SYS_CPTR_EL2:	return _vcpu_read_sys_reg(vcpu, SYS_CPTR_EL2);
+	case SYS_MDCR_EL2:	return _vcpu_read_sys_reg(vcpu, SYS_MDCR_EL2);
+	case SYS_HCRX_EL2:	return _vcpu_read_sys_reg(vcpu, SYS_HCRX_EL2);
+	case SYS_HFGRTR_EL2:	return _vcpu_read_sys_reg(vcpu, SYS_HFGRTR_EL2);
+	case SYS_HFGWTR_EL2:	return _vcpu_read_sys_reg(vcpu, SYS_HFGWTR_EL2);
+	case SYS_HDFGWTR_EL2:	return _vcpu_read_sys_reg(vcpu, SYS_HDFGWTR_EL2);
+	case SYS_HDFGRTR_EL2:	return _vcpu_read_sys_reg(vcpu, SYS_HDFGRTR_EL2);
+	case SYS_HFGITR_EL2:	return _vcpu_read_sys_reg(vcpu, SYS_HFGITR_EL2);
+	case SYS_CNTHCTL_EL2:	return _vcpu_read_sys_reg(vcpu, SYS_CNTHCTL_EL2);
+	case SYS_ICC_SRE_EL2:	return _vcpu_read_sys_reg(vcpu, SYS_ICC_SRE_EL2);
+	case SYS_VMPIDR_EL2:	return _vcpu_read_sys_reg(vcpu, SYS_VMPIDR_EL2);
+	default:
+		WARN(true, "%s wants to read non-host register %x", __func__, reg);
+		return SR_INVALID;
+	}
+}
+
+void vcpu_write_host_sys_reg(struct kvm_vcpu *vcpu, u64 val, int reg)
+{
+	switch (reg) {
+	case SYS_ICH_LR0_EL2:	vcpu->arch.sae_block.ic_regs.ich_lrn_el2[0] = val;	break;
+	case SYS_ICH_LR1_EL2:	vcpu->arch.sae_block.ic_regs.ich_lrn_el2[1] = val;	break;
+	case SYS_ICH_LR2_EL2:	vcpu->arch.sae_block.ic_regs.ich_lrn_el2[2] = val;	break;
+	case SYS_ICH_LR3_EL2:	vcpu->arch.sae_block.ic_regs.ich_lrn_el2[3] = val;	break;
+	case SYS_ICH_HCR_EL2:	vcpu->arch.sae_block.ic_regs.ich_hcr_el2 = val;		break;
+	case SYS_ICH_AP0R0_EL2:	vcpu->arch.sae_block.ic_regs.ich_ap0r0_el2 = val;	break;
+	case SYS_ICH_AP1R0_EL2:	vcpu->arch.sae_block.ic_regs.ich_ap1r0_el2 = val;	break;
+	case SYS_ICH_VMCR_EL2:	vcpu->arch.sae_block.ic_regs.ich_vmcr_el2 = val;	break;
+	case SYS_VSESR_EL2:	_vcpu_write_sys_reg(vcpu, val, SYS_VSESR_EL2);		break;
+	case SYS_HCR_EL2:	_vcpu_write_sys_reg(vcpu, val, SYS_HCR_EL2);		break;
+	case SYS_CPTR_EL2:	_vcpu_write_sys_reg(vcpu, val, SYS_CPTR_EL2);		break;
+	case SYS_MDCR_EL2:	_vcpu_write_sys_reg(vcpu, val, SYS_MDCR_EL2);		break;
+	case SYS_HCRX_EL2:	_vcpu_write_sys_reg(vcpu, val, SYS_HCRX_EL2);		break;
+	case SYS_HFGRTR_EL2:	_vcpu_write_sys_reg(vcpu, val, SYS_HFGRTR_EL2);		break;
+	case SYS_HFGWTR_EL2:	_vcpu_write_sys_reg(vcpu, val, SYS_HFGWTR_EL2);		break;
+	case SYS_HDFGWTR_EL2:	_vcpu_write_sys_reg(vcpu, val, SYS_HDFGWTR_EL2);	break;
+	case SYS_HDFGRTR_EL2:	_vcpu_write_sys_reg(vcpu, val, SYS_HDFGRTR_EL2);	break;
+	case SYS_HFGITR_EL2:	_vcpu_write_sys_reg(vcpu, val, SYS_HFGITR_EL2);		break;
+	case SYS_CNTHCTL_EL2:	_vcpu_write_sys_reg(vcpu, val, SYS_CNTHCTL_EL2);	break;
+	case SYS_ICC_SRE_EL2:	_vcpu_write_sys_reg(vcpu, val, SYS_ICC_SRE_EL2);	break;
+	case SYS_VMPIDR_EL2:	_vcpu_write_sys_reg(vcpu, val, SYS_VMPIDR_EL2);		break;
+	default:
+		WARN(true, "%s wants to write non-host register %x", __func__, reg);
+	}
+}
+
+static int arm64_check_features(struct kvm_vcpu *vcpu,
+				const struct sys_reg_desc *rd, u64 val)
+{
+	u32 id = reg_to_encoding(rd);
+	u64 host_val;
+	u64 old_val;
+
+	/*
+	 * This is a very minimal implementation to sanitise only the craziest
+	 * shenanigans we could get from userspace. The final goal is to share
+	 * the sanitisation with arm as well but this needs access to arm
+	 * (core) kernel code for which there is no suitable solution yet. TODO
+	 */
+
+	/*
+	 * If the register is RAZ we know the only safe value is 0.
+	 */
+	if (sysreg_visible_as_raz(vcpu, rd))
+		return val ? -E2BIG : 0;
+
+	host_val = read_sanitised_ftr_reg(id);
+
+	switch (id) {
+	case SYS_ID_AA64MMFR0_EL1:
+		/* Forbid PRANGE values larger than the host supports*/
+		if (SYS_FIELD_GET(ID_AA64MMFR0_EL1, PARANGE, val) >
+		    SYS_FIELD_GET(ID_AA64MMFR0_EL1, PARANGE, host_val))
+			return -E2BIG;
+		break;
+	case SYS_CTR_EL0:
+		/* forbid upgrading from VIPT to PIPT */
+		old_val = read_id_reg(vcpu, rd);
+		if (SYS_FIELD_GET(CTR_EL0, L1Ip, old_val) == CTR_EL0_L1Ip_VIPT &&
+		    SYS_FIELD_GET(CTR_EL0, L1Ip, val) == CTR_EL0_L1Ip_PIPT)
+			return -E2BIG;
+		break;
+	}
+	return 0;
+}
+
+static void init_imp_id_regs(void)
+{
+	boot_cpu_midr_val = read_sanitised_ftr_reg(SYS_MIDR_EL1);
+	boot_cpu_revidr_val = read_sanitised_ftr_reg(SYS_REVIDR_EL1);
+	boot_cpu_aidr_val = read_sanitised_ftr_reg(SYS_AIDR_EL1);
+}
+
+static bool access_imp_id_reg(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
+			      const struct sys_reg_desc *r)
+{
+	if (p->is_write)
+		return write_to_read_only(vcpu, p, r);
+
+	/*
+	 * Return the VM-scoped implementation ID register values if userspace
+	 * has made them writable.
+	 */
+	if (test_bit(KVM_ARCH_FLAG_WRITABLE_IMP_ID_REGS, &vcpu->kvm->arch.flags))
+		return access_id_reg(vcpu, p, r);
+
+	switch (reg_to_encoding(r)) {
+	case SYS_REVIDR_EL1:
+		p->regval = boot_cpu_revidr_val; //no old api to conform to?
+		break;
+	case SYS_AIDR_EL1:
+		p->regval = boot_cpu_aidr_val;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+	}
+
+	return true;
+}
+
+static int get_mpidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd, u64 *val)
+{
+	*val = vcpu->arch.mpidr;
+	return 0;
+}
+
+static int set_mpidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd, u64 val)
+{
+	vcpu->arch.mpidr = val;
+	return 0;
+}
+
+static u64 reset_midr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
+{
+	_vcpu_write_sys_reg(vcpu, boot_cpu_midr_val, SYS_MIDR_EL1);
+	return boot_cpu_midr_val;
+}
+
+static int set_oslsr_el1(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
+			 u64 val)
+{
+	u64 oslk;
+
+	/*
+	 * The only modifiable bit is the OSLK bit. Refuse the write if
+	 * userspace attempts to change any other bit in the register.
+	 */
+	if ((val ^ rd->val) & ~OSLSR_EL1_OSLK)
+		return -EINVAL;
+
+	/*
+	 * Redirect the write to the proper control register.
+	 * OSLSR is read-only
+	 */
+	oslk = SYS_FIELD_GET(OSLSR_EL1, OSLK, val);
+	__vcpu_assign_sys_reg(vcpu, OSLAR_EL1, SYS_FIELD_PREP(OSLAR_EL1, OSLK, oslk));
+	return 0;
+}
+
+static u64 reset_oslsr_el1(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
+{
+	u64 oslsr = r->val;
+
+	set_oslsr_el1(vcpu, r, oslsr);
+	return oslsr;
+}
+
+static int arch_timer_set_user(struct kvm_vcpu *vcpu,
+			       const struct sys_reg_desc *rd,
+			       u64 val)
+{
+	switch (reg_to_encoding(rd)) {
+	case SYS_CNTVCT_EL0:
+		vcpu->arch.sae_block.gpto = ptff_qagto(val);
+		return 0;
+	case SYS_CNTPCT_EL0:
+		return 0;
+	}
+
+	__vcpu_assign_sys_reg(vcpu, rd->reg, val);
+	return 0;
+}
+
+static int arch_timer_get_user(struct kvm_vcpu *vcpu,
+			       const struct sys_reg_desc *rd,
+			       u64 *val)
+{
+	switch (reg_to_encoding(rd)) {
+	case SYS_CNTVCT_EL0:
+		*val = ptff_qagpt(vcpu->arch.sae_block.gpto);
+		break;
+	case SYS_CNTPCT_EL0:
+		*val = ptff_qagpt(vcpu->arch.sae_block.gpto);
+		break;
+	default:
+		*val = __vcpu_sys_reg(vcpu, rd->reg);
+	}
+
+	return 0;
+}
+
+#define TIMER_REG(name) { \
+	SYS_DESC(SYS_##name),			\
+	.reset = reset_val,			\
+	.reg = name,				\
+	.get_user = arch_timer_get_user,	\
+	.set_user = arch_timer_set_user,	\
+}
+
+/*
+ * Architected system registers.
+ * Important: Must be sorted ascending by Op0, Op1, CRn, CRm, Op2
+ */
+static const struct sys_reg_desc sys_reg_descs[] = {
+	/* Op0 = 2 */
+	{ SYS_DESC(SYS_OSLAR_EL1), trap_oslar_el1 },
+	{ SYS_DESC(SYS_OSLSR_EL1), trap_oslsr_el1, reset_oslsr_el1, OSLSR_EL1,
+	  OSLSR_EL1_OSLM_IMPLEMENTED, NULL, set_oslsr_el1 },
+
+	/* Op0 = 3 */
+	/* Op1 = 0 */
+	/* CRn = 0 */
+	/* CRm = 0 */
+
+	{ SYS_DESC(SYS_MIDR_EL1), NULL, reset_midr, 0, GENMASK_ULL(31, 0),
+	  get_id_reg, set_imp_id_reg },
+	{ SYS_DESC(SYS_MPIDR_EL1), NULL, reset_mpidr, MPIDR_EL1, 0, get_mpidr,
+	  set_mpidr },
+	IMPLEMENTATION_ID(REVIDR_EL1, GENMASK_ULL(63, 0)),
+
+	/*
+	 * ID regs: all ID_SANITISED() entries here must have corresponding
+	 * entries in arm64_ftr_regs[].
+	 */
+
+	/* AArch64 mappings of the AArch32 ID registers */
+	/* CRm=1 */
+	ID_HIDDEN(ID_PFR0_EL1),
+	ID_HIDDEN(ID_PFR1_EL1),
+	ID_HIDDEN(ID_DFR0_EL1),
+	ID_HIDDEN(ID_AFR0_EL1),
+	ID_HIDDEN(ID_MMFR0_EL1),
+	ID_HIDDEN(ID_MMFR1_EL1),
+	ID_HIDDEN(ID_MMFR2_EL1),
+	ID_HIDDEN(ID_MMFR3_EL1),
+
+	/* CRm=2 */
+	ID_HIDDEN(ID_ISAR0_EL1),
+	ID_HIDDEN(ID_ISAR1_EL1),
+	ID_HIDDEN(ID_ISAR2_EL1),
+	ID_HIDDEN(ID_ISAR3_EL1),
+	ID_HIDDEN(ID_ISAR4_EL1),
+	ID_HIDDEN(ID_ISAR5_EL1),
+	ID_HIDDEN(ID_MMFR4_EL1),
+	ID_HIDDEN(ID_ISAR6_EL1),
+
+	/* CRm=3 */
+	ID_HIDDEN(MVFR0_EL1),
+	ID_HIDDEN(MVFR1_EL1),
+	ID_HIDDEN(MVFR2_EL1),
+	ID_UNALLOCATED(3, 3),
+	ID_HIDDEN(ID_PFR2_EL1),
+	ID_HIDDEN(ID_DFR1_EL1),
+	ID_HIDDEN(ID_MMFR5_EL1),
+	ID_UNALLOCATED(3, 7),
+
+	/* AArch64 ID registers */
+	/* CRm=4 */
+	ID_FILTERED(ID_AA64PFR0_EL1, id_aa64pfr0_el1,
+		    ~(ID_AA64PFR0_EL1_AMU | ID_AA64PFR0_EL1_MPAM |
+		      ID_AA64PFR0_EL1_SVE | ID_AA64PFR0_EL1_RAS |
+		      ID_AA64PFR0_EL1_GIC | ID_AA64PFR0_EL1_AdvSIMD |
+		      ID_AA64PFR0_EL1_FP)),
+	ID_FILTERED(ID_AA64PFR1_EL1, id_aa64pfr1_el1,
+		    ~(ID_AA64PFR1_EL1_PFAR | ID_AA64PFR1_EL1_DF2 |
+		      ID_AA64PFR1_EL1_MTEX | ID_AA64PFR1_EL1_THE |
+		      ID_AA64PFR1_EL1_GCS | ID_AA64PFR1_EL1_MTE_frac |
+		      ID_AA64PFR1_EL1_NMI | ID_AA64PFR1_EL1_RNDR_trap |
+		      ID_AA64PFR1_EL1_SME | ID_AA64PFR1_EL1_RES0 |
+		      ID_AA64PFR1_EL1_MPAM_frac | ID_AA64PFR1_EL1_RAS_frac |
+		      ID_AA64PFR1_EL1_MTE)),
+	ID_FILTERED(ID_AA64PFR2_EL1, id_aa64pfr2_el1,
+		    (ID_AA64PFR2_EL1_FPMR		|
+		     ID_AA64PFR2_EL1_MTEFAR		|
+		     ID_AA64PFR2_EL1_MTESTOREONLY	|
+		     ID_AA64PFR2_EL1_GCIE)),
+	ID_UNALLOCATED(4, 3),
+	ID_WRITABLE(ID_AA64ZFR0_EL1, ~ID_AA64ZFR0_EL1_RES0),
+	ID_HIDDEN(ID_AA64SMFR0_EL1),
+	ID_UNALLOCATED(4, 6),
+	ID_WRITABLE(ID_AA64FPFR0_EL1, ~ID_AA64FPFR0_EL1_RES0),
+
+	/* CRm=5 */
+	/*
+	 * Prior to FEAT_Debugv8.9, the architecture defines context-aware
+	 * breakpoints (CTX_CMPs) as the highest numbered breakpoints (BRPs).
+	 * KVM does not trap + emulate the breakpoint registers, and as such
+	 * cannot support a layout that misaligns with the underlying hardware.
+	 * While it may be possible to describe a subset that aligns with
+	 * hardware, just prevent changes to BRPs and CTX_CMPs altogether for
+	 * simplicity.
+	 *
+	 * See DDI0487K.a, section D2.8.3 Breakpoint types and linking
+	 * of breakpoints for more details.
+	 */
+	ID_FILTERED(ID_AA64DFR0_EL1, id_aa64dfr0_el1,
+		    ID_AA64DFR0_EL1_DoubleLock_MASK |
+			    ID_AA64DFR0_EL1_WRPs_MASK |
+			    ID_AA64DFR0_EL1_PMUVer_MASK |
+			    ID_AA64DFR0_EL1_DebugVer_MASK),
+	ID_SANITISED(ID_AA64DFR1_EL1),
+	ID_UNALLOCATED(5, 2),
+	ID_UNALLOCATED(5, 3),
+	ID_HIDDEN(ID_AA64AFR0_EL1),
+	ID_HIDDEN(ID_AA64AFR1_EL1),
+	ID_UNALLOCATED(5, 6),
+	ID_UNALLOCATED(5, 7),
+
+	/* CRm=6 */
+	ID_WRITABLE(ID_AA64ISAR0_EL1, ~ID_AA64ISAR0_EL1_RES0),
+	ID_WRITABLE(ID_AA64ISAR1_EL1,
+		    ~(ID_AA64ISAR1_EL1_GPI | ID_AA64ISAR1_EL1_GPA |
+		      ID_AA64ISAR1_EL1_API | ID_AA64ISAR1_EL1_APA)),
+	ID_WRITABLE(ID_AA64ISAR2_EL1,
+		    ~(ID_AA64ISAR2_EL1_RES0 | ID_AA64ISAR2_EL1_APA3 |
+		      ID_AA64ISAR2_EL1_GPA3)),
+	ID_WRITABLE(ID_AA64ISAR3_EL1,
+		    (ID_AA64ISAR3_EL1_FPRCVT | ID_AA64ISAR3_EL1_FAMINMAX)),
+	ID_UNALLOCATED(6, 4),
+	ID_UNALLOCATED(6, 5),
+	ID_UNALLOCATED(6, 6),
+	ID_UNALLOCATED(6, 7),
+
+	/* CRm=7 */
+	ID_FILTERED(ID_AA64MMFR0_EL1, id_aa64mmfr0_el1,
+		    ~(ID_AA64MMFR0_EL1_RES0 | ID_AA64MMFR0_EL1_ASIDBITS)),
+	ID_WRITABLE(ID_AA64MMFR1_EL1,
+		    ~(ID_AA64MMFR1_EL1_RES0 | ID_AA64MMFR1_EL1_HCX |
+		      ID_AA64MMFR1_EL1_TWED | ID_AA64MMFR1_EL1_XNX |
+		      ID_AA64MMFR1_EL1_VH | ID_AA64MMFR1_EL1_VMIDBits)),
+	ID_FILTERED(ID_AA64MMFR2_EL1, id_aa64mmfr2_el1,
+		    ~(ID_AA64MMFR2_EL1_RES0 | ID_AA64MMFR2_EL1_EVT |
+		      ID_AA64MMFR2_EL1_FWB | ID_AA64MMFR2_EL1_IDS |
+		      ID_AA64MMFR2_EL1_NV | ID_AA64MMFR2_EL1_CCIDX)),
+	ID_WRITABLE(ID_AA64MMFR3_EL1,
+		    (ID_AA64MMFR3_EL1_TCRX | ID_AA64MMFR3_EL1_S1PIE |
+		     ID_AA64MMFR3_EL1_S1POE)),
+	ID_WRITABLE(ID_AA64MMFR4_EL1, ID_AA64MMFR4_EL1_NV_frac),
+	ID_UNALLOCATED(7, 5),
+	ID_UNALLOCATED(7, 6),
+	ID_UNALLOCATED(7, 7),
+
+	/* CRn = 1 */
+	{ SYS_DESC(SYS_SCTLR_EL1), NULL, reset_val, SCTLR_EL1, 0x00C50078 },
+	{ SYS_DESC(SYS_CPACR_EL1), NULL, reset_val, CPACR_EL1, 0 },
+
+	/* CRn = 2 */
+	{ SYS_DESC(SYS_TTBR0_EL1), access_rw, reset_val, TTBR0_EL1, 0 },
+	{ SYS_DESC(SYS_TTBR1_EL1), access_rw, reset_val, TTBR1_EL1, 0 },
+	{ SYS_DESC(SYS_TCR_EL1), access_rw, reset_val, TCR_EL1, 0 },
+
+	{ SYS_DESC(SYS_PMMIR_EL1), trap_raz_wi },
+	/* CRn = 10 */
+	{ SYS_DESC(SYS_MAIR_EL1), NULL, reset_unknown, MAIR_EL1 },
+	{ SYS_DESC(SYS_LORSA_EL1), trap_loregion },
+	{ SYS_DESC(SYS_LOREA_EL1), trap_loregion },
+	{ SYS_DESC(SYS_LORN_EL1), trap_loregion },
+	{ SYS_DESC(SYS_LORC_EL1), trap_loregion },
+	{ SYS_DESC(SYS_LORID_EL1), trap_loregion },
+
+	/* CRn = 12 */
+	{ SYS_DESC(SYS_VBAR_EL1), access_rw, reset_val, VBAR_EL1, 0 },
+
+	/* CRn = 13 */
+	{ SYS_DESC(SYS_TPIDR_EL1), NULL, reset_unknown, TPIDR_EL1 },
+
+	/* Op1 = 1 */
+	/* CRn = 0 */
+	/* CRm = 0 */
+	{ SYS_DESC(SYS_CCSIDR_EL1), access_ccsidr },
+	{ SYS_DESC(SYS_CLIDR_EL1), access_clidr, reset_clidr, CLIDR_EL1,
+	  ~CLIDR_EL1_RES0, .set_user = set_clidr },
+	IMPLEMENTATION_ID(AIDR_EL1, GENMASK_ULL(63, 0)),
+	{ SYS_DESC(SYS_CSSELR_EL1), access_csselr, reset_unknown, CSSELR_EL1 },
+	ID_FILTERED(CTR_EL0, ctr_el0,
+		    CTR_EL0_DIC_MASK | CTR_EL0_IDC_MASK |
+			    CTR_EL0_DminLine_MASK | CTR_EL0_L1Ip_MASK |
+			    CTR_EL0_IminLine_MASK),
+
+	{ SYS_DESC(SYS_CNTFRQ_EL0), NULL, reset_val, CNTFRQ_EL0, 0x3B9ACA00 },
+	{ SYS_DESC(SYS_CNTPCT_EL0), .get_user = arch_timer_get_user,
+	  .set_user = arch_timer_set_user },
+	{ SYS_DESC(SYS_CNTVCT_EL0), .get_user = arch_timer_get_user,
+	  .set_user = arch_timer_set_user },
+	TIMER_REG(CNTP_CTL_EL0),
+	TIMER_REG(CNTP_CVAL_EL0),
+	TIMER_REG(CNTV_CTL_EL0),
+	TIMER_REG(CNTV_CVAL_EL0),
+};
+
+static const size_t  num_sys_reg_descs = ARRAY_SIZE(sys_reg_descs);
+
+/**
+ * kvm_reset_sys_regs - sets system registers to reset value
+ * @vcpu: The VCPU pointer
+ *
+ * This function finds the right table above and sets the registers on the
+ * virtual CPU struct to their architecturally defined reset values.
+ */
+void kvm_reset_sys_regs(struct kvm_vcpu *vcpu)
+{
+	struct kvm *kvm = vcpu->kvm;
+	unsigned long i;
+
+	for (i = 0; i < num_sys_reg_descs; i++) {
+		const struct sys_reg_desc *r = &sys_reg_descs[i];
+
+		if (!r->reset)
+			continue;
+
+		if (is_vm_ftr_id_reg(reg_to_encoding(r))) {
+			reset_vm_ftr_id_reg(vcpu, r);
+			/*
+			 * ID registers are stored per VCPU as well and need a
+			 * meaningful reset value. Reset the VCPU regas well.
+			 */
+			if (!kvm_vcpu_initialized(vcpu))
+				r->reset(vcpu, r);
+		} else if (is_vcpu_ftr_id_reg(reg_to_encoding(r))) {
+			reset_vcpu_ftr_id_reg(vcpu, r);
+		} else {
+			r->reset(vcpu, r);
+		}
+	}
+
+	set_bit(KVM_ARCH_FLAG_ID_REGS_INITIALIZED, &kvm->arch.flags);
+
+	if (kvm_vcpu_has_pmu(vcpu))
+		kvm_make_request(KVM_REQ_RELOAD_PMU, vcpu);
+}
+
+/*
+ * kvm_handle_sys_reg -- handles a system instruction or mrs/msr instruction
+ *			 trap on a guest execution
+ * @vcpu: The VCPU pointer
+ */
+int kvm_handle_sys_reg(struct kvm_vcpu *vcpu)
+{
+	const struct sys_reg_desc *desc = NULL;
+	struct sys_reg_params params;
+	unsigned long esr = kvm_vcpu_get_esr(vcpu);
+	int Rt = kvm_vcpu_sys_get_rt(vcpu);
+
+	trace_kvm_handle_sys_reg(esr);
+
+	params = esr_sys64_to_params(esr);
+	params.regval = vcpu_get_reg(vcpu, Rt);
+
+	/* System registers have Op0=={2,3}, as per DDI487 J.a C5.1.2 */
+	if (params.Op0 == 2 || params.Op0 == 3)
+		desc = find_reg(&params, sys_reg_descs, num_sys_reg_descs);
+	else
+		WARN(true, "system instruction handling not supported");
+
+	if (!desc) {
+		if (!(params.Op0 == 3 && (params.CRn & 0b1011) == 0b1011))
+			print_sys_reg_msg(&params,
+					  "Unsupported guest access at: %lx\n",
+					  *vcpu_pc(vcpu));
+		kvm_inject_undefined(vcpu);
+		return 1;
+	} else {
+		perform_access(vcpu, &params, desc);
+	}
+
+	/* Read from system register? */
+	if (!params.is_write &&
+	    (params.Op0 == 2 || params.Op0 == 3))
+		vcpu_set_reg(vcpu, Rt, params.regval);
+
+	return 1;
+}
+
+int __init kvm_sys_reg_table_init(void)
+{
+	init_imp_id_regs();
+
+	bool valid =
+		check_sysreg_table(sys_reg_descs, num_sys_reg_descs, false);
+
+	if (!valid)
+		return -EINVAL;
+
+	return 0;
+}
+
+/*
+ * Perform last adjustments to the ID registers that are implied by the
+ * configuration outside of the ID regs themselves, as well as any
+ * initialisation that directly depend on these ID registers (such as
+ * RES0/RES1 behaviours). This is not the place to configure traps though.
+ *
+ * Because this can be called once per CPU, changes must be idempotent.
+ */
+int kvm_finalize_sys_regs(struct kvm_vcpu *vcpu)
+{
+	return 0;
+}
+
diff --git a/arch/s390/kvm/arm64/trace.h b/arch/s390/kvm/arm64/trace.h
index 2a205ba0165c..77d146e3d6a5 100644
--- a/arch/s390/kvm/arm64/trace.h
+++ b/arch/s390/kvm/arm64/trace.h
@@ -4,6 +4,8 @@
 
 #include <linux/tracepoint.h>
 
+#include <arm64/sys_regs.h>
+
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM kvm_arm64
 
@@ -31,6 +33,55 @@ TRACE_EVENT(kvm_mmio_nisv,
 		  __entry->far, __entry->vcpu_pc)
 );
 
+TRACE_EVENT(kvm_handle_sys_reg,
+	TP_PROTO(unsigned long hsr),
+	TP_ARGS(hsr),
+
+	TP_STRUCT__entry(
+		__field(unsigned long,	hsr)
+	),
+
+	TP_fast_assign(
+		__entry->hsr = hsr;
+	),
+
+	TP_printk("HSR 0x%08lx", __entry->hsr)
+);
+
+TRACE_EVENT(kvm_sys_access,
+	TP_PROTO(unsigned long vcpu_pc, struct sys_reg_params *params, const struct sys_reg_desc *reg),
+	TP_ARGS(vcpu_pc, params, reg),
+
+	TP_STRUCT__entry(
+		__field(unsigned long,			vcpu_pc)
+		__field(bool,				is_write)
+		__field(const char *,			name)
+		__field(u8,				Op0)
+		__field(u8,				Op1)
+		__field(u8,				CRn)
+		__field(u8,				CRm)
+		__field(u8,				Op2)
+	),
+
+	TP_fast_assign(
+		__entry->vcpu_pc = vcpu_pc;
+		__entry->is_write = params->is_write;
+		__entry->name = reg->name;
+		__entry->Op0 = reg->Op0;
+		__entry->Op0 = reg->Op0;
+		__entry->Op1 = reg->Op1;
+		__entry->CRn = reg->CRn;
+		__entry->CRm = reg->CRm;
+		__entry->Op2 = reg->Op2;
+	),
+
+	TP_printk("PC: %lx %s (%d,%d,%d,%d,%d) %s",
+		  __entry->vcpu_pc, __entry->name ?: "UNKN",
+		  __entry->Op0, __entry->Op1, __entry->CRn,
+		  __entry->CRm, __entry->Op2,
+		  str_write_read(__entry->is_write))
+);
+
 #endif /* KVM_ARM64_TRACE_KVM_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/arch/s390/tools/Makefile.arm64h b/arch/s390/tools/Makefile.arm64h
index 49f344636e83..28103cdc243c 100644
--- a/arch/s390/tools/Makefile.arm64h
+++ b/arch/s390/tools/Makefile.arm64h
@@ -17,12 +17,16 @@ arm64uapi := $(objtree)/arch/$(ARCH)/include/generated/uapi/arm64
 # If the file does not contain any markers the whole file will be copied.
 ARM64_SHARED_HEADERS := \
 	brk-imm.h \
+	cache.h \
+	cputype.h \
 	esr.h \
 	kvm_arm.h \
 	kvm_emulate-gen.h \
 	kvm_host.h \
 	ptrace-gen.h \
 	sysreg-gen.h \
+	spectre.h \
+	kvm:sys_regs-gen.h \
 	uapi:hwcap.h \
 	uapi:kvm.h \
 	uapi:ptrace.h \
-- 
2.53.0

