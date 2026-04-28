Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625A943E4B1;
	Tue, 28 Apr 2026 16:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777392360; cv=none; b=RJnSSPD4MBhBuxVzkSbnQ7IHU5WL5HpGKwpWFaZp2K92Fhc9e1plLb63KZlWAzA4YRecScSKZta0wmwk07sJkQ11HtxwvdAcS06AZJ1yx8XXzgop0yXWD/xrPXq/QrPwAuczGXbxtP9sP55njcQy2Z3hTMYwQqN83b51J2r7VwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777392360; c=relaxed/simple;
	bh=uHxvoTgwXjL2QW3i35q4rUmRCDNLvFBHj4SO4Xc9KPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=unNoGTDX3YFwKCU/MNUKSEPWMx8Ug81t+eNcaXF6OvyDEAIIvR0QpAkvJIaRh3dcscWODyxT2Juv5LN4eZEPHeWlqay5GfpMRBUDnitIDr/cr05m/19xtvlRn2vTcB758Rw8nkqXmI5CgoXM+XgtLYDagUwdgNe4+HbVowTSWFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T/cG7bFG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T/cG7bFG"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S6lGsO2931477;
	Tue, 28 Apr 2026 16:05:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Kg67JfY+fk4IjcDPP
	0va87xdQ4xDehqqcIBdAGfz9iA=; b=T/cG7bFGCXtucMDdH78KFC5SNoq80K6+C
	RuuIdXjdO+py7x5291NdJpNRy9mLLCHSd4oC3EaJD3/M5Mbppvurtffxh7p75fRH
	ISAdQXj7/qhle47sJY6ITAfC1/bwxfWLCvSSI1xU6ocxO1SF7zs3d9w8fcmOxClS
	wTLMoHM4ZNBW9DzTkePfcRY0j0BDrzpOzsAVc4Rq5V6jDMEJdpWQh6J3OBBZyhby
	ZXVTq/daJbKDKmj/nlksP1ZUop61PvajmJAg/ZpMwRm4tE56zp8Fufs/PWHNBphw
	k3WAtza9McnYiplAc6En5E0BlL8URwXvM+YIZiKz7VsjHBBntauEQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn44pgpx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 16:05:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SFrqfj001950;
	Tue, 28 Apr 2026 16:05:33 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsa5ga9eb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 16:05:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63SG5UUP49742086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 16:05:30 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E71E320040;
	Tue, 28 Apr 2026 16:05:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96A242004E;
	Tue, 28 Apr 2026 16:05:29 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Apr 2026 16:05:29 +0000 (GMT)
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
Subject: [RFC PATCH v2 06/28] arm64: Provide arm64 API for non-native architectures
Date: Tue, 28 Apr 2026 18:05:03 +0200
Message-ID: <20260428160527.1378085-7-seiden@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: hgRmQUGaJKDnOIRpnqaoFlOT4NiIQWVM
X-Authority-Analysis: v=2.4 cv=Ft81OWrq c=1 sm=1 tr=0 ts=69f0dace cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=shFDtqSNEAS05WitX5wA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: hgRmQUGaJKDnOIRpnqaoFlOT4NiIQWVM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE1MSBTYWx0ZWRfXwed5FC+l8sSl
 iT5EjNl9ipmb/sF6YogBSAP00g7Utc86v2Xw+22tpvi4UwRhP4+GchyriAdY1hVulkKkt8Cik6y
 LO6iBrOf+9V+Zqes/9vaRdAsXnjlm3SV0mJe7uiI7Ot8frauXR+PTSiOy3mZF9XMhbQpBmuzEaD
 9WEM01M5848Ku0ruEFkHPdRCnD69yqBPJpSeRyXP8RNcjc2wW4QlOFommF2CuPPkOsC1gikh1Gp
 W1IYNyheVO1+/DWub/SHeUhfdLnrtiHx/IMDfy6is/B2ky+zGYHwGXeRn2OZsCDb/7XQ/9iXFRP
 pw08oDualN2VvSiY4hNGzNYPhRVNmixTEVN530TwP6x4NCC20/qmGVCG7RR9il1SZ4Do78R4Jbe
 02EqbUMTsd/8RcRE8roRvDq/LphFookiBYi7CL1tlFUV5SUNvwdT42UJrUynay+OMYI78yYNMY/
 0IIbZJ6hD6kgk4COXkw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280151

