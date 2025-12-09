Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64A727380A;
	Tue,  9 Dec 2025 12:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765282631; cv=none; b=eHRsHbx6o0V08xoU/jiNcmdw2nbrEYxyCZwE4giEhnV2BVNp8739VSZL9MYFzW9gkBBgeNwlFd5bYo313zqKJI1x1NAQytJ3O8rz3JWMkUZukYqxZAKysVxgUGATUVVQtFln3byyWl41LerwL3IGVH2zyswC4isOYJwUShA06Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765282631; c=relaxed/simple;
	bh=QaRx1UkAn32WurAO0wIdjnA4tym1sc7QHJZNm8354Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K5G/ajbVDdO7VmATvDFWa4k0YalyQmSLoFrNEwGnY4/vmaOFrO+nzDrSynGqlhM+hRZu2khkv5mjuwsMRzwwmUzYDYNsSuRZvEC2872XB3fM3qN5jdt8mcmo1dlicngJBmJXkTAuSOErhxclCv+cSjupzBjIGsPbNo4+PTJGP0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bzjE5Ogl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bzjE5Ogl"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B9312ah029935;
	Tue, 9 Dec 2025 12:17:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=m11Efmma+EjHgNF9r
	jTSsc11defZAuUDNNsmmunS9TI=; b=bzjE5OglDPm70ktwPmywwfxxQ0znh9izX
	Ajq+3YBsKcrOGttvdmZH/YBp/0vt91kNDxZHDN3/zdZiXt0lBAHmdHV61QYvbbr9
	sjME+TScDLS9yawpZkyhh/6Kn1tGRODoTSwypCL9I/EeVLJfGB3C+qQoOAK30XNz
	NPL1aJNzSQZvPQzhWJoyZVpL54Pn4Ee3jsaHJDGXecUPB+iAqUk4kRZD9zeMKVjL
	9D1xF1ms7ZPh72WWSCmlShyZZIm2to5u0mee4EE6H+O1cxobw4dthUUwvvep5afZ
	vDB1ThlYNyHhvFi/LQkN08e7cXTzA7vqfcGwmshpNVOPq+u2Cb5Cw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc61crdk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Dec 2025 12:17:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B998kGR026887;
	Tue, 9 Dec 2025 12:17:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aw1h12fus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Dec 2025 12:17:06 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B9CH3gs57475480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Dec 2025 12:17:03 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2C2F20040;
	Tue,  9 Dec 2025 12:17:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A05B820043;
	Tue,  9 Dec 2025 12:17:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Dec 2025 12:17:02 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Jens Remus <jremus@linux.ibm.com>,
        Stefan Schulze Frielinghaus <stefansf@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 6/9] s390/bug: Implement __WARN_printf()
Date: Tue,  9 Dec 2025 13:16:58 +0100
Message-ID: <20251209121701.1856271-7-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251209121701.1856271-1-hca@linux.ibm.com>
References: <20251209121701.1856271-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX+L0PJQtnfO3J
 e42rnZLIv7+c9HgUJLh2kYtjK6WxDqPdEFLwp6myBqh95WzsTXZ/JoNCS1lFeX9WTZTSSkriSxl
 MBlYHsXMhGE6l00jPCxJkJT6QkY2l6l3cVDJ9O5Rn2Fr0TzpmQOv8B76pyP/+kIGgqrZKkytKn4
 CwHO/SVDn+4Prv+psdOUU0zJvRiNDq22uDTcr1SpQ8Lf5zxAsOtleUNHHlfJsgAF+nr+Eg8aEAh
 zVdZx53ot+MTuNYV8u78swnVkfKXeB9LcBnclYvcYNTjQYHZydYh/mvkvx7GMufKD6KidYYC80k
 +tbkMYS2S5w5feK7um3DC70FH4S77maydAVnObLryOX3KppfIRpWfuuEeybsD4aMCCnTXywhqlL
 d192LKLPKx4U5V/O14zk7w8XdFCPTg==
X-Proofpoint-GUID: MXa84x5MNYsHdPHwcHJdaozLMvRsQ_PU
X-Proofpoint-ORIG-GUID: MXa84x5MNYsHdPHwcHJdaozLMvRsQ_PU
X-Authority-Analysis: v=2.4 cv=O/U0fR9W c=1 sm=1 tr=0 ts=69381343 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=1LMq0zfvll1xo8deCS4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020

