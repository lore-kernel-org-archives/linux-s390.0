Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB88D3F9278;
	Fri, 21 Aug 2026 19:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787342054; cv=none; b=b4SUXfiL24ZDN7S/2phmMxgQdtUsZo66WDiCWk+bglDponZ3hL2RhmEf5q27T2LTJzA74eikUT46nPwbK64PLCpGhmXwLPnxVbqWv2xMvrbDcCX8M2HJXrpQCyuvSgdTVBLu5Ofrhz3UgyaH50Ue8w0pA9izqMka6gl//PHoKs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787342054; c=relaxed/simple;
	bh=TgiT8Xnhc5VLifuhTHbl67ng/yIBp4wlIbp5EtKoKcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K1NR8iNILoybXsuN4M41Ke5+kHkqTAFaCqsm11KIho8FhcnxV/NVQckpOUWeGMHCZc8SoVC+u+qB2RuWmCJwJBJPr04qirW2LvtCQ/HVfWf/9Ors7za2GVdXD1gQFF9Dvs02zogSMlYTl6uAqOZ+6ZKB4K5gweJW+8CSUZE9MSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f1qgWRvD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f1qgWRvD"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LIW5bb2254763;
	Fri, 21 Aug 2026 19:53:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Y+mdTmXPgPz0paNvu
	3GnRv+WInnbZ0GCjERerrKsAso=; b=f1qgWRvDG1qtN2I/6fsZuazodHrXbDBwJ
	1Jyk3nc+YOMEs3AzpgQtWuH2a7asHZNUnLP7El7bK8yXUIcc+OmucAHRZ5Pd1aD+
	ntWL1d5gfrq5hyCUG9YCOX9K3edAqnRM7775KCBIBIK8OpBJY9sx36BxZACGzZAQ
	RdtmM8SEoPPfYHFQgz9ff31UxP1ilTJ07zDSzKLAZRImUkTsPQA+TpXH9Gt+u5EC
	cHecAS44Q7ZdDiZvU/DGFZp1ZzltMnAgLcVR93MhXZ5n3sGucRVq72iPWqsyb6d2
	ENEmqd0wMiFt+Sbv3v4SKnRuzshAW4Kap9j9QmkjZ8oRAbTR67cRA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4krkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LJfIZP016594;
	Fri, 21 Aug 2026 19:53:14 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xhpnkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:14 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LJrAe010420482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 19:53:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C5F420040;
	Fri, 21 Aug 2026 19:53:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4EA252004B;
	Fri, 21 Aug 2026 19:53:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 19:53:10 +0000 (GMT)
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
Subject: [RFC PATCH v2 19/24] unwind_user/eh_frame/x86: Enable eh_frame unwinding on x86
Date: Fri, 21 Aug 2026 21:52:54 +0200
Message-ID: <20260821195259.2688377-20-jremus@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX7P16kilAz/Cg
 Lq/sSi7M8fKGWynnhYOI+Kza/6SGI/O/WNq/fSqjEbktt6d3IWsHxHCJo+GdfSCxnJ4nrgueh0n
 Vh5XwJKguDm8wOsvkWo9ptgtUCuIT9Y=
X-Proofpoint-GUID: hX6K2Yi5jUq9h32bOLekL6f4ADhy0INj
X-Proofpoint-ORIG-GUID: MB8ma26FyBMsQ5YMuoUB-JXbpT_uSI9A
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a88acab cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=TKDeGWYlhpvMKGhGT-EA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX42idbx157ijU
 ecZfUaHcpMcqMrpf64CuqiHi7T9YZVpLzRwVU2D7WsjVfF24QOhfk2qOzm+usBRMBt7qdX7aYqT
 ue2++I+Gzfss0TNxoRooL5m6BuZcupxQ+wIFOrZoHl7NqjEiiM+MSv8rptMoOIFYMXJGxdkA1J5
 JIpvI3wHakZWEVScZ2kdaqStEF8WyY5PZaYrgl4VnRBLBvEC9xZa1g7W7JR647eBdN77ir/UCIH
 Ks/jLqCBvFZSIBBj3ayZxPsp6ZfnKpmWthERW/9P8R9IEDBwBlw6/OyPEK8D/FDVUtNx4fdvx+U
 7RXNGEAYseI0kyMNjAHPtOlfntHH3/U21kA0JxrYti6b91dR4Zkg8jIuqGhFjrU33XmmtgeRHb+
 Hp60ofot2kfPMdnmOd4JnnTqhflQ56CEqepdG0QXSfbuotw+sFeHFyNHXR2yD6cSYCPqq5rzpQH
 Y8zOQ/NDI0Y2Z3L4hig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210155

