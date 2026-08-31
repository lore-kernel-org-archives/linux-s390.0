Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDED4AD7D3
	for <linux-s390@vger.kernel.org>; Mon, 31 Aug 2026 15:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788190123; cv=none; b=EXYUbMlIxHoQQDYuFd+r2StM12FE/ZfH23dVhOyQoNlB+8CgyK+Uw+fu5RmzlFNqlc7V1SOOjxCEANZ/KkPFUa1HL7mXstHP7ncfW9uPUzRpWXOQuHWB5mKiaF9aSzMumVStmZt97OXnXcTCwN2eyz+iVZysIZO2IIaLpnhDZNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788190123; c=relaxed/simple;
	bh=aWlpfF52MnLfp/I8C9+SvVVx6MDz+/+1eV0YgZzfMVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WwFAe/4fT4+R9SDUoYAd8+mnyCa/aDTemFSYMxhAot5jUK5cymj3Bciz6KPpOJoe6JchO1EJm7UWBXEJZUPQ6y8oU+CUIF3E7sYTDmGFcZe0Ww1ReSCbCb1m75lQlrhA+6ttNioysGRDyvSCfMQ3Q40aYokkmUNmLEyg2DunQmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mVj50PK6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mVj50PK6"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZAf82582971
	for <linux-s390@vger.kernel.org>; Mon, 31 Aug 2026 15:28:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=hIQp11QyADwzjlw5jqDFLbJh2+omSunyW2UpYmg6E
	qk=; b=mVj50PK6Hi8m9jx/gUbbkHjeVQ7XyeSMhmbXFzcCw6jhQhSET4cv/y1Nh
	TYenftQpQxetq2R/9tcIdKhypRDKbinQDJs1SD3K7SvxSpJONEq5N30/AznErCqw
	CFkU9HeXnnJ2yVaIhL+8CreLmgUpUyDin7mD1i8HJiR+FOKFu/e+ZzkVCTWiU9I+
	paqbFAA65sbGKVHlzK0N7LchVOTG7ZeK7O27zIX1B9o/P8rCLUxz57Ot4/rrJDGs
	qD9Mh7PkhDqSaR//ChQqaZt+bqMCgn0xiKqre62VPmElQmCxRi1Ho2mMhs/E7H9I
	PFtk3cHYYnV3sRC+oThgisJgCn66w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq2t21q6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 31 Aug 2026 15:28:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VFQUhN032555
	for <linux-s390@vger.kernel.org>; Mon, 31 Aug 2026 15:28:39 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarjxnyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 31 Aug 2026 15:28:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VFSXaV40239566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 15:28:34 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C69FE2004E;
	Mon, 31 Aug 2026 15:28:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 778E12004B;
	Mon, 31 Aug 2026 15:28:33 +0000 (GMT)
Received: from li-26e6d1cc-3485-11b2-a85c-83dbc1845c5e.ibm.com.com (unknown [9.111.49.7])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 15:28:33 +0000 (GMT)
From: Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: aleksei.nikiforov@linux.ibm.com
Subject: [PATCH] kmsan: fix false warnings in return_address on s390
Date: Mon, 31 Aug 2026 17:28:12 +0200
Message-ID: <20260831152811.3817938-2-aleksei.nikiforov@linux.ibm.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=bc1bluPB c=1 sm=1 tr=0 ts=6a959da8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=8FUz_h-aifKTqfv4emAA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEzMCBTYWx0ZWRfX4TRCW+WLhcTk
 nYihtLp9XVPXucCAa9O/0+ThVFKVnVs73nL8xa9gE6M11arZRCwhgJYulw6E57eCzG8Z7OeXxmO
 r6TxpFEB4s4hchR7E9Bhu4HtInhe/+c=