Enable the usage of arm64 asm headers independent of the CPU
architecture. Introduce a new directory, include/arch/arm64 to store
(host) architecture- agnostic headers for arm64 implementors.

The new path is added to the include patch of native arm64. Therefore,
arm64 will continue to reference to those headers via include
<asm/header.h> without any code change. This means that the header names
should be unique for arm64 asm headers. For native arm64, headers at the
new path take precedence over any other include path.

For other architectures to use the esr string names, move *esr_class_str
from traps.c to esr.h.

For a seamless integration non-native architectures must also include the
new path to the include path.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 MAINTAINERS                          |  1 +
 arch/arm64/Makefile                  |  2 +
 arch/arm64/include/asm/brk-imm.h     |  6 +--
 arch/arm64/include/asm/esr.h         | 62 +++++++++++++++++++++++++---
 arch/arm64/include/asm/sysreg-defs.h |  6 +--
 arch/arm64/kernel/traps.c            | 53 ------------------------
 include/arch/arm64/asm/brk-imm.h     |  1 +
 include/arch/arm64/asm/esr.h         |  1 +
 include/arch/arm64/asm/sysreg-defs.h |  1 +
 9 files changed, 68 insertions(+), 65 deletions(-)
 create mode 120000 include/arch/arm64/asm/brk-imm.h
 create mode 120000 include/arch/arm64/asm/esr.h
 create mode 120000 include/arch/arm64/asm/sysreg-defs.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 1b67fb5da13e..3ffd5102dcfd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3817,6 +3817,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 F:	Documentation/arch/arm64/
 F:	arch/arm64/
+F:	include/arch/arm64/
 F:	drivers/virt/coco/arm-cca-guest/
 F:	drivers/virt/coco/pkvm-guest/
 F:	tools/testing/selftests/arm64/
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 73a10f65ce8b..b244e837cedd 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -221,6 +221,8 @@ PHONY += virtconfig
 virtconfig:
 	$(call merge_into_defconfig_override,defconfig,virt)
 
+LINUXINCLUDE := -I$(srctree)/include/arch/arm64/ $(LINUXINCLUDE)
+
 define archhelp
   echo  '* Image.gz      - Compressed kernel image (arch/$(ARCH)/boot/Image.gz)'
   echo  '  Image         - Uncompressed kernel image (arch/$(ARCH)/boot/Image)'
diff --git a/arch/arm64/include/asm/brk-imm.h b/arch/arm64/include/asm/brk-imm.h
index beb42c62b6ac..265965339e95 100644
--- a/arch/arm64/include/asm/brk-imm.h
+++ b/arch/arm64/include/asm/brk-imm.h
@@ -3,8 +3,8 @@
  * Copyright (C) 2012 ARM Ltd.
  */
 
-#ifndef __ASM_BRK_IMM_H
-#define __ASM_BRK_IMM_H
+#ifndef __ARM64_SHARED_ASM_BRK_IMM_H
+#define __ARM64_SHARED_ASM_BRK_IMM_H
 
 /*
  * #imm16 values used for BRK instruction generation
@@ -39,4 +39,4 @@
 #define CFI_BRK_IMM_BASE		0x8000
 #define CFI_BRK_IMM_MASK		(CFI_BRK_IMM_TARGET | CFI_BRK_IMM_TYPE)
 
-#endif
+#endif /* __ARM64_SHARED_ASM_BRK_IMM_H */
diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index 7e86d400864e..780dc44faf99 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -4,11 +4,12 @@
  * Author: Marc Zyngier <marc.zyngier@arm.com>
  */
 
