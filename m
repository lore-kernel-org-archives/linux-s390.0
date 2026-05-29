Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C0A3ED122;
	Fri, 29 May 2026 15:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780070237; cv=none; b=TZz/anjLrxhsnaHagvKsls6tavD5ul93sbWBWwGCk+w2JjgYhZs0FJoZNadcyQ6Ro/vQzQU0qGTkZUvB248bG3d30nWGXIbiN+tukZs2IVnogFUDGKQfe9SkFWM8xu1Iy7qnWqcmgWaLcwaMrR3uuxRAq1/J2QNQD9fzmj8ei2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780070237; c=relaxed/simple;
	bh=cyXILq1LLFkDFrc0kGqmBLvqFD/iCpmLI91ZjU6FB1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n90IDvHjZ6d3gWu6D3rRLHxCvEmLFF2iOJ/HLQaUzafmxr2jay/g4n/0YW3qfShK1GYxn0x9bkF7qfbK8eczkyj9pKn3Ixb4VDCZGKzbhrWLn0no35dullb/rB3D5/mhqDfZ5u5QhFrW6pBS/Z5Wv7pktKwyvbhsN7ELKw5YDOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fx6amajS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fx6amajS"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TFA3JN3216069;
	Fri, 29 May 2026 15:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=TL40fMZy2fWepaNwM
	1qtWRxV/Tf0P7eTV3P3XEqPeUQ=; b=fx6amajSEZG9eQadH97mpWNb+sWSQ3Lfg
	uluSuUIV08qYYkdKCgWrn+uN8ZTpk1FxXVguQ3axWtk7/HSQQ8UyF3rAXLrMUNPR
	Sl5+xx9/hkt+ZHkzmCl2U8vYrf7+ySyQPcxsZPQ1zIMTYuwDLdhB8JLhGJOvC+Fl
	H7Fsexuico2Z2VRb3YyFbwaGBvG6wjEG/GETD0i/1ZcTxXDMf98k40DXGb2I4a5P
	enpvuHKEC+CcjixS2CDC9ev6PGEgjPg6SX5ZyRY9+YovkX4F5Js2xf56PG+YRK9y
	40zI6jET3g9Vdh+dUkcZGt/boP2QPEXo1WiQM+nUrXdq2jLJl11sw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee88bm2p7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:56:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TFs7xi027794;
	Fri, 29 May 2026 15:56:18 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrc8jp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:56:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TFuAg649414436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 15:56:10 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A17C20040;
	Fri, 29 May 2026 15:56:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D528720043;
	Fri, 29 May 2026 15:56:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 15:56:09 +0000 (GMT)
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
Subject: [PATCH v1 21/26] KVM: arm64: Share sys-reg handling
Date: Fri, 29 May 2026 17:55:54 +0200
Message-ID: <20260529155601.2927240-22-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529155601.2927240-1-seiden@linux.ibm.com>
References: <20260529155601.2927240-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE1NiBTYWx0ZWRfX8jUTfgrFCSjx
 mqFKqkU+Nf83KKfu3qKOCO3c4sFy1aaOX2FaK1wgpJTrpXi5hlCUqCzLjVmDDoyhtwmD1CTWiDJ
 435ksW1Cud3WMQsdd6W6BnWVuvq1sGLA9NRtthCGithA+6VJ0X4rk2N59jiWrG5yvFDscOF3cX0
 TYdZESjCCHsHMsj+jtgCa+jm2uNXTFZqJWzvp9tmTEdymp8nNMZgVmScb6wL4F0LSTG5dJS7oOC
 uKWWSJnV8wOs8qwD9niyRVqQAOeJ4GErD436nI9V/045fyQXfcEvr3e+V65/0xB7/GyIm0OVnwo
 SExO5LVuAk32/0/0+jkn9NJmt3NjdgxVl5zKYe4MmvgM7e4Jdc6a8Lrq9NQDZr/tRzJ8r3/uBLa
 W6bUM9uCqhzmHRvNSgYGFXSAp5lBrhx6jpSC/LFZbgzchnl6gN8MdY9d6hVz45rlEgFUAfgjLVL
 Q3m0KHij8Ge9r3CXhcA==
X-Proofpoint-ORIG-GUID: LU_bZm0FbEwXxFgJ45qb8q_a_dsHJj1J
X-Authority-Analysis: v=2.4 cv=IJEyzAvG c=1 sm=1 tr=0 ts=6a19b722 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=7CQSdrXTAAAA:8 a=UQM1QJzDAAAA:8
 a=1dDqwGSCEFCIWNWQU7AA:9 a=a-qgeE7W1pNrGK8U0ZQC:22 a=Y_cFJIg8yfREFdlijoxh:22
X-Proofpoint-GUID: LU_bZm0FbEwXxFgJ45qb8q_a_dsHJj1J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290156

Move system register handling code from arch/arm64/kvm to shared
locations (virt/kvm/arm64 and include/kvm/arm64) to enable reuse by e.g.
s390 for KVM/arm64 on s390 support.

Stub functions in s390 are added to maintain linking compatibility. No
functional changes.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/include/asm/kvm_host.h      |   13 -
 arch/arm64/kvm/Makefile                |    1 +
 arch/arm64/kvm/arm.c                   |    2 +-
 arch/arm64/kvm/hyp/nvhe/sys_regs.c     |    2 +-
 arch/arm64/kvm/nested.c                |    2 +-
 arch/arm64/kvm/sys_regs.c              | 1250 +-----------------------
 arch/arm64/kvm/sys_regs.h              |  363 -------
 arch/arm64/kvm/trace_handle_exit.h     |   36 +-
 arch/arm64/kvm/vgic-sys-reg-v3.c       |    2 +-
 arch/arm64/kvm/vgic/vgic-init.c        |    1 +
 arch/s390/include/asm/kvm_host_arm64.h |    5 +-
 arch/s390/kvm/arm64/arm.c              |    9 +
 include/kvm/arm64/kvm_host.h           |   10 +
 include/kvm/arm64/sys_regs.h           |  548 +++++++++++
 virt/kvm/arm64/mmio.c                  |    1 +
 virt/kvm/arm64/sys_regs.c              | 1039 ++++++++++++++++++++
 virt/kvm/arm64/trace.h                 |   34 +
 17 files changed, 1684 insertions(+), 1634 deletions(-)
 delete mode 100644 arch/arm64/kvm/sys_regs.h
 create mode 100644 include/kvm/arm64/sys_regs.h
 create mode 100644 virt/kvm/arm64/sys_regs.c

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index a5fca468cc4a..f3113cdcea0e 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1073,9 +1073,6 @@ u64 kvm_vcpu_apply_reg_masks(const struct kvm_vcpu *, enum vcpu_sysreg, u64);
 		__v;							\
 	})
 
-u64 vcpu_read_sys_reg(const struct kvm_vcpu *, enum vcpu_sysreg);
-void vcpu_write_sys_reg(struct kvm_vcpu *, u64, enum vcpu_sysreg);
-
 struct kvm_vm_stat {
 	struct kvm_vm_stat_generic generic;
 };
@@ -1095,9 +1092,6 @@ unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu);
 int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
 int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
 
-unsigned long kvm_arm_num_sys_reg_descs(struct kvm_vcpu *vcpu);
-int kvm_arm_copy_sys_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices);
-
 int __kvm_arm_vcpu_get_events(struct kvm_vcpu *vcpu,
 			      struct kvm_vcpu_events *events);
 
@@ -1161,11 +1155,9 @@ int kvm_handle_cp14_32(struct kvm_vcpu *vcpu);
 int kvm_handle_cp14_64(struct kvm_vcpu *vcpu);
 int kvm_handle_cp15_32(struct kvm_vcpu *vcpu);
 int kvm_handle_cp15_64(struct kvm_vcpu *vcpu);
-int kvm_handle_sys_reg(struct kvm_vcpu *vcpu);
 int kvm_handle_cp10_id(struct kvm_vcpu *vcpu);
 
 void kvm_sys_regs_create_debugfs(struct kvm *kvm);
-void kvm_reset_sys_regs(struct kvm_vcpu *vcpu);
 
 int __init kvm_sys_reg_table_init(void);
 struct sys_reg_desc;
@@ -1362,9 +1354,6 @@ bool kvm_arm_vcpu_is_finalized(struct kvm_vcpu *vcpu);
 	(system_supports_32bit_el0() &&				\
 	 !static_branch_unlikely(&arm64_mismatched_32bit_el0))
 
-#define kvm_vm_has_ran_once(kvm)					\
-	(test_bit(KVM_ARCH_FLAG_HAS_RAN_ONCE, &(kvm)->arch.flags))
-
 static inline bool __vcpu_has_feature(const struct kvm_arch *ka, int feature)
 {
 	return test_bit(feature, ka->vcpu_features);
@@ -1385,8 +1374,6 @@ static inline void kvm_hyp_reserve(void) { }
 void kvm_arm_vcpu_power_off(struct kvm_vcpu *vcpu);
 bool kvm_arm_vcpu_stopped(struct kvm_vcpu *vcpu);
 
-void kvm_set_vm_id_reg(struct kvm *kvm, u32 reg, u64 val);
-
 static inline bool kvm_arch_has_irq_bypass(void)
 {
 	return true;
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index 5b4a8d002fc9..d55c7245aad9 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -19,6 +19,7 @@ kvm-y += arm.o mmu.o psci.o hypercalls.o pvtime.o \
 	 guest.o debug.o reset.o sys_regs.o stacktrace.o \
 	 vgic-sys-reg-v3.o fpsimd.o pkvm.o \
 	 arch_timer.o trng.o vmid.o emulate-nested.o nested.o at.o \
+	 $(KVM_ARM64)/sys_regs.o \
 	 vgic/vgic.o vgic/vgic-init.o \
 	 vgic/vgic-irqfd.o vgic/vgic-v2.o \
 	 vgic/vgic-v3.o vgic/vgic-v4.o \
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 929b8e6eae9a..99044b1e3c9f 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -54,7 +54,7 @@
 
 #include <kvm/arm64/guest.h>
 
-#include "sys_regs.h"
+#include <kvm/arm64/sys_regs.h>
 
 static enum kvm_mode kvm_mode = KVM_MODE_DEFAULT;
 
diff --git a/arch/arm64/kvm/hyp/nvhe/sys_regs.c b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
index 08b14053568b..51fd49d00c95 100644
--- a/arch/arm64/kvm/hyp/nvhe/sys_regs.c
+++ b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
@@ -14,7 +14,7 @@
 
 #include <nvhe/pkvm.h>
 
-#include "../../sys_regs.h"
+#include <kvm/arm64/sys_regs.h>
 
 /*
  * Copies of the host's CPU features registers holding sanitized values at hyp.
diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index 5321911f19e0..dce896e2a151 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -15,7 +15,7 @@
 #include <asm/kvm_nested.h>
 #include <asm/sysreg.h>
 
-#include "sys_regs.h"
+#include <kvm/arm64/sys_regs.h>
 
 struct vncr_tlb {
 	/* The guest's VNCR_EL2 */
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 46b24529ec70..b68622f93621 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -34,7 +34,7 @@
 
 #include <trace/events/kvm.h>
 
-#include "sys_regs.h"
+#include <kvm/arm64/sys_regs.h>
 #include "vgic/vgic.h"
 
 #include "trace.h"
@@ -45,43 +45,6 @@
  * 64bit interface.
  */
 
-static u64 sys_reg_to_index(const struct sys_reg_desc *reg);
-static int set_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
-		      u64 val);
-
-static bool undef_access(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
-			 const struct sys_reg_desc *r)
-{
-	kvm_inject_undefined(vcpu);
-	return false;
-}
-
-static bool bad_trap(struct kvm_vcpu *vcpu,
-		     struct sys_reg_params *params,
-		     const struct sys_reg_desc *r,
-		     const char *msg)
-{
-	WARN_ONCE(1, "Unexpected %s\n", msg);
-	print_sys_reg_instr(params);
-	return undef_access(vcpu, params, r);
-}
-
-static bool read_from_write_only(struct kvm_vcpu *vcpu,
-				 struct sys_reg_params *params,
-				 const struct sys_reg_desc *r)
-{
-	return bad_trap(vcpu, params, r,
-			"sys_reg read to write-only register");
-}
-
-static bool write_to_read_only(struct kvm_vcpu *vcpu,
-			       struct sys_reg_params *params,
-			       const struct sys_reg_desc *r)
-{
-	return bad_trap(vcpu, params, r,
-			"sys_reg write to read-only register");
-}
-
 enum sr_loc_attr {
 	SR_LOC_MEMORY	= 0,	  /* Register definitely in memory */
 	SR_LOC_LOADED	= BIT(0), /* Register on CPU, unless it cannot */
@@ -391,111 +354,8 @@ void vcpu_write_sys_reg(struct kvm_vcpu *vcpu, u64 val, enum vcpu_sysreg reg)
 	__vcpu_assign_sys_reg(vcpu, reg, val);
 }
 
-/* CSSELR values; used to index KVM_REG_ARM_DEMUX_ID_CCSIDR */
 #define CSSELR_MAX 14
 
-/*
- * Returns the minimum line size for the selected cache, expressed as
- * Log2(bytes).
- */
-static u8 get_min_cache_line_size(bool icache)
-{
-	u64 ctr = read_sanitised_ftr_reg(SYS_CTR_EL0);
-	u8 field;
-
-	if (icache)
-		field = SYS_FIELD_GET(CTR_EL0, IminLine, ctr);
-	else
-		field = SYS_FIELD_GET(CTR_EL0, DminLine, ctr);
-
-	/*
-	 * Cache line size is represented as Log2(words) in CTR_EL0.
-	 * Log2(bytes) can be derived with the following:
-	 *
-	 * Log2(words) + 2 = Log2(bytes / 4) + 2
-	 * 		   = Log2(bytes) - 2 + 2
-	 * 		   = Log2(bytes)
-	 */
-	return field + 2;
-}
-
-/* Which cache CCSIDR represents depends on CSSELR value. */
-static u32 get_ccsidr(struct kvm_vcpu *vcpu, u32 csselr)
-{
-	u8 line_size;
-
-	if (vcpu->arch.ccsidr)
-		return vcpu->arch.ccsidr[csselr];
-
-	line_size = get_min_cache_line_size(csselr & CSSELR_EL1_InD);
-
-	/*
-	 * Fabricate a CCSIDR value as the overriding value does not exist.
-	 * The real CCSIDR value will not be used as it can vary by the
-	 * physical CPU which the vcpu currently resides in.
-	 *
-	 * The line size is determined with get_min_cache_line_size(), which
-	 * should be valid for all CPUs even if they have different cache
-	 * configuration.
-	 *
-	 * The associativity bits are cleared, meaning the geometry of all data
-	 * and unified caches (which are guaranteed to be PIPT and thus
-	 * non-aliasing) are 1 set and 1 way.
-	 * Guests should not be doing cache operations by set/way at all, and
-	 * for this reason, we trap them and attempt to infer the intent, so
-	 * that we can flush the entire guest's address space at the appropriate
-	 * time. The exposed geometry minimizes the number of the traps.
-	 * [If guests should attempt to infer aliasing properties from the
-	 * geometry (which is not permitted by the architecture), they would
-	 * only do so for virtually indexed caches.]
-	 *
-	 * We don't check if the cache level exists as it is allowed to return
-	 * an UNKNOWN value if not.
-	 */
-	return SYS_FIELD_PREP(CCSIDR_EL1, LineSize, line_size - 4);
-}
-
-static int set_ccsidr(struct kvm_vcpu *vcpu, u32 csselr, u32 val)
-{
-	u8 line_size = FIELD_GET(CCSIDR_EL1_LineSize, val) + 4;
-	u32 *ccsidr = vcpu->arch.ccsidr;
-	u32 i;
-
-	if ((val & CCSIDR_EL1_RES0) ||
-	    line_size < get_min_cache_line_size(csselr & CSSELR_EL1_InD))
-		return -EINVAL;
-
-	if (!ccsidr) {
-		if (val == get_ccsidr(vcpu, csselr))
-			return 0;
-
-		ccsidr = kmalloc_array(CSSELR_MAX, sizeof(u32), GFP_KERNEL_ACCOUNT);
-		if (!ccsidr)
-			return -ENOMEM;
-
-		for (i = 0; i < CSSELR_MAX; i++)
-			ccsidr[i] = get_ccsidr(vcpu, i);
-
-		vcpu->arch.ccsidr = ccsidr;
-	}
-
-	ccsidr[csselr] = val;
-
-	return 0;
-}
-
-static bool access_rw(struct kvm_vcpu *vcpu,
-		      struct sys_reg_params *p,
-		      const struct sys_reg_desc *r)
-{
-	if (p->is_write)
-		vcpu_write_sys_reg(vcpu, p->regval, r->reg);
-	else
-		p->regval = vcpu_read_sys_reg(vcpu, r->reg);
-
-	return true;
-}
-
 /*
  * See note at ARMv7 ARM B1.14.4 (TL;DR: S/W ops are not easily virtualized).
  */
@@ -530,24 +390,6 @@ static bool access_dcgsw(struct kvm_vcpu *vcpu,
 	return access_dcsw(vcpu, p, r);
 }
 
-static void get_access_mask(const struct sys_reg_desc *r, u64 *mask, u64 *shift)
-{
-	switch (r->aarch32_map) {
-	case AA32_LO:
-		*mask = GENMASK_ULL(31, 0);
-		*shift = 0;
-		break;
-	case AA32_HI:
-		*mask = GENMASK_ULL(63, 32);
-		*shift = 32;
-		break;
-	default:
-		*mask = GENMASK_ULL(63, 0);
-		*shift = 0;
-		break;
-	}
-}
-
 /*
  * Generic accessor for VM registers. Only called as long as HCR_TVM
  * is set. If the guest enables the MMU, we stop trapping the VM
@@ -766,16 +608,6 @@ static bool access_gicv5_ppi_enabler(struct kvm_vcpu *vcpu,
 	return true;
 }
 
-static bool trap_raz_wi(struct kvm_vcpu *vcpu,
-			struct sys_reg_params *p,
-			const struct sys_reg_desc *r)
-{
-	if (p->is_write)
-		return ignore_write(vcpu, p);
-	else
-		return read_zero(vcpu, p);
-}
-
 /*
  * ARMv8.1 mandates at least a trivial LORegion implementation, where all the
  * RW registers are RES0 (which we can implement as RAZ/WI). On an ARMv8.0
@@ -797,50 +629,6 @@ static bool trap_loregion(struct kvm_vcpu *vcpu,
 	return trap_raz_wi(vcpu, p, r);
 }
 
-static bool trap_oslar_el1(struct kvm_vcpu *vcpu,
-			   struct sys_reg_params *p,
-			   const struct sys_reg_desc *r)
-{
-	if (!p->is_write)
-		return read_from_write_only(vcpu, p, r);
-
-	kvm_debug_handle_oslar(vcpu, p->regval);
-	return true;
-}
-
-static bool trap_oslsr_el1(struct kvm_vcpu *vcpu,
-			   struct sys_reg_params *p,
-			   const struct sys_reg_desc *r)
-{
-	if (p->is_write)
-		return write_to_read_only(vcpu, p, r);
-
-	p->regval = __vcpu_sys_reg(vcpu, r->reg);
-	return true;
-}
-
-static int set_oslsr_el1(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
-			 u64 val)
-{
-	u64 oslk;
-
-	/*
-	 * The only modifiable bit is the OSLK bit. Refuse the write if
-	 * userspace attempts to change any other bit in the register.
-	 */
-	if ((val ^ rd->val) & ~OSLSR_EL1_OSLK)
-		return -EINVAL;
-
-	/*
-	 * Redirect the write to the proper control register.
-	 * OSLSR is read-only
-	 */
-	oslk = SYS_FIELD_GET(OSLSR_EL1, OSLK, val);
-	__vcpu_assign_sys_reg(vcpu, OSLAR_EL1,
-			      SYS_FIELD_PREP(OSLAR_EL1, OSLK, oslk));
-	return 0;
-}
-
 static bool trap_dbgauthstatus_el1(struct kvm_vcpu *vcpu,
 				   struct sys_reg_params *p,
 				   const struct sys_reg_desc *r)
