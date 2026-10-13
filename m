Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37062503BF2;
	Tue, 13 Oct 2026 13:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791898501; cv=none; b=Tjt1K87hC/XKsxLc7lvYrbQBwEi4wM73bG9j0+TCFIMnSKqBwocxMyMO6LzZv4mgUe7HnBsWnHAwVpuU0Tgg0F6tnShRIwKq0L76QYDcMyIwXBnNTZ9TATUsHmEiOvs/u9U8Rq9Kn5++2LjCGP/mSghx1hbyO9I928ZM28es2z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791898501; c=relaxed/simple;
	bh=UbF0PcLYo7bS6QiSd+ML0rVYoIY/YE2Gj3IrRPUcan4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NX1zN7+HaJjSTdtOK7O4S6+TuFRxeG6dgHMFxJ5QP5THFdM+ZW6M8ucSH29E35uYKYLtzXftCacREh9cmQf+8uRCoiXjOdFOvllwD34emGCsdc6tqlCD/v7Ix3BXC2U64PppI/zMmK3BiUuW3iKxHeanTG/kGF10l3HLoKrGUY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ereMQEhp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ereMQEhp"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D2F2Uc1775833;
	Tue, 13 Oct 2026 13:34:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=AgRMM6TJakOC0gf13
	Yo8I0oP2yKF6BxjHqBsf6iGY04=; b=ereMQEhpVHTlgkFw962fbatLm6PB3CRGH
	BTMujgys2uPp0hx1+GC2yAaVS/2oGZaMkOS5DlO6foAUTQFFiHDoe6Qt1FPH5pb4
	VlZ/AXxfaRBu0h/SUhYR7QveWu33Yo04f67XGvEoAG307ElkMEf5jjntEEpBh+Uu
	HB5uL7DpYH2eyht8aiSiIjX22+uQJvv4GBu/Un4daTsz5ZBvSPLUVSazBjpvs+JP
	v+rHA0oFogxghde1UchAHqDla5SbQEpjgAKf7+6kjNiYgJ/QM2iMkaYN6ElFTaAA
	ofxiHYP0my2XsqjO3S6p36/RXPb/nw1aaxqIQh8zemPf3hBY53XMw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhx0nv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 13:34:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69DCPW4l2667224;
	Tue, 13 Oct 2026 13:34:58 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h802vt69h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 13:34:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69DDYslo41353628
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 13:34:54 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F33A20040;
	Tue, 13 Oct 2026 13:34:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 001692005A;
	Tue, 13 Oct 2026 13:34:53 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Oct 2026 13:34:53 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v2 1/2] s390/signal: Fix incorrect return address in signal frame
Date: Tue, 13 Oct 2026 15:34:52 +0200
Message-ID: <20261013133453.2288894-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013133453.2288894-1-hca@linux.ibm.com>
References: <20261013133453.2288894-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA1MiBTYWx0ZWRfX0GINlBIzNlxx
 b2H34cW5PcLKd9VgMheBDEz6TEGEUKRQKt0QwSoiVO6Df8QesKtYe5AVyivbF1OEUrlixl7Ho7b
 NyGdZt8gsV05A9+C/uCjf/gg7G4a7a7MlEfBdiVisgXEB75Qi3nJQU8NxFaKTCYA0Wy7Ffv1lfn
 t/zKlVbnpHgzzs0YFBCJIprQA3CvIyL7rczJjneLFbTBgDjiDHfCj8NefV4Pgj9DC/G7ydARew2
 V6TKcbiHYYD0IgX/jmXCPVSqd4FwmMP3Mr4MaeUnA/91ftyMvK0ietjwJbaXVovGS9lkAmNHu8c
 AQ4QJ/9Ah1qywcz1PPoFeMGn38WrulRJUW7Qsd8qKa6qa5g862ppyfwDrkl4MaEiC4stPUSRo3K
 tauJOMWvfsZj6AiD6DZB+MaCwkU/8XGBs/ZB6Z1B8kxi3kP5I6QCYuMLhoky1VDorQWfblVIbTs
 IZTRefXzZcdqt9Gy6eg==
X-Proofpoint-GUID: P4lG1N4nUgF-aHXrvbM0yQNIJ_GvsczX
X-Proofpoint-ORIG-GUID: P4lG1N4nUgF-aHXrvbM0yQNIJ_GvsczX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA1MiBTYWx0ZWRfX/gAwYBU413tq
 ibUMflsjtG6Ihu26bELULnuW8TXjPEguiIlx/tud0qYRaVEshyvsdgXmTk2vVc0p229DlQkYhLY
 3pmPdVjMdPTH/jFtVyMp8TTWpYipPZQ=
X-Authority-Analysis: v=2.4 cv=btHZl0ai c=1 sm=1 tr=0 ts=6ace3383 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=WT4i2XjXIP67Cb3RjXIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130052

exit_to_user_mode_loop() can call arch_do_signal_or_restart() multiple
times when signals are pending.

If the first call set up a vDSO system call restart by saving the real
user return address and adjusting psw.addr so it points to the vDSO stub,
a second call builds the signal frame with the wrong return address.

Restore psw.addr from arch_data, and set the return code to -EINTR before
building the signal frame.

This requires restart_block.arch_data to be properly initialized for all
tasks. Move the initialization in copy_thread() in front of the kernel
thread check, so that it also covers kernel threads and their children
(PID 1, usermode helpers). Only PID 0 is left uninitialized, since it
never returns to user space.

Fixes: df29a7440c4b ("s390/signal: switch to using vdso for sigreturn and syscall restart")
Cc: stable@vger.kernel.org
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/process.c | 12 ++++++------
 arch/s390/kernel/signal.c  |  6 +++++-
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index 416650ae4871..4676a6a8257e 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -131,6 +131,12 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	p->thread.hardirq_timer = 0;
 	p->thread.softirq_timer = 0;
 	p->thread.last_break = 1;
+	/*
+	 * s390 stores the svc return address in arch_data when calling
+	 * sigreturn()/restart_syscall() via vdso. 1 means no valid address
+	 * stored.
+	 */
+	p->restart_block.arch_data = 1;
 
 	frame->sf.back_chain = 0;
 	frame->sf.gprs[11 - 6] = (unsigned long)&frame->childregs;
@@ -168,12 +174,6 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 		p->thread.acrs[0] = (unsigned int)(tls >> 32);
 		p->thread.acrs[1] = (unsigned int)tls;
 	}
-	/*
-	 * s390 stores the svc return address in arch_data when calling
-	 * sigreturn()/restart_syscall() via vdso. 1 means no valid address
-	 * stored.
-	 */
-	p->restart_block.arch_data = 1;
 	return 0;
 }
 
diff --git a/arch/s390/kernel/signal.c b/arch/s390/kernel/signal.c
index 4874de5edea0..b59b0c49a1aa 100644
--- a/arch/s390/kernel/signal.c
+++ b/arch/s390/kernel/signal.c
@@ -475,7 +475,11 @@ void arch_do_signal_or_restart(struct pt_regs *regs)
 		}
 		/* No longer in a system call */
 		clear_pt_regs_flag(regs, PIF_SYSCALL);
-
+		if (!(current->restart_block.arch_data & 1)) {
+			regs->psw.addr = current->restart_block.arch_data;
+			current->restart_block.arch_data = 1;
+			regs->gprs[2] = -EINTR;
+		}
 		rseq_signal_deliver(&ksig, regs);
 		handle_signal(&ksig, oldset, regs);
 		return;
-- 
2.53.0

