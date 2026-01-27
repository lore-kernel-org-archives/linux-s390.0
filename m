Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A041D35FF47;
	Tue, 27 Jan 2026 15:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769527203; cv=none; b=NNn2INkb0tvS0Ihp1f0oCY9vaF3wnkFD5Z36KzXvPU7POW4BgxI0Es6vWdcg5l7BTAik06G8MNnTxsJFjy/AFuAMBzy12iKmt8XBuknQwygd9i2NOpZUOvyzRTJ0QaWeweQoGHcQeiMcsAR9Yh/xvFiowFcX3Lb2xylgs0U1ywU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769527203; c=relaxed/simple;
	bh=tE+HbJKnHo0bokVJmiQhkZqCUoyrJolgL0VrBkszPm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FThg6H3HHXX4gKiNA/cVhisO4FjjETreYw+KSbr6FaNAzggAR/tveuyZY0tNXo1JscqiAMvU8Htv0mD1sX0PfLkB1/TMUZ6oMKRxDQfsyDoWWyR5VxFA7w2cCdGOiNRqlwkwMeQebgFIFfKCQnm3WJfdxPRY04P2ul2Di8OCN/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QdOx7Neh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QdOx7Neh"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60REnrac000461;
	Tue, 27 Jan 2026 15:19:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=l733ryMv8oM5HTOcb
	kvDb9WV+38YiH1DO3xwmb+1T3s=; b=QdOx7Nehq6bQUjuRlKaQUjwhmGuo08+Px
	PgzIwLDkHBcgf5QN2nvVSnTr3ZplYcqkkwIj1BUfLux9KpS7lGlawgXGPA2pimtn
	Ob+3nH6n2/ElRxuMK0oYAU3tOpGEduVYMLQoAIZRrfCwrHjZOe/VyiqxtJeRfjbr
	7k9FwTWRse6iulNW4mPK86lpn+cmS+Q5Oxbd6il2od1CvIr5W8iOE5+AbyCP3DSm
	0OBLhoao9eUC5BODxWN1Gm/V7jzBGXWCTpxI4XDLh2+HcUvgwiWpK3ZDdQX6+bOu
	FHjxTSkTATyl5CJemhqbB0C1Ai73w4ea3nCyovdpzNYGghUCHeoeQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvkgmmkpn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:19:40 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60RF6Gsi003971;
	Tue, 27 Jan 2026 15:19:40 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvkgmmkph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:19:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60RD5pK0006707;
	Tue, 27 Jan 2026 15:19:39 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw8sy97y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:19:39 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60RFJZtd45482304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 15:19:35 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DF2520040;
	Tue, 27 Jan 2026 15:19:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD9362004B;
	Tue, 27 Jan 2026 15:19:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Jan 2026 15:19:34 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@kernel.org>
Cc: Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>,
        "Carlos O'Donell" <codonell@redhat.com>, Sam James <sam@gentoo.org>,
        Dylan Hatch <dylanbhatch@google.com>
Subject: [PATCH v4 12/12] s390/unwind_user/fp: Enable back chain unwinding of user space
Date: Tue, 27 Jan 2026 16:19:25 +0100
Message-ID: <20260127151926.2805123-13-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127151926.2805123-1-jremus@linux.ibm.com>
References: <20260127151926.2805123-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Gr1PO01C c=1 sm=1 tr=0 ts=6978d78c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=VQtjK7h01SoePT0JaawA:9
X-Proofpoint-GUID: 8g5ku-kVF1yBq_8TiLE-bjQChnL2nhJs
X-Proofpoint-ORIG-GUID: FZoY_R0sCta0qELqFeMt3Pk3VIkD4udE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyNSBTYWx0ZWRfXzxmOXzsI1Kz8
 GsSWxW1VXDgWpOOlj6vHzy5KK2pOi/72fM379JcuAGpt8vfIxvQRvIFAEk8Cz669l1Ie/Ckm5Xs
 rTMPGDB0bfJlh5x4blobzfXnGTP3lAJU7WvMvbzoMhej7/yE1JJDi7jg1wtdzxMKkOjE8/7AiA2
 kDDd9PPekZsteXTFxPT94Kt2JTUT1NZbuSS7Oe3km2aL07JvlKUZgi4AKFQAqBB9EPaNcQb/R39
 zxbtU3CQzjTk6vRZ0dX30AhN6fz8E1+xIDac6BNyriwfVsPnpu+3oOxazb165Yoj3qVPQLFZyte
 RdoE/Jb9KcFwa2ByM7WiE/egSvC/AF4B4Ur+ZPLwWf7JaQ1Zr2tAM+76hFcWRfyhbhsGmoRneu0
 9tjxaW/P+Pk7FExS7otbWXHQ/MOD6CUXQ+NO53iXwuLwpIpng2EMbul45p8hm8oY5aoZtNUslh4
 8RYUf+gl8L+5buelJDg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601270125

Unwinding of user space using frame pointer (FP) is virtually impossible
on s390 for the following reasons:  The s390 64-bit (s390x) ELF ABI [1]
does only designate a "preferred" FP register and does not mandate fixed
FP and return address (RA) stack save slots.  Therefore neither the FP
register nor the FP/RA stack save slot offsets from CFA are known.
Compilers, such as GCC and Clang, do not necessarily setup a FP register
early in the function prologue, even not with compiler option
-fno-omit-frame-pointer.  Therefore the CFA offset from FP register is
not known.