This is the s390 variant of commit 5b472b6e5bd9 ("x86_64/bug: Implement
__WARN_printf()"). See the x86 commit for the general idea; there are only
implementation details which are different.

With the new exception based __WARN_printf() implementation the generated
code for a simple WARN() is simplified.

For example:

void foo(int a) { WARN(a, "bar"); }

Before this change the generated code looks like this:

0000000000000210 <foo>:
 210:   c0 04 00 00 00 00       jgnop   210 <foo>
 216:   ec 26 00 06 00 7c       cgijne  %r2,0,222 <foo+0x12>
 21c:   c0 f4 00 00 00 00       jg      21c <foo+0xc>
                        21e: R_390_PC32DBL      __s390_indirect_jump_r14+0x2
 222:   eb ef f0 88 00 24       stmg    %r14,%r15,136(%r15)
 228:   b9 04 00 ef             lgr     %r14,%r15
 22c:   e3 f0 ff e8 ff 71       lay     %r15,-24(%r15)
 232:   e3 e0 f0 98 00 24       stg     %r14,152(%r15)
 238:   c0 20 00 00 00 00       larl    %r2,238 <foo+0x28>
                        23a: R_390_PC32DBL      .LC48+0x2
 23e:   c0 e5 00 00 00 00       brasl   %r14,23e <foo+0x2e>
                        240: R_390_PLT32DBL     __warn_printk+0x2
 244:   af 00 00 00             mc      0,0
 248:   eb ef f0 a0 00 04       lmg     %r14,%r15,160(%r15)
 24e:   c0 f4 00 00 00 00       jg      24e <foo+0x3e>
                        250: R_390_PC32DBL      __s390_indirect_jump_r14+0x2

With this change the generated code looks like this:

0000000000000210 <foo>:
 210:   c0 04 00 00 00 00       jgnop   210 <foo>
 216:   ec 26 00 06 00 7c       cgijne  %r2,0,222 <foo+0x12>
 21c:   c0 f4 00 00 00 00       jg      21c <foo+0xc>
                        21e: R_390_PC32DBL      __s390_indirect_jump_r14+0x2
 222:   c0 20 00 00 00 00       larl    %r2,222 <foobar+0x12>
                        224: R_390_PC32DBL      __bug_table+0x2
 228:   c0 f4 00 00 00 00       jg      228 <foobar+0x18>
                        22a: R_390_PLT32DBL     __WARN_trap+0x2

Downside is that the call trace now starts at __WARN_trap():

------------[ cut here ]------------
bar
WARNING: arch/s390/kernel/setup.c:1017 at 0x0, CPU#0: swapper/0/0
...
Krnl PSW : 0704c00180000000 000003ffe0f6a3b4 (__WARN_trap+0x4/0x10)
...
Krnl Code: 000003ffe0f6a3ac: 0707                bcr     0,%r7
           000003ffe0f6a3ae: 0707                bcr     0,%r7
          *000003ffe0f6a3b0: af000001            mc      1,0
          >000003ffe0f6a3b4: 07fe                bcr     15,%r14
           000003ffe0f6a3b6: 47000700            bc      0,1792
           000003ffe0f6a3ba: 0707                bcr     0,%r7
           000003ffe0f6a3bc: 0707                bcr     0,%r7
           000003ffe0f6a3be: 0707                bcr     0,%r7
Call Trace:
 [<000003ffe0f6a3b4>] __WARN_trap+0x4/0x10
([<000003ffe185a54c>] start_kernel+0x53c/0x5d8)
 [<000003ffe010002e>] startup_continue+0x2e/0x40

Which isn't too helpful. This can be addressed by just skipping __WARN_trap(),
which will be addressed in a later patch.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/bug.h | 62 +++++++++++++++++++++++++++++++++----
 arch/s390/kernel/entry.S    |  7 +++++
 arch/s390/kernel/traps.c    | 34 +++++++++++++++++++-
 3 files changed, 96 insertions(+), 7 deletions(-)

diff --git a/arch/s390/include/asm/bug.h b/arch/s390/include/asm/bug.h
index 1e1dece0eee4..f3aca691bae2 100644
--- a/arch/s390/include/asm/bug.h
+++ b/arch/s390/include/asm/bug.h
@@ -6,6 +6,7 @@
 #include <linux/const.h>
 
 #define	MONCODE_BUG	_AC(0, U)
+#define	MONCODE_BUG_ARG _AC(1, U)
 
 #ifndef __ASSEMBLER__
 #ifdef CONFIG_BUG
@@ -25,16 +26,20 @@
 #define WARN_CONDITION_STR(cond_str) ""
 #endif
 
+#define __BUG_ENTRY(format, file, line, flags, size)			\
+		"	.section __bug_table,\"aw\"\n"			\
+		"1:	.long	0b - .	# bug_entry::bug_addr\n"	\
+		__BUG_ENTRY_VERBOSE(format, file, line)			\
+		"	.short	"flags"	# bug_entry::flags\n"		\
+		"	.org	1b+"size"\n"				\
+		"	.previous"
+
 #define __BUG_ASM(cond_str, flags)					\
 do {									\
 	asm_inline volatile("\n"					\
 		"0:	mc	%[monc](%%r0),0\n"			\
-		"	.section __bug_table,\"aw\"\n"			\
-		"1:	.long	0b - .	# bug_entry::bug_addr\n"	\
-		__BUG_ENTRY_VERBOSE("%[frmt]", "%[file]", "%[line]")	\
-		"	.short	%[flgs]	# bug_entry::flags\n"		\
-		"	.org	1b+%[size]\n"				\
-		"	.previous"					\
+		__BUG_ENTRY("%[frmt]", "%[file]", "%[line]",		\
+			    "%[flgs]", "%[size]")			\
 		:							\
 		: [monc] "i" (MONCODE_BUG),				\
 		  [frmt] "i" (WARN_CONDITION_STR(cond_str)),		\
@@ -55,8 +60,53 @@ do {									\
 	__BUG_ASM(cond_str, BUGFLAG_WARNING | (flags));			\
 } while (0)
 
+#define __WARN_bug_entry(flags, format)					\
+({									\
+	struct bug_entry *bug;						\
+									\
+	asm_inline volatile("\n"					\
+		"0:	larl	%[bug],1f\n"				\
+		__BUG_ENTRY("%[frmt]", "%[file]", "%[line]",		\
+			    "%[flgs]", "%[size]")			\
+		: [bug] "=d" (bug)					\
+		: [frmt] "i" (format),					\
+		  [file] "i" (__FILE__),				\
+		  [line] "i" (__LINE__),				\
+		  [flgs] "i" (flags),					\
+		  [size] "i" (sizeof(struct bug_entry)));		\
+	bug;								\
+})
+
+/*
+ * Variable Argument List (va_list) as defined in ELF Application
+ * Binary Interface s390x Supplement documentation.
+ */
+struct arch_va_list {
+	long __gpr;
+	long __fpr;
+	void *__overflow_arg_area;
+	void *__reg_save_area;
+};
+
+struct bug_entry;
+struct pt_regs;
+
+void *__warn_args(struct arch_va_list *args, struct pt_regs *regs);
+void __WARN_trap(struct bug_entry *bug, ...);
+
+#define __WARN_print_arg(flags, format, arg...)				\
+do {									\
+	int __flags = (flags) | BUGFLAG_WARNING | BUGFLAG_ARGS;		\
+									\
+	__WARN_trap(__WARN_bug_entry(__flags, format), ## arg);		\
+} while (0)
+
+#define __WARN_printf(taint, fmt, arg...) \
+	__WARN_print_arg(BUGFLAG_TAINT(taint), fmt, ## arg)
+
 #define HAVE_ARCH_BUG
 #define HAVE_ARCH_BUG_FORMAT
+#define HAVE_ARCH_BUG_FORMAT_ARGS
 
 #endif /* CONFIG_BUG */
 #endif /* __ASSEMBLER__ */
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index b7f1553d9ee5..23ff05746aa6 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -23,6 +23,7 @@
 #include <asm/unistd.h>
 #include <asm/page.h>
 #include <asm/sigp.h>
+#include <asm/bug.h>
 #include <asm/irq.h>
 #include <asm/fpu-insn.h>
 #include <asm/setup.h>
@@ -173,6 +174,12 @@ SYM_FUNC_START(__switch_to_asm)
 	BR_EX	%r14
 SYM_FUNC_END(__switch_to_asm)
 
+SYM_FUNC_START(__WARN_trap)
+	mc	MONCODE_BUG_ARG(%r0),0
+	BR_EX	%r14
+SYM_FUNC_END(__WARN_trap)
+EXPORT_SYMBOL(__WARN_trap)
+
 #if IS_ENABLED(CONFIG_KVM)
 /*
  * __sie64a calling convention:
diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index b2d6d7cc3b17..8aca5858b403 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -23,6 +23,7 @@
 #include <linux/cpu.h>
 #include <linux/entry-common.h>
 #include <linux/kmsan.h>
+#include <linux/bug.h>
 #include <asm/asm-extable.h>
 #include <asm/irqflags.h>
 #include <asm/ptrace.h>
@@ -220,11 +221,42 @@ static void space_switch_exception(struct pt_regs *regs)
 	do_trap(regs, SIGILL, ILL_PRVOPC, "space switch event");
 }
 
+void *__warn_args(struct arch_va_list *args, struct pt_regs *regs)
+{
+	struct stack_frame *stack_frame;
+
+	/*
+	 * Generate va_list from pt_regs. See ELF Application Binary Interface
+	 * s390x Supplement documentation for details.
+	 *
+	 * - __overflow_arg_area needs to point to the parameter area, which
+	 *   is right above the standard stack frame (160 bytes)
+	 *
+	 * - __reg_save_area needs to point to a register save area where
+	 *   general registers (%r2 - %r6) can be found at offset 16. Which
+	 *   means that the gprs save area of pt_regs can be used
+	 *
+	 * - __gpr must be set to one, since the first parameter has been
+	 *   processed (pointer to bug_entry)
+	 */
+	stack_frame = (struct stack_frame *)regs->gprs[15];
+	args->__overflow_arg_area = stack_frame + 1;
+	args->__reg_save_area = regs->gprs;
+	args->__gpr = 1;
+	return args;
+}
+
 static void monitor_event_exception(struct pt_regs *regs)
 {
+	enum bug_trap_type btt;
+
 	if (user_mode(regs))
 		return;
-	switch (report_bug(regs->psw.addr - (regs->int_code >> 16), regs)) {
+	if (regs->monitor_code == MONCODE_BUG_ARG)
+		btt = report_bug_entry((struct bug_entry *)regs->gprs[2], regs);
+	else
+		btt = report_bug(regs->psw.addr - (regs->int_code >> 16), regs);
+	switch (btt) {
 	case BUG_TRAP_TYPE_NONE:
 		fixup_exception(regs);
 		break;
-- 
2.51.0