The x86-64 .eh_frame implementation works well with GCC and Clang
generated code.  Enable it.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 arch/x86/Kconfig                            |  1 +
 arch/x86/include/asm/unwind_user.h          | 40 +++++++++++++++++++++
 arch/x86/include/asm/unwind_user_eh_frame.h | 22 ++++++++++++
 3 files changed, 63 insertions(+)
 create mode 100644 arch/x86/include/asm/unwind_user_eh_frame.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index bdad90f210e4..fe7919915084 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -300,6 +300,7 @@ config X86
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UACCESS_VALIDATION		if HAVE_OBJTOOL
 	select HAVE_UNSTABLE_SCHED_CLOCK
+	select HAVE_UNWIND_USER_EH_FRAME	if X86_64
 	select HAVE_UNWIND_USER_FP		if X86_64
 	select HAVE_USER_RETURN_NOTIFIER
 	select HAVE_GENERIC_VDSO
diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
index c96645c824d1..df1966bcb0f6 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -4,6 +4,7 @@
 
 #ifdef CONFIG_UNWIND_USER
 
+#include <linux/sched/task_stack.h>
 #include <asm/ptrace.h>
 #include <asm/uprobes.h>
 
@@ -15,6 +16,45 @@ static inline int unwind_user_word_size(struct pt_regs *regs)
 	return user_64bit_mode(regs) ? 8 : 4;
 }
 
+#ifdef CONFIG_X86_64
+
+static inline int unwind_user_get_reg(unsigned long *val, unsigned int regnum)
+{
+	struct pt_regs *regs = task_pt_regs(current);
+
+	/* TODO: eh_frame is currently limited to x86-64 */
+	if (!user_64bit_mode(regs))
+		return -EINVAL;
+
+	switch (regnum) {
+	/* DWARF register numbers 0..15 */
+	case  0: *val = regs->ax; break;
+	case  1: *val = regs->dx; break;
+	case  2: *val = regs->cx; break;
+	case  3: *val = regs->bx; break;
+	case  4: *val = regs->si; break;
+	case  5: *val = regs->di; break;
+	case  6: *val = regs->bp; break;
+	case  7: *val = regs->sp; break;
+	case  8: *val = regs->r8; break;
+	case  9: *val = regs->r9; break;
+	case 10: *val = regs->r10; break;
+	case 11: *val = regs->r11; break;
+	case 12: *val = regs->r12; break;
+	case 13: *val = regs->r13; break;
+	case 14: *val = regs->r14; break;
+	case 15: *val = regs->r15; break;
+	default:
+		pr_debug("%s (%d): %s(%u): unsupported register number\n",
+			 current->comm, current->pid, __func__, regnum);
+		return -EINVAL;
+	}
+	return 0;
+}
+#define unwind_user_get_reg unwind_user_get_reg
+
+#endif /* CONFIG_X86_64 */
+
 #endif /* CONFIG_UNWIND_USER */
 
 #ifdef CONFIG_HAVE_UNWIND_USER_FP
diff --git a/arch/x86/include/asm/unwind_user_eh_frame.h b/arch/x86/include/asm/unwind_user_eh_frame.h
new file mode 100644
index 000000000000..fdccbda2fe4b
--- /dev/null
+++ b/arch/x86/include/asm/unwind_user_eh_frame.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_UNWIND_USER_EH_FRAME_H
+#define _ASM_X86_UNWIND_USER_EH_FRAME_H
+
+#ifdef CONFIG_X86_64
+
+#define EH_FRAME_REG_SP	7	/* designated stack pointer register */
+#define EH_FRAME_REG_FP	6	/* designated frame pointer register */
+#define EH_FRAME_REG_RA	16	/* (pseudo) return address register */
+
+/* Instructions must be 1-byte aligned */
+#define EH_FRAME_MAX_CODE_ALIGN 1
+
+/* Stack grows towards lower addresses and SP must be 8-byte aligned */
+#define EH_FRAME_MIN_DATA_ALIGN -8
+#define EH_FRAME_MAX_DATA_ALIGN -1
+
+#endif
+
+#include <asm-generic/unwind_user_eh_frame.h>
+
+#endif /* _ASM_X86_UNWIND_USER_EH_FRAME_H */
-- 
2.53.0