-#ifndef __ASM_ESR_H
-#define __ASM_ESR_H
+#ifndef __ARM64_SHARED_ASM_ESR_H
+#define __ARM64_SHARED_ASM_ESR_H
 
-#include <asm/memory.h>
-#include <asm/sysreg.h>
+#include <linux/const.h>
+#include <asm/sysreg-defs.h>
+#include <asm/brk-imm.h>
 
 #define ESR_ELx_EC_UNKNOWN	UL(0x00)
 #define ESR_ELx_EC_WFx		UL(0x01)
@@ -541,7 +542,56 @@ static inline bool esr_iss_is_eretab(unsigned long esr)
 	return esr & ESR_ELx_ERET_ISS_ERETA;
 }
 
-const char *esr_get_class_string(unsigned long esr);
+static inline const char *esr_get_class_string(unsigned long esr)
+{
+	switch (ESR_ELx_EC(esr)) {
+	case ESR_ELx_EC_UNKNOWN:	return "Unknown/Uncategorized";
+	case ESR_ELx_EC_WFx:		return "WFI/WFE";
+	case ESR_ELx_EC_CP15_32:	return "CP15 MCR/MRC";
+	case ESR_ELx_EC_CP15_64:	return "CP15 MCRR/MRRC";
+	case ESR_ELx_EC_CP14_MR:	return "CP14 MCR/MRC";
+	case ESR_ELx_EC_CP14_LS:	return "CP14 LDC/STC";
+	case ESR_ELx_EC_FP_ASIMD:	return "ASIMD";
+	case ESR_ELx_EC_CP10_ID:	return "CP10 MRC/VMRS";
+	case ESR_ELx_EC_PAC:		return "PAC";
+	case ESR_ELx_EC_CP14_64:	return "CP14 MCRR/MRRC";
+	case ESR_ELx_EC_BTI:		return "BTI";
+	case ESR_ELx_EC_ILL:		return "PSTATE.IL";
+	case ESR_ELx_EC_SVC32:		return "SVC (AArch32)";
+	case ESR_ELx_EC_HVC32:		return "HVC (AArch32)";
+	case ESR_ELx_EC_SMC32:		return "SMC (AArch32)";
+	case ESR_ELx_EC_SVC64:		return "SVC (AArch64)";
+	case ESR_ELx_EC_HVC64:		return "HVC (AArch64)";
+	case ESR_ELx_EC_SMC64:		return "SMC (AArch64)";
+	case ESR_ELx_EC_SYS64:		return "MSR/MRS (AArch64)";
+	case ESR_ELx_EC_SVE:		return "SVE";
+	case ESR_ELx_EC_ERET:		return "ERET/ERETAA/ERETAB";
+	case ESR_ELx_EC_FPAC:		return "FPAC";
+	case ESR_ELx_EC_SME:		return "SME";
+	case ESR_ELx_EC_IMP_DEF:	return "EL3 IMP DEF";
+	case ESR_ELx_EC_IABT_LOW:	return "IABT (lower EL)";
+	case ESR_ELx_EC_IABT_CUR:	return "IABT (current EL)";
+	case ESR_ELx_EC_PC_ALIGN:	return "PC Alignment";
+	case ESR_ELx_EC_DABT_LOW:	return "DABT (lower EL)";
+	case ESR_ELx_EC_DABT_CUR:	return "DABT (current EL)";
+	case ESR_ELx_EC_SP_ALIGN:	return "SP Alignment";
+	case ESR_ELx_EC_MOPS:		return "MOPS";
+	case ESR_ELx_EC_FP_EXC32:	return "FP (AArch32)";
+	case ESR_ELx_EC_FP_EXC64:	return "FP (AArch64)";
+	case ESR_ELx_EC_GCS:		return "Guarded Control Stack";
+	case ESR_ELx_EC_SERROR:		return "SError";
+	case ESR_ELx_EC_BREAKPT_LOW:	return "Breakpoint (lower EL)";
+	case ESR_ELx_EC_BREAKPT_CUR:	return "Breakpoint (current EL)";
+	case ESR_ELx_EC_SOFTSTP_LOW:	return "Software Step (lower EL)";
+	case ESR_ELx_EC_SOFTSTP_CUR:	return "Software Step (current EL)";
+	case ESR_ELx_EC_WATCHPT_LOW:	return "Watchpoint (lower EL)";
+	case ESR_ELx_EC_WATCHPT_CUR:	return "Watchpoint (current EL)";
+	case ESR_ELx_EC_BKPT32:		return "BKPT (AArch32)";
+	case ESR_ELx_EC_VECTOR32:	return "Vector catch (AArch32)";
+	case ESR_ELx_EC_BRK64:		return "BRK (AArch64)";
+	default:			return "UNRECOGNIZED EC";
+	}
+}
 #endif /* __ASSEMBLER__ */
 