@@ -985,26 +773,6 @@ static u64 reset_actlr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 	return actlr;
 }
 
-static u64 reset_mpidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
-{
-	u64 mpidr;
-
-	/*
-	 * Map the vcpu_id into the first three affinity level fields of
-	 * the MPIDR. We limit the number of VCPUs in level 0 due to a
-	 * limitation to 16 CPUs in that level in the ICC_SGIxR registers
-	 * of the GICv3 to be able to address each CPU directly when
-	 * sending IPIs.
-	 */
-	mpidr = (vcpu->vcpu_id & 0x0f) << MPIDR_LEVEL_SHIFT(0);
-	mpidr |= ((vcpu->vcpu_id >> 4) & 0xff) << MPIDR_LEVEL_SHIFT(1);
-	mpidr |= ((vcpu->vcpu_id >> 12) & 0xff) << MPIDR_LEVEL_SHIFT(2);
-	mpidr |= (1ULL << 31);
-	vcpu_write_sys_reg(vcpu, mpidr, MPIDR_EL1);
-
-	return mpidr;
-}
-
 static unsigned int hidden_visibility(const struct kvm_vcpu *vcpu,
 				      const struct sys_reg_desc *r)
 {
@@ -1783,7 +1551,7 @@ static s64 kvm_arm64_ftr_safe_value(u32 id, const struct arm64_ftr_bits *ftrp,
  *
  * Return: 0 if all the fields are safe. Otherwise, return negative errno.
  */
-static int arm64_check_features(struct kvm_vcpu *vcpu,
+int arm64_check_features(struct kvm_vcpu *vcpu,
 				const struct sys_reg_desc *rd,
 				u64 val)
 {
@@ -1905,188 +1673,6 @@ u64 kvm_sanitised_host_ftr_reg(u32 id)
 	return val;
 }
 
-/*
- * Statically sanitise the host's feature register, independent of the guest's
- * configuration and host implementation.
- */
-static u64 kvm_max_possible_guest_ftr_reg(u32 id, u64 val)
-{
-	switch (id) {
-	case SYS_ID_AA64DFR0_EL1:
-		val = ID_REG_LIMIT_FIELD_ENUM(val, ID_AA64DFR0_EL1, DebugVer, V8P8);
-
-		/* Hide SPE from guests */
-		val &= ~ID_AA64DFR0_EL1_PMSVer_MASK;
-
-		/* Hide BRBE from guests */
-		val &= ~ID_AA64DFR0_EL1_BRBE_MASK;
-		break;
-	case SYS_ID_AA64ISAR2_EL1:
-		/* Mask WFxT field unless *both* WFET & WFIT are present. */
-		if (!id_has_feat(val, ID_AA64ISAR2_EL1, WFxT, IMP))
-			val &= ~ID_AA64ISAR2_EL1_WFxT;
-		break;
-	case SYS_ID_AA64ISAR3_EL1:
-		val &= ID_AA64ISAR3_EL1_FPRCVT | ID_AA64ISAR3_EL1_LSFE |
-		       ID_AA64ISAR3_EL1_FAMINMAX | ID_AA64ISAR3_EL1_LSUI;
-		break;
-	case SYS_ID_AA64MMFR2_EL1:
-		val &= ~ID_AA64MMFR2_EL1_CCIDX_MASK;
-		val &= ~ID_AA64MMFR2_EL1_NV;
-		break;
-	case SYS_ID_AA64MMFR3_EL1:
-		val &= ID_AA64MMFR3_EL1_TCRX |
-		       ID_AA64MMFR3_EL1_SCTLRX |
-		       ID_AA64MMFR3_EL1_S1POE |
-		       ID_AA64MMFR3_EL1_S1PIE;
-		break;
-	case SYS_ID_MMFR4_EL1:
-		val &= ~ID_MMFR4_EL1_CCIDX;
-		break;
-	case SYS_ID_AA64PFR0_EL1:
-		val &= ~ID_AA64PFR0_EL1_AMU_MASK;
-		/*
-		 * MPAM is disabled by default as KVM also needs a set of PARTID to
-		 * program the MPAMVPMx_EL2 PARTID remapping registers with. But some
-		 * older kernels let the guest see the ID bit.
-		 */
-		val &= ~ID_AA64PFR0_EL1_MPAM_MASK;
-		break;
-	case SYS_ID_AA64PFR1_EL1:
-		val &= ~ID_AA64PFR1_EL1_SME;
-		val &= ~ID_AA64PFR1_EL1_RNDR_trap;
-		val &= ~ID_AA64PFR1_EL1_NMI;
-		val &= ~ID_AA64PFR1_EL1_GCS;
-		val &= ~ID_AA64PFR1_EL1_THE;
-		val &= ~ID_AA64PFR1_EL1_MTEX;
-		val &= ~ID_AA64PFR1_EL1_PFAR;
-		val &= ~ID_AA64PFR1_EL1_MPAM_frac;
-		break;
-	case SYS_ID_AA64PFR2_EL1:
-		val &= ID_AA64PFR2_EL1_FPMR |
-		       ID_AA64PFR2_EL1_MTEFAR |
-		       ID_AA64PFR2_EL1_MTESTOREONLY;
-		break;
-	}
-
-	return val;
-}
-
-/*
- * Sanitise based on vCPU configuration.
- */
-static u64 kvm_sanitise_vcpu_ftr_reg(const struct kvm_vcpu *vcpu, u32 id, u64 val)
-{
-	switch (id) {
-	case SYS_ID_AA64DFR0_EL1:
-		/*
-		 * Only initialize the PMU version if the vCPU was configured with one.
-		 */
-		val &= ~ID_AA64DFR0_EL1_PMUVer_MASK;
-		if (kvm_vcpu_has_pmu(vcpu))
-			val |= SYS_FIELD_PREP(ID_AA64DFR0_EL1, PMUVer,
-					      kvm_arm_pmu_get_pmuver_limit());
-		break;
-	case SYS_ID_AA64PFR0_EL1:
-		if (!vcpu_has_sve(vcpu))
-			val &= ~ID_AA64PFR0_EL1_SVE_MASK;
-		break;
-	case SYS_ID_AA64PFR1_EL1:
-		if (!kvm_has_mte(vcpu->kvm)) {
-			val &= ~ID_AA64PFR1_EL1_MTE;
-			val &= ~ID_AA64PFR1_EL1_MTE_frac;
-		}
-		break;
-	case SYS_ID_AA64PFR2_EL1:
-		if (!kvm_has_mte(vcpu->kvm)) {
-			val &= ~ID_AA64PFR2_EL1_MTEFAR;
-			val &= ~ID_AA64PFR2_EL1_MTESTOREONLY;
-		}
-		break;
-	case SYS_ID_AA64ISAR1_EL1:
-		if (!vcpu_has_ptrauth(vcpu))
-			val &= ~(ID_AA64ISAR1_EL1_APA |
-				 ID_AA64ISAR1_EL1_API |
-				 ID_AA64ISAR1_EL1_GPA |
-				 ID_AA64ISAR1_EL1_GPI);
-		break;
-	case SYS_ID_AA64ISAR2_EL1:
-		if (!vcpu_has_ptrauth(vcpu))
-			val &= ~(ID_AA64ISAR2_EL1_APA3 |
-				 ID_AA64ISAR2_EL1_GPA3);
-	}
-
-	if (vcpu_has_nv(vcpu))
-		val = limit_nv_id_reg(vcpu->kvm, id, val);
-
-	return val;
-}
-
-/* Read a sanitised cpufeature ID register by sys_reg_desc */
-static u64 __kvm_read_sanitised_id_reg(const struct kvm_vcpu *vcpu,
-				       const struct sys_reg_desc *r)
-{
-	u32 id = reg_to_encoding(r);
-	u64 val;
-
-	if (sysreg_visible_as_raz(vcpu, r))
-		return 0;
-
-	val = kvm_sanitised_host_ftr_reg(id);
-	val = kvm_max_possible_guest_ftr_reg(id, val);
-	val = kvm_sanitise_vcpu_ftr_reg(vcpu, id, val);
-
-	return val;
-}
-
-u64 kvm_read_sanitised_id_reg(struct kvm_vcpu *vcpu,
-			      const struct sys_reg_desc *r)
-{
-	return __kvm_read_sanitised_id_reg(vcpu, r);
-}
-
-static u64 read_id_reg(const struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
-{
-	return kvm_read_vm_id_reg(vcpu->kvm, reg_to_encoding(r));
-}
-
-static bool is_feature_id_reg(u32 encoding)
-{
-	return (sys_reg_Op0(encoding) == 3 &&
-		(sys_reg_Op1(encoding) < 2 || sys_reg_Op1(encoding) == 3) &&
-		sys_reg_CRn(encoding) == 0 &&
-		sys_reg_CRm(encoding) <= 7);
-}
-
-/*
- * Return true if the register's (Op0, Op1, CRn, CRm, Op2) is
- * (3, 0, 0, crm, op2), where 1<=crm<8, 0<=op2<8, which is the range of ID
- * registers KVM maintains on a per-VM basis.
- *
- * Additionally, the implementation ID registers and CTR_EL0 are handled as
- * per-VM registers.
- */
-static inline bool is_vm_ftr_id_reg(u32 id)
-{
-	switch (id) {
-	case SYS_CTR_EL0:
-	case SYS_MIDR_EL1:
-	case SYS_REVIDR_EL1:
-	case SYS_AIDR_EL1:
-		return true;
-	default:
-		return (sys_reg_Op0(id) == 3 && sys_reg_Op1(id) == 0 &&
-			sys_reg_CRn(id) == 0 && sys_reg_CRm(id) >= 1 &&
-			sys_reg_CRm(id) < 8);
-
-	}
-}
-
-static inline bool is_vcpu_ftr_id_reg(u32 id)
-{
-	return is_feature_id_reg(id) && !is_vm_ftr_id_reg(id);
-}
-
 static inline bool is_aa32_id_reg(u32 id)
 {
 	return (sys_reg_Op0(id) == 3 && sys_reg_Op1(id) == 0 &&
@@ -2094,49 +1680,6 @@ static inline bool is_aa32_id_reg(u32 id)
 		sys_reg_CRm(id) <= 3);
 }
 
-static unsigned int id_visibility(const struct kvm_vcpu *vcpu,
-				  const struct sys_reg_desc *r)
-{
-	u32 id = reg_to_encoding(r);
-
-	switch (id) {
-	case SYS_ID_AA64ZFR0_EL1:
-		if (!vcpu_has_sve(vcpu))
-			return REG_RAZ;
-		break;
-	}
-
-	return 0;
-}
-
-static unsigned int aa32_id_visibility(const struct kvm_vcpu *vcpu,
-				       const struct sys_reg_desc *r)
-{
-	/*
-	 * AArch32 ID registers are UNKNOWN if AArch32 isn't implemented at any
-	 * EL. Promote to RAZ/WI in order to guarantee consistency between
-	 * systems.
-	 */
-	if (!kvm_supports_32bit_el0())
-		return REG_RAZ | REG_USER_WI;
-
-	return id_visibility(vcpu, r);
-}
-
-/* cpufeature ID register access trap handlers */
-
-static bool access_id_reg(struct kvm_vcpu *vcpu,
-			  struct sys_reg_params *p,
-			  const struct sys_reg_desc *r)
-{
-	if (p->is_write)
-		return write_to_read_only(vcpu, p, r);
-
-	p->regval = read_id_reg(vcpu, r);
-
-	return true;
-}
-
 /* Visibility overrides for SVE-specific control registers */
 static unsigned int sve_visibility(const struct kvm_vcpu *vcpu,
 				   const struct sys_reg_desc *rd)
@@ -2333,290 +1876,48 @@ static int set_id_aa64pfr1_el1(struct kvm_vcpu *vcpu,
 	return set_id_reg(vcpu, rd, user_val);
 }
 
-static int set_id_aa64pfr2_el1(struct kvm_vcpu *vcpu,
-			       const struct sys_reg_desc *rd, u64 user_val)
-{
-	return set_id_reg(vcpu, rd, user_val);
-}
-
-/*
- * Allow userspace to de-feature a stage-2 translation granule but prevent it
- * from claiming the impossible.
- */
-#define tgran2_val_allowed(tg, safe, user)			\
-({								\
-	u8 __s = SYS_FIELD_GET(ID_AA64MMFR0_EL1, tg, safe);	\
-	u8 __u = SYS_FIELD_GET(ID_AA64MMFR0_EL1, tg, user);	\
-								\
-	__s == __u || __u == ID_AA64MMFR0_EL1_##tg##_NI;	\
-})
-
-static int set_id_aa64mmfr0_el1(struct kvm_vcpu *vcpu,
-				const struct sys_reg_desc *rd, u64 user_val)
-{
-	u64 sanitized_val = kvm_read_sanitised_id_reg(vcpu, rd);
-
-	if (!vcpu_has_nv(vcpu))
-		return set_id_reg(vcpu, rd, user_val);
-
-	if (!tgran2_val_allowed(TGRAN4_2, sanitized_val, user_val) ||
-	    !tgran2_val_allowed(TGRAN16_2, sanitized_val, user_val) ||
-	    !tgran2_val_allowed(TGRAN64_2, sanitized_val, user_val))
-		return -EINVAL;
-
-	return set_id_reg(vcpu, rd, user_val);
-}
-
-static int set_id_aa64mmfr2_el1(struct kvm_vcpu *vcpu,
-				const struct sys_reg_desc *rd, u64 user_val)
-{
-	u64 hw_val = read_sanitised_ftr_reg(SYS_ID_AA64MMFR2_EL1);
-	u64 nv_mask = ID_AA64MMFR2_EL1_NV_MASK;
-
-	/*
-	 * We made the mistake to expose the now deprecated NV field,
-	 * so allow userspace to write it, but silently ignore it.
-	 */
-	if ((hw_val & nv_mask) == (user_val & nv_mask))
-		user_val &= ~nv_mask;
-
-	return set_id_reg(vcpu, rd, user_val);
-}
-
-static int set_ctr_el0(struct kvm_vcpu *vcpu,
-		       const struct sys_reg_desc *rd, u64 user_val)
-{
-	u8 user_L1Ip = SYS_FIELD_GET(CTR_EL0, L1Ip, user_val);
-
-	/*
-	 * Both AIVIVT (0b01) and VPIPT (0b00) are documented as reserved.
-	 * Hence only allow to set VIPT(0b10) or PIPT(0b11) for L1Ip based
-	 * on what hardware reports.
-	 *
-	 * Using a VIPT software model on PIPT will lead to over invalidation,
-	 * but still correct. Hence, we can allow downgrading PIPT to VIPT,
-	 * but not the other way around. This is handled via arm64_ftr_safe_value()
-	 * as CTR_EL0 ftr_bits has L1Ip field with type FTR_EXACT and safe value
-	 * set as VIPT.
-	 */
-	switch (user_L1Ip) {
-	case CTR_EL0_L1Ip_RESERVED_VPIPT:
-	case CTR_EL0_L1Ip_RESERVED_AIVIVT:
-		return -EINVAL;
-	case CTR_EL0_L1Ip_VIPT:
-	case CTR_EL0_L1Ip_PIPT:
-		return set_id_reg(vcpu, rd, user_val);
-	default:
-		return -ENOENT;
-	}
-}
-
-/*
- * cpufeature ID register user accessors
- *
- * For now, these registers are immutable for userspace, so no values
- * are stored, and for set_id_reg() we don't allow the effective value
- * to be changed.
- */
-static int get_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
-		      u64 *val)
-{
-	/*
-	 * Avoid locking if the VM has already started, as the ID registers are
-	 * guaranteed to be invariant at that point.
-	 */
-	if (kvm_vm_has_ran_once(vcpu->kvm)) {
-		*val = read_id_reg(vcpu, rd);
-		return 0;
-	}
-
-	mutex_lock(&vcpu->kvm->arch.config_lock);
-	*val = read_id_reg(vcpu, rd);
-	mutex_unlock(&vcpu->kvm->arch.config_lock);
-
-	return 0;
-}
-
-static int set_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
-		      u64 val)
-{
-	u32 id = reg_to_encoding(rd);
-	int ret;
-
-	mutex_lock(&vcpu->kvm->arch.config_lock);
-
-	/*
-	 * Once the VM has started the ID registers are immutable. Reject any
-	 * write that does not match the final register value.
-	 */
-	if (kvm_vm_has_ran_once(vcpu->kvm)) {
-		if (val != read_id_reg(vcpu, rd))
-			ret = -EBUSY;
-		else
-			ret = 0;
-
-		mutex_unlock(&vcpu->kvm->arch.config_lock);
-		return ret;
-	}
-
-	ret = arm64_check_features(vcpu, rd, val);
-	if (!ret)
-		kvm_set_vm_id_reg(vcpu->kvm, id, val);
-
-	mutex_unlock(&vcpu->kvm->arch.config_lock);
-
-	/*
-	 * arm64_check_features() returns -E2BIG to indicate the register's
-	 * feature set is a superset of the maximally-allowed register value.
-	 * While it would be nice to precisely describe this to userspace, the
-	 * existing UAPI for KVM_SET_ONE_REG has it that invalid register
-	 * writes return -EINVAL.
-	 */
-	if (ret == -E2BIG)
-		ret = -EINVAL;
-	return ret;
-}
-
-void kvm_set_vm_id_reg(struct kvm *kvm, u32 reg, u64 val)
-{
-	u64 *p = __vm_id_reg(&kvm->arch.id_regs, reg);
-
-	lockdep_assert_held(&kvm->arch.config_lock);
-
-	if (KVM_BUG_ON(kvm_vm_has_ran_once(kvm) || !p, kvm))
-		return;
-
-	*p = val;
-}
-
-static int get_raz_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
-		       u64 *val)
-{
-	*val = 0;
-	return 0;
-}
-
-static int set_wi_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
-		      u64 val)
-{
-	return 0;
-}
-
-static bool access_ctr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
-		       const struct sys_reg_desc *r)
-{
-	if (p->is_write)
-		return write_to_read_only(vcpu, p, r);
-
-	p->regval = kvm_read_vm_id_reg(vcpu->kvm, SYS_CTR_EL0);
-	return true;
-}
-
-static bool access_clidr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
-			 const struct sys_reg_desc *r)
-{
-	if (p->is_write)
-		return write_to_read_only(vcpu, p, r);
-
-	p->regval = __vcpu_sys_reg(vcpu, r->reg);
-	return true;
-}
-
-/*
- * Fabricate a CLIDR_EL1 value instead of using the real value, which can vary
- * by the physical CPU which the vcpu currently resides in.
- */
-static u64 reset_clidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
-{
-	u64 ctr_el0 = read_sanitised_ftr_reg(SYS_CTR_EL0);
-	u64 clidr;
-	u8 loc;
-
-	if ((ctr_el0 & CTR_EL0_IDC)) {
-		/*
-		 * Data cache clean to the PoU is not required so LoUU and LoUIS
-		 * will not be set and a unified cache, which will be marked as
-		 * LoC, will be added.
-		 *
-		 * If not DIC, let the unified cache L2 so that an instruction
-		 * cache can be added as L1 later.
-		 */
-		loc = (ctr_el0 & CTR_EL0_DIC) ? 1 : 2;
-		clidr = CACHE_TYPE_UNIFIED << CLIDR_CTYPE_SHIFT(loc);
-	} else {
-		/*
-		 * Data cache clean to the PoU is required so let L1 have a data
-		 * cache and mark it as LoUU and LoUIS. As L1 has a data cache,
-		 * it can be marked as LoC too.
-		 */
-		loc = 1;
-		clidr = 1 << CLIDR_LOUU_SHIFT;
-		clidr |= 1 << CLIDR_LOUIS_SHIFT;
-		clidr |= CACHE_TYPE_DATA << CLIDR_CTYPE_SHIFT(1);
-	}
-
-	/*
-	 * Instruction cache invalidation to the PoU is required so let L1 have
-	 * an instruction cache. If L1 already has a data cache, it will be
-	 * CACHE_TYPE_SEPARATE.
-	 */
-	if (!(ctr_el0 & CTR_EL0_DIC))
-		clidr |= CACHE_TYPE_INST << CLIDR_CTYPE_SHIFT(1);
+static int set_id_aa64pfr2_el1(struct kvm_vcpu *vcpu,
+			       const struct sys_reg_desc *rd, u64 user_val)
+{
+	return set_id_reg(vcpu, rd, user_val);
+}
 
-	clidr |= loc << CLIDR_LOC_SHIFT;
+static int set_id_aa64mmfr2_el1(struct kvm_vcpu *vcpu,
+				const struct sys_reg_desc *rd, u64 user_val)
+{
+	u64 hw_val = read_sanitised_ftr_reg(SYS_ID_AA64MMFR2_EL1);
+	u64 nv_mask = ID_AA64MMFR2_EL1_NV_MASK;
 
 	/*
-	 * Add tag cache unified to data cache. Allocation tags and data are
-	 * unified in a cache line so that it looks valid even if there is only
-	 * one cache line.
+	 * We made the mistake to expose the now deprecated NV field,
+	 * so allow userspace to write it, but silently ignore it.
 	 */
-	if (kvm_has_mte(vcpu->kvm))
-		clidr |= 2ULL << CLIDR_TTYPE_SHIFT(loc);
-
-	__vcpu_assign_sys_reg(vcpu, r->reg, clidr);
+	if ((hw_val & nv_mask) == (user_val & nv_mask))
+		user_val &= ~nv_mask;
 
-	return __vcpu_sys_reg(vcpu, r->reg);
+	return set_id_reg(vcpu, rd, user_val);
 }
 
-static int set_clidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
-		      u64 val)
+static int get_raz_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
+		       u64 *val)
 {
-	u64 ctr_el0 = read_sanitised_ftr_reg(SYS_CTR_EL0);
-	u64 idc = !CLIDR_LOC(val) || (!CLIDR_LOUIS(val) && !CLIDR_LOUU(val));
-
-	if ((val & CLIDR_EL1_RES0) || (!(ctr_el0 & CTR_EL0_IDC) && idc))
-		return -EINVAL;
-
-	__vcpu_assign_sys_reg(vcpu, rd->reg, val);
-
+	*val = 0;
 	return 0;
 }
 
