Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAB52F0C7E;
	Wed, 15 Jul 2026 13:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784122760; cv=none; b=MTqvx7RPzYuSs7xM0LF1tAxCGTAXA24tpIiIVGPNrDob7i+9xJ6lrKYwIko40EwH6E2GmNdbNCJEWzua5QnEJNU0amMAxiGKbaWDzZE6g1GaL5yjhOKyu3GSMbPXMjXmMYzmxMsH1iGOENZt/QxDI89e5POXrbjDM1maxRbCTeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784122760; c=relaxed/simple;
	bh=LFpRRLAwGojICFfqvVUiszV0t6Dtp06cOg2uLaqds3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2LgElXBtrPvgj5n3pzpYsfwNDDYMT5fj/VNGUWA6vlRevlXy44/CWw7cY/a5YtB1TXrvqYXiOoWIWSSlMH5tmY4viY4kkIGarRmlKFsNwgofYgIubNSkeppWSVeeXVXiwQPUNWUTS3Qm3WdYWhXUE4dcvmSMhL+oo9QLRqlpMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LD+q8a7G; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LD+q8a7G"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FBg474051881;
	Wed, 15 Jul 2026 13:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=mEugLMrTgEXFnbcW1
	uLOAmhX9P3SVYXWKPsXxdRsQ1I=; b=LD+q8a7G+xO3vbGHiC6/Lp/qMpS3mqEWp
	l0o346t21CmhvxDbb28OZUuNNqGCeWYZx1R7ixZZXeh1OxTlSK5lnLS9OvR2O12/
	jZqNOwdUxpRxnyXWQlPsaroDSd2Y4Nvuu1pYouqZfDJir0a8V4WgvcuWIsYi3ILG
	2zsi5ArvCg5tfs/tGzxk9p9e2zFQ1OgnmZa6GaNF6Jmyl7zNFak1SLPcItGDDCqJ
	z/Siygs+Gj6He3lVEFyZAWOUql2t0na1nK7lpVJlRAodwBiS4VCWLlYU/WpB35gI
	dxAb/nM6eFjdyE32T3cqaOq3s9dZrEZAZYRnsE1cHSFwJoxts+DWA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegbu7jy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 13:39:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66FDYZZX011026;
	Wed, 15 Jul 2026 13:39:05 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nhg5fr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 13:39:05 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66FDd1U441419120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jul 2026 13:39:01 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43B162004D;
	Wed, 15 Jul 2026 13:39:01 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 211262004B;
	Wed, 15 Jul 2026 13:39:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 15 Jul 2026 13:39:01 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id 0A42F1624F9; Wed, 15 Jul 2026 15:39:01 +0200 (CEST)
From: Sven Schnelle <svens@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
        Peter Zijlstra <peterz@infradead.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] s390/syscall: Keep syscall number in extra ptregs member
Date: Wed, 15 Jul 2026 15:38:30 +0200
Message-ID: <20260715133830.2619853-3-svens@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715133830.2619853-1-svens@linux.ibm.com>
References: <20260715133830.2619853-1-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a578d7a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=1LztGbuzUtLrLWyZigkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDEzMSBTYWx0ZWRfX/V6cTwX33y7E
 nSoQyi7hFaKAKQu9tW9z69NkdT5Kp2g5xKjpW1Xh2hbcWxKp5TKxtvHRCLZQoP1lrBYS/NMO8iF
 sKZDQFpfZEJgEUoIAYCo2d9e6waB3+hajF505vd5VtteFrYWpWDf9sqSZKk4A3WCdEDAbhnf/dq
 yM6uhy0TDfVIy1lKawS11XmSTsFvh/fuKVVjeiFyn7CvD8xmAO69EWjsj8MRHh1aOw0qrK18YXB
 sG4LueIMVI87E+mvScqHSb082joqqd7nLsd+ZeWyTqdqsM6yC/umtocyfensFpa0m7O8QsCF5j1
 K1zbcXTQjUYcj9WVUxaxRINqsOpnQ6JWmeru2HSAnHadvsuKYr+ZS0+EMM5Jt+1v8CgJQf9lgEZ
 RFT+HpyXOBygw0mE8kFksOh3H/MpRlzCWyXJFlBDt0Inf8fp/MI7Zmlh9wrU0psPfOifwnXGh9j
 U1fq5q8r6goe3VQmX+g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDEzMSBTYWx0ZWRfX2iCzeFRcvQOA
 SwdYaZxRW4nSUVIifPaUBACEUG7yhF2w8hddBqQ2LI+oUB+OJRi6ssojtybn250RTlHmTVSJzWn
 OIPABPx2RYFr6QAMmy3hzw16174J1h4=
