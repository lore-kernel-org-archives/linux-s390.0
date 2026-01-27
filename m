Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED5E2652B2;
	Tue, 27 Jan 2026 15:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769528040; cv=none; b=s+N2goXYkiezcUBnkX/mTJlA48Kx/R6D6wcUgQ18iA23vIdL5A9lqhEJ303s47o0Xsaa9HYz/mV1iFBhqdKEZDHixNyEScz6EcTSXDgGmlkoVtdl1t7GZkpm5Se+3fDF9XuDPnNX2wxWWM8r9G/yoXkxX2EDzYDg1mUQ5r9TP7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769528040; c=relaxed/simple;
	bh=6wF8XaQDxfz966svEGjEX62SHz+yu4PVfqIF2EC8+bI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dgunWYQWc0EZ591YKrGCwkeZpavYEnZKSdrU4Y1ue24LSmUEJ69OeeaZmODxgeoU+BPB2R00fd9E850n3cWAVijuU9pG2571G3fK1m9yFijQi/w4m+6aHdnjaFIQiUFI2JpenegfaDDzwtWYU7ToEqZPZ+IrnJiOMB7xANZ98ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Jp2Mj893; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Jp2Mj893"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R4IfNG010997;
	Tue, 27 Jan 2026 15:33:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=q9xWw3J6O/0w+A2Ag
	FzZG5+Z1M2XrO4YIdPqlsT8BVk=; b=Jp2Mj8932FMCdb+TT6aofLZAlp0RJ/sHQ
	XKip5bXq91kQnG8RBx+mjQvGBpi1CkSyDvwcbjhg5LI+Y46pTJXlB4DvvAVP0yFz
	JMOXgRnP24VeIPtl6ZClJcsWfTfxFHol0XWRBpLP98MdTU78B43GEVAM9ru5L6B3
	skrhIUlPzvAs6gnDUIYCYORk2ogRJs4uBQ2+pQi88DBINt+CrGFfxsUmC4U6W/3j
	Qb1sJgxiROtF+byU+QRvfX05vX6r+DffOpMD30F0L+tWgdN2QGhVLzlcuTE7xWqA
	ewNBV6qofLVvA/VcyxgFefiOCILji4DSceCSTQQliFtjBKtIVQU5w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnt7p63h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:33:40 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60RFTQ8b013023;
	Tue, 27 Jan 2026 15:33:40 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnt7p63b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:33:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60RDaigl026334;
	Tue, 27 Jan 2026 15:33:38 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw9wk94jj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:33:38 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60RFXY8617826178
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 15:33:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A56D220043;
	Tue, 27 Jan 2026 15:33:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60C4C20040;
	Tue, 27 Jan 2026 15:33:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Jan 2026 15:33:34 +0000 (GMT)
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
Subject: [RFC PATCH v1 4/5] s390/signal: Move struct [rt_]sigframe to asm/sigframe.h
Date: Tue, 27 Jan 2026 16:33:30 +0100
Message-ID: <20260127153331.2902504-5-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127153331.2902504-1-jremus@linux.ibm.com>
References: <20260127153331.2902504-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Qb4EApp12JCRn_T5hpvaHaPXdJqDRXMm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyNSBTYWx0ZWRfX3Wku2S3ysnWv
 m1+BsFGQEBmf/HQAYi0Aw26JFSB5L4JCqGkNCmFOjBU9BnNChHUM8YSEmJNcBmbF19mJKjWJd19
 sH7SSYSiVHNgVvBewPQMW/Ag+fM927aK79TL/kmpuGFXeq64XVY7vYJLzc6QWK5/OaJymQdsDOr
 aspLIliNQuQQrybuHE0vRnzx/9UUE1jJ7+M/3SHTlULd7oah43PpUKpMZT7QN3Ra/HF41M83Gw3
 7OrbLSM/ZeESAR8ntJiHzaS4ibEY8E8AG4REh5SLC+td8kghD5WLalb/8BbaM8p54Kfx/a/p/k1
 996JleWH+drlaA++ntq1rVBrCMAZAuGJWfo9wtcrivWJaSkqVm7at1vNfYSVTSH0yxAj4hGpw8t
 DnOaGHQ+SLcM3qiNSpr/iCtTtu26Ng3xlTNmSivMvscpdSBAJO1uHSKlkl4IoPhLq+peuI0Sr7c
 OIIeSDJFudjMBsJk5gw==