X-Proofpoint-ORIG-GUID: XKXFvF-xwvsGsdY5SU3FDgD65hbDDrfP
X-Proofpoint-GUID: XKXFvF-xwvsGsdY5SU3FDgD65hbDDrfP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEzMCBTYWx0ZWRfXzzN46deisbgA
 zXENVOU6qB2nK+yuv8UpskCT60wrX+pfhQFOOaCjXjKIYIUmTg/Nwah2foVePb9PLeVCNiBL7oT
 U7rBI2w8OWVdfy+QoC1ccCrRTJNVTuToqNrg6i8IabvdIb4ykC9anHjXLyd5sC5hbbERz2fXZrm
 +5Cv7CA/xzrf8qgnJVFrRBDOK2eVnMNl7RgobT7idVdQ1vyQ2wIW9EkRotbRXxvFHptj7x8WXRX
 RnnFHe2ZxPTC/1YCa3qXckZtsWv6PhU0RojZIPphRrAAjlzEpT0rLeYSPLd+YRwBF/kK8LAN03z
 xA97lxA2+dpHTnhAe5wMWcMVxUFFiQpGFrFR3BpY5RTPPVQSwTuhtop7a3WBe5L9A2D7zu3KqU0
 RbXvGGHR1a51+1hGsx3aVwjIReW6bjE08mkNC6mUZ06uJ9qeO1z0m+2UB2dRbMoyFkrU7vuFoUn
 QFosB+YZvsZSQk0WtgA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310130

Function return_address manually traverses stack frames
using backchain on s390.
Stack frames are written to stack in function prologues
and are not marked as written for kmsan.
This may lead to previous mark being used.

Let's assume that there was an unitialized area on stack.
Later backchain and other information is written there
in function prologue.
kmsan markings are unchanged in prologue.
That means data is actually initialized but incorrectly marked.
And when data is read, a false warning is emitted.

It might be possible to fix marking data written in prologue of function,
but it may be somewhat complex, especially in leaf functions
where no stack for next function call is allocated yet
and new function call would be required for kmsan helper function.

Other approach is to mark return_address function as noinstr
to skip kmsan checks there. That's approach in this patch.

When kmsan is enabled, a special noinstr wrapper function is used.
Since one more function call is introduced,
depth n of backtrace is incremented to account for this function call.

Fix false warnings like following one:

[    1.017151] =====================================================
[    1.017218] BUG: KMSAN: uninit-value in trace_hardirqs_off+0x134/0x5e0
[    1.017280]  trace_hardirqs_off+0x134/0x5e0
[    1.017330]  _raw_spin_lock_irqsave+0x74/0xc0
[    1.017375]  get_from_partial_node+0x112/0x1df0
[    1.017424]  ___slab_alloc+0x27c/0x29a0
[    1.017466]  __kmalloc_noprof+0x442/0x1cb0
[    1.017507]  alloc_workqueue_va+0x188/0x3f30
[    1.017552]  alloc_workqueue_noprof+0x236/0x260
[    1.017595]  kmem_cache_init_late+0x44/0xe0
[    1.017648]  start_kernel+0x57a/0xcd0
[    1.017689]  startup_continue+0x2e/0x40
[    1.017724]
[    1.017732] Local variable old created at:
[    1.017747]  get_from_partial_node+0x35c/0x1df0
[    1.017790]
[    1.017804] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.2.0 #54 PREEMPT
[    1.017859] Hardware name: IBM 8561 T01 703 (KVM/Linux)
[    1.017877] =====================================================

Signed-off-by: Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com>
---
 arch/s390/include/asm/ftrace.h | 6 ++++++
 arch/s390/kernel/stacktrace.c  | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
index 692c484ec163..9a9f7f2f2c36 100644
--- a/arch/s390/include/asm/ftrace.h
+++ b/arch/s390/include/asm/ftrace.h
@@ -23,7 +23,13 @@ static __always_inline unsigned long return_address(unsigned int n)
 	} while (--n);
 	return sf->gprs[8];
 }
+
+#ifdef CONFIG_KMSAN
+unsigned long return_address_noinstr(unsigned int n);
+#define ftrace_return_address(n) return_address_noinstr(n)
+#else
 #define ftrace_return_address(n) return_address(n)
+#endif
 
 void ftrace_caller(void);
 
diff --git a/arch/s390/kernel/stacktrace.c b/arch/s390/kernel/stacktrace.c
index 18520d333058..db458050d8bf 100644
--- a/arch/s390/kernel/stacktrace.c
+++ b/arch/s390/kernel/stacktrace.c
@@ -146,3 +146,11 @@ void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
 {
 	arch_stack_walk_user_common(consume_entry, cookie, NULL, regs, false);
 }
+
+#ifdef CONFIG_KMSAN
+noinstr unsigned long return_address_noinstr(unsigned int n)
+{
+	/* Add 1 to account for call of uninlined function return_address_noinstr */
+	return return_address(n+1);
+}
+#endif
-- 
2.43.7

