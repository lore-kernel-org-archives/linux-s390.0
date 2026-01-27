Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDD827FB35;
	Tue, 27 Jan 2026 15:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769528040; cv=none; b=FOdHhq01i3u3qg6P83Z/dNjwJm+5TlNviFvmCuD7HJd/BmNfqpuJGF7sHTgz2ZwiZ7yGERigIvJQImZYv/iR5Ox12YbH/H6FBpgy+FqLxO7ZPw7a5Ozccx9GRHyhx9/6eJt+Rv3ICZwDYt598rlnMb6J9PFBig+0tbgPtlZhAB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769528040; c=relaxed/simple;
	bh=86jpirqaQmUPCyz8o+dsbMp2rt2TgCVsRD8m15jXVwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MGZabkAyIa+1qQZR4ZWiXWf/mNokxA3gSvYAdKEza83TugUD6GHylToxDpZq+SRy5nNzhp7Uv6D/vIWVSi8QQpdwdC/H3ggfzYZmd2kf3abclOt5HJvzBdaD6W71nX8JLm+ZWD/7kNErzg+SP7WIkTmKT9rE4HazDf/XCZQfsDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K+x4OCS3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K+x4OCS3"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R80wYD010200;
	Tue, 27 Jan 2026 15:33:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FZ8S4pktqaByy4bmM
	ZjsAmN/DAuj1dp0vk/8CjYYzGk=; b=K+x4OCS3ZZ75agk3mpGHGE2+vedZv/CpE
	sD1NjiKh/TlkmNpdhhlB4597f+J5FAktRHxoKV5rjdEIP20R2Q5lnWPvg/ZU98XX
	kXkox+i28VZnhlniPC0YSDJxJv8PAQQLozUZtACwwmpQP4Gh8b//3EDE8q9mA3Jl
	vGfI1svoATSlb8IfwCHLFXs6xy7wr5axAjMe9qKxt3cBoRe5JmpCZY2hjyToxa+4
	rZfAd2dgWEoAEVifZz9fzH89S/eyHeNZcSCLuQ2Lo4nXMLbomIXb/OT9LOzW9OE9
	RX60sOnQp9GDIb31c/rXzkBnV1KeZ35cS5ns7Ir4wn9QZ2S1NY/9A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnrte437-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:33:41 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60RFTbBk027291;
	Tue, 27 Jan 2026 15:33:40 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnrte42y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:33:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60RDnlDV026333;
	Tue, 27 Jan 2026 15:33:39 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw9wk94jk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:33:38 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60RFXZZW51118590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 15:33:35 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F24D720040;
	Tue, 27 Jan 2026 15:33:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD4EB2004B;
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
Subject: [RFC PATCH v1 5/5] s390/unwind_user: Enable signal frame unwinding of user space
Date: Tue, 27 Jan 2026 16:33:31 +0100
Message-ID: <20260127153331.2902504-6-jremus@linux.ibm.com>
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
X-Proofpoint-GUID: Egw92gpmw21Tk624x5Mdz0ym_tBI3ZKX
X-Authority-Analysis: v=2.4 cv=Uptu9uwB c=1 sm=1 tr=0 ts=6978dad5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=ZF5zZzGiEMQ9POZBm20A:9
X-Proofpoint-ORIG-GUID: CJduqsfu8ckaT3gi-0pqezvQAKTeBaJV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyMSBTYWx0ZWRfX8rVLt5Xl7ClL
 FJE/3s2Blo2OpURe8yq6VPsvBVe8Vm9wYW7VMsTOkl+3R8iMgDwIfO0HawD+LZFSHhIbtjGE6rw
 ENwL1lXVV95OGhAdVze4bcQHr/0nfstMuJW3KARqIkIVh2JoUD2r4iRLdoELlTDkiTTJem7r4C9
 mM9xRSTJJUSyEs4szmvbxYlNX0oM+uBDQhkOs+5OIPQpgu/ZNlAzPHaNghd688/H156RYgnNfGk
 bzqhhciShiGtDxjAHq0JOHwG8FiE5LVbeXl/Fu/lah2CHn9NfpeTGearhtnSgTqzHg0gx9qj5yH
 dHmBDjjvhdSlUrHEFXBjIPR3JwaGWFIG5VMjkeVNL9jHQ7LqFTk7S4QlCSpDI3hXCikONv41kqk
 fwQFsl+iaZ4zbycUYSFIPlVZeTnvpRBN+cdvgSdme6f8PtJkDyWI9NPuzx0zyovY9fg2mgKNoD8
 E/zXH/m+B4NHAgarMIw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601270121

