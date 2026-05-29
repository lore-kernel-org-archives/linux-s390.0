Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE693CAA48;
	Fri, 29 May 2026 15:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780069892; cv=none; b=U4lbi5FAzAxhpsXdrn+4GWcEs0PgYjrtdZW34+nTB47Gwzqe3nxitMlYvzI4aQ8T/LzUaZiCpVk6dkHLaVkadjFd8elOqeBaK3SLXwBfuoA7QKEumDh7SwLEsFXp0YTQRd2gfREvW1c4g5KulccUY4h+IQbn7UNXjZWXno5Tmvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780069892; c=relaxed/simple;
	bh=IpSkmgltURiOixZ9J6VMSnCeDegPnSVABhBYhZdqopQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V3eIiX6C8jZ5ANPC08bdjX7ymBuILnpW2lsqmlw9sUyhAETWDk+2jEXJ611QmvzFC0TXx3iwcRMpwiHd4A9H8l80YOz7mly+er2XyS5KqQaQ6+3QWDpo0SgkGTyddaO6OsdtaguOZmti7kzSFyvUJK6ZyH40JH/CKE092ioX80U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QEo0jr1b; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QEo0jr1b"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TFHdxl1684851;
	Fri, 29 May 2026 15:51:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=EP11Cumj4nKaKd4Hx
	AFU2oQnORGO9DvArObT4KChA6Q=; b=QEo0jr1bmzP3TLJkypLNqcynHC5/7cW1B
	pSrZ/Y3ORctR8xu4QdUtxxUFrcZRtQXhrd4KXEwssuXXP1xJrlvnNnPLDeFa3pm3
	bXacZb7VgQu1NBw0atIUTUE0qKWIHLoCC+PqGvp4nI5fcON7P4lXFOknMhQVJJOj
	hbF9ZYf3oTyzYs9bxIOPlf5V2nPuJek6HI/gpuDOvrcZrVItuXBIgZlLkPjvEt7c
	YVtPX5FbclbU7Q5LnRi4Gq52u+Ezh8LEeTN5/Z0PGhVgUEIPhuGmrI2PjgWZXdAo
	eFyGCPITTh09T8+iFSoIBpBYQTomYFVe2joYtyXnoGBuj1+AVmZeA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884mbqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:51:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TFd6M8024385;
	Fri, 29 May 2026 15:51:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrbgfrq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:51:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TForRl29950420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 15:50:53 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D2A32004B;
	Fri, 29 May 2026 15:50:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1ADF2004E;
	Fri, 29 May 2026 15:50:52 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 15:50:52 +0000 (GMT)
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
Subject: [PATCH v3 06/27] arm64: Provide arm64 API for non-native architectures
Date: Fri, 29 May 2026 17:50:20 +0200
Message-ID: <20260529155050.2902245-7-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529155050.2902245-1-seiden@linux.ibm.com>
References: <20260529155050.2902245-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fIYJG5ae c=1 sm=1 tr=0 ts=6a19b5e5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=dpC639kuH8ZWnzxCXqwA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: sSwyQJGarf1KBsO_6t_yv_wqo_G4Q5RU
X-Proofpoint-GUID: sSwyQJGarf1KBsO_6t_yv_wqo_G4Q5RU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE1NiBTYWx0ZWRfX1/Uh4z0k/Yvb
 8c7kLCrM1X7eCmsFL42yQmWh5BAIaBL7SRwP3mxofP0UfqhDo+xFdt1rL6sl+q494mobj77obnP
 VYfxWE/t2ZHHQ7BINa7Zxb9E6ZOpeJYxrD70GTdo9YMfQD62Flq/m6wZD/NgaC8vp8cwvJD6G1V
 glCuPu0aej7lotLIq3gOHszWFNMiR/plTh/y3zIu+i3V1Lihp+VrfnXerG6/XfTn3OJjF88yAK5
 jpbcE/ridLM5MFz7Yh0I2V5ePhL0ppaX0T138iUNOW1cK6lAstcwP4G3fyVmUpWfYGWsWPfL5w/
 IblUUZ0Dq3xGHpPAIUNgP6NRHxY/HCmLkDnW+bUXnEVMEocNfitG8XcwdCiplS1TRV3a/dZzbAN
 ORFSMey/Phb05Ljh9mm7TPy+DxIz4udQKzVtMvvXLxnlL6C0eezOMyuHgJHP0J+tgVNl2fzZ9ig
 n4zBYKHeswUfNu8suKQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290156

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
index 52b66c8b97f4..f1903e4f0dcf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3838,6 +3838,7 @@ S:	Maintained
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
index 06bfc8e65b8d..58cb7eb0bf4e 100644
--- a/arch/arm64/include/asm/sysreg-defs.h
+++ b/include/arch/arm64/asm/sysreg-defs.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 
-#ifndef __ASM_SYSREG_DEFS_H
-#define __ASM_SYSREG_DEFS_H
+#ifndef __ARM64_ASM_SYSREG_DEFS_H
+#define __ARM64_ASM_SYSREG_DEFS_H
 
 #include <linux/bits.h>
 
@@ -969,4 +969,4 @@
 		 FIELD_PREP(reg##_##field##_MASK,	\
 			    SYS_FIELD_VALUE(reg, field, val))
 #endif /* __ASSEMBLER__ */
-#endif	/* __ASM_SYSREG_DEFS_H */
+#endif /* __ARM64_ASM_SYSREG_DEFS_H */
-- 
2.53.0