X-Authority-Analysis: v=2.4 cv=Zs3g6t7G c=1 sm=1 tr=0 ts=6978dad4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=vr68hYBkSomNBJpq4wcA:9
X-Proofpoint-ORIG-GUID: hpKplGUd3QhEkBUect78SS6ekHow8NrU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601270125

This enables use of struct sigframe and struct rt_sigframe elsewhere,
such as unwind user.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 arch/s390/include/asm/sigframe.h | 78 ++++++++++++++++++++++++++++++++
 arch/s390/kernel/signal.c        | 71 +----------------------------
 2 files changed, 79 insertions(+), 70 deletions(-)
 create mode 100644 arch/s390/include/asm/sigframe.h

diff --git a/arch/s390/include/asm/sigframe.h b/arch/s390/include/asm/sigframe.h
new file mode 100644
index 000000000000..7539fd802675
--- /dev/null
+++ b/arch/s390/include/asm/sigframe.h
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef _ASM_S390_SIGFRAME_H
+#define _ASM_S390_SIGFRAME_H
+
+#include <uapi/asm/sigcontext.h>
+#include <asm/ucontext.h>
+
+/*
+ * Layout of an old-style signal-frame:
+ *	-----------------------------------------
+ *	| save area (_SIGNAL_FRAMESIZE)		|
+ *	-----------------------------------------
+ *	| struct sigcontext			|
+ *	|	oldmask				|
+ *	|	_sigregs *			|
+ *	-----------------------------------------
+ *	| _sigregs with				|
+ *	|	_s390_regs_common		|
+ *	|	_s390_fp_regs			|
+ *	-----------------------------------------
+ *	| int signo				|
+ *	-----------------------------------------
+ *	| _sigregs_ext with			|
+ *	|	gprs_high 64 byte (opt)		|
+ *	|	vxrs_low 128 byte (opt)		|
+ *	|	vxrs_high 256 byte (opt)	|
+ *	|	reserved 128 byte (opt)		|
+ *	-----------------------------------------
+ *	| __u16 svc_insn			|
+ *	-----------------------------------------
+ * The svc_insn entry with the sigreturn system call opcode does not
+ * have a fixed position and moves if gprs_high or vxrs exist.
+ * Future extensions will be added to _sigregs_ext.
+ */
+struct sigframe
+{
+	__u8 callee_used_stack[__SIGNAL_FRAMESIZE];
+	struct sigcontext sc;
+	_sigregs sregs;
+	int signo;
+	_sigregs_ext sregs_ext;
+	__u16 svc_insn;		/* Offset of svc_insn is NOT fixed! */
+};
+
+/*
+ * Layout of an rt signal-frame:
+ *	-----------------------------------------
+ *	| save area (_SIGNAL_FRAMESIZE)		|
+ *	-----------------------------------------
+ *	| svc __NR_rt_sigreturn 2 byte		|
+ *	-----------------------------------------
+ *	| struct siginfo			|
+ *	-----------------------------------------
+ *	| struct ucontext_extended with		|
+ *	|	unsigned long uc_flags		|
+ *	|	struct ucontext *uc_link	|
+ *	|	stack_t uc_stack		|
+ *	|	_sigregs uc_mcontext with	|
+ *	|		_s390_regs_common	|
+ *	|		_s390_fp_regs		|
+ *	|	sigset_t uc_sigmask		|
+ *	|	_sigregs_ext uc_mcontext_ext	|
+ *	|		gprs_high 64 byte (opt)	|
+ *	|		vxrs_low 128 byte (opt)	|
+ *	|		vxrs_high 256 byte (opt)|
+ *	|		reserved 128 byte (opt)	|
+ *	-----------------------------------------
+ * Future extensions will be added to _sigregs_ext.
+ */
+struct rt_sigframe
+{
+	__u8 callee_used_stack[__SIGNAL_FRAMESIZE];
+	__u16 svc_insn;
+	struct siginfo info;
+	struct ucontext_extended uc;
+};
+
+#endif /* _ASM_S390_SIGFRAME_H */
diff --git a/arch/s390/kernel/signal.c b/arch/s390/kernel/signal.c
index 4874de5edea0..42675066399f 100644
--- a/arch/s390/kernel/signal.c
+++ b/arch/s390/kernel/signal.c
@@ -32,78 +32,9 @@
 #include <asm/vdso-symbols.h>
 #include <asm/access-regs.h>
 #include <asm/lowcore.h>