Provide a s390-specific implementation of unwind_user_signal_next(),
that unwinds from a (RT) signal frame.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 arch/s390/include/asm/unwind_user.h | 57 +++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/s390/include/asm/unwind_user.h b/arch/s390/include/asm/unwind_user.h
index a7b97ea01c26..8f5524a24ae1 100644
--- a/arch/s390/include/asm/unwind_user.h
+++ b/arch/s390/include/asm/unwind_user.h
@@ -7,6 +7,7 @@
 #include <linux/types.h>
 #include <asm/asm-offsets.h>
 #include <asm/fpu.h>
+#include <asm/sigframe.h>
 #include <asm/stacktrace.h>
 #include <linux/unwind_user_types.h>
 
@@ -67,6 +68,62 @@ static inline int arch_unwind_user_get_reg(unsigned long *val,
 }
 #define unwind_user_get_reg arch_unwind_user_get_reg
 
+#define SVC_OPCODE		0x0a
+#define INSN_SVC_SIGRETURN	((SVC_OPCODE << 8) | __NR_sigreturn)
+#define INSN_SVC_RT_SIGRETURN	((SVC_OPCODE << 8) | __NR_rt_sigreturn)
+
+static inline int unwind_user_signal_next(struct unwind_user_state *state)
+{
+	unsigned short insn;
+	const _sigregs __user *sr;
+	unsigned long sp, fp, ra;
+
+	/* ABI requires IP to be 2-byte aligned. */
+	if (state->ip & 1)
+		return -EINVAL;
+
+	if (__get_user(insn, (unsigned short __user *)state->ip))
+		return -EINVAL;
+
+	/*
+	 * A signal frame has the instruction pointer pointing to
+	 * svc $__NR_sigreturn or svc $__NR_rt_sigreturn
+	 */
+	switch (insn) {
+	case INSN_SVC_SIGRETURN:
+		/* New-style non-RT frame.  */
+		const struct sigframe __user *sf;
+
+		sf = (struct sigframe __user *)state->sp;
+		if (__get_user(sr, (_sigregs __user **)&sf->sc.sregs))
+			return -EINVAL;
+		break;
+	case INSN_SVC_RT_SIGRETURN:
+		/* New-style RT frame.  */
+		const struct rt_sigframe __user *rt_sf;
+
+		rt_sf = (struct rt_sigframe __user *)state->sp;
+		sr = (_sigregs __user *)&rt_sf->uc.uc_mcontext;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (__get_user(sp, (unsigned long __user *)&sr->regs.gprs[15]))
+		return -EINVAL;
+	if (__get_user(fp, (unsigned long __user *)&sr->regs.gprs[11]))
+		return -EINVAL;
+	if (__get_user(ra, (unsigned long __user *)&sr->regs.psw.addr))
+		return -EINVAL;
+
+	state->ip = ra;
+	state->sp = sp;
+	state->fp = fp;
+	state->topmost = false;
+	return 0;
+}
+#define unwind_user_signal_next unwind_user_signal_next
+
 #endif /* CONFIG_UNWIND_USER */
 
 #ifdef CONFIG_HAVE_UNWIND_USER_FP
-- 
2.51.0