This could be resolved by having compiler option -no-omit-frame-pointer
enforce all of the following:  Use the preferred FP register 11 as frame
pointer, use fixed FP/RA stack slot offsets from CFA (e.g. -72 for FP
and -48 for RA), and setup the FP register immediately after saving the
call saved registers.

Fortunately s390 provides an alternative to frame pointer:  back chain,
which can be enabled using s390-specific compiler option -mbackchain.
The back chain is very similar to a frame pointer on the stack.

Leverage the unwind user fp infrastructure to enable unwinding of user
space using back chain.  Enable HAVE_UNWIND_USER_FP and provide a s390-
specific implementation of unwind_user_fp_get_frame(), which uses the
back chain.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in v4:
    - Remove flawed heuristic to detect if topmost IP in early prologue.
      While it may resolve the caller getting skipped it may erroneously
      inject a callee as caller.
    - Fix outermost frame indication.
    - Adjust to flexible CFA and FP/RA rules.
    - Remove superfluous unwind_user_fp_get_frame define.
    
    Changes in RFC v3:
    - New patch.  Implement unwind user fp using back chain on s390. Reuses
      logic from RFC v2 patch "unwind_user/backchain: Introduce back chain
      user space unwinding". (Josh)

 arch/s390/Kconfig                   |  1 +
 arch/s390/include/asm/unwind_user.h | 62 +++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 063f0c857600..5f7e83ba54b2 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -250,6 +250,7 @@ config S390
 	select HAVE_SOFTIRQ_ON_OWN_STACK
 	select HAVE_STACKPROTECTOR if CC_HAS_STACKPROTECTOR_GLOBAL
 	select HAVE_SYSCALL_TRACEPOINTS
+	select HAVE_UNWIND_USER_FP
 	select HAVE_UNWIND_USER_SFRAME
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select HAVE_VIRT_CPU_ACCOUNTING_IDLE
diff --git a/arch/s390/include/asm/unwind_user.h b/arch/s390/include/asm/unwind_user.h
index 941aa3f0f70f..a7b97ea01c26 100644
--- a/arch/s390/include/asm/unwind_user.h
+++ b/arch/s390/include/asm/unwind_user.h
@@ -3,8 +3,12 @@
 #define _ASM_S390_UNWIND_USER_H
 
 #include <linux/sched/task_stack.h>
+#include <linux/security.h>
 #include <linux/types.h>
+#include <asm/asm-offsets.h>
 #include <asm/fpu.h>
+#include <asm/stacktrace.h>
+#include <linux/unwind_user_types.h>
 
 #ifdef CONFIG_UNWIND_USER
 
@@ -65,6 +69,64 @@ static inline int arch_unwind_user_get_reg(unsigned long *val,
 
 #endif /* CONFIG_UNWIND_USER */
 
+#ifdef CONFIG_HAVE_UNWIND_USER_FP
+
+static inline bool ip_within_vdso(unsigned long ip)
+{
+	return in_range(ip, current->mm->context.vdso_base, vdso_text_size());
+}
+
+static inline int unwind_user_fp_get_frame(struct unwind_user_state *state,
+					   struct unwind_user_frame *frame)
+{
+	struct stack_frame_user __user *sf;
+	unsigned long __user *ra_addr;
+	unsigned long sp;
+
+	sf = (void __user *)state->sp;
+	if (__get_user(sp, (unsigned long __user *)&sf->back_chain))
+		return -EINVAL;
+	if (!sp && ip_within_vdso(state->ip)) {
+		/*
+		 * Assume non-standard vDSO user wrapper stack frame.
+		 * See vDSO user wrapper code for details.
+		 */
+		struct stack_frame_vdso_wrapper *sf_vdso = (void __user *)sf;
+
+		ra_addr = (unsigned long __user *)&sf_vdso->return_address;
+		sf = (void __user *)((unsigned long)sf + STACK_FRAME_VDSO_OVERHEAD);
+		if (__get_user(sp, (unsigned long __user *)&sf->back_chain))
+			return -EINVAL;
+	} else if (!sp) {
+		/*
+		 * Assume outermost frame reached. unwind_user_next_common()
+		 * disregards all other fields in outermost frame.
+		 */
+		frame->outermost = true;
+		return 0;
+	} else {
+		/*
+		 * Assume IP past prologue and new stack frame allocated.
+		 * Follow back chain, which then equals the SP at entry.
+		 * Skips caller if wrong in topmost frame.
+		 */
+		sf = (void __user *)sp;
+		ra_addr = (unsigned long __user *)&sf->gprs[8];
+	}
+
+	frame->cfa.rule = UNWIND_USER_CFA_RULE_SP_OFFSET;
+	frame->cfa.offset = sp - state->sp + 160;
+	frame->sp_off = -160;
+	frame->fp.rule = UNWIND_USER_RULE_ZERO;	/* Cannot unwind FP. */
+	frame->ra.rule = UNWIND_USER_RULE_CFA_OFFSET_DEREF;
+	frame->ra.offset = (unsigned long)ra_addr - (state->sp + frame->cfa.offset);
+	frame->outermost = false;
+
+	return 0;
+}
+
+#endif /* CONFIG_HAVE_UNWIND_USER_FP */
+
 #include <asm-generic/unwind_user.h>
 
 #endif /* _ASM_S390_UNWIND_USER_H */
-- 
2.51.0

