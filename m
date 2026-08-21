Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03743FFAA4;
	Fri, 21 Aug 2026 19:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787342054; cv=none; b=GC67nmHk/SBwQ+O07eXmJwiKQlM74JZ4/JFCtWsBEr8sYZiFlS2ejjqLOWlaDAY+soOa3ZjSGjznDVHwwu5cmIu41NpNNSc/E0fE376Wvr60lgW/PNy62dQJ9khomQQ7fxLU8ec5wlwmRY00eV6KFMSgfT6gEhjqmpMyhktUC2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787342054; c=relaxed/simple;
	bh=ZWia27gK5Uu/rA6TzDzSSPKWN0bclHUCBb817crgoGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bH3DW7t1AMebAZ9Omjg8KA1rEgoP2eVaTzoEwBpA6bT23Z2opQtU7fuY/+54uZuTn0I3pkZgIxPUIL9Jq3kmYh3A31fHZy8IHZ2Bs48AkYEaFMQJBNdHFcbSbfVkHfPXgwSZKCPyNlkaApwx9A34IFBLLZsm/JlrSUPX1Z52HwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eaRTdbVJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eaRTdbVJ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LIVsMb2253836;
	Fri, 21 Aug 2026 19:53:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UBQVMEerwR6B6Lb2m
	WCr+ZIf4sr/j5+4uJyDzFTYLIY=; b=eaRTdbVJErkdFF7CjeWZRJ2nLmkpR0Ffa
	htGsE2FDWt0ECHXix52Pe+Wcgh4Tw4P3dSplcZTkHHLnlVgzawWw2UZjEVrdrG9O
	AO0VgbHZmfx/QCU8TJFgCdNU6YJFzrOfxha+CkOogVNktzAt5bnmiZbScEdbrc5m
	FnT3HCCeAEVXnaJ39okTITVi0WFjv7hNdyBOMAN5wPwf/VDgJRRerUZ6+qfYHuKs
	/Ls0V9r68cdAAHN943JZdHomyfti0hWVp68r7lA5I7wbhlMV+ecsYinWHiTzUFsV
	Qr4TGBwsS4BVCtDBNFBdDJdT4ESvM6DMkj1NASmfqb3Nsg5cG8Qqg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4krm0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LJfOOH016658;
	Fri, 21 Aug 2026 19:53:15 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xhpnky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:15 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LJrBLo50331924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 19:53:11 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B41F120040;
	Fri, 21 Aug 2026 19:53:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 776702004B;
	Fri, 21 Aug 2026 19:53:11 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 19:53:11 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Indu Bhagat <ibhagatgnu@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Namhyung Kim <namhyung@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, Kees Cook <kees@kernel.org>,
        Sam James <sam@gentoo.org>, Fangrui Song <i@maskray.me>
Subject: [RFC PATCH v2 23/24] unwind_user/eh_frame/s390: Enable eh_frame unwinding on s390
Date: Fri, 21 Aug 2026 21:52:58 +0200
Message-ID: <20260821195259.2688377-24-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821195259.2688377-1-jremus@linux.ibm.com>
References: <20260821195259.2688377-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfXzKG+S2u53BzP
 hqy+2y2eBLsMuAyXCGbVawq72lSScsbNJz2QBM8GHbKjMux/2gIhPSukvKMSA7oG/MbgdbfegmF
 LXqxfdluZWsF3/GctKUrLyfHKa1iTRs=
X-Proofpoint-GUID: ismV3-0PHheBjc3lL-v0KI1YRoSnqBTU
X-Proofpoint-ORIG-GUID: fh0wHN0Grpa8vy5clGXhKBYq-SjqqQM1
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a88acad cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=FmDO2REWYRq66Aip4RwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX2Xt7KTGJ0tcn
 jUt54EXZmbaP4rKr+60qBjMsiMxVUT7F/D2spaFaf24XGFV2jam59DxRof9obOnyHn7A9j4w4P1
 lIYANRQp6kylxUgd4IMoPK87Yr2Gm7YI94bx+PG2YDn5kC7k5Vk0PGFW7t2cpx7suCkkLe4S0kw
 2BYVjcbcEvDmblSMoM+Z0bX/WM5TK9nOxqDUZbmb2EowFvrKKYkj8L5v2jxh21yAc1Q4SVLSuAN
 E9wZghJECHta9UQ871tupgBHyEZt+/GvL5kmnZcICkerSFRdeNzhrEXeiy4i3NGO0FJ16ReaurX
 MJjFd+hYpu5dzEULoddLKMvfclco6brQx6+MqUzLDEkiHtnoY+GJXHRWlfaRzv0PZCAa5iAXGhF
 0L7Vqm8eSrgZb/p79ezXVyxHsZZXKmkB3u6wzjhzEKevMxzCOsTLitzv006b+KII3Nw63hD0k5a
 UuqtQgWrWQu06mPuyrQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210155

