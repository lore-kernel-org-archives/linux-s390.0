Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6689332614;
	Tue, 18 Aug 2026 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787064637; cv=none; b=BKJwmzzzraDiKpHVmniBNis5L/NvoStr/ffy4cxnRfB6BGLeGVjiQDSVD3n9OfgweuFMJI2S8406v4af5QINY1S397Jh/vVChwjKmGP0poPu2bjIR5TUcYPvN+P/dkTi2JlQRYuX+ldmOaOdFGqqHlJ9pjJwcpxA/RM9L5bBLLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787064637; c=relaxed/simple;
	bh=TgiT8Xnhc5VLifuhTHbl67ng/yIBp4wlIbp5EtKoKcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bg8A5L8I5xctox8G8GXrXM9FhN/Q1ano5t9tGwjpEMIbiVtZlGiGQoLlpl+JBsmkX9+VVTRK3jIH9my6HmntCJ9SWtwgrVMaoL1JkdYKRzT8LVFNpwyLwlVjXL2wOsw/U27P0exuTDgBctgY4zRRKo34gRtLSOKTPW9lJKLJCn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EJWfh785; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EJWfh785"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE3q5E401906;
	Tue, 18 Aug 2026 14:50:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Y+mdTmXPgPz0paNvu
	3GnRv+WInnbZ0GCjERerrKsAso=; b=EJWfh785Gl9SgiQr7AwbltrX+doRbU/fR
	LwsRK0IV1N3UOqxq3fJkJ7ne9fVj2nE7BAdanqP4c2koPZa/chLx6OJJUVREu3vv
	cQJhaYsCd+a+zq7/E8JHERC+V0SbKP1y+Qqz6+YFSp2Lh83HhZtEoYsuIyU3b0rD
	pQ9fc8Jz5IlMeHSyO+WjYShRjKnsxhhw9dBhL+eb75ZpFU0FycdDj0bpOWDTcjcZ
	sq4KrpBXQh+voEMzF7AWXOpyrONKmTh6dBfFKIgkEXvHrbp6OjBUhnqsdDlBzF/9
	GMFIxh386YTT86+bq+5OcSAYpiYjrLyjD3Sjdkrps+XAOFWZ2iHWw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2dhm0qp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IEfOdH014762;
	Tue, 18 Aug 2026 14:50:12 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ek3r87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IEo3tT39584242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 14:50:03 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5EBE20040;
	Tue, 18 Aug 2026 14:50:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D6362004B;
	Tue, 18 Aug 2026 14:50:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 14:50:03 +0000 (GMT)
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
        Sam James <sam@gentoo.org>
Subject: [RFC PATCH v1 20/25] unwind_user/eh_frame/x86: Enable eh_frame unwinding on x86
Date: Tue, 18 Aug 2026 16:49:49 +0200
Message-ID: <20260818144954.2320378-21-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818144954.2320378-1-jremus@linux.ibm.com>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfX1d8kHklq4oDh
 qR4gu3EKLxIH2H6af2/tFoGatTv0RSz3dUC6OGuPybXidi/6OguOOpI1qUmpEf+omNupfqXwVV1
 m0njASuR8qu1Tzx0isUw0inKwarDPbTPyO80owWXYfwEacJ4wiFcS9mOvYRqeBkgf4ol3PFtg0H
 nw/YV+TenMASA0/ULS0uCECLbYW/UPZP8wbzEahyFIld3N1FLOuivkxdtTpIblhhDDMjgrMt08w
 4m5STs49i4l4nrZ6tZgZaXRV6rke0/kbPrbwY5vlQpDLV73IApD4E17R4anpZlEAKHPray8bKO1
 DEyq0KUm9tkx95jpud9s3FqJl2DxdZSlRrG9GDiZnsrzVdr9us4M4wumAjrzU/1b+8vFdv8f5QZ
 2XJ4/9D/NV2mbqfOlFx+UeMoi3InQLA3A5+82Ifg+SFS25b84RG9uE6y9T6gbFKCeTOvuKjQneJ
 pochYYMmYYf/CgHTGlA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfX4dlFwffqua8d
 36q2ijmGmJcp32QgX0E0svsuYGUKF4+TARoYPZ9NgqjLj+zJ67kyJVrqWJqYMwn7bbvk4iVygO5
 PXvc5nznVBl9532iN6qOm4wCxUlSO4M=
X-Authority-Analysis: v=2.4 cv=JKkLdcKb c=1 sm=1 tr=0 ts=6a847125 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=TKDeGWYlhpvMKGhGT-EA:9
X-Proofpoint-ORIG-GUID: s2pENtJPPp-RNFhBqfL1gEj1gc3OogDn
X-Proofpoint-GUID: iZq1MtKPvsvjYKRpHGf-XAOdce5efOHG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180107

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

