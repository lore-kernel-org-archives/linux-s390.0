Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CAB37E2E6;
	Thu,  2 Apr 2026 04:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775103767; cv=none; b=n/JF6AZUYOSyJDgNI5YrfE1Sdggp4M2HFHffuWOJOwlHX4pyOioQWr7iszCMCuyYun9BFJAMoshh3mHFqefYvZsUKotmUeSE6Z2MhH9+/LpMK+08sjfqv13Iwj4cCgQXn0DMhBRAOvFmLdUHqJJdaLq5nn3GdYvcbz6+BtPNr0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775103767; c=relaxed/simple;
	bh=vvCIx0lGl116UOOTLZr3vEf2R8qpjcyxjJcnbQZKCFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nfW+1HkL50zZThKlj3VgHTJrofPOwTkbDfzQj3YmHdp6OLXDffnOu/udcllIwpTCS6mWCHcsGDOyWcD17/p+vFudO5HrKCt4JGAGI94R8L+d50dHv7MDN1Ugl/zrmdJPKCvnKywBFKZXeb3GyLCHyFzn7kWTgyX6r4YEIspJQ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OvSuNpe6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OvSuNpe6"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631Id6HM3728917;
	Thu, 2 Apr 2026 04:21:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ESqyI50zDk32MY5zI
	8RuKqT07ww33io9vyaGfEUhbes=; b=OvSuNpe6mnRzoHACV5mFAB8UUbAGvABX2
	QOuaJG7S0GOwm25gIw4S9OEYasVBZqSD85946Iz8hoaYwrux/86hz6z+iUSnk7qe
	Azn46z/Uzu7H8zwVmrbVxICsjvtQUy6uwJuZbh8IEek5CHYiIrmOion6NiYQab0r
	MUZlaKwhNNR55cw1C+V72QZz0ENpcx/eoNeawX8En2B+fVAnECs4a/wlyt1My4Ki
	3GorcLXy61p8Ci2vS79WfnAnNKeFkTTN6VIu6sqMN66VwcfmigsQBJlphuN7bHjq
	1QIpiXWVMfPeBc5w07OkWJDqKWDNOBLXhN4z7CJy6JveeNCKyixBQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d64dgtjgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 04:21:33 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6322PK8C008689;
	Thu, 2 Apr 2026 04:21:32 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6v11rd0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 04:21:32 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6324LSU815663502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 04:21:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64C4320040;
	Thu,  2 Apr 2026 04:21:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10AA62004D;
	Thu,  2 Apr 2026 04:21:28 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 04:21:28 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Andreas Grapentin <Andreas.Grapentin@ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
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
Subject: [PATCH v1 06/27] arm64: Provide arm64 API for non-native architectures
Date: Thu,  2 Apr 2026 06:21:02 +0200
Message-ID: <20260402042125.3948963-7-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260402042125.3948963-1-seiden@linux.ibm.com>
References: <20260402042125.3948963-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDAzNCBTYWx0ZWRfXz2uM3j/LbhD7
 gHTwv800w/2ZT7MFKdjIhjm0ZIuE93U7olGa0EY36BND4YYpIwpt9cCxynEJfm+c9ZnY9EmH7lF
 IAB/QS5edqWvUmc52ej3LqJUZZGXhiRjUIfizaBAo20NAXxMIbWz5+g6WC0RW6n21c01NSp9qtv
 XeAEcOwlPwwTUoldmW+iWwlWtgof6cA9RPHoOSJYB+V/MfT0bxDfGs0vX5GXzb1kL2iKi5KB8ct
 go6kxycvqH5JoNQUyCaunB0rWW2KZ8gwM4RSnOcyX4KAiiPa+c4Sqdv8vfSHOm57bPPLmCK+ZOH
 fy884OAydaj1Whpvc6Jr/B3rLwizNoy48hda+HoEmSXIcD+lV2TWVCkEfhcq2CnAw068Qm/piBN
 Fjf2t8aN8lx/re+SPhr0MApvBeS9/aIV1ikpMde3tneRkVdAefJg/lhB1n4GB8t5DF9SQh4/o9h
 RaL49CykHw+MY2IPjsQ==
X-Authority-Analysis: v=2.4 cv=QKZlhwLL c=1 sm=1 tr=0 ts=69cdeecd cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=gY0r652GdjXvr5nJ4_8A:9
X-Proofpoint-GUID: FR-lCbn_OxsuHP5HuBThu4KqhgWpMR3n
X-Proofpoint-ORIG-GUID: FR-lCbn_OxsuHP5HuBThu4KqhgWpMR3n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1011
 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020034

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
 arch/arm64/kernel/traps.c                     | 53 ------------------
 .../arch/arm64}/asm/brk-imm.h                 |  0
 .../include => include/arch/arm64}/asm/esr.h  | 56 ++++++++++++++++++-
 .../arch/arm64}/asm/sysreg-defs.h             |  0
 6 files changed, 56 insertions(+), 56 deletions(-)
 rename {arch/arm64/include => include/arch/arm64}/asm/brk-imm.h (100%)
 rename {arch/arm64/include => include/arch/arm64}/asm/esr.h (88%)
 rename {arch/arm64/include => include/arch/arm64}/asm/sysreg-defs.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3f03ef9ee2bd..e0a101fe05ce 100644
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
similarity index 100%
rename from arch/arm64/include/asm/brk-imm.h
rename to include/arch/arm64/asm/brk-imm.h
diff --git a/arch/arm64/include/asm/esr.h b/include/arch/arm64/asm/esr.h
similarity index 88%
rename from arch/arm64/include/asm/esr.h
rename to include/arch/arm64/asm/esr.h
index 7e86d400864e..1c86202c1be4 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/include/arch/arm64/asm/esr.h
@@ -7,8 +7,9 @@
 #ifndef __ASM_ESR_H
 #define __ASM_ESR_H
 
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
 
 #endif /* __ASM_ESR_H */
diff --git a/arch/arm64/include/asm/sysreg-defs.h b/include/arch/arm64/asm/sysreg-defs.h
similarity index 100%
rename from arch/arm64/include/asm/sysreg-defs.h
rename to include/arch/arm64/asm/sysreg-defs.h
-- 
2.51.0