X-Proofpoint-GUID: i3-KhUENUgcU74dDnGiwjf5msIV6HiML
X-Proofpoint-ORIG-GUID: i3-KhUENUgcU74dDnGiwjf5msIV6HiML
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607150131

Move the syscall number from ptregs::int_code to another union member
called syscall_nr. This simplifies the code a bit.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 arch/s390/include/asm/ptrace.h  |  2 +-
 arch/s390/include/asm/syscall.h |  8 +++++---
 arch/s390/kernel/ptrace.c       |  2 +-
 arch/s390/kernel/signal.c       | 12 +++++-------
 arch/s390/kernel/syscall.c      | 11 ++++-------
 5 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrac=
e.h
index f39b349da9a7..2edc85ddcba8 100644
--- a/arch/s390/include/asm/ptrace.h
+++ b/arch/s390/include/asm/ptrace.h
@@ -130,7 +130,7 @@ struct pt_regs {
 			unsigned long int_parm_long;
 		};
 		struct {
-			unsigned long __unused;
+			unsigned long syscall_nr;
 			unsigned long syscall_ret;
 		};
 		struct tpi_info tpi_info;
diff --git a/arch/s390/include/asm/syscall.h b/arch/s390/include/asm/sysc=
all.h
index 22b6ed20a9ae..abb0d4348912 100644
--- a/arch/s390/include/asm/syscall.h
+++ b/arch/s390/include/asm/syscall.h
@@ -14,13 +14,15 @@
 #include <linux/err.h>
 #include <asm/ptrace.h>
=20
+#define SVC_LEN 2
 extern const sys_call_ptr_t sys_call_table[];
=20
 static inline long syscall_get_nr(struct task_struct *task,
 				  struct pt_regs *regs)
 {
-	return test_pt_regs_flag(regs, PIF_SYSCALL) ?
-		(regs->int_code & 0xffff) : -1;
+	if (!test_pt_regs_flag(regs, PIF_SYSCALL))
+		return -1;
+	return regs->syscall_nr;
 }
