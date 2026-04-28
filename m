Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCFF44CF34;
	Tue, 28 Apr 2026 15:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777391830; cv=none; b=WJGyxqAlhFDE0sOw7V3Pxnm+CyBZLp3KT6SXvTNsj4cPrNhcUV5x46yl3/VyH18oTNlE7J4FXlDbqkqRdKUQgtqsLoqqK4VGX3/eHS9S6RNH8gQ1ClOF4x8Pk0rRB0h+haJjSKulsmNGkZgmZnaxEzqu0bUH2b5TCFzzi0vUC+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777391830; c=relaxed/simple;
	bh=ClaAvHSN/NV6Y5sqs38JGW4Ut86MYpSpBs7LvYTvPfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FppSWPDqZxGlaxJqWiObn33yznsCtUUUTtf7mhNixBiNKAyG+4EJ0kBuUnLbO8mog40WwAyn8Ndt/qsjl5aKDrZyzlQehDvitx1byR4nB9+ZAwVIw1lZn4vpekuh6RfXfpIM/VAcqNqZGB+dqGEIkAgEzdnyt/Us8c7pxR7hGXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gF+gRWIt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gF+gRWIt"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SCxpg71693197;
	Tue, 28 Apr 2026 15:56:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PwEHQniqXdMxcfdD5
	244XT/z51Zh5/xASU3rwpu8hYY=; b=gF+gRWIt9z2/6kb4wRqOXZGba/dWxIW4U
	pkOvIBvM4SF44nGa06iBPfFKD6JnXM6cQ4sraiUbILUcQyV4RFRWPyjVo5u2FLrF
	Yiv9jRONecXMuJPwk+p8Gs+hMl4dBq0kgUS1wTYSzIAWz1bgVRVjvBbR31nA02jb
	0rpiDxgBLHbrvLlMBQ9FW3v2Jsj+VGVHUs4a4ZQPzvLC2+3ZWbbAstl60WSoSWRb
	WPAzaM1ui88pF+ooSAHt5YTIajGXL4fTr3iDxI9wCqRTtw/RCH6xfbGOycmFnw3s
	I6Z4bPRlBMGJn43K9L2HQprOq5osrSreN24zI3jHj4DBtv8a7oCrw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn44pfaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 15:56:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SFrsPn002841;
	Tue, 28 Apr 2026 15:56:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8xk2d46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 15:56:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63SFuPjS13173040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 15:56:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AD732004B;
	Tue, 28 Apr 2026 15:56:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A36B20043;
	Tue, 28 Apr 2026 15:56:25 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Apr 2026 15:56:25 +0000 (GMT)
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
Subject: [PATCH v2 06/28] arm64: Provide arm64 API for non-native architectures
Date: Tue, 28 Apr 2026 17:55:58 +0200
Message-ID: <20260428155622.1361364-7-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260428155622.1361364-1-seiden@linux.ibm.com>
References: <20260428155622.1361364-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YAEJwXYuBcghpjy2Gj8k4qBq2rquzRlK
X-Authority-Analysis: v=2.4 cv=Ft81OWrq c=1 sm=1 tr=0 ts=69f0d8ae cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=dpC639kuH8ZWnzxCXqwA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: YAEJwXYuBcghpjy2Gj8k4qBq2rquzRlK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE1MSBTYWx0ZWRfX60rPJj0EGYIk
 5FG9Y8Q4k4wmL1lHADZiIi2TfTGrTwrrgaJojULbwoY8of0yBp3kYl0wRZ+q7QtAIE8hzJ8umKm
 QL0CT+eNlz4jeWrwGm3IFX5fB3R1e/0JFryesLpMs9/NEsDu4U2F1lISUyJM3NiCwbaG2wS4WjZ
 dPqGNOa4WfgMlEs6v1hqWKMlqTCQuxaPqyXQvcko8vdVa3Stg365op7Mqlc1b5N/emqWJn6Zkcj
 5/IAPwyUyFpXK6MBSNWLfQBGHyj1Uc+oA6OhHFvMGhXj1XjG+5rnGVbda4VcwKyUA0NP2++Dad0
 vxFt0wWuof1R8DyKojbFvGm5H7h4rPy/6399FLqh2EuX+lx2vlRRFGZJJA3tVOsdbKWXOteM0xr
 gj8vWSLJEFYVawrMDi1WPHSeHuqTyoe3u4CKF/fVXG9RS8F+rtYGG8sjLvr7pl1nj2eGj83mXvk
 2kZf2Z0pD4zUW7fyueg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280151