-#endif /* __ASM_ESR_H */
+#endif /* __ARM64_SHARED_ASM_ESR_H */
diff --git a/arch/arm64/include/asm/sysreg-defs.h b/arch/arm64/include/asm/sysreg-defs.h
index 311f882a992b..42cbf4e66507 100644
--- a/arch/arm64/include/asm/sysreg-defs.h
+++ b/arch/arm64/include/asm/sysreg-defs.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 
-#ifndef __ASM_SYSREG_DEFS_H
-#define __ASM_SYSREG_DEFS_H
+#ifndef __ARM64_SHARED_ASM_SYSREG_DEFS_H
+#define __ARM64_SHARED_ASM_SYSREG_DEFS_H
 
 #include <linux/bits.h>
 
@@ -968,4 +968,4 @@
 		 FIELD_PREP(reg##_##field##_MASK,	\
 			    SYS_FIELD_VALUE(reg, field, val))
 #endif /* __ASSEMBLER__ */
-#endif	/* __ASM_SYSREG_DEFS_H */
+#endif /* __ARM64_SHARED_ASM_SYSREG_DEFS_H */
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 914282016069..ca679dcdf1c8 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -829,59 +829,6 @@ void do_el0_sys(unsigned long esr, struct pt_regs *regs)
 	do_el0_undef(regs, esr);
 }
 