=20
 static inline void syscall_set_nr(struct task_struct *task,
@@ -32,7 +34,7 @@ static inline void syscall_set_nr(struct task_struct *t=
ask,
 	 * the target task is stopped for tracing on entering syscall, so
 	 * there is no need to have the same check syscall_get_nr() has.
 	 */
-	regs->int_code =3D (regs->int_code & ~0xffff) | (nr & 0xffff);
+	regs->syscall_nr =3D nr;
 }
=20
 static inline void syscall_rollback(struct task_struct *task,
diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index 125ca4c4e30c..00e825d01504 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -349,7 +349,7 @@ static int __poke_user(struct task_struct *child, add=
r_t addr, addr_t data)
 			addr =3D=3D offsetof(struct user, regs.gprs[2])) {
 			struct pt_regs *regs =3D task_pt_regs(child);
=20
-			regs->int_code =3D 0x20000 | (data & 0xffff);
+			regs->syscall_nr =3D data;
 		}
 		*(addr_t *)((addr_t) &regs->psw + addr) =3D data;
 	} else if (addr < offsetof(struct user, regs.orig_gpr2)) {
diff --git a/arch/s390/kernel/signal.c b/arch/s390/kernel/signal.c
index 4874de5edea0..c3c69294ff33 100644
--- a/arch/s390/kernel/signal.c
+++ b/arch/s390/kernel/signal.c
@@ -447,12 +447,12 @@ void arch_do_signal_or_restart(struct pt_regs *regs=
)
 	 * call information.
 	 */
 	current->thread.system_call =3D
-		test_pt_regs_flag(regs, PIF_SYSCALL) ? regs->int_code : 0;
+		test_pt_regs_flag(regs, PIF_SYSCALL) ? regs->syscall_nr : 0;
=20
 	if (get_signal(&ksig)) {
 		/* Whee!  Actually deliver the signal.  */
 		if (current->thread.system_call) {
-			regs->int_code =3D current->thread.system_call;
+			regs->syscall_nr =3D current->thread.system_call;
 			/* Check for system call restarting. */
 			switch (regs->gprs[2]) {
 			case -ERESTART_RESTARTBLOCK:
@@ -467,9 +467,7 @@ void arch_do_signal_or_restart(struct pt_regs *regs)
 				fallthrough;
 			case -ERESTARTNOINTR:
 				regs->gprs[2] =3D regs->orig_gpr2;
-				regs->psw.addr =3D
-					__rewind_psw(regs->psw,
-						     regs->int_code >> 16);
+				regs->psw.addr =3D __rewind_psw(regs->psw, SVC_LEN);
 				break;
 			}
 		}
@@ -484,7 +482,7 @@ void arch_do_signal_or_restart(struct pt_regs *regs)
 	/* No handlers present - check for system call restart */
 	clear_pt_regs_flag(regs, PIF_SYSCALL);
 	if (current->thread.system_call) {
-		regs->int_code =3D current->thread.system_call;
+		regs->syscall_nr =3D current->thread.system_call;
 		switch (regs->gprs[2]) {
 		case -ERESTART_RESTARTBLOCK:
 			/* Restart with sys_restart_syscall */
@@ -498,7 +496,7 @@ void arch_do_signal_or_restart(struct pt_regs *regs)
 		case -ERESTARTSYS:
 		case -ERESTARTNOINTR:
 			regs->gprs[2] =3D regs->orig_gpr2;
-			regs->psw.addr =3D __rewind_psw(regs->psw, regs->int_code >> 16);
+			regs->psw.addr =3D __rewind_psw(regs->psw, SVC_LEN);
 			if (test_thread_flag(TIF_SINGLE_STEP))
 				clear_thread_flag(TIF_PER_TRAP);
 			break;
diff --git a/arch/s390/kernel/syscall.c b/arch/s390/kernel/syscall.c
index ce244dceec6d..62e283ffef37 100644
--- a/arch/s390/kernel/syscall.c
+++ b/arch/s390/kernel/syscall.c
@@ -100,7 +100,10 @@ void noinstr __do_syscall(struct pt_regs *regs, int =
per_trap)
 	enter_from_user_mode(regs);
 	add_random_kstack_offset();
 	regs->psw =3D get_lowcore()->svc_old_psw;
-	regs->int_code =3D get_lowcore()->svc_int_code;
+	nr =3D get_lowcore()->svc_int_code & 0xffff;
+	if (likely(!nr))
+		nr =3D regs->gprs[1];
+	regs->syscall_nr =3D nr;
 	update_timer_sys();
 	if (cpu_has_bear())
 		current->thread.last_break =3D regs->last_break;
@@ -110,12 +113,6 @@ void noinstr __do_syscall(struct pt_regs *regs, int =
per_trap)
 		set_thread_flag(TIF_PER_TRAP);
 	regs->flags =3D 0;
 	set_pt_regs_flag(regs, PIF_SYSCALL);
-	nr =3D regs->int_code & 0xffff;
-	if (likely(!nr)) {
-		nr =3D regs->gprs[1] & 0xffff;
-		regs->int_code &=3D ~0xffffUL;
-		regs->int_code |=3D nr;
-	}
 	regs->gprs[2] =3D nr;
 	regs->syscall_ret =3D -ENOSYS;
 	if (nr =3D=3D __NR_restart_syscall && !(current->restart_block.arch_dat=
a & 1)) {
--=20
2.53.0