Enable the usage of arm64 asm headers independent of the CPU
architecture. Introduce a new directory, include/arch/arm64/asm to store
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
 MAINTAINERS                                   |  1 +
 arch/arm64/Makefile                           |  2 +
 arch/arm64/kernel/traps.c                     | 53 ----------------
 .../arch/arm64}/asm/brk-imm.h                 |  6 +-
 .../include => include/arch/arm64}/asm/esr.h  | 62 +++++++++++++++++--
 .../arch/arm64}/asm/sysreg-defs.h             |  6 +-
 6 files changed, 65 insertions(+), 65 deletions(-)
 rename {arch/arm64/include => include/arch/arm64}/asm/brk-imm.h (92%)
 rename {arch/arm64/include => include/arch/arm64}/asm/esr.h (88%)
 rename {arch/arm64/include => include/arch/arm64}/asm/sysreg-defs.h (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0752e340e569..b58399be11f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3817,6 +3817,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 F:	Documentation/arch/arm64/
 F:	arch/arm64/
+F:	include/arch/arm64/
 F:	include/uapi/arch/arm64/
 F:	drivers/virt/coco/arm-cca-guest/
 F:	drivers/virt/coco/pkvm-guest/
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
diff --git a/arch/arm64/include/asm/brk-imm.h b/include/arch/arm64/asm/brk-imm.h
similarity index 92%
rename from arch/arm64/include/asm/brk-imm.h
rename to include/arch/arm64/asm/brk-imm.h
index beb42c62b6ac..c311085886f5 100644
--- a/arch/arm64/include/asm/brk-imm.h
+++ b/include/arch/arm64/asm/brk-imm.h
@@ -3,8 +3,8 @@
  * Copyright (C) 2012 ARM Ltd.
  */
 
-#ifndef __ASM_BRK_IMM_H
-#define __ASM_BRK_IMM_H
+#ifndef __ARM64_ASM_BRK_IMM_H
+#define __ARM64_ASM_BRK_IMM_H
 
 /*
  * #imm16 values used for BRK instruction generation
@@ -39,4 +39,4 @@
 #define CFI_BRK_IMM_BASE		0x8000
 #define CFI_BRK_IMM_MASK		(CFI_BRK_IMM_TARGET | CFI_BRK_IMM_TYPE)
 
-#endif
+#endif /* __ARM64_ASM_BRK_IMM_H */
diff --git a/arch/arm64/include/asm/esr.h b/include/arch/arm64/asm/esr.h
similarity index 88%
rename from arch/arm64/include/asm/esr.h
rename to include/arch/arm64/asm/esr.h
index 7e86d400864e..a7421cc966f9 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/include/arch/arm64/asm/esr.h
@@ -4,11 +4,12 @@
  * Author: Marc Zyngier <marc.zyngier@arm.com>
  */
 
-#ifndef __ASM_ESR_H
-#define __ASM_ESR_H
+#ifndef __ARM64_ASM_ESR_H
+#define __ARM64_ASM_ESR_H
 
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
+#endif /* __ARM64_ASM_ESR_H */
diff --git a/arch/arm64/include/asm/sysreg-defs.h b/include/arch/arm64/asm/sysreg-defs.h
similarity index 99%
rename from arch/arm64/include/asm/sysreg-defs.h
rename to include/arch/arm64/asm/sysreg-defs.h
index 311f882a992b..399ff6897c1b 100644
--- a/arch/arm64/include/asm/sysreg-defs.h
+++ b/include/arch/arm64/asm/sysreg-defs.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 
-#ifndef __ASM_SYSREG_DEFS_H
-#define __ASM_SYSREG_DEFS_H
+#ifndef __ARM64_ASM_SYSREG_DEFS_H
+#define __ARM64_ASM_SYSREG_DEFS_H
 
 #include <linux/bits.h>
 
@@ -968,4 +968,4 @@
 		 FIELD_PREP(reg##_##field##_MASK,	\
 			    SYS_FIELD_VALUE(reg, field, val))
 #endif /* __ASSEMBLER__ */
-#endif	/* __ASM_SYSREG_DEFS_H */
+#endif /* __ARM64_ASM_SYSREG_DEFS_H */
-- 
2.51.0