The unwind user eh_frame implementation works well with GCC and Clang
generated code on s390.  Enable it.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 arch/s390/Kconfig                            |  1 +
 arch/s390/include/asm/unwind_user.h          | 71 ++++++++++++++++++++
 arch/s390/include/asm/unwind_user_eh_frame.h | 24 +++++++
 3 files changed, 96 insertions(+)
 create mode 100644 arch/s390/include/asm/unwind_user.h
 create mode 100644 arch/s390/include/asm/unwind_user_eh_frame.h

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 84404e6778d5..fa229ac92d5a 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -251,6 +251,7 @@ config S390
 	select HAVE_SOFTIRQ_ON_OWN_STACK
 	select HAVE_STACKPROTECTOR if CC_HAS_STACKPROTECTOR_GLOBAL
 	select HAVE_SYSCALL_TRACEPOINTS
+	select HAVE_UNWIND_USER_EH_FRAME
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select HAVE_VIRT_CPU_ACCOUNTING_IDLE
 	select HOTPLUG_SMT
diff --git a/arch/s390/include/asm/unwind_user.h b/arch/s390/include/asm/unwind_user.h
new file mode 100644
index 000000000000..41ff0b477626
--- /dev/null
+++ b/arch/s390/include/asm/unwind_user.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_S390_UNWIND_USER_H
+#define _ASM_S390_UNWIND_USER_H
+
+#include <linux/sched/task_stack.h>
+#include <linux/types.h>
+#include <asm/fpu.h>
+
+#ifdef CONFIG_UNWIND_USER
+
+static inline int unwind_user_word_size(struct pt_regs *regs)
+{
+	return 8;
+}
+
+static inline int unwind_user_get_ra_reg(unsigned long *val)
+{
+	struct pt_regs *regs = task_pt_regs(current);
+	*val = regs->gprs[14];
+	return 0;
+}
+#define unwind_user_get_ra_reg unwind_user_get_ra_reg
+
+static inline unsigned long __s390_dwarf_fpr_to_fpr(unsigned int regnum)
+{
+	unsigned int fpr;
+
+	/*
+	 * Convert from s390 DWARF floating-point register number (16..31)
+	 * to floating-point register number (0..15): left rotate the least
+	 * significant three bits and then return the least significant four
+	 * bits.
+	 */
+	fpr  = (regnum & 3) << 1;
+	fpr |= (regnum & 4) >> 2;
+	fpr |= (regnum & 8);
+	return fpr;
+}
+
+static inline unsigned long __s390_get_dwarf_fpr(unsigned int regnum)
+{
+	struct fpu *fpu = &current->thread.ufpu;
+
+	save_user_fpu_regs();
+	return fpu->vxrs[__s390_dwarf_fpr_to_fpr(regnum)].high;
+}
+
+static inline int unwind_user_get_reg(unsigned long *val, unsigned int regnum)
+{
+	if (regnum <= 15) {
+		/* DWARF register numbers 0..15 */
+		struct pt_regs *regs = task_pt_regs(current);
+		*val = regs->gprs[regnum];
+		return 0;
+	} else if (regnum <= 31) {
+		/* DWARF register numbers 16..31 */
+		*val = __s390_get_dwarf_fpr(regnum);
+		return 0;
+	}
+
+	pr_debug("%s (%d): %s(%u): unsupported register number\n",
+		 current->comm, current->pid, __func__, regnum);
+	return -EINVAL;
+}
+#define unwind_user_get_reg unwind_user_get_reg
+
+#endif /* CONFIG_UNWIND_USER */
+
+#include <asm-generic/unwind_user.h>
+
+#endif /* _ASM_S390_UNWIND_USER_H */
diff --git a/arch/s390/include/asm/unwind_user_eh_frame.h b/arch/s390/include/asm/unwind_user_eh_frame.h
new file mode 100644
index 000000000000..842d9f7c3d80
--- /dev/null
+++ b/arch/s390/include/asm/unwind_user_eh_frame.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_S390_UNWIND_USER_EH_FRAME_H
+#define _ASM_S390_UNWIND_USER_EH_FRAME_H
+
+#define EH_FRAME_REG_SP	15	/* designated stack pointer register */
+#define EH_FRAME_REG_FP	11	/* "preferred" frame pointer register */
+#define EH_FRAME_REG_RA	14	/* designaged return address register */
+
+/* Instructions must be 2-byte aligned */
+#define EH_FRAME_MAX_CODE_ALIGN 2
+
+/* CFA is defined as SP at call site + 160, so that SP = CFA - 160 */
+#define EH_FRAME_SP_VAL_OFFSET -160
+
+/* SP may be saved on the stack or in a register */
+static inline bool eh_frame_reject_sp_rule(void)
+{
+	return false;
+}
+#define eh_frame_reject_sp_rule eh_frame_reject_sp_rule
+
+#include <asm-generic/unwind_user_eh_frame.h>
+
+#endif /* _ASM_S390_UNWIND_USER_EH_FRAME_H */
-- 
2.53.0