+#include <asm/sigframe.h>
 #include "entry.h"
 
-/*
- * Layout of an old-style signal-frame:
- *	-----------------------------------------
- *	| save area (_SIGNAL_FRAMESIZE)		|
- *	-----------------------------------------
- *	| struct sigcontext			|
- *	|	oldmask				|
- *	|	_sigregs *			|
- *	-----------------------------------------
- *	| _sigregs with				|
- *	|	_s390_regs_common		|
- *	|	_s390_fp_regs			|
- *	-----------------------------------------
- *	| int signo				|
- *	-----------------------------------------
- *	| _sigregs_ext with			|
- *	|	gprs_high 64 byte (opt)		|
- *	|	vxrs_low 128 byte (opt)		|
- *	|	vxrs_high 256 byte (opt)	|
- *	|	reserved 128 byte (opt)		|
- *	-----------------------------------------
- *	| __u16 svc_insn			|
- *	-----------------------------------------
- * The svc_insn entry with the sigreturn system call opcode does not
- * have a fixed position and moves if gprs_high or vxrs exist.
- * Future extensions will be added to _sigregs_ext.
- */
-struct sigframe
-{
-	__u8 callee_used_stack[__SIGNAL_FRAMESIZE];
-	struct sigcontext sc;
-	_sigregs sregs;
-	int signo;
-	_sigregs_ext sregs_ext;
-	__u16 svc_insn;		/* Offset of svc_insn is NOT fixed! */
-};
-
-/*
- * Layout of an rt signal-frame:
- *	-----------------------------------------
- *	| save area (_SIGNAL_FRAMESIZE)		|
- *	-----------------------------------------
- *	| svc __NR_rt_sigreturn 2 byte		|
- *	-----------------------------------------
- *	| struct siginfo			|
- *	-----------------------------------------
- *	| struct ucontext_extended with		|
- *	|	unsigned long uc_flags		|
- *	|	struct ucontext *uc_link	|
- *	|	stack_t uc_stack		|
- *	|	_sigregs uc_mcontext with	|
- *	|		_s390_regs_common	|
- *	|		_s390_fp_regs		|
- *	|	sigset_t uc_sigmask		|
- *	|	_sigregs_ext uc_mcontext_ext	|
- *	|		gprs_high 64 byte (opt)	|
- *	|		vxrs_low 128 byte (opt)	|
- *	|		vxrs_high 256 byte (opt)|
- *	|		reserved 128 byte (opt)	|
- *	-----------------------------------------
- * Future extensions will be added to _sigregs_ext.
- */
-struct rt_sigframe
-{
-	__u8 callee_used_stack[__SIGNAL_FRAMESIZE];
-	__u16 svc_insn;
-	struct siginfo info;
-	struct ucontext_extended uc;
-};
-
 /* Store registers needed to create the signal frame */
 static void store_sigregs(void)
 {
-- 
2.51.0