-static bool access_csselr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
-			  const struct sys_reg_desc *r)
+static int set_wi_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
+		      u64 val)
 {
-	int reg = r->reg;
-
-	if (p->is_write)
-		vcpu_write_sys_reg(vcpu, p->regval, reg);
-	else
-		p->regval = vcpu_read_sys_reg(vcpu, reg);
-	return true;
+	return 0;
 }
 
-static bool access_ccsidr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
-			  const struct sys_reg_desc *r)
+static bool access_ctr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
+		       const struct sys_reg_desc *r)
 {
-	u32 csselr;
-
 	if (p->is_write)
 		return write_to_read_only(vcpu, p, r);
 
-	csselr = vcpu_read_sys_reg(vcpu, CSSELR_EL1);
-	csselr &= CSSELR_EL1_Level | CSSELR_EL1_InD;
-	if (csselr < CSSELR_MAX)
-		p->regval = get_ccsidr(vcpu, csselr);
-
+	p->regval = kvm_read_vm_id_reg(vcpu->kvm, SYS_CTR_EL0);
 	return true;
 }
 
@@ -2700,82 +2001,6 @@ static bool bad_redir_trap(struct kvm_vcpu *vcpu,
 	SYS_REG_USER_FILTER(name, access_arch_timer, reset_val, 0, \
 			    arch_timer_get_user, arch_timer_set_user, vis)
 
-/*
- * Since reset() callback and field val are not used for idregs, they will be
- * used for specific purposes for idregs.
- * The reset() would return KVM sanitised register value. The value would be the
- * same as the host kernel sanitised value if there is no KVM sanitisation.
- * The val would be used as a mask indicating writable fields for the idreg.
- * Only bits with 1 are writable from userspace. This mask might not be
- * necessary in the future whenever all ID registers are enabled as writable
- * from userspace.
- */
-
-#define ID_DESC_DEFAULT_CALLBACKS		\
-	.access	= access_id_reg,		\
-	.get_user = get_id_reg,			\
-	.set_user = set_id_reg,			\
-	.visibility = id_visibility,		\
-	.reset = kvm_read_sanitised_id_reg
-
-#define ID_DESC(name)				\
-	SYS_DESC(SYS_##name),			\
-	ID_DESC_DEFAULT_CALLBACKS
-
-/* sys_reg_desc initialiser for known cpufeature ID registers */
-#define ID_SANITISED(name) {			\
-	ID_DESC(name),				\
-	.val = 0,				\
-}
-
-/* sys_reg_desc initialiser for writable ID registers */
-#define ID_WRITABLE(name, mask) {		\
-	ID_DESC(name),				\
-	.val = mask,				\
-}
-
-/*
- * 32bit ID regs are fully writable when the guest is 32bit
- * capable. Nothing in the KVM code should rely on 32bit features
- * anyway, only 64bit, so let the VMM do its worse.
- */
-#define AA32_ID_WRITABLE(name) {		\
-	ID_DESC(name),				\
-	.visibility = aa32_id_visibility,	\
-	.val = GENMASK(31, 0),			\
-}
-
-/* sys_reg_desc initialiser for cpufeature ID registers that need filtering */
-#define ID_FILTERED(sysreg, name, mask) {	\
-	ID_DESC(sysreg),				\
-	.set_user = set_##name,				\
-	.val = (mask),					\
-}
-
-/*
- * sys_reg_desc initialiser for architecturally unallocated cpufeature ID
- * register with encoding Op0=3, Op1=0, CRn=0, CRm=crm, Op2=op2
- * (1 <= crm < 8, 0 <= Op2 < 8).
- */
-#define ID_UNALLOCATED(crm, op2) {			\
-	.name = "S3_0_0_" #crm "_" #op2,		\
-	Op0(3), Op1(0), CRn(0), CRm(crm), Op2(op2),	\
-	ID_DESC_DEFAULT_CALLBACKS,			\
-	.visibility = raz_visibility,			\
-	.val = 0,					\
-}
-
-/*
- * sys_reg_desc initialiser for known ID registers that we hide from guests.
- * For now, these are exposed just like unallocated ID regs: they appear
- * RAZ for the guest.
- */
-#define ID_HIDDEN(name) {			\
-	ID_DESC(name),				\
-	.visibility = raz_visibility,		\
-	.val = 0,				\
-}
-
 static bool access_sp_el1(struct kvm_vcpu *vcpu,
 			  struct sys_reg_params *p,
 			  const struct sys_reg_desc *r)
@@ -3100,7 +2325,7 @@ static bool access_ras(struct kvm_vcpu *vcpu,
  * follows attempts to give a user / guest view consistent with the existing
  * ABI.
  */
-static bool access_imp_id_reg(struct kvm_vcpu *vcpu,
+bool access_imp_id_reg(struct kvm_vcpu *vcpu,
 			      struct sys_reg_params *p,
 			      const struct sys_reg_desc *r)
 {
@@ -3143,7 +2368,7 @@ static void init_imp_id_regs(void)
 	boot_cpu_aidr_val = read_sysreg(aidr_el1);
 }
 
-static u64 reset_imp_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
+ u64 reset_imp_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 {
 	switch (reg_to_encoding(r)) {
 	case SYS_MIDR_EL1:
@@ -3158,48 +2383,6 @@ static u64 reset_imp_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 	}
 }
 
-static int set_imp_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
-			  u64 val)
-{
-	struct kvm *kvm = vcpu->kvm;
-	u64 expected;
-
-	guard(mutex)(&kvm->arch.config_lock);
-
-	expected = read_id_reg(vcpu, r);
-	if (expected == val)
-		return 0;
-
-	if (!test_bit(KVM_ARCH_FLAG_WRITABLE_IMP_ID_REGS, &kvm->arch.flags))
-		return -EINVAL;
-
-	/*
-	 * Once the VM has started the ID registers are immutable. Reject the
-	 * write if userspace tries to change it.
-	 */
-	if (kvm_vm_has_ran_once(kvm))
-		return -EBUSY;
-
-	/*
-	 * Any value is allowed for the implementation ID registers so long as
-	 * it is within the writable mask.
-	 */
-	if ((val & r->val) != val)
-		return -EINVAL;
-
-	kvm_set_vm_id_reg(kvm, reg_to_encoding(r), val);
-	return 0;
-}
-
-#define IMPLEMENTATION_ID(reg, mask) {			\
-	SYS_DESC(SYS_##reg),				\
-	.access = access_imp_id_reg,			\
-	.get_user = get_id_reg,				\
-	.set_user = set_imp_id_reg,			\
-	.reset = reset_imp_id_reg,			\
-	.val = mask,					\
-	}
-
 static u64 reset_mdcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 {
 	__vcpu_assign_sys_reg(vcpu, r->reg, vcpu->kvm->arch.nr_pmu_counters);
@@ -4747,61 +3930,12 @@ static const struct sys_reg_desc cp15_64_regs[] = {
 	{ SYS_DESC(SYS_AARCH32_CNTVCTSS),     access_arch_timer },
 };
 
-static bool check_sysreg_table(const struct sys_reg_desc *table, unsigned int n,
-			       bool reset_check)
-{
-	unsigned int i;
-
-	for (i = 0; i < n; i++) {
-		if (reset_check && table[i].reg && !table[i].reset) {
-			kvm_err("sys_reg table %pS entry %d (%s) lacks reset\n",
-				&table[i], i, table[i].name);
-			return false;
-		}
-
-		if (i && cmp_sys_reg(&table[i-1], &table[i]) >= 0) {
-			kvm_err("sys_reg table %pS entry %d (%s -> %s) out of order\n",
-				&table[i], i, table[i - 1].name, table[i].name);
-			return false;
-		}
-	}
-
-	return true;
-}
-
 int kvm_handle_cp14_load_store(struct kvm_vcpu *vcpu)
 {
 	kvm_inject_undefined(vcpu);
 	return 1;
 }
 
-static void perform_access(struct kvm_vcpu *vcpu,
-			   struct sys_reg_params *params,
-			   const struct sys_reg_desc *r)
-{
-	trace_kvm_sys_access(*vcpu_pc(vcpu), params, r);
-
-	/* Check for regs disabled by runtime config */
-	if (sysreg_hidden(vcpu, r)) {
-		kvm_inject_undefined(vcpu);
-		return;
-	}
-
-	/*
-	 * Not having an accessor means that we have configured a trap
-	 * that we don't know how to handle. This certainly qualifies
-	 * as a gross bug that should be fixed right away.
-	 */
-	if (!r->access) {
-		bad_trap(vcpu, params, r, "register access");
-		return;
-	}
-
-	/* Skip instruction if instructed so */
-	if (likely(r->access(vcpu, params, r)))
-		kvm_incr_pc(vcpu);
-}
-
 /*
  * emulate_cp --  tries to match a sys_reg access in a handling table, and
  *                call the corresponding trap handler.
@@ -5256,26 +4390,6 @@ void kvm_sys_regs_create_debugfs(struct kvm *kvm)
 			    &sr_resx_fops);
 }
 
-static void reset_vm_ftr_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *reg)
-{
-	u32 id = reg_to_encoding(reg);
-	struct kvm *kvm = vcpu->kvm;
-
-	if (test_bit(KVM_ARCH_FLAG_ID_REGS_INITIALIZED, &kvm->arch.flags))
-		return;
-
-	kvm_set_vm_id_reg(kvm, id, reg->reset(vcpu, reg));
-}
-
-static void reset_vcpu_ftr_id_reg(struct kvm_vcpu *vcpu,
-				  const struct sys_reg_desc *reg)
-{
-	if (kvm_vcpu_initialized(vcpu))
-		return;
-
-	reg->reset(vcpu, reg);
-}
-
 /**
  * kvm_reset_sys_regs - sets system registers to reset value
  * @vcpu: The VCPU pointer
@@ -5352,321 +4466,25 @@ int kvm_handle_sys_reg(struct kvm_vcpu *vcpu)
  * Userspace API
  *****************************************************************************/
 
-static bool index_to_params(u64 id, struct sys_reg_params *params)
-{
-	switch (id & KVM_REG_SIZE_MASK) {
-	case KVM_REG_SIZE_U64:
-		/* Any unused index bits means it's not valid. */
-		if (id & ~(KVM_REG_ARCH_MASK | KVM_REG_SIZE_MASK
-			      | KVM_REG_ARM_COPROC_MASK
-			      | KVM_REG_ARM64_SYSREG_OP0_MASK
-			      | KVM_REG_ARM64_SYSREG_OP1_MASK
-			      | KVM_REG_ARM64_SYSREG_CRN_MASK
-			      | KVM_REG_ARM64_SYSREG_CRM_MASK
-			      | KVM_REG_ARM64_SYSREG_OP2_MASK))
-			return false;
-		params->Op0 = ((id & KVM_REG_ARM64_SYSREG_OP0_MASK)
-			       >> KVM_REG_ARM64_SYSREG_OP0_SHIFT);
-		params->Op1 = ((id & KVM_REG_ARM64_SYSREG_OP1_MASK)
-			       >> KVM_REG_ARM64_SYSREG_OP1_SHIFT);
-		params->CRn = ((id & KVM_REG_ARM64_SYSREG_CRN_MASK)
-			       >> KVM_REG_ARM64_SYSREG_CRN_SHIFT);
-		params->CRm = ((id & KVM_REG_ARM64_SYSREG_CRM_MASK)
-			       >> KVM_REG_ARM64_SYSREG_CRM_SHIFT);
-		params->Op2 = ((id & KVM_REG_ARM64_SYSREG_OP2_MASK)
-			       >> KVM_REG_ARM64_SYSREG_OP2_SHIFT);
-		return true;
-	default:
-		return false;
-	}
-}
-
-const struct sys_reg_desc *get_reg_by_id(u64 id,
-					 const struct sys_reg_desc table[],
-					 unsigned int num)
-{
-	struct sys_reg_params params;
-
-	if (!index_to_params(id, &params))
-		return NULL;
-
-	return find_reg(&params, table, num);
-}
-
-/* Decode an index value, and find the sys_reg_desc entry. */
-static const struct sys_reg_desc *
-id_to_sys_reg_desc(struct kvm_vcpu *vcpu, u64 id,
-		   const struct sys_reg_desc table[], unsigned int num)
-
-{
-	const struct sys_reg_desc *r;
-
-	/* We only do sys_reg for now. */
-	if ((id & KVM_REG_ARM_COPROC_MASK) != KVM_REG_ARM64_SYSREG)
-		return NULL;
-
-	r = get_reg_by_id(id, table, num);
-
-	/* Not saved in the sys_reg array and not otherwise accessible? */
-	if (r && (!(r->reg || r->get_user) || sysreg_hidden(vcpu, r)))
-		r = NULL;
-
-	return r;
-}
-
-static int demux_c15_get(struct kvm_vcpu *vcpu, u64 id, void __user *uaddr)
-{
-	u32 val;
-	u32 __user *uval = uaddr;
-
-	/* Fail if we have unknown bits set. */
-	if (id & ~(KVM_REG_ARCH_MASK|KVM_REG_SIZE_MASK|KVM_REG_ARM_COPROC_MASK
-		   | ((1 << KVM_REG_ARM_COPROC_SHIFT)-1)))
-		return -ENOENT;
-
-	switch (id & KVM_REG_ARM_DEMUX_ID_MASK) {
-	case KVM_REG_ARM_DEMUX_ID_CCSIDR:
-		if (KVM_REG_SIZE(id) != 4)
-			return -ENOENT;
-		val = (id & KVM_REG_ARM_DEMUX_VAL_MASK)
-			>> KVM_REG_ARM_DEMUX_VAL_SHIFT;
-		if (val >= CSSELR_MAX)
-			return -ENOENT;
-
-		return put_user(get_ccsidr(vcpu, val), uval);
-	default:
-		return -ENOENT;
-	}
-}
-
-static int demux_c15_set(struct kvm_vcpu *vcpu, u64 id, void __user *uaddr)
-{
-	u32 val, newval;
-	u32 __user *uval = uaddr;
-
-	/* Fail if we have unknown bits set. */
-	if (id & ~(KVM_REG_ARCH_MASK|KVM_REG_SIZE_MASK|KVM_REG_ARM_COPROC_MASK
-		   | ((1 << KVM_REG_ARM_COPROC_SHIFT)-1)))
-		return -ENOENT;
-
-	switch (id & KVM_REG_ARM_DEMUX_ID_MASK) {
-	case KVM_REG_ARM_DEMUX_ID_CCSIDR:
-		if (KVM_REG_SIZE(id) != 4)
-			return -ENOENT;
-		val = (id & KVM_REG_ARM_DEMUX_VAL_MASK)
-			>> KVM_REG_ARM_DEMUX_VAL_SHIFT;
-		if (val >= CSSELR_MAX)
-			return -ENOENT;
-
-		if (get_user(newval, uval))
-			return -EFAULT;
-
-		return set_ccsidr(vcpu, val, newval);
-	default:
-		return -ENOENT;
-	}
-}
-
-static u64 kvm_one_reg_to_id(const struct kvm_one_reg *reg)
-{
-	switch(reg->id) {
-	case KVM_REG_ARM_TIMER_CVAL:
-		return TO_ARM64_SYS_REG(CNTV_CVAL_EL0);
-	case KVM_REG_ARM_TIMER_CNT:
-		return TO_ARM64_SYS_REG(CNTVCT_EL0);
-	default:
-		return reg->id;
-	}
-}
-
-int kvm_sys_reg_get_user(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg,
-			 const struct sys_reg_desc table[], unsigned int num)
-{
-	u64 __user *uaddr = (u64 __user *)(unsigned long)reg->addr;
-	const struct sys_reg_desc *r;
-	u64 id = kvm_one_reg_to_id(reg);
-	u64 val;
-	int ret;
-
-	r = id_to_sys_reg_desc(vcpu, id, table, num);
-	if (!r || sysreg_hidden(vcpu, r))
-		return -ENOENT;
-
-	if (r->get_user) {
-		ret = (r->get_user)(vcpu, r, &val);
-	} else {
-		val = __vcpu_sys_reg(vcpu, r->reg);
-		ret = 0;
-	}
-
-	if (!ret)
-		ret = put_user(val, uaddr);
-
-	return ret;
-}
-
 int kvm_arm_sys_reg_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 {
-	void __user *uaddr = (void __user *)(unsigned long)reg->addr;
-
-	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_DEMUX)
-		return demux_c15_get(vcpu, reg->id, uaddr);
-
-	return kvm_sys_reg_get_user(vcpu, reg,
-				    sys_reg_descs, ARRAY_SIZE(sys_reg_descs));
-}
-
-int kvm_sys_reg_set_user(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg,
-			 const struct sys_reg_desc table[], unsigned int num)
-{
-	u64 __user *uaddr = (u64 __user *)(unsigned long)reg->addr;
-	const struct sys_reg_desc *r;
-	u64 id = kvm_one_reg_to_id(reg);
-	u64 val;
-	int ret;
-
-	if (get_user(val, uaddr))
-		return -EFAULT;
-
-	r = id_to_sys_reg_desc(vcpu, id, table, num);
-	if (!r || sysreg_hidden(vcpu, r))
-		return -ENOENT;
-
-	if (sysreg_user_write_ignore(vcpu, r))
-		return 0;
-
-	if (r->set_user) {
-		ret = (r->set_user)(vcpu, r, val);
-	} else {
-		__vcpu_assign_sys_reg(vcpu, r->reg, val);
-		ret = 0;
-	}
-
-	return ret;
+	return __kvm_arm_sys_reg_get_reg(vcpu, reg, ARRAY_SIZE(sys_reg_descs), sys_reg_descs);
 }
 
 int kvm_arm_sys_reg_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 {
-	void __user *uaddr = (void __user *)(unsigned long)reg->addr;
-
-	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_DEMUX)
-		return demux_c15_set(vcpu, reg->id, uaddr);
-
-	return kvm_sys_reg_set_user(vcpu, reg,
-				    sys_reg_descs, ARRAY_SIZE(sys_reg_descs));
-}
-
-static unsigned int num_demux_regs(void)
-{
-	return CSSELR_MAX;
-}
-
-static int write_demux_regids(u64 __user *uindices)
-{
-	u64 val = KVM_REG_ARM64 | KVM_REG_SIZE_U32 | KVM_REG_ARM_DEMUX;
-	unsigned int i;
-
-	val |= KVM_REG_ARM_DEMUX_ID_CCSIDR;
-	for (i = 0; i < CSSELR_MAX; i++) {
-		if (put_user(val | i, uindices))
-			return -EFAULT;
-		uindices++;
-	}
-	return 0;
-}
-
-static u64 sys_reg_to_index(const struct sys_reg_desc *reg)
-{
-	return (KVM_REG_ARM64 | KVM_REG_SIZE_U64 |
-		KVM_REG_ARM64_SYSREG |
-		(reg->Op0 << KVM_REG_ARM64_SYSREG_OP0_SHIFT) |
-		(reg->Op1 << KVM_REG_ARM64_SYSREG_OP1_SHIFT) |
-		(reg->CRn << KVM_REG_ARM64_SYSREG_CRN_SHIFT) |
-		(reg->CRm << KVM_REG_ARM64_SYSREG_CRM_SHIFT) |
-		(reg->Op2 << KVM_REG_ARM64_SYSREG_OP2_SHIFT));
-}
-
-static bool copy_reg_to_user(const struct sys_reg_desc *reg, u64 __user **uind)
-{
-	u64 idx;
-
-	if (!*uind)
-		return true;
-
-	switch (reg_to_encoding(reg)) {
-	case SYS_CNTV_CVAL_EL0:
-		idx = KVM_REG_ARM_TIMER_CVAL;
-		break;
-	case SYS_CNTVCT_EL0:
-		idx = KVM_REG_ARM_TIMER_CNT;
-		break;
-	default:
-		idx = sys_reg_to_index(reg);
-	}
-
-	if (put_user(idx, *uind))
-		return false;
-
-	(*uind)++;
-	return true;
-}
-
-static int walk_one_sys_reg(const struct kvm_vcpu *vcpu,
-			    const struct sys_reg_desc *rd,
-			    u64 __user **uind,
-			    unsigned int *total)
-{
-	/*
-	 * Ignore registers we trap but don't save,
-	 * and for which no custom user accessor is provided.
-	 */
-	if (!(rd->reg || rd->get_user))
-		return 0;
-
-	if (sysreg_hidden(vcpu, rd))
-		return 0;
-
-	if (!copy_reg_to_user(rd, uind))
-		return -EFAULT;
-
-	(*total)++;
-	return 0;
-}
-
-/* Assumed ordered tables, see kvm_sys_reg_table_init. */
-static int walk_sys_regs(struct kvm_vcpu *vcpu, u64 __user *uind)
-{
-	const struct sys_reg_desc *i2, *end2;
-	unsigned int total = 0;
-	int err;
-
-	i2 = sys_reg_descs;
-	end2 = sys_reg_descs + ARRAY_SIZE(sys_reg_descs);
 
-	while (i2 != end2) {
-		err = walk_one_sys_reg(vcpu, i2++, &uind, &total);
-		if (err)
-			return err;
-	}
-	return total;
+	return __kvm_arm_sys_reg_set_reg(vcpu, reg, ARRAY_SIZE(sys_reg_descs), sys_reg_descs);
 }
 
 unsigned long kvm_arm_num_sys_reg_descs(struct kvm_vcpu *vcpu)
 {
-	return num_demux_regs()
-		+ walk_sys_regs(vcpu, (u64 __user *)NULL);
-}
+	return __kvm_arm_num_sys_reg_descs(vcpu, ARRAY_SIZE(sys_reg_descs), sys_reg_descs);}
 