-static const char *esr_class_str[] = {
-	[0 ... ESR_ELx_EC_MAX]		= "UNRECOGNIZED EC",
-	[ESR_ELx_EC_UNKNOWN]		= "Unknown/Uncategorized",
-	[ESR_ELx_EC_WFx]		= "WFI/WFE",
-	[ESR_ELx_EC_CP15_32]		= "CP15 MCR/MRC",
-	[ESR_ELx_EC_CP15_64]		= "CP15 MCRR/MRRC",
-	[ESR_ELx_EC_CP14_MR]		= "CP14 MCR/MRC",
-	[ESR_ELx_EC_CP14_LS]		= "CP14 LDC/STC",
-	[ESR_ELx_EC_FP_ASIMD]		= "ASIMD",
-	[ESR_ELx_EC_CP10_ID]		= "CP10 MRC/VMRS",
-	[ESR_ELx_EC_PAC]		= "PAC",
-	[ESR_ELx_EC_CP14_64]		= "CP14 MCRR/MRRC",
-	[ESR_ELx_EC_BTI]		= "BTI",
-	[ESR_ELx_EC_ILL]		= "PSTATE.IL",
-	[ESR_ELx_EC_SVC32]		= "SVC (AArch32)",
-	[ESR_ELx_EC_HVC32]		= "HVC (AArch32)",
-	[ESR_ELx_EC_SMC32]		= "SMC (AArch32)",
-	[ESR_ELx_EC_SVC64]		= "SVC (AArch64)",
-	[ESR_ELx_EC_HVC64]		= "HVC (AArch64)",
-	[ESR_ELx_EC_SMC64]		= "SMC (AArch64)",
-	[ESR_ELx_EC_SYS64]		= "MSR/MRS (AArch64)",
-	[ESR_ELx_EC_SVE]		= "SVE",
-	[ESR_ELx_EC_ERET]		= "ERET/ERETAA/ERETAB",
-	[ESR_ELx_EC_FPAC]		= "FPAC",
-	[ESR_ELx_EC_SME]		= "SME",
-	[ESR_ELx_EC_IMP_DEF]		= "EL3 IMP DEF",
-	[ESR_ELx_EC_IABT_LOW]		= "IABT (lower EL)",
-	[ESR_ELx_EC_IABT_CUR]		= "IABT (current EL)",
-	[ESR_ELx_EC_PC_ALIGN]		= "PC Alignment",
-	[ESR_ELx_EC_DABT_LOW]		= "DABT (lower EL)",
-	[ESR_ELx_EC_DABT_CUR]		= "DABT (current EL)",
-	[ESR_ELx_EC_SP_ALIGN]		= "SP Alignment",
-	[ESR_ELx_EC_MOPS]		= "MOPS",
-	[ESR_ELx_EC_FP_EXC32]		= "FP (AArch32)",
-	[ESR_ELx_EC_FP_EXC64]		= "FP (AArch64)",
-	[ESR_ELx_EC_GCS]		= "Guarded Control Stack",
-	[ESR_ELx_EC_SERROR]		= "SError",
-	[ESR_ELx_EC_BREAKPT_LOW]	= "Breakpoint (lower EL)",
-	[ESR_ELx_EC_BREAKPT_CUR]	= "Breakpoint (current EL)",
-	[ESR_ELx_EC_SOFTSTP_LOW]	= "Software Step (lower EL)",
-	[ESR_ELx_EC_SOFTSTP_CUR]	= "Software Step (current EL)",
-	[ESR_ELx_EC_WATCHPT_LOW]	= "Watchpoint (lower EL)",
-	[ESR_ELx_EC_WATCHPT_CUR]	= "Watchpoint (current EL)",
-	[ESR_ELx_EC_BKPT32]		= "BKPT (AArch32)",
-	[ESR_ELx_EC_VECTOR32]		= "Vector catch (AArch32)",
-	[ESR_ELx_EC_BRK64]		= "BRK (AArch64)",
-};
-
-const char *esr_get_class_string(unsigned long esr)
-{
-	return esr_class_str[ESR_ELx_EC(esr)];
-}
-
 /*
  * bad_el0_sync handles unexpected, but potentially recoverable synchronous
  * exceptions taken from EL0.
diff --git a/include/arch/arm64/asm/brk-imm.h b/include/arch/arm64/asm/brk-imm.h
new file mode 120000
index 000000000000..5f9d5e9b5f34
--- /dev/null
+++ b/include/arch/arm64/asm/brk-imm.h
@@ -0,0 +1 @@
+../../../../arch/arm64/include/asm/brk-imm.h
\ No newline at end of file
diff --git a/include/arch/arm64/asm/esr.h b/include/arch/arm64/asm/esr.h
new file mode 120000
index 000000000000..471e9aae8714
--- /dev/null
+++ b/include/arch/arm64/asm/esr.h
@@ -0,0 +1 @@
+../../../../arch/arm64/include/asm/esr.h
\ No newline at end of file
diff --git a/include/arch/arm64/asm/sysreg-defs.h b/include/arch/arm64/asm/sysreg-defs.h
new file mode 120000
index 000000000000..19de1996db12
--- /dev/null
+++ b/include/arch/arm64/asm/sysreg-defs.h
@@ -0,0 +1 @@
+../../../../arch/arm64/include/asm/sysreg-defs.h
\ No newline at end of file
-- 
2.51.0

