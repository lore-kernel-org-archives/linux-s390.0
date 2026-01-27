Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45112E62C3;
	Tue, 27 Jan 2026 15:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769528039; cv=none; b=jj3iSn3YXLaAbUqYx9lsWBuxGuMbFdWpps2FRBLKMSaeGGX1fxvYR7P7XSQhgHdPsAZ6fOPAaeQJDOA9o/l0TY1KoIJW5KZlhOZFP6pGMR5nrBmVjzjnIe/FiHgKcq6KzUbVoLfBHsQ1ylIEcaNkFOjeS+IM034cxn0g1TsyR6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769528039; c=relaxed/simple;
	bh=fckhmEHCu07z8Mxu4nptZTCsNrlx4U4UfODG2qNYOg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uUu8QGuSc4zJ1ITdCHTFY3XlYu7HXaiqPOxf7sB9phh1Tb2l2C7KKlb41b6WEOK03gSd3ce+qnFXuS//cf889XDOFGB6r/eCGppA8jZQrraxun89msGJ93llAbviiqtvWePi/nr8XgZFDn0xRQAsVhdPMJSbNnwkMpfQJOZX4CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ajPwMbf5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ajPwMbf5"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R6iIkV015740;
	Tue, 27 Jan 2026 15:33:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=QZ99OWNmMBbUEI/up
	S6Lh/Pr3C7xmJcHJQVJOuXZK4Q=; b=ajPwMbf5t+HJKMFljln0ZDk5HV+yBxiyo
	AN8y6ysrBrh6Yov6dj9cekMV1wjIKOOTMV8elnCWRH/J+sXgQeQEywsRVlhN0pp5
	FZd0ScQQPx+UHXUMzdvPg/IDQGuXIOcopKpvqS9Tp5IY9QWUk0Mq5LGoBfCf/e+8
	HTRtRjccvcZzQ58Vff3b9w34Qgx4YsBpDinwT3vX7limAC66uh+dBZHoVhiSbKKU
	4z07P3nw+UYGYT9mBC34HJN5Ay5Vt+PwSRWRHH4wBL5OR1EPhrOZY7Cyppw8MoOG
	S7Ji4wkYvyi3PGg4OaS8E/gaqdLtD931R3uJpPsyE8QQz5cWS2NJg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvkgmmnnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:33:39 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60RFXdlo028803;
	Tue, 27 Jan 2026 15:33:39 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvkgmmnmx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:33:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60REjchQ018399;
	Tue, 27 Jan 2026 15:33:38 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bwb41rx1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:33:38 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60RFXYXi17826174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 15:33:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A3F920043;
	Tue, 27 Jan 2026 15:33:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16A8F2004E;
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
Subject: [RFC PATCH v1 3/5] s390/vdso: Annotate __kernel_[rt_]sigreturn as signal frames
Date: Tue, 27 Jan 2026 16:33:29 +0100
Message-ID: <20260127153331.2902504-4-jremus@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Gr1PO01C c=1 sm=1 tr=0 ts=6978dad3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=zNkqyI7T-dXuitzZt0UA:9
X-Proofpoint-GUID: SY8BXNk1xyheiTHU5IBxjM5Ph5-Sya8r
X-Proofpoint-ORIG-GUID: _BjtumY_aMyvFAWO4fAwnrAaACY4d7u3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyNSBTYWx0ZWRfX1DV/G7FoRixL
 PWN30h/Qeq3E5KxxA5Qix73RlQto54TqjoelNNP8ldv9Gqf+Y66qh59LUOAplvSXv0xC6bNkBH8
 UHeB9lLvxvvHFD7Armf+Ul8TlaW3AtpCyaQcB9AIMMJ+yGuyS1RikwWG9ECh7eqsucNuyGHAkLd
 5Cqk3JB0+Au8MUPwk+7iJyNApXXhSQ97RKDkZnX1uR07NMSg8gp3aYMT7HfvD2jrvCYuNEcX3Nk
 mHp42IJc8At5mZ2TiXjlZWGxrWUcZFQyy+O6G/ERVAhyO0UfXWR0L8zdPxJKiIrYBJRypV5egbS
 gkNIvhvwXkWDjhdTkmwu8vInRUDwOhqeFtqTH7MmfqgwcSTY0LJ4918SMEsbguML4eGCyP6MfDc
 dwufAqHukGY1C9vaTe2YeYsQw3Stiq2S8ow/p/RaFeE/ldSFi9DWvRdbhiiycl5At6RtHDNibLV
 lpcL/1fS6mcKAV3L39g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601270125

The GNU assembler supports CFI directive .cfi_signal_frame with
binutils 2.17+.  Use it to annotate the vDSO functions
__kernel_sigreturn() and __kernel_rt_sigreturn() as signal
frames.

This enables generation of SFrame stack trace information for the
vDSO to likewise annotate these functions for use in stack tracers,
such as the kernel unwind user sframe.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 arch/s390/include/asm/dwarf.h             |  3 +++
 arch/s390/kernel/vdso/vdso_user_wrapper.S | 15 +++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/dwarf.h b/arch/s390/include/asm/dwarf.h
index 2f148b15fd7d..e5663d6b11db 100644
--- a/arch/s390/include/asm/dwarf.h
+++ b/arch/s390/include/asm/dwarf.h
@@ -35,6 +35,8 @@
 #define CFI_VAL_OFFSET		nocfi
 #endif
 
+#define CFI_SIGNAL_FRAME	.cfi_signal_frame
+
 #else /* !BUILD_VDSO */
 
 /*
@@ -49,6 +51,7 @@
 #define CFI_RESTORE		nocfi
 #define CFI_REL_OFFSET		nocfi
 #define CFI_VAL_OFFSET		nocfi
+#define CFI_SIGNAL_FRAME	nocfi
 
 #endif /* !BUILD_VDSO */
 
diff --git a/arch/s390/kernel/vdso/vdso_user_wrapper.S b/arch/s390/kernel/vdso/vdso_user_wrapper.S
index aa06c85bcbd3..757503929ab0 100644
--- a/arch/s390/kernel/vdso/vdso_user_wrapper.S
+++ b/arch/s390/kernel/vdso/vdso_user_wrapper.S
@@ -47,6 +47,17 @@ SYM_FUNC_START(__kernel_\func)
 SYM_FUNC_END(__kernel_\func)
 .endm
 
+.macro vdso_syscall_sf func,syscall
+SYM_FUNC_START(__kernel_\func)
+	CFI_STARTPROC simple
+	CFI_SIGNAL_FRAME
+	svc	\syscall
+	/* Trap, if syscall returns, which shouldn't happen */
+	.insn e,0x0000
+	CFI_ENDPROC
+SYM_FUNC_END(__kernel_\func)
+.endm
+
 vdso_syscall restart_syscall,__NR_restart_syscall
-vdso_syscall sigreturn,__NR_sigreturn
-vdso_syscall rt_sigreturn,__NR_rt_sigreturn
+vdso_syscall_sf sigreturn,__NR_sigreturn
+vdso_syscall_sf rt_sigreturn,__NR_rt_sigreturn
-- 
2.51.0