-int kvm_arm_copy_sys_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
+int kvm_arm_copy_sys_reg_indices(struct kvm_vcpu * vcpu, u64 __user * uindices)
 {
-	int err;
-
-	err = walk_sys_regs(vcpu, uindices);
-	if (err < 0)
-		return err;
-	uindices += err;
-
-	return write_demux_regids(uindices);
+	return __kvm_arm_copy_sys_reg_indices(
+		vcpu, uindices, ARRAY_SIZE(sys_reg_descs), sys_reg_descs);
 }
 
 #define KVM_ARM_FEATURE_ID_RANGE_INDEX(r)			\
diff --git a/arch/arm64/kvm/sys_regs.h b/arch/arm64/kvm/sys_regs.h
deleted file mode 100644
index 75d581050b09..000000000000
--- a/arch/arm64/kvm/sys_regs.h
+++ /dev/null
@@ -1,363 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2012,2013 - ARM Ltd
- * Author: Marc Zyngier <marc.zyngier@arm.com>
- *
- * Derived from arch/arm/kvm/coproc.h
- * Copyright (C) 2012 - Virtual Open Systems and Columbia University
- * Authors: Christoffer Dall <c.dall@virtualopensystems.com>
- */
-
-#ifndef __ARM64_KVM_SYS_REGS_LOCAL_H__
-#define __ARM64_KVM_SYS_REGS_LOCAL_H__
-
-#include <linux/bsearch.h>
-
-#define reg_to_encoding(x)						\
-	sys_reg((u32)(x)->Op0, (u32)(x)->Op1,				\
-		(u32)(x)->CRn, (u32)(x)->CRm, (u32)(x)->Op2)
-
-struct sys_reg_params {
-	u8	Op0;
-	u8	Op1;
-	u8	CRn;
-	u8	CRm;
-	u8	Op2;
-	u64	regval;
-	bool	is_write;
-};
-
-#define encoding_to_params(reg)						\
-	((struct sys_reg_params){ .Op0 = sys_reg_Op0(reg),		\
-				  .Op1 = sys_reg_Op1(reg),		\
-				  .CRn = sys_reg_CRn(reg),		\
-				  .CRm = sys_reg_CRm(reg),		\
-				  .Op2 = sys_reg_Op2(reg) })
-
-#define esr_sys64_to_params(esr)                                               \
-	((struct sys_reg_params){ .Op0 = ((esr) >> 20) & 3,                    \
-				  .Op1 = ((esr) >> 14) & 0x7,                  \
-				  .CRn = ((esr) >> 10) & 0xf,                  \
-				  .CRm = ((esr) >> 1) & 0xf,                   \
-				  .Op2 = ((esr) >> 17) & 0x7,                  \
-				  .is_write = !((esr) & 1) })
-
-#define esr_cp1x_32_to_params(esr)						\
-	((struct sys_reg_params){ .Op1 = ((esr) >> 14) & 0x7,			\
-				  .CRn = ((esr) >> 10) & 0xf,			\
-				  .CRm = ((esr) >> 1) & 0xf,			\
-				  .Op2 = ((esr) >> 17) & 0x7,			\
-				  .is_write = !((esr) & 1) })
-
-/*
- * The Feature ID space is defined as the System register space in AArch64
- * with op0==3, op1=={0, 1, 3}, CRn==0, CRm=={0-7}, op2=={0-7}.
- */
-static inline bool in_feat_id_space(struct sys_reg_params *p)
-{
-	return (p->Op0 == 3 && !(p->Op1 & 0b100) && p->Op1 != 2 &&
-		p->CRn == 0 && !(p->CRm & 0b1000));
-}
-
-struct sys_reg_desc {
-	/* Sysreg string for debug */
-	const char *name;
-
-	enum {
-		AA32_DIRECT,
-		AA32_LO,
-		AA32_HI,
-	} aarch32_map;
-
-	/* MRS/MSR instruction which accesses it. */
-	u8	Op0;
-	u8	Op1;
-	u8	CRn;
-	u8	CRm;
-	u8	Op2;
-
-	/* Trapped access from guest, if non-NULL. */
-	bool (*access)(struct kvm_vcpu *,
-		       struct sys_reg_params *,
-		       const struct sys_reg_desc *);
-
-	/*
-	 * Initialization for vcpu. Return initialized value, or KVM
-	 * sanitized value for ID registers.
-	 */
-	u64 (*reset)(struct kvm_vcpu *, const struct sys_reg_desc *);
-
-	/* Index into sys_reg[], or 0 if we don't need to save it. */
-	int reg;
-
-	/* Value (usually reset value), or write mask for idregs */
-	u64 val;
-
-	/* Custom get/set_user functions, fallback to generic if NULL */
-	int (*get_user)(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
-			u64 *val);
-	int (*set_user)(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
-			u64 val);
-
-	/* Return mask of REG_* runtime visibility overrides */
-	unsigned int (*visibility)(const struct kvm_vcpu *vcpu,
-				   const struct sys_reg_desc *rd);
-};
-
-#define REG_HIDDEN		(1 << 0) /* hidden from userspace and guest */
-#define REG_RAZ			(1 << 1) /* RAZ from userspace and guest */
-#define REG_USER_WI		(1 << 2) /* WI from userspace only */
-
-static inline unsigned int raz_visibility(const struct kvm_vcpu *vcpu,
-				   const struct sys_reg_desc *r)
-{
-	return REG_RAZ;
-}
-
-static __printf(2, 3)
-inline void print_sys_reg_msg(const struct sys_reg_params *p,
-				       char *fmt, ...)
-{
-	va_list va;
-
-	va_start(va, fmt);
-	/* Look, we even formatted it for you to paste into the table! */
-	kvm_pr_unimpl("%pV { Op0(%2u), Op1(%2u), CRn(%2u), CRm(%2u), Op2(%2u), func_%s },\n",
-		      &(struct va_format){ fmt, &va },
-		      p->Op0, p->Op1, p->CRn, p->CRm, p->Op2, str_write_read(p->is_write));
-	va_end(va);
-}
-
-static inline void print_sys_reg_instr(const struct sys_reg_params *p)
-{
-	/* GCC warns on an empty format string */
-	print_sys_reg_msg(p, "%s", "");
-}
-
-static inline bool ignore_write(struct kvm_vcpu *vcpu,
-				const struct sys_reg_params *p)
-{
-	return true;
-}
-
-static inline bool read_zero(struct kvm_vcpu *vcpu,
-			     struct sys_reg_params *p)
-{
-	p->regval = 0;
-	return true;
-}
-
-/* Reset functions */
-static inline u64 reset_unknown(struct kvm_vcpu *vcpu,
-				 const struct sys_reg_desc *r)
-{
-	BUG_ON(!r->reg);
-	BUG_ON(r->reg >= NR_SYS_REGS);
-	__vcpu_assign_sys_reg(vcpu, r->reg, 0x1de7ec7edbadc0deULL);
-	return __vcpu_sys_reg(vcpu, r->reg);
-}
-
-static inline u64 reset_val(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
-{
-	BUG_ON(!r->reg);
-	BUG_ON(r->reg >= NR_SYS_REGS);
-	__vcpu_assign_sys_reg(vcpu, r->reg, r->val);
-	return __vcpu_sys_reg(vcpu, r->reg);
-}
-
-static inline unsigned int sysreg_visibility(const struct kvm_vcpu *vcpu,
-					     const struct sys_reg_desc *r)
-{
-	if (likely(!r->visibility))
-		return 0;
-
-	return r->visibility(vcpu, r);
-}
-
-static inline bool sysreg_hidden(const struct kvm_vcpu *vcpu,
-				 const struct sys_reg_desc *r)
-{
-	return sysreg_visibility(vcpu, r) & REG_HIDDEN;
-}
-
-static inline bool sysreg_visible_as_raz(const struct kvm_vcpu *vcpu,
-					 const struct sys_reg_desc *r)
-{
-	return sysreg_visibility(vcpu, r) & REG_RAZ;
-}
-
-static inline bool sysreg_user_write_ignore(const struct kvm_vcpu *vcpu,
-					    const struct sys_reg_desc *r)
-{
-	return sysreg_visibility(vcpu, r) & REG_USER_WI;
-}
-
-static inline int cmp_sys_reg(const struct sys_reg_desc *i1,
-			      const struct sys_reg_desc *i2)
-{
-	BUG_ON(i1 == i2);
-	if (!i1)
-		return 1;
-	else if (!i2)
-		return -1;
-	if (i1->Op0 != i2->Op0)
-		return i1->Op0 - i2->Op0;
-	if (i1->Op1 != i2->Op1)
-		return i1->Op1 - i2->Op1;
-	if (i1->CRn != i2->CRn)
-		return i1->CRn - i2->CRn;
-	if (i1->CRm != i2->CRm)
-		return i1->CRm - i2->CRm;
-	return i1->Op2 - i2->Op2;
-}
-
-static inline int match_sys_reg(const void *key, const void *elt)
-{
-	const unsigned long pval = (unsigned long)key;
-	const struct sys_reg_desc *r = elt;
-
-	return pval - reg_to_encoding(r);
-}
-
-static inline const struct sys_reg_desc *
-find_reg(const struct sys_reg_params *params, const struct sys_reg_desc table[],
-	 unsigned int num)
-{
-	unsigned long pval = reg_to_encoding(params);
-
-	return __inline_bsearch((void *)pval, table, num, sizeof(table[0]), match_sys_reg);
-}
-
-const struct sys_reg_desc *get_reg_by_id(u64 id,
-					 const struct sys_reg_desc table[],
-					 unsigned int num);
-
-int kvm_arm_sys_reg_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *);
-int kvm_arm_sys_reg_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *);
-int kvm_sys_reg_get_user(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg,
-			 const struct sys_reg_desc table[], unsigned int num);
-int kvm_sys_reg_set_user(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg,
-			 const struct sys_reg_desc table[], unsigned int num);
-
-bool triage_sysreg_trap(struct kvm_vcpu *vcpu, int *sr_index);
-
-int kvm_finalize_sys_regs(struct kvm_vcpu *vcpu);
-
-u64 kvm_read_sanitised_id_reg(struct kvm_vcpu *vcpu,
-			      const struct sys_reg_desc *r);
-
-/* Implemented by each architecture */
-u64 kvm_sanitised_host_ftr_reg(u32 id);
-
-#define AA32(_x)	.aarch32_map = AA32_##_x
-#define Op0(_x) 	.Op0 = _x
-#define Op1(_x) 	.Op1 = _x
-#define CRn(_x)		.CRn = _x
-#define CRm(_x) 	.CRm = _x
-#define Op2(_x) 	.Op2 = _x
-
-#define SYS_DESC(reg)					\
-	.name = #reg,					\
-	Op0(sys_reg_Op0(reg)), Op1(sys_reg_Op1(reg)),	\
-	CRn(sys_reg_CRn(reg)), CRm(sys_reg_CRm(reg)),	\
-	Op2(sys_reg_Op2(reg))
-
-#define CP15_SYS_DESC(reg)				\
-	.name = #reg,					\
-	.aarch32_map = AA32_DIRECT,			\
-	Op0(0), Op1(sys_reg_Op1(reg)),			\
-	CRn(sys_reg_CRn(reg)), CRm(sys_reg_CRm(reg)),	\
-	Op2(sys_reg_Op2(reg))
-
-/*
- * Since reset() callback and field val are not used for idregs, they will be
- * used for specific purposes for idregs.
- * The reset() would return KVM sanitised register value. The value would be the
- * same as the host kernel sanitised value if there is no KVM sanitisation.
- * The val would be used as a mask indicating writable fields for the idreg.
- * Only bits with 1 are writable from userspace. This mask might not be
- * necessary in the future whenever all ID registers are enabled as writable
- * from userspace.
- */
-
-#define ID_DESC_DEFAULT_CALLBACKS		\
-	.access	= access_id_reg,		\
-	.get_user = get_id_reg,			\
-	.set_user = set_id_reg,			\
-	.visibility = id_visibility,		\
-	.reset = kvm_read_sanitised_id_reg
-
-#define ID_DESC(name)				\
-	SYS_DESC(SYS_##name),			\
-	ID_DESC_DEFAULT_CALLBACKS
-
-/* sys_reg_desc initialiser for known cpufeature ID registers */
-#define ID_SANITISED(name) {			\
-	ID_DESC(name),				\
-	.val = 0,				\
-}
-
-/* sys_reg_desc initialiser for writable ID registers */
-#define ID_WRITABLE(name, mask) {		\
-	ID_DESC(name),				\
-	.val = mask,				\
-}
-
-/*
- * 32bit ID regs are fully writable when the guest is 32bit
- * capable. Nothing in the KVM code should rely on 32bit features
- * anyway, only 64bit, so let the VMM do its worse.
- */
-#define AA32_ID_WRITABLE(name) {		\
-	ID_DESC(name),				\
-	.visibility = aa32_id_visibility,	\
-	.val = GENMASK(31, 0),			\
-}
-
-/* sys_reg_desc initialiser for cpufeature ID registers that need filtering */
-#define ID_FILTERED(sysreg, name, mask) {	\
-	ID_DESC(sysreg),				\
-	.set_user = set_##name,				\
-	.val = (mask),					\
-}
-
-/*
- * sys_reg_desc initialiser for architecturally unallocated cpufeature ID
- * register with encoding Op0=3, Op1=0, CRn=0, CRm=crm, Op2=op2
- * (1 <= crm < 8, 0 <= Op2 < 8).
- */
-#define ID_UNALLOCATED(crm, op2) {			\
-	.name = "S3_0_0_" #crm "_" #op2,		\
-	Op0(3), Op1(0), CRn(0), CRm(crm), Op2(op2),	\
-	ID_DESC_DEFAULT_CALLBACKS,			\
-	.visibility = raz_visibility,			\
-	.val = 0,					\
-}
-
-/*
- * sys_reg_desc initialiser for known ID registers that we hide from guests.
- * For now, these are exposed just like unallocated ID regs: they appear
- * RAZ for the guest.
- */
-#define ID_HIDDEN(name) {			\
-	ID_DESC(name),				\
-	.visibility = raz_visibility,		\
-	.val = 0,				\
-}
-#define ID_REG_LIMIT_FIELD_ENUM(val, reg, field, limit)			       \
-({									       \
-	u64 __f_val = FIELD_GET(reg##_##field##_MASK, val);		       \
-	(val) &= ~reg##_##field##_MASK;					       \
-	(val) |= FIELD_PREP(reg##_##field##_MASK,			       \
-			    min(__f_val,				       \
-				(u64)SYS_FIELD_VALUE(reg, field, limit)));     \
-	(val);								       \
-})
-
-#define TO_ARM64_SYS_REG(r)	ARM64_SYS_REG(sys_reg_Op0(SYS_ ## r),	\
-					      sys_reg_Op1(SYS_ ## r),	\
-					      sys_reg_CRn(SYS_ ## r),	\
-					      sys_reg_CRm(SYS_ ## r),	\
-					      sys_reg_Op2(SYS_ ## r))
-
-#endif /* __ARM64_KVM_SYS_REGS_LOCAL_H__ */
diff --git a/arch/arm64/kvm/trace_handle_exit.h b/arch/arm64/kvm/trace_handle_exit.h
index a7ab9a3bbed0..280d79469551 100644
--- a/arch/arm64/kvm/trace_handle_exit.h
+++ b/arch/arm64/kvm/trace_handle_exit.h
@@ -3,7 +3,7 @@
 #define _TRACE_HANDLE_EXIT_ARM64_KVM_H
 
 #include <linux/tracepoint.h>
-#include "sys_regs.h"
+#include <kvm/arm64/sys_regs.h>
 
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM kvm
@@ -82,40 +82,6 @@ TRACE_EVENT(kvm_handle_sys_reg,
 	TP_printk("HSR 0x%08lx", __entry->hsr)
 );
 
-TRACE_EVENT(kvm_sys_access,
-	TP_PROTO(unsigned long vcpu_pc, struct sys_reg_params *params, const struct sys_reg_desc *reg),
-	TP_ARGS(vcpu_pc, params, reg),
-
-	TP_STRUCT__entry(
-		__field(unsigned long,			vcpu_pc)
-		__field(bool,				is_write)
-		__field(const char *,			name)
-		__field(u8,				Op0)
-		__field(u8,				Op1)
-		__field(u8,				CRn)
-		__field(u8,				CRm)
-		__field(u8,				Op2)
-	),
-
-	TP_fast_assign(
-		__entry->vcpu_pc = vcpu_pc;
-		__entry->is_write = params->is_write;
-		__entry->name = reg->name;
-		__entry->Op0 = reg->Op0;
-		__entry->Op0 = reg->Op0;
-		__entry->Op1 = reg->Op1;
-		__entry->CRn = reg->CRn;
-		__entry->CRm = reg->CRm;
-		__entry->Op2 = reg->Op2;
-	),
-
-	TP_printk("PC: %lx %s (%d,%d,%d,%d,%d) %s",
-		  __entry->vcpu_pc, __entry->name ?: "UNKN",
-		  __entry->Op0, __entry->Op1, __entry->CRn,
-		  __entry->CRm, __entry->Op2,
-		  str_write_read(__entry->is_write))
-);
-
 TRACE_EVENT(kvm_set_guest_debug,
 	TP_PROTO(struct kvm_vcpu *vcpu, __u32 guest_debug),
 	TP_ARGS(vcpu, guest_debug),
diff --git a/arch/arm64/kvm/vgic-sys-reg-v3.c b/arch/arm64/kvm/vgic-sys-reg-v3.c
index bdc2d57370b2..b6cbe8ea679e 100644
--- a/arch/arm64/kvm/vgic-sys-reg-v3.c
+++ b/arch/arm64/kvm/vgic-sys-reg-v3.c
@@ -8,7 +8,7 @@
 #include <linux/kvm_host.h>
 #include <asm/kvm_emulate.h>
 #include "vgic/vgic.h"
-#include "sys_regs.h"
+#include <kvm/arm64/sys_regs.h>
 
 static int set_gic_ctlr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
 			u64 val)
diff --git a/arch/arm64/kvm/vgic/vgic-init.c b/arch/arm64/kvm/vgic/vgic-init.c
index 933983bb2005..d75c32f6909e 100644
--- a/arch/arm64/kvm/vgic/vgic-init.c
+++ b/arch/arm64/kvm/vgic/vgic-init.c
@@ -10,6 +10,7 @@
 #include <kvm/arm_vgic.h>
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_mmu.h>
+#include <kvm/arm64/sys_regs.h>
 #include "vgic.h"
 
 /*
diff --git a/arch/s390/include/asm/kvm_host_arm64.h b/arch/s390/include/asm/kvm_host_arm64.h
index d6d9e3ad7a8e..fcbe510cb868 100644
--- a/arch/s390/include/asm/kvm_host_arm64.h
+++ b/arch/s390/include/asm/kvm_host_arm64.h
@@ -145,6 +145,8 @@ struct kvm_arch {
 	DECLARE_BITMAP(vcpu_features, KVM_VCPU_MAX_FEATURES);
 
 	unsigned long mem_limit;
+
+	struct kvm_vm_id_regs id_regs;
 };
 
 static inline bool __vcpu_has_feature(const struct kvm_arch *ka, int feature)
@@ -218,9 +220,6 @@ static inline void kvm_arch_async_page_present_queued(struct kvm_vcpu *vcpu)
 
 #define kvm_supports_32bit_el0() false
 
-#define vcpu_read_sys_reg(_v, _r) 0xbad1234bad
-#define vcpu_write_sys_reg(_v, _p, _r) ((void)0)
-
 #define __vcpu_sys_reg(__vcpu, __reg) \
 	vcpu_read_sys_reg(__vcpu, __reg)
 
diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
index 636bbeda98a8..48418c46e451 100644
--- a/arch/s390/kvm/arm64/arm.c
+++ b/arch/s390/kvm/arm64/arm.c
@@ -690,6 +690,15 @@ long kvm_arch_vcpu_unlocked_ioctl(struct file *filp, unsigned int ioctl,
 	return -ENOIOCTLCMD;
 }
 
+void vcpu_write_sys_reg(struct kvm_vcpu *vcpu, u64 val, enum vcpu_sysreg reg)
+{
+}
+
+u64 vcpu_read_sys_reg(const struct kvm_vcpu *vcpu, enum vcpu_sysreg reg)
+{
+	return 0xbad12324bad;
+}
+
 static int __init kvm_s390_arm64_init(void)
 {
 	if (!sclp.has_aef) {
diff --git a/include/kvm/arm64/kvm_host.h b/include/kvm/arm64/kvm_host.h
index 379942225d5f..deb115a737b5 100644
--- a/include/kvm/arm64/kvm_host.h
+++ b/include/kvm/arm64/kvm_host.h
@@ -233,7 +233,17 @@ int io_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa);
 /* Unhandled SEAs are taken to userspace */
 #define KVM_ARCH_FLAG_EXIT_SEA				11
 
+#define kvm_vm_has_ran_once(kvm)					\
+	(test_bit(KVM_ARCH_FLAG_HAS_RAN_ONCE, &(kvm)->arch.flags))
+
 /* Implemented in architecture specific code */
 unsigned long system_supported_vcpu_features(void);
 
+enum vcpu_sysreg;
+void vcpu_write_sys_reg(struct kvm_vcpu *vcpu, u64 val, enum vcpu_sysreg reg);
+u64 vcpu_read_sys_reg(const struct kvm_vcpu *vcpu, enum vcpu_sysreg reg);
+
+int kvm_handle_sys_reg(struct kvm_vcpu *vcpu);
+void kvm_reset_sys_regs(struct kvm_vcpu *vcpu);
+
 #endif /* __KVM_ARM64_KVM_HOST_H */
diff --git a/include/kvm/arm64/sys_regs.h b/include/kvm/arm64/sys_regs.h
new file mode 100644
index 000000000000..ca652274072a
--- /dev/null
+++ b/include/kvm/arm64/sys_regs.h
@@ -0,0 +1,548 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2012,2013 - ARM Ltd
+ * Author: Marc Zyngier <marc.zyngier@arm.com>
+ *
+ * Derived from arch/arm/kvm/coproc.h
+ * Copyright (C) 2012 - Virtual Open Systems and Columbia University
+ * Authors: Christoffer Dall <c.dall@virtualopensystems.com>
+ */
+
+#ifndef __ARM64_KVM_SYS_REGS_LOCAL_H__
+#define __ARM64_KVM_SYS_REGS_LOCAL_H__
+
+#include <linux/bsearch.h>
+
+#include <asm/kvm_emulate.h>
+
+#define reg_to_encoding(x)						\
+	sys_reg((u32)(x)->Op0, (u32)(x)->Op1,				\
+		(u32)(x)->CRn, (u32)(x)->CRm, (u32)(x)->Op2)
+
+struct sys_reg_params {
+	u8	Op0;
+	u8	Op1;
+	u8	CRn;
+	u8	CRm;
+	u8	Op2;
+	u64	regval;
+	bool	is_write;
+};
+
+#define encoding_to_params(reg)						\
+	((struct sys_reg_params){ .Op0 = sys_reg_Op0(reg),		\
+				  .Op1 = sys_reg_Op1(reg),		\
+				  .CRn = sys_reg_CRn(reg),		\
+				  .CRm = sys_reg_CRm(reg),		\
+				  .Op2 = sys_reg_Op2(reg) })
+
+#define esr_sys64_to_params(esr)                                               \
+	((struct sys_reg_params){ .Op0 = ((esr) >> 20) & 3,                    \
+				  .Op1 = ((esr) >> 14) & 0x7,                  \
+				  .CRn = ((esr) >> 10) & 0xf,                  \
+				  .CRm = ((esr) >> 1) & 0xf,                   \
+				  .Op2 = ((esr) >> 17) & 0x7,                  \
+				  .is_write = !((esr) & 1) })
+
+#define esr_cp1x_32_to_params(esr)						\
+	((struct sys_reg_params){ .Op1 = ((esr) >> 14) & 0x7,			\
+				  .CRn = ((esr) >> 10) & 0xf,			\
+				  .CRm = ((esr) >> 1) & 0xf,			\
+				  .Op2 = ((esr) >> 17) & 0x7,			\
+				  .is_write = !((esr) & 1) })
+
+/*
+ * The Feature ID space is defined as the System register space in AArch64
+ * with op0==3, op1=={0, 1, 3}, CRn==0, CRm=={0-7}, op2=={0-7}.
+ */
+static inline bool in_feat_id_space(struct sys_reg_params *p)
+{
+	return (p->Op0 == 3 && !(p->Op1 & 0b100) && p->Op1 != 2 &&
+		p->CRn == 0 && !(p->CRm & 0b1000));
+}
+
+struct sys_reg_desc {
+	/* Sysreg string for debug */
+	const char *name;
+
+	enum {
+		AA32_DIRECT,
+		AA32_LO,
+		AA32_HI,
+	} aarch32_map;
+
+	/* MRS/MSR instruction which accesses it. */
+	u8	Op0;
+	u8	Op1;
+	u8	CRn;
+	u8	CRm;
+	u8	Op2;
+
+	/* Trapped access from guest, if non-NULL. */
+	bool (*access)(struct kvm_vcpu *,
+		       struct sys_reg_params *,
+		       const struct sys_reg_desc *);
+
+	/*
+	 * Initialization for vcpu. Return initialized value, or KVM
+	 * sanitized value for ID registers.
+	 */
+	u64 (*reset)(struct kvm_vcpu *, const struct sys_reg_desc *);
+
+	/* Index into sys_reg[], or 0 if we don't need to save it. */
+	int reg;
+
+	/* Value (usually reset value), or write mask for idregs */
+	u64 val;
+
+	/* Custom get/set_user functions, fallback to generic if NULL */
+	int (*get_user)(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
+			u64 *val);
+	int (*set_user)(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
+			u64 val);
+
+	/* Return mask of REG_* runtime visibility overrides */
+	unsigned int (*visibility)(const struct kvm_vcpu *vcpu,
+				   const struct sys_reg_desc *rd);
+};
+
+#define REG_HIDDEN		(1 << 0) /* hidden from userspace and guest */
+#define REG_RAZ			(1 << 1) /* RAZ from userspace and guest */
+#define REG_USER_WI		(1 << 2) /* WI from userspace only */
+
+static inline unsigned int raz_visibility(const struct kvm_vcpu *vcpu,
+				   const struct sys_reg_desc *r)
+{
+	return REG_RAZ;
+}
+
+static __printf(2, 3)
+inline void print_sys_reg_msg(const struct sys_reg_params *p,
+				       char *fmt, ...)
+{
+	va_list va;
+
+	va_start(va, fmt);
+	/* Look, we even formatted it for you to paste into the table! */
+	kvm_pr_unimpl("%pV { Op0(%2u), Op1(%2u), CRn(%2u), CRm(%2u), Op2(%2u), func_%s },\n",
+		      &(struct va_format){ fmt, &va },
+		      p->Op0, p->Op1, p->CRn, p->CRm, p->Op2, str_write_read(p->is_write));
+	va_end(va);
+}
+
+static inline void print_sys_reg_instr(const struct sys_reg_params *p)
+{
+	/* GCC warns on an empty format string */
+	print_sys_reg_msg(p, "%s", "");
+}
+
+static inline bool ignore_write(struct kvm_vcpu *vcpu,
+				const struct sys_reg_params *p)
+{
+	return true;
+}
+
+static inline bool read_zero(struct kvm_vcpu *vcpu,
+			     struct sys_reg_params *p)
+{
+	p->regval = 0;
+	return true;
+}
+
+/* Reset functions */
+static inline u64 reset_unknown(struct kvm_vcpu *vcpu,
+				 const struct sys_reg_desc *r)
+{
+	BUG_ON(!r->reg);
+	BUG_ON(r->reg >= NR_SYS_REGS);
+	__vcpu_assign_sys_reg(vcpu, r->reg, 0x1de7ec7edbadc0deULL);
+	return __vcpu_sys_reg(vcpu, r->reg);
+}
+
+static inline u64 reset_val(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
+{
+	BUG_ON(!r->reg);
+	BUG_ON(r->reg >= NR_SYS_REGS);
+	__vcpu_assign_sys_reg(vcpu, r->reg, r->val);
+	return __vcpu_sys_reg(vcpu, r->reg);
+}
+
+static inline unsigned int sysreg_visibility(const struct kvm_vcpu *vcpu,
+					     const struct sys_reg_desc *r)
+{
+	if (likely(!r->visibility))
+		return 0;
+
+	return r->visibility(vcpu, r);
+}
+
+static inline bool sysreg_hidden(const struct kvm_vcpu *vcpu,
+				 const struct sys_reg_desc *r)
+{
+	return sysreg_visibility(vcpu, r) & REG_HIDDEN;
+}
+
+static inline bool sysreg_visible_as_raz(const struct kvm_vcpu *vcpu,
+					 const struct sys_reg_desc *r)
+{
+	return sysreg_visibility(vcpu, r) & REG_RAZ;
+}
+
+static inline bool sysreg_user_write_ignore(const struct kvm_vcpu *vcpu,
+					    const struct sys_reg_desc *r)
+{
+	return sysreg_visibility(vcpu, r) & REG_USER_WI;
+}
+
+static inline int cmp_sys_reg(const struct sys_reg_desc *i1,
+			      const struct sys_reg_desc *i2)
+{
+	BUG_ON(i1 == i2);
+	if (!i1)
+		return 1;
+	else if (!i2)
+		return -1;
+	if (i1->Op0 != i2->Op0)
+		return i1->Op0 - i2->Op0;
+	if (i1->Op1 != i2->Op1)
+		return i1->Op1 - i2->Op1;
+	if (i1->CRn != i2->CRn)
+		return i1->CRn - i2->CRn;
+	if (i1->CRm != i2->CRm)
+		return i1->CRm - i2->CRm;
+	return i1->Op2 - i2->Op2;
+}
+
+static inline int match_sys_reg(const void *key, const void *elt)
+{
+	const unsigned long pval = (unsigned long)key;
+	const struct sys_reg_desc *r = elt;
+
+	return pval - reg_to_encoding(r);
+}
+
+static inline const struct sys_reg_desc *
+find_reg(const struct sys_reg_params *params, const struct sys_reg_desc table[],
+	 unsigned int num)
+{
+	unsigned long pval = reg_to_encoding(params);
+
+	return __inline_bsearch((void *)pval, table, num, sizeof(table[0]), match_sys_reg);
+}
+
+const struct sys_reg_desc *get_reg_by_id(u64 id,
+					 const struct sys_reg_desc table[],
+					 unsigned int num);
+
+int kvm_sys_reg_get_user(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg,
+			 const struct sys_reg_desc table[], unsigned int num);
+int kvm_sys_reg_set_user(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg,
+			 const struct sys_reg_desc table[], unsigned int num);
+
+bool triage_sysreg_trap(struct kvm_vcpu *vcpu, int *sr_index);
+
+int kvm_finalize_sys_regs(struct kvm_vcpu *vcpu);
+
+
+int __kvm_arm_sys_reg_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg,
+			      size_t n_descs,
+			      const struct sys_reg_desc sys_reg_descs[n_descs])
+;
+
+int __kvm_arm_sys_reg_set_reg(struct kvm_vcpu *vcpu, 
+			      const struct kvm_one_reg *reg,
+			      size_t n_descs,
+			      const struct sys_reg_desc sys_reg_descs[n_descs]);
+unsigned long __kvm_arm_num_sys_reg_descs(struct kvm_vcpu *vcpu, size_t n_descs,
+					  const struct sys_reg_desc sys_reg_descs[n_descs]);
+int __kvm_arm_copy_sys_reg_indices(struct kvm_vcpu *vcpu,
+				   u64 __user *uindices,
+				   size_t n_descs,
+				   const struct sys_reg_desc sys_reg_descs[n_descs]);
+int get_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd, u64 *val);
+int set_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd, u64 val);
+bool access_id_reg(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
+		   const struct sys_reg_desc *r);
+int set_id_aa64mmfr0_el1(struct kvm_vcpu *vcpu,
+			 const struct sys_reg_desc *rd,
+			 u64 user_val);
+unsigned int id_visibility(const struct kvm_vcpu *vcpu,
+			   const struct sys_reg_desc *r);
+unsigned int aa32_id_visibility(const struct kvm_vcpu *vcpu,
+				const struct sys_reg_desc *r);
+int set_imp_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
+		   u64 val);
+void kvm_set_vm_id_reg(struct kvm *kvm, u32 reg, u64 val);
+int set_ctr_el0(struct kvm_vcpu *vcpu, 
+		const struct sys_reg_desc *rd,
+		u64 user_val);
+bool trap_oslar_el1(struct kvm_vcpu *vcpu,
+		    struct sys_reg_params *p,
+		    const struct sys_reg_desc *r);
+bool trap_oslsr_el1(struct kvm_vcpu *vcpu,
+		    struct sys_reg_params *p,
+		    const struct sys_reg_desc *r);
+int set_oslsr_el1(struct kvm_vcpu *vcpu,
+		  const struct sys_reg_desc *rd,
+		  u64 val);
+
+bool trap_raz_wi(struct kvm_vcpu *vcpu,
+		 struct sys_reg_params *p,
+		 const struct sys_reg_desc *r);
+ u64 reset_mpidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r);
+ bool access_rw(struct kvm_vcpu *vcpu,
+		struct sys_reg_params *p,
+		const struct sys_reg_desc *r);
+bool access_clidr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
+		  const struct sys_reg_desc *r);
+u64 reset_clidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r);
+int set_clidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd, u64 val);
+bool access_csselr(struct kvm_vcpu *vcpu,
+		   struct sys_reg_params *p,
+		   const struct sys_reg_desc *r);
+u32 get_ccsidr(struct kvm_vcpu *vcpu, u32 csselr);
+int set_ccsidr(struct kvm_vcpu *vcpu, u32 csselr, u32 val);
+bool access_ccsidr(struct kvm_vcpu *vcpu,
+		   struct sys_reg_params *p,
+		   const struct sys_reg_desc *r);
+void perform_access(struct kvm_vcpu *vcpu,
+		    struct sys_reg_params *params,
+		    const struct sys_reg_desc *r);
+
+void reset_vm_ftr_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *reg);
+void reset_vcpu_ftr_id_reg(struct kvm_vcpu *vcpu,
+			   const struct sys_reg_desc *reg);
+bool check_sysreg_table(const struct sys_reg_desc *table, unsigned int n,
+			bool reset_check);
+
+static inline u64 read_id_reg(const struct kvm_vcpu *vcpu,
+			      const struct sys_reg_desc *r)
+{
+	return kvm_read_vm_id_reg(vcpu->kvm, reg_to_encoding(r));
+}
+
+static bool is_feature_id_reg(u32 encoding)
+{
+	return (sys_reg_Op0(encoding) == 3 &&
+		(sys_reg_Op1(encoding) < 2 || sys_reg_Op1(encoding) == 3) &&
+		sys_reg_CRn(encoding) == 0 &&
+		sys_reg_CRm(encoding) <= 7);
+}
+
+static inline bool undef_access(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
+				const struct sys_reg_desc *r)
+{
+	kvm_inject_undefined(vcpu);
+	return false;
+}
+
+static inline bool bad_trap(struct kvm_vcpu *vcpu,
+			    struct sys_reg_params *params,
+			    const struct sys_reg_desc *r, const char *msg)
+{
+	WARN_ONCE(1, "Unexpected %s\n", msg);
+	print_sys_reg_instr(params);
+	return undef_access(vcpu, params, r);
+}
+
+static inline bool read_from_write_only(struct kvm_vcpu *vcpu,
+					struct sys_reg_params *params,
+					const struct sys_reg_desc *r)
+{
+	return bad_trap(vcpu, params, r,
+			"sys_reg read to write-only register");
+}
+
+static inline bool write_to_read_only(struct kvm_vcpu *vcpu,
+				      struct sys_reg_params *params,
+				      const struct sys_reg_desc *r)
+{
+	return bad_trap(vcpu, params, r,
+			"sys_reg write to read-only register");
+}
+
+static inline void get_access_mask(const struct sys_reg_desc *r, u64 *mask, u64 *shift)
+{
+	switch (r->aarch32_map) {
+	case AA32_LO:
+		*mask = GENMASK_ULL(31, 0);
+		*shift = 0;
+		break;
+	case AA32_HI:
+		*mask = GENMASK_ULL(63, 32);
+		*shift = 32;
+		break;
+	default:
+		*mask = GENMASK_ULL(63, 0);
+		*shift = 0;
+		break;
+	}
+}
+
+/*
+ * Return true if the register's (Op0, Op1, CRn, CRm, Op2) is
+ * (3, 0, 0, crm, op2), where 1<=crm<8, 0<=op2<8, which is the range of ID
+ * registers KVM maintains on a per-VM basis.
+ *
+ * Additionally, the implementation ID registers and CTR_EL0 are handled as
+ * per-VM registers.
+ */
+static inline bool is_vm_ftr_id_reg(u32 id)
+{
+	switch (id) {
+	case SYS_CTR_EL0:
+	case SYS_MIDR_EL1:
+	case SYS_REVIDR_EL1:
+	case SYS_AIDR_EL1:
+		return true;
+	default:
+		return (sys_reg_Op0(id) == 3 && sys_reg_Op1(id) == 0 &&
+			sys_reg_CRn(id) == 0 && sys_reg_CRm(id) >= 1 &&
+			sys_reg_CRm(id) < 8);
+	}
+}
+
+static inline bool is_vcpu_ftr_id_reg(u32 id)
+{
+	return is_feature_id_reg(id) && !is_vm_ftr_id_reg(id);
+}
+
+#define AA32(_x) .aarch32_map = AA32_##_x
+#define Op0(_x) .Op0 = _x
+#define Op1(_x) .Op1 = _x
+#define CRn(_x) .CRn = _x
+#define CRm(_x) .CRm = _x
+#define Op2(_x) .Op2 = _x
+
+#define SYS_DESC(reg)                                               \
+	 .name = #reg, Op0(sys_reg_Op0(reg)), Op1(sys_reg_Op1(reg)), \
+	 CRn(sys_reg_CRn(reg)), CRm(sys_reg_CRm(reg)), Op2(sys_reg_Op2(reg))
+
+#define CP15_SYS_DESC(reg)                                                    \
+	 .name = #reg, .aarch32_map = AA32_DIRECT, Op0(0),                    \
+	 Op1(sys_reg_Op1(reg)), CRn(sys_reg_CRn(reg)), CRm(sys_reg_CRm(reg)), \
+	 Op2(sys_reg_Op2(reg))
+
+/*
+ * Since reset() callback and field val are not used for idregs, they will be
+ * used for specific purposes for idregs.
+ * The reset() would return KVM sanitised register value. The value would be the
+ * same as the host kernel sanitised value if there is no KVM sanitisation.
+ * The val would be used as a mask indicating writable fields for the idreg.
+ * Only bits with 1 are writable from userspace. This mask might not be
+ * necessary in the future whenever all ID registers are enabled as writable
+ * from userspace.
+ */
+
+#define ID_DESC_DEFAULT_CALLBACKS                             \
+	 .access = access_id_reg, .get_user = get_id_reg,     \
+	 .set_user = set_id_reg, .visibility = id_visibility, \
+	 .reset = kvm_read_sanitised_id_reg
+
+#define ID_DESC(name) SYS_DESC(SYS_##name), ID_DESC_DEFAULT_CALLBACKS
+
+/* sys_reg_desc initialiser for known cpufeature ID registers */
+#define ID_SANITISED(name)      \
+	{                       \
+		 ID_DESC(name), \
+		 .val = 0,      \
+	}
+
+/* sys_reg_desc initialiser for writable ID registers */
+#define ID_WRITABLE(name, mask) \
+	{                       \
+		 ID_DESC(name), \
+		 .val = mask,   \
+	}
+
+/*
+ * 32bit ID regs are fully writable when the guest is 32bit
+ * capable. Nothing in the KVM code should rely on 32bit features
+ * anyway, only 64bit, so let the VMM do its worse.
+ */
+#define AA32_ID_WRITABLE(name)                     \
+	{                                          \
+		 ID_DESC(name),                    \
+		 .visibility = aa32_id_visibility, \
+		 .val = GENMASK(31, 0),            \
+	}
+
+/* sys_reg_desc initialiser for cpufeature ID registers that need filtering */
+#define ID_FILTERED(sysreg, name, mask)  \
+	{                                \
+		 ID_DESC(sysreg),        \
+		 .set_user = set_##name, \
+		 .val = (mask),          \
+	}
+
+/*
+ * sys_reg_desc initialiser for architecturally unallocated cpufeature ID
+ * register with encoding Op0=3, Op1=0, CRn=0, CRm=crm, Op2=op2
+ * (1 <= crm < 8, 0 <= Op2 < 8).
+ */
+#define ID_UNALLOCATED(crm, op2)                 \
+	 {                                        \
+		 .name = "S3_0_0_" #crm "_" #op2, \
+		 Op0(3),                          \
+		 Op1(0),                          \
+		 CRn(0),                          \
+		 CRm(crm),                        \
+		 Op2(op2),                        \
+		 ID_DESC_DEFAULT_CALLBACKS,       \
+		 .visibility = raz_visibility,    \
+		 .val = 0,                        \
+	 }
+
+/*
+ * sys_reg_desc initialiser for known ID registers that we hide from guests.
+ * For now, these are exposed just like unallocated ID regs: they appear
+ * RAZ for the guest.
+ */
+#define ID_HIDDEN(name)                       \
+	 {                                     \
+		 ID_DESC(name),                \
+		 .visibility = raz_visibility, \
+		 .val = 0,                     \
+	}
+#define ID_REG_LIMIT_FIELD_ENUM(val, reg, field, limit)                 \
+	 ({                                                             \
+		u64 __f_val = FIELD_GET(reg##_##field##_MASK, val);     \
+		(val) &= ~reg##_##field##_MASK;                         \
+		(val) |= FIELD_PREP(                                    \
+			 reg##_##field##_MASK,                          \
+			 min(__f_val,                                   \
+			     (u64)SYS_FIELD_VALUE(reg, field, limit))); \
+		 (val);                                                 \
+	 })
+
+#define TO_ARM64_SYS_REG(r)                                       \
+	 ARM64_SYS_REG(sys_reg_Op0(SYS_##r), sys_reg_Op1(SYS_##r), \
+		       sys_reg_CRn(SYS_##r), sys_reg_CRm(SYS_##r), \
+		       sys_reg_Op2(SYS_##r))
+
+#define IMPLEMENTATION_ID(reg, mask) {			\
+	SYS_DESC(SYS_##reg),				\
+	.access = access_imp_id_reg,			\
+	.get_user = get_id_reg,				\
+	.set_user = set_imp_id_reg,			\
+	.reset = reset_imp_id_reg,			\
+	.val = mask,					\
+	}
+
+/* Implemented by each architecture */
+int arm64_check_features(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
+			 u64 val);
+u64 kvm_sanitised_host_ftr_reg(u32 id);
+bool access_imp_id_reg(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
+		       const struct sys_reg_desc *r);
+u64 reset_imp_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r);
+
+u64 kvm_read_sanitised_id_reg(struct kvm_vcpu *vcpu,
+			      const struct sys_reg_desc *r);
+
+int kvm_arm_sys_reg_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg * reg);
+int kvm_arm_sys_reg_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg * reg);
+unsigned long kvm_arm_num_sys_reg_descs(struct kvm_vcpu *vcpu);
+int kvm_arm_copy_sys_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices);
+
+#endif /* __ARM64_KVM_SYS_REGS_LOCAL_H__ */
diff --git a/virt/kvm/arm64/mmio.c b/virt/kvm/arm64/mmio.c
index 438a554ec1ed..089ee364df87 100644
--- a/virt/kvm/arm64/mmio.c
+++ b/virt/kvm/arm64/mmio.c
@@ -6,6 +6,7 @@
 
 #include <linux/kvm_host.h>
 #include <asm/kvm_emulate.h>
+#include <kvm/arm64/sys_regs.h>
 #include <trace/events/kvm.h>
 
 #define CREATE_TRACE_POINTS
diff --git a/virt/kvm/arm64/sys_regs.c b/virt/kvm/arm64/sys_regs.c
new file mode 100644
index 000000000000..70664bd7d339
--- /dev/null
+++ b/virt/kvm/arm64/sys_regs.c
@@ -0,0 +1,1039 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/kvm_host.h>
+
+#include <asm/sysreg-defs.h>
+#include <asm/kvm_emulate.h>
+#include <asm/kvm_nested.h>
+#include <asm/cputype-defs.h>
+#include <asm/cache-defs.h>
+
+#include <kvm/arm64/sys_regs.h>
+
+#include "trace.h"
+/*
+ * Statically sanitise the host's feature register, independent of the guest's
+ * configuration and host implementation.
+ */
+static u64 kvm_max_possible_guest_ftr_reg(u32 id, u64 val)
+{
+	switch (id) {
+	case SYS_ID_AA64DFR0_EL1:
+		val = ID_REG_LIMIT_FIELD_ENUM(val, ID_AA64DFR0_EL1, DebugVer, V8P8);
+
+		/* Hide SPE from guests */
+		val &= ~ID_AA64DFR0_EL1_PMSVer_MASK;
+
+		/* Hide BRBE from guests */
+		val &= ~ID_AA64DFR0_EL1_BRBE_MASK;
+		break;
+	case SYS_ID_AA64ISAR2_EL1:
+		/* Mask WFxT field unless *both* WFET & WFIT are present. */
+		if (!id_has_feat(val, ID_AA64ISAR2_EL1, WFxT, IMP))
+			val &= ~ID_AA64ISAR2_EL1_WFxT;
+		break;
+	case SYS_ID_AA64ISAR3_EL1:
+		val &= ID_AA64ISAR3_EL1_FPRCVT | ID_AA64ISAR3_EL1_LSFE |
+		       ID_AA64ISAR3_EL1_FAMINMAX | ID_AA64ISAR3_EL1_LSUI;
+		break;
+	case SYS_ID_AA64MMFR2_EL1:
+		val &= ~ID_AA64MMFR2_EL1_CCIDX_MASK;
+		val &= ~ID_AA64MMFR2_EL1_NV;
+		break;
+	case SYS_ID_AA64MMFR3_EL1:
+		val &= ID_AA64MMFR3_EL1_TCRX |
+		       ID_AA64MMFR3_EL1_SCTLRX |
+		       ID_AA64MMFR3_EL1_S1POE |
+		       ID_AA64MMFR3_EL1_S1PIE;
+		break;
+	case SYS_ID_MMFR4_EL1:
+		val &= ~ID_MMFR4_EL1_CCIDX;
+		break;
+	case SYS_ID_AA64PFR0_EL1:
+		val &= ~ID_AA64PFR0_EL1_AMU_MASK;
+		/*
+		 * MPAM is disabled by default as KVM also needs a set of PARTID to
+		 * program the MPAMVPMx_EL2 PARTID remapping registers with. But some
+		 * older kernels let the guest see the ID bit.
+		 */
+		val &= ~ID_AA64PFR0_EL1_MPAM_MASK;
+		break;
+	case SYS_ID_AA64PFR1_EL1:
+		val &= ~ID_AA64PFR1_EL1_SME;
+		val &= ~ID_AA64PFR1_EL1_RNDR_trap;
+		val &= ~ID_AA64PFR1_EL1_NMI;
+		val &= ~ID_AA64PFR1_EL1_GCS;
+		val &= ~ID_AA64PFR1_EL1_THE;
+		val &= ~ID_AA64PFR1_EL1_MTEX;
+		val &= ~ID_AA64PFR1_EL1_PFAR;
+		val &= ~ID_AA64PFR1_EL1_MPAM_frac;
+		break;
+	case SYS_ID_AA64PFR2_EL1:
+		val &= ID_AA64PFR2_EL1_FPMR |
+		       ID_AA64PFR2_EL1_MTEFAR |
+		       ID_AA64PFR2_EL1_MTESTOREONLY;
+		break;
+	}
+
+	return val;
+}
+
+/*
+ * Sanitise based on vCPU configuration.
+ */
+static u64 kvm_sanitise_vcpu_ftr_reg(const struct kvm_vcpu *vcpu, u32 id, u64 val)
+{
+	switch (id) {
+	case SYS_ID_AA64DFR0_EL1:
+		/*
+		 * Only initialize the PMU version if the vCPU was configured with one.
+		 */
+		val &= ~ID_AA64DFR0_EL1_PMUVer_MASK;
+		if (kvm_vcpu_has_pmu(vcpu))
+			val |= SYS_FIELD_PREP(ID_AA64DFR0_EL1, PMUVer,
+					      kvm_arm_pmu_get_pmuver_limit());
+		break;
+	case SYS_ID_AA64PFR0_EL1:
+		if (!vcpu_has_sve(vcpu))
+			val &= ~ID_AA64PFR0_EL1_SVE_MASK;
+		break;
+	case SYS_ID_AA64PFR1_EL1:
+		if (!kvm_has_mte(vcpu->kvm)) {
+			val &= ~ID_AA64PFR1_EL1_MTE;
+			val &= ~ID_AA64PFR1_EL1_MTE_frac;
+		}
+		break;
+	case SYS_ID_AA64PFR2_EL1:
+		if (!kvm_has_mte(vcpu->kvm))
+			val &= ~(ID_AA64PFR2_EL1_MTEFAR |
+				 ID_AA64PFR2_EL1_MTESTOREONLY);
+		break;
+	case SYS_ID_AA64ISAR1_EL1:
+		if (!vcpu_has_ptrauth(vcpu))
+			val &= ~(ID_AA64ISAR1_EL1_APA |
+				 ID_AA64ISAR1_EL1_API |
+				 ID_AA64ISAR1_EL1_GPA |
+				 ID_AA64ISAR1_EL1_GPI);
+		break;
+	case SYS_ID_AA64ISAR2_EL1:
+		if (!vcpu_has_ptrauth(vcpu))
+			val &= ~(ID_AA64ISAR2_EL1_APA3 |
+				 ID_AA64ISAR2_EL1_GPA3);
+		break;
+	}
+
+	if (vcpu_has_nv(vcpu))
+		val = limit_nv_id_reg(vcpu->kvm, id, val);
+
+	return val;
+}
+
+/* Read a sanitised cpufeature ID register by sys_reg_desc */
+static u64 __kvm_read_sanitised_id_reg(const struct kvm_vcpu *vcpu,
+				       const struct sys_reg_desc *r)
+{
+	u32 id = reg_to_encoding(r);
+	u64 val;
+
+	if (sysreg_visible_as_raz(vcpu, r))
+		return 0;
+
+	val = kvm_sanitised_host_ftr_reg(id);
+	val = kvm_max_possible_guest_ftr_reg(id, val);
+	val = kvm_sanitise_vcpu_ftr_reg(vcpu, id, val);
+
+	return val;
+}
+
+u64 kvm_read_sanitised_id_reg(struct kvm_vcpu *vcpu,
+			      const struct sys_reg_desc *r)
+{
+	return __kvm_read_sanitised_id_reg(vcpu, r);
+}
+
+/* cpufeature ID register access trap handlers */
+bool access_id_reg(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
+		   const struct sys_reg_desc *r)
+{
+	if (p->is_write)
+		return write_to_read_only(vcpu, p, r);
+
+	p->regval = read_id_reg(vcpu, r);
+
+	return true;
+}
+
+unsigned int id_visibility(const struct kvm_vcpu *vcpu,
+			   const struct sys_reg_desc *r)
+{
+	u32 id = reg_to_encoding(r);
+
+	switch (id) {
+	case SYS_ID_AA64ZFR0_EL1:
+		if (!vcpu_has_sve(vcpu))
+			return REG_RAZ;
+		break;
+	}
+
+	return 0;
+}
+
+unsigned int aa32_id_visibility(const struct kvm_vcpu *vcpu,
+				const struct sys_reg_desc *r)
+{
+	/*
+	 * AArch32 ID registers are UNKNOWN if AArch32 isn't implemented at any
+	 * EL. Promote to RAZ/WI in order to guarantee consistency between
+	 * systems.
+	 */
+	if (!kvm_supports_32bit_el0())
+		return REG_RAZ | REG_USER_WI;
+
+	return id_visibility(vcpu, r);
+}
+
+/*
+ * cpufeature ID register user accessors
+ *
+ * For now, these registers are immutable for userspace, so no values
+ * are stored, and for set_id_reg() we don't allow the effective value
+ * to be changed.
+ */
+int get_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd, u64 *val)
+{
+	/*
+	 * Avoid locking if the VM has already started, as the ID registers are
+	 * guaranteed to be invariant at that point.
+	 */
+	if (kvm_vm_has_ran_once(vcpu->kvm)) {
+		*val = read_id_reg(vcpu, rd);
+		return 0;
+	}
+
+	mutex_lock(&vcpu->kvm->arch.config_lock);
+	*val = read_id_reg(vcpu, rd);
+	mutex_unlock(&vcpu->kvm->arch.config_lock);
+
+	return 0;
+}
+
+int set_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd, u64 val)
+{
+	u32 id = reg_to_encoding(rd);
+	int ret;
+
+	mutex_lock(&vcpu->kvm->arch.config_lock);
+
+	/*
+	 * Once the VM has started the ID registers are immutable. Reject any
+	 * write that does not match the final register value.
+	 */
+	if (kvm_vm_has_ran_once(vcpu->kvm)) {
+		if (val != read_id_reg(vcpu, rd))
+			ret = -EBUSY;
+		else
+			ret = 0;
+
+		mutex_unlock(&vcpu->kvm->arch.config_lock);
+		return ret;
+	}
+
+	ret = arm64_check_features(vcpu, rd, val);
+	if (!ret)
+		kvm_set_vm_id_reg(vcpu->kvm, id, val);
+
+	mutex_unlock(&vcpu->kvm->arch.config_lock);
+
+	/*
+	 * arm64_check_features() returns -E2BIG to indicate the register's
+	 * feature set is a superset of the maximally-allowed register value.
+	 * While it would be nice to precisely describe this to userspace, the
+	 * existing UAPI for KVM_SET_ONE_REG has it that invalid register
+	 * writes return -EINVAL.
+	 */
+	if (ret == -E2BIG)
+		ret = -EINVAL;
+	return ret;
+}
+
+int set_imp_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r, u64 val)
+{
+	struct kvm *kvm = vcpu->kvm;
+	u64 expected;
+
+	guard(mutex)(&kvm->arch.config_lock);
+
+	expected = read_id_reg(vcpu, r);
+	if (expected == val)
+		return 0;
+
+	if (!test_bit(KVM_ARCH_FLAG_WRITABLE_IMP_ID_REGS, &kvm->arch.flags))
+		return -EINVAL;
+
+	/*
+	 * Once the VM has started the ID registers are immutable. Reject the
+	 * write if userspace tries to change it.
+	 */
+	if (kvm_vm_has_ran_once(kvm))
+		return -EBUSY;
+
+	/*
+	 * Any value is allowed for the implementation ID registers so long as
+	 * it is within the writable mask.
+	 */
+	if ((val & r->val) != val)
+		return -EINVAL;
+
+	kvm_set_vm_id_reg(kvm, reg_to_encoding(r), val);
+	return 0;
+}
+
+void kvm_set_vm_id_reg(struct kvm *kvm, u32 reg, u64 val)
+{
+	u64 *p = __vm_id_reg(&kvm->arch.id_regs, reg);
+
+	lockdep_assert_held(&kvm->arch.config_lock);
+
+	if (KVM_BUG_ON(kvm_vm_has_ran_once(kvm) || !p, kvm))
+		return;
+
+	*p = val;
+}
+
+int set_ctr_el0(struct kvm_vcpu *vcpu,
+		const struct sys_reg_desc *rd,
+		u64 user_val)
+{
+	u8 user_L1Ip = SYS_FIELD_GET(CTR_EL0, L1Ip, user_val);
+
+	/*
+	 * Both AIVIVT (0b01) and VPIPT (0b00) are documented as reserved.
+	 * Hence only allow to set VIPT(0b10) or PIPT(0b11) for L1Ip based
+	 * on what hardware reports.
+	 *
+	 * Using a VIPT software model on PIPT will lead to over invalidation,
+	 * but still correct. Hence, we can allow downgrading PIPT to VIPT,
+	 * but not the other way around. This is handled via arm64_ftr_safe_value()
+	 * as CTR_EL0 ftr_bits has L1Ip field with type FTR_EXACT and safe value
+	 * set as VIPT.
+	 */
+	switch (user_L1Ip) {
+	case CTR_EL0_L1Ip_RESERVED_VPIPT:
+	case CTR_EL0_L1Ip_RESERVED_AIVIVT:
+		return -EINVAL;
+	case CTR_EL0_L1Ip_VIPT:
+	case CTR_EL0_L1Ip_PIPT:
+		return set_id_reg(vcpu, rd, user_val);
+	default:
+		return -ENOENT;
+	}
+}
+
+bool trap_oslar_el1(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
+		    const struct sys_reg_desc *r)
+{
+	if (!p->is_write)
+		return read_from_write_only(vcpu, p, r);
+
+	kvm_debug_handle_oslar(vcpu, p->regval);
+	return true;
+}
+
+bool trap_oslsr_el1(struct kvm_vcpu *vcpu,
+		    struct sys_reg_params *p,
+		    const struct sys_reg_desc *r)
+{
+	if (p->is_write)
+		return write_to_read_only(vcpu, p, r);
+
+	p->regval = __vcpu_sys_reg(vcpu, r->reg);
+	return true;
+}
+
+int set_oslsr_el1(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd, u64 val)
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
+	oslk = SYS_FIELD_GET(OSLSR_EL1, OSLK, val);
+	__vcpu_assign_sys_reg(vcpu, OSLAR_EL1, SYS_FIELD_PREP(OSLAR_EL1, OSLK, oslk));
+	return 0;
+}
+
+bool trap_raz_wi(struct kvm_vcpu *vcpu,
+		 struct sys_reg_params *p,
+		 const struct sys_reg_desc *r)
+{
+	if (p->is_write)
+		return ignore_write(vcpu, p);
+	else
+		return read_zero(vcpu, p);
+}
+
+u64 reset_mpidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
+{
+	u64 mpidr;
+
+	/*
+	 * Map the vcpu_id into the first three affinity level fields of
+	 * the MPIDR. We limit the number of VCPUs in level 0 due to a
+	 * limitation to 16 CPUs in that level in the ICC_SGIxR registers
+	 * of the GICv3 to be able to address each CPU directly when
+	 * sending IPIs.
+	 */
+	mpidr = (vcpu->vcpu_id & 0x0f) << MPIDR_LEVEL_SHIFT(0);
+	mpidr |= ((vcpu->vcpu_id >> 4) & 0xff) << MPIDR_LEVEL_SHIFT(1);
+	mpidr |= ((vcpu->vcpu_id >> 12) & 0xff) << MPIDR_LEVEL_SHIFT(2);
+	mpidr |= (1ULL << 31);
+	vcpu_write_sys_reg(vcpu, mpidr, MPIDR_EL1);
+
+	return mpidr;
+}
+
+/*
+ * Allow userspace to de-feature a stage-2 translation granule but prevent it
+ * from claiming the impossible.
+ */
+#define tgran2_val_allowed(tg, safe, user)			\
+({								\
+	u8 __s = SYS_FIELD_GET(ID_AA64MMFR0_EL1, tg, safe);	\
+	u8 __u = SYS_FIELD_GET(ID_AA64MMFR0_EL1, tg, user);	\
+								\
+	__s == __u || __u == ID_AA64MMFR0_EL1_##tg##_NI;	\
+})
+
+int set_id_aa64mmfr0_el1(struct kvm_vcpu *vcpu,
+			 const struct sys_reg_desc *rd,
+			 u64 user_val)
+{
+	u64 sanitized_val = kvm_read_sanitised_id_reg(vcpu, rd);
+
+	if (!vcpu_has_nv(vcpu))
+		return set_id_reg(vcpu, rd, user_val);
+
+	if (!tgran2_val_allowed(TGRAN4_2, sanitized_val, user_val) ||
+	    !tgran2_val_allowed(TGRAN16_2, sanitized_val, user_val) ||
+	    !tgran2_val_allowed(TGRAN64_2, sanitized_val, user_val))
+		return -EINVAL;
+
+	return set_id_reg(vcpu, rd, user_val);
+}
+
+bool access_rw(struct kvm_vcpu *vcpu,
+	       struct sys_reg_params *p,
+	       const struct sys_reg_desc *r)
+{
+	if (p->is_write)
+		vcpu_write_sys_reg(vcpu, p->regval, r->reg);
+	else
+		p->regval = vcpu_read_sys_reg(vcpu, r->reg);
+
+	return true;
+}
+
+bool access_clidr(struct kvm_vcpu *vcpu,
+		  struct sys_reg_params *p,
+		  const struct sys_reg_desc *r)
+{
+	if (p->is_write)
+		return write_to_read_only(vcpu, p, r);
+
+	p->regval = __vcpu_sys_reg(vcpu, r->reg);
+	return true;
+}
+
+/*
+ * Fabricate a CLIDR_EL1 value instead of using the real value, which can vary
+ * by the physical CPU which the vcpu currently resides in.
+ */
+u64 reset_clidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
+{
+	u64 ctr_el0 = kvm_sanitised_host_ftr_reg(SYS_CTR_EL0);
+	u64 clidr;
+	u8 loc;
+
+	if ((ctr_el0 & CTR_EL0_IDC)) {
+		/*
+		 * Data cache clean to the PoU is not required so LoUU and LoUIS
+		 * will not be set and a unified cache, which will be marked as
+		 * LoC, will be added.
+		 *
+		 * If not DIC, let the unified cache L2 so that an instruction
+		 * cache can be added as L1 later.
+		 */
+		loc = (ctr_el0 & CTR_EL0_DIC) ? 1 : 2;
+		clidr = CACHE_TYPE_UNIFIED << CLIDR_CTYPE_SHIFT(loc);
+	} else {
+		/*
+		 * Data cache clean to the PoU is required so let L1 have a data
+		 * cache and mark it as LoUU and LoUIS. As L1 has a data cache,
+		 * it can be marked as LoC too.
+		 */
+		loc = 1;
+		clidr = 1 << CLIDR_LOUU_SHIFT;
+		clidr |= 1 << CLIDR_LOUIS_SHIFT;
+		clidr |= CACHE_TYPE_DATA << CLIDR_CTYPE_SHIFT(1);
+	}
+
+	/*
+	 * Instruction cache invalidation to the PoU is required so let L1 have
+	 * an instruction cache. If L1 already has a data cache, it will be
+	 * CACHE_TYPE_SEPARATE.
+	 */
+	if (!(ctr_el0 & CTR_EL0_DIC))
+		clidr |= CACHE_TYPE_INST << CLIDR_CTYPE_SHIFT(1);
+
+	clidr |= loc << CLIDR_LOC_SHIFT;
+
+	/*
+	 * Add tag cache unified to data cache. Allocation tags and data are
+	 * unified in a cache line so that it looks valid even if there is only
+	 * one cache line.
+	 */
+	if (kvm_has_mte(vcpu->kvm))
+		clidr |= 2ULL << CLIDR_TTYPE_SHIFT(loc);
+
+	__vcpu_assign_sys_reg(vcpu, r->reg, clidr);
+
+	return __vcpu_sys_reg(vcpu, r->reg);
+}
+
+int set_clidr(struct kvm_vcpu *vcpu,
+	      const struct sys_reg_desc *rd,
+	      u64 val)
+{
+	u64 ctr_el0 = kvm_sanitised_host_ftr_reg(SYS_CTR_EL0);
+	u64 idc = !CLIDR_LOC(val) || (!CLIDR_LOUIS(val) && !CLIDR_LOUU(val));
+
+	if ((val & CLIDR_EL1_RES0) || (!(ctr_el0 & CTR_EL0_IDC) && idc))
+		return -EINVAL;
+
+	__vcpu_assign_sys_reg(vcpu, rd->reg, val);
+
+	return 0;
+}
+
+bool access_csselr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
+			  const struct sys_reg_desc *r)
+{
+	int reg = r->reg;
+
+	if (p->is_write)
+		vcpu_write_sys_reg(vcpu, p->regval, reg);
+	else
+		p->regval = vcpu_read_sys_reg(vcpu, reg);
+	return true;
+}
+
+/* CSSELR values; used to index KVM_REG_ARM_DEMUX_ID_CCSIDR */
+#define CSSELR_MAX 14
+
+/*
+ * Returns the minimum line size for the selected cache, expressed as
+ * Log2(bytes).
+ */
+static u8 get_min_cache_line_size(bool icache)
+{
+	u64 ctr = kvm_sanitised_host_ftr_reg(SYS_CTR_EL0);
+	u8 field;
+
+	if (icache)
+		field = SYS_FIELD_GET(CTR_EL0, IminLine, ctr);
+	else
+		field = SYS_FIELD_GET(CTR_EL0, DminLine, ctr);
+
+	/*
+	 * Cache line size is represented as Log2(words) in CTR_EL0.
+	 * Log2(bytes) can be derived with the following:
+	 *
+	 * Log2(words) + 2 = Log2(bytes / 4) + 2
+	 *		   = Log2(bytes) - 2 + 2
+	 *		   = Log2(bytes)
+	 */
+	return field + 2;
+}
+
+/* Which cache CCSIDR represents depends on CSSELR value. */
+u32 get_ccsidr(struct kvm_vcpu *vcpu, u32 csselr)
+{
+	u8 line_size;
+
+	if (vcpu->arch.ccsidr)
+		return vcpu->arch.ccsidr[csselr];
+
+	line_size = get_min_cache_line_size(csselr & CSSELR_EL1_InD);
+
+	/*
+	 * Fabricate a CCSIDR value as the overriding value does not exist.
+	 * The real CCSIDR value will not be used as it can vary by the
+	 * physical CPU which the vcpu currently resides in.
+	 *
+	 * The line size is determined with get_min_cache_line_size(), which
+	 * should be valid for all CPUs even if they have different cache
+	 * configuration.
+	 *
+	 * The associativity bits are cleared, meaning the geometry of all data
+	 * and unified caches (which are guaranteed to be PIPT and thus
+	 * non-aliasing) are 1 set and 1 way.
+	 * Guests should not be doing cache operations by set/way at all, and
+	 * for this reason, we trap them and attempt to infer the intent, so
+	 * that we can flush the entire guest's address space at the appropriate
+	 * time. The exposed geometry minimizes the number of the traps.
+	 * [If guests should attempt to infer aliasing properties from the
+	 * geometry (which is not permitted by the architecture), they would
+	 * only do so for virtually indexed caches.]
+	 *
+	 * We don't check if the cache level exists as it is allowed to return
+	 * an UNKNOWN value if not.
+	 */
+	return SYS_FIELD_PREP(CCSIDR_EL1, LineSize, line_size - 4);
+}
+
+int set_ccsidr(struct kvm_vcpu *vcpu, u32 csselr, u32 val)
+{
+	u8 line_size = FIELD_GET(CCSIDR_EL1_LineSize, val) + 4;
+	u32 *ccsidr = vcpu->arch.ccsidr;
+	u32 i;
+
+	if ((val & CCSIDR_EL1_RES0) ||
+	    line_size < get_min_cache_line_size(csselr & CSSELR_EL1_InD))
+		return -EINVAL;
+
+	if (!ccsidr) {
+		if (val == get_ccsidr(vcpu, csselr))
+			return 0;
+
+		ccsidr = kmalloc_array(CSSELR_MAX, sizeof(u32), GFP_KERNEL_ACCOUNT);
+		if (!ccsidr)
+			return -ENOMEM;
+
+		for (i = 0; i < CSSELR_MAX; i++)
+			ccsidr[i] = get_ccsidr(vcpu, i);
+
+		vcpu->arch.ccsidr = ccsidr;
+	}
+
+	ccsidr[csselr] = val;
+
+	return 0;
+}
+
+bool access_ccsidr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
+		   const struct sys_reg_desc *r)
+{
+	u32 csselr;
+
+	if (p->is_write)
+		return write_to_read_only(vcpu, p, r);
+
+	csselr = vcpu_read_sys_reg(vcpu, CSSELR_EL1);
+	csselr &= CSSELR_EL1_Level | CSSELR_EL1_InD;
+	if (csselr < CSSELR_MAX)
+		p->regval = get_ccsidr(vcpu, csselr);
+
+	return true;
+}
+
+void perform_access(struct kvm_vcpu *vcpu,
+		    struct sys_reg_params *params,
+		    const struct sys_reg_desc *r)
+{
+	trace_kvm_sys_access(*vcpu_pc(vcpu), params, r);
+
+	/* Check for regs disabled by runtime config */
+	if (sysreg_hidden(vcpu, r)) {
+		kvm_inject_undefined(vcpu);
+		return;
+	}
+
+	/*
+	 * Not having an accessor means that we have configured a trap
+	 * that we don't know how to handle. This certainly qualifies
+	 * as a gross bug that should be fixed right away.
+	 */
+	if (!r->access) {
+		bad_trap(vcpu, params, r, "register access");
+		return;
+	}
+
+	/* Skip instruction if instructed so */
+	if (likely(r->access(vcpu, params, r)))
+		kvm_incr_pc(vcpu);
+}
+
+void reset_vm_ftr_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *reg)
+{
+	u32 id = reg_to_encoding(reg);
+	struct kvm *kvm = vcpu->kvm;
+
+	if (test_bit(KVM_ARCH_FLAG_ID_REGS_INITIALIZED, &kvm->arch.flags))
+		return;
+
+	kvm_set_vm_id_reg(kvm, id, reg->reset(vcpu, reg));
+}
+
+void reset_vcpu_ftr_id_reg(struct kvm_vcpu *vcpu,
+			   const struct sys_reg_desc *reg)
+{
+	if (kvm_vcpu_initialized(vcpu))
+		return;
+
+	reg->reset(vcpu, reg);
+}
+
+static int demux_c15_get(struct kvm_vcpu *vcpu, u64 id, void __user *uaddr)
+{
+	u32 val;
+	u32 __user *uval = uaddr;
+
+	/* Fail if we have unknown bits set. */
+	if (id & ~(KVM_REG_ARCH_MASK|KVM_REG_SIZE_MASK|KVM_REG_ARM_COPROC_MASK
+		   | ((1 << KVM_REG_ARM_COPROC_SHIFT)-1)))
+		return -ENOENT;
+
+	switch (id & KVM_REG_ARM_DEMUX_ID_MASK) {
+	case KVM_REG_ARM_DEMUX_ID_CCSIDR:
+		if (KVM_REG_SIZE(id) != 4)
+			return -ENOENT;
+		val = (id & KVM_REG_ARM_DEMUX_VAL_MASK)
+			>> KVM_REG_ARM_DEMUX_VAL_SHIFT;
+		if (val >= CSSELR_MAX)
+			return -ENOENT;
+
+		return put_user(get_ccsidr(vcpu, val), uval);
+	default:
+		return -ENOENT;
+	}
+}
+
+int __kvm_arm_sys_reg_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg,
+			      size_t n_descs,
+			      const struct sys_reg_desc sys_reg_descs[n_descs])
+{
+	void __user *uaddr = (void __user *)(unsigned long)reg->addr;
+
+	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_DEMUX)
+		return demux_c15_get(vcpu, reg->id, uaddr);
+
+	return kvm_sys_reg_get_user(vcpu, reg, sys_reg_descs, n_descs);
+}
+
+static int demux_c15_set(struct kvm_vcpu *vcpu, u64 id, void __user *uaddr)
+{
+	u32 val, newval;
+	u32 __user *uval = uaddr;
+
+	/* Fail if we have unknown bits set. */
+	if (id & ~(KVM_REG_ARCH_MASK|KVM_REG_SIZE_MASK|KVM_REG_ARM_COPROC_MASK
+		   | ((1 << KVM_REG_ARM_COPROC_SHIFT)-1)))
+		return -ENOENT;
+
+	switch (id & KVM_REG_ARM_DEMUX_ID_MASK) {
+	case KVM_REG_ARM_DEMUX_ID_CCSIDR:
+		if (KVM_REG_SIZE(id) != 4)
+			return -ENOENT;
+		val = (id & KVM_REG_ARM_DEMUX_VAL_MASK)
+			>> KVM_REG_ARM_DEMUX_VAL_SHIFT;
+		if (val >= CSSELR_MAX)
+			return -ENOENT;
+
+		if (get_user(newval, uval))
+			return -EFAULT;
+
+		return set_ccsidr(vcpu, val, newval);
+	default:
+		return -ENOENT;
+	}
+}
+
+
+int __kvm_arm_sys_reg_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg,
+			      size_t n_descs,
+			      const struct sys_reg_desc sys_reg_descs[n_descs])
+
+{
+	void __user *uaddr = (void __user *)(unsigned long)reg->addr;
+
+	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_DEMUX)
+		return demux_c15_set(vcpu, reg->id, uaddr);
+
+	return kvm_sys_reg_set_user(vcpu, reg, sys_reg_descs, n_descs);
+}
+
+static unsigned int num_demux_regs(void)
+{
+	return CSSELR_MAX;
+}
+
+static int write_demux_regids(u64 __user *uindices)
+{
+	u64 val = KVM_REG_ARM64 | KVM_REG_SIZE_U32 | KVM_REG_ARM_DEMUX;
+	unsigned int i;
+
+	val |= KVM_REG_ARM_DEMUX_ID_CCSIDR;
+	for (i = 0; i < CSSELR_MAX; i++) {
+		if (put_user(val | i, uindices))
+			return -EFAULT;
+		uindices++;
+	}
+	return 0;
+}
+
+static u64 sys_reg_to_index(const struct sys_reg_desc *reg)
+{
+	return (KVM_REG_ARM64 | KVM_REG_SIZE_U64 |
+		KVM_REG_ARM64_SYSREG |
+		(reg->Op0 << KVM_REG_ARM64_SYSREG_OP0_SHIFT) |
+		(reg->Op1 << KVM_REG_ARM64_SYSREG_OP1_SHIFT) |
+		(reg->CRn << KVM_REG_ARM64_SYSREG_CRN_SHIFT) |
+		(reg->CRm << KVM_REG_ARM64_SYSREG_CRM_SHIFT) |
+		(reg->Op2 << KVM_REG_ARM64_SYSREG_OP2_SHIFT));
+}
+
+static bool copy_reg_to_user(const struct sys_reg_desc *reg, u64 __user **uind)
+{
+	u64 idx;
+
+	if (!*uind)
+		return true;
+
+	switch (reg_to_encoding(reg)) {
+	case SYS_CNTV_CVAL_EL0:
+		idx = KVM_REG_ARM_TIMER_CVAL;
+		break;
+	case SYS_CNTVCT_EL0:
+		idx = KVM_REG_ARM_TIMER_CNT;
+		break;
+	default:
+		idx = sys_reg_to_index(reg);
+	}
+
+	if (put_user(idx, *uind))
+		return false;
+
+	(*uind)++;
+	return true;
+}
+
+static int walk_one_sys_reg(const struct kvm_vcpu *vcpu,
+			    const struct sys_reg_desc *rd,
+			    u64 __user **uind,
+			    unsigned int *total)
+{
+	/*
+	 * Ignore registers we trap but don't save,
+	 * and for which no custom user accessor is provided.
+	 */
+	if (!(rd->reg || rd->get_user))
+		return 0;
+
+	if (sysreg_hidden(vcpu, rd))
+		return 0;
+
+	if (!copy_reg_to_user(rd, uind))
+		return -EFAULT;
+
+	(*total)++;
+	return 0;
+}
+
+/* Assumed ordered tables, see kvm_sys_reg_table_init. */
+static int walk_sys_regs(struct kvm_vcpu *vcpu,
+		  const struct sys_reg_desc *start,
+		  const struct sys_reg_desc *end2,
+		  u64 __user *uind)
+{
+	const struct sys_reg_desc *i2;
+	unsigned int total = 0;
+	int err;
+
+	i2 = start;
+
+	while (i2 != end2) {
+		err = walk_one_sys_reg(vcpu, i2++, &uind, &total);
+		if (err)
+			return err;
+	}
+	return total;
+}
+
+unsigned long __kvm_arm_num_sys_reg_descs(struct kvm_vcpu *vcpu, size_t n_descs,
+					  const struct sys_reg_desc sys_reg_descs[n_descs])
+{
+	return num_demux_regs()
+		+ walk_sys_regs(vcpu, sys_reg_descs, sys_reg_descs + n_descs, (u64 __user *)NULL);
+}
+
+int __kvm_arm_copy_sys_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices,
+				   size_t n_descs,
+				   const struct sys_reg_desc sys_reg_descs[n_descs])
+{
+	int err;
+
+	err = walk_sys_regs(vcpu, sys_reg_descs, sys_reg_descs + n_descs, uindices);
+	if (err < 0)
+		return err;
+	uindices += err;
+
+	return write_demux_regids(uindices);
+}
+
+bool check_sysreg_table(const struct sys_reg_desc *table, unsigned int n,
+			       bool reset_check)
+{
+	unsigned int i;
+
+	for (i = 0; i < n; i++) {
+		if (reset_check && table[i].reg && !table[i].reset) {
+			kvm_err("sys_reg table %pS entry %d (%s) lacks reset\n",
+				&table[i], i, table[i].name);
+			return false;
+		}
+
+		if (i && cmp_sys_reg(&table[i-1], &table[i]) >= 0) {
+			kvm_err("sys_reg table %pS entry %d (%s -> %s) out of order\n",
+				&table[i], i, table[i - 1].name, table[i].name);
+			return false;
+		}
+	}
+
+	return true;
+}
+
+/******************************************************************************
+ * Userspace API
+ *****************************************************************************/
+
+static bool index_to_params(u64 id, struct sys_reg_params *params)
+{
+	switch (id & KVM_REG_SIZE_MASK) {
+	case KVM_REG_SIZE_U64:
+		/* Any unused index bits means it's not valid. */
+		if (id & ~(KVM_REG_ARCH_MASK | KVM_REG_SIZE_MASK
+			      | KVM_REG_ARM_COPROC_MASK
+			      | KVM_REG_ARM64_SYSREG_OP0_MASK
+			      | KVM_REG_ARM64_SYSREG_OP1_MASK
+			      | KVM_REG_ARM64_SYSREG_CRN_MASK
+			      | KVM_REG_ARM64_SYSREG_CRM_MASK
+			      | KVM_REG_ARM64_SYSREG_OP2_MASK))
+			return false;
+		params->Op0 = ((id & KVM_REG_ARM64_SYSREG_OP0_MASK)
+			       >> KVM_REG_ARM64_SYSREG_OP0_SHIFT);
+		params->Op1 = ((id & KVM_REG_ARM64_SYSREG_OP1_MASK)
+			       >> KVM_REG_ARM64_SYSREG_OP1_SHIFT);
+		params->CRn = ((id & KVM_REG_ARM64_SYSREG_CRN_MASK)
+			       >> KVM_REG_ARM64_SYSREG_CRN_SHIFT);
+		params->CRm = ((id & KVM_REG_ARM64_SYSREG_CRM_MASK)
+			       >> KVM_REG_ARM64_SYSREG_CRM_SHIFT);
+		params->Op2 = ((id & KVM_REG_ARM64_SYSREG_OP2_MASK)
+			       >> KVM_REG_ARM64_SYSREG_OP2_SHIFT);
+		return true;
+	default:
+		return false;
+	}
+}
+
+const struct sys_reg_desc *get_reg_by_id(u64 id,
+					 const struct sys_reg_desc table[],
+					 unsigned int num)
+{
+	struct sys_reg_params params;
+
+	if (!index_to_params(id, &params))
+		return NULL;
+
+	return find_reg(&params, table, num);
+}
+
+/* Decode an index value, and find the sys_reg_desc entry. */
+static const struct sys_reg_desc *
+id_to_sys_reg_desc(struct kvm_vcpu *vcpu, u64 id,
+		   const struct sys_reg_desc table[], unsigned int num)
+
+{
+	const struct sys_reg_desc *r;
+
+	/* We only do sys_reg for now. */
+	if ((id & KVM_REG_ARM_COPROC_MASK) != KVM_REG_ARM64_SYSREG)
+		return NULL;
+
+	r = get_reg_by_id(id, table, num);
+
+	/* Not saved in the sys_reg array and not otherwise accessible? */
+	if (r && (!(r->reg || r->get_user) || sysreg_hidden(vcpu, r)))
+		r = NULL;
+
+	return r;
+}
+
+static u64 kvm_one_reg_to_id(const struct kvm_one_reg *reg)
+{
+	switch (reg->id) {
+	case KVM_REG_ARM_TIMER_CVAL:
+		return TO_ARM64_SYS_REG(CNTV_CVAL_EL0);
+	case KVM_REG_ARM_TIMER_CNT:
+		return TO_ARM64_SYS_REG(CNTVCT_EL0);
+	default:
+		return reg->id;
+	}
+}
+
+int kvm_sys_reg_get_user(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg,
+			 const struct sys_reg_desc table[], unsigned int num)
+{
+	u64 __user *uaddr = (u64 __user *)(unsigned long)reg->addr;
+	const struct sys_reg_desc *r;
+	u64 id = kvm_one_reg_to_id(reg);
+	u64 val;
+	int ret;
+
+	r = id_to_sys_reg_desc(vcpu, id, table, num);
+	if (!r || sysreg_hidden(vcpu, r))
+		return -ENOENT;
+
+	if (r->get_user) {
+		ret = (r->get_user)(vcpu, r, &val);
+	} else {
+		val = __vcpu_sys_reg(vcpu, r->reg);
+		ret = 0;
+	}
+
+	if (!ret)
+		ret = put_user(val, uaddr);
+
+	return ret;
+}
+
+int kvm_sys_reg_set_user(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg,
+			 const struct sys_reg_desc table[], unsigned int num)
+{
+	u64 __user *uaddr = (u64 __user *)(unsigned long)reg->addr;
+	const struct sys_reg_desc *r;
+	u64 id = kvm_one_reg_to_id(reg);
+	u64 val;
+	int ret;
+
+	if (get_user(val, uaddr))
+		return -EFAULT;
+
+	r = id_to_sys_reg_desc(vcpu, id, table, num);
+	if (!r || sysreg_hidden(vcpu, r))
+		return -ENOENT;
+
+	if (sysreg_user_write_ignore(vcpu, r))
+		return 0;
+
+	if (r->set_user) {
+		ret = (r->set_user)(vcpu, r, val);
+	} else {
+		__vcpu_assign_sys_reg(vcpu, r->reg, val);
+		ret = 0;
+	}
+
+	return ret;
+}
diff --git a/virt/kvm/arm64/trace.h b/virt/kvm/arm64/trace.h
index 0814000b7749..d791ee4ea2bf 100644
--- a/virt/kvm/arm64/trace.h
+++ b/virt/kvm/arm64/trace.h
@@ -36,6 +36,40 @@ TRACE_EVENT(kvm_mmio_nisv,
 		  __entry->far, __entry->vcpu_pc)
 );
 
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
 #endif /* __KVM_ARM64_TRACE_H__ */
 
 /* This part must be outside protection */
-- 
2.53.0

