Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F299248425A;
	Tue, 18 Aug 2026 18:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787076863; cv=none; b=DiTb/8VUMUxPalAChmV+9ehwXegpUDQ3YsEEdvWcN42yYT/nbUxJBrGZjzD0JhjB+UniUWoH/BbMAHGL6QbLnrhZXFcFfBTt7iVwgFrXZjvc8X2eu7NYH093LzMSoV0Z+Xh1h+GPUbpLEIWozOqUQR6mIgOOzZwUtCEcBcscmGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787076863; c=relaxed/simple;
	bh=XsCM3Qnnqz8ZMwHkykfDIgp3J/doiSoBPfvx/1cnMKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b4qlCApuG7prmDtHXpNZrjOECHqoGD1aWwtR7PxcbUvAU5zlmKRYmL9mK8JAkQu/5s279W8+pHoGfL933JRizK012SrOwOouyc9pNZ2UXPZ6u0lhhxx2/E3Dy6Jtc6Jm3zprZCYyJZeXkKDL/SQ8mmvROzIEmQZhAigaKlLIigU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ssG0RXIO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ssG0RXIO"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IHVWVi932437;
	Tue, 18 Aug 2026 18:14:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=gF8BVm8uvhBe8RTU8mZVtkp7HnuvwdoRlzUWKx6XY
	JM=; b=ssG0RXIO2diocysnJLIpbLZOmaUAF/R2fH+IJQYsHVPau/tf4NjBcL3V7
	t3AavyYyrRJcf8Gha2xDxSHF+/InqxOwC6Egi0I6AL9IMWUDdM2+jRowYWozdNfD
	TpEg6bSskaHIKbmwl53CRsLxLbHL3c4eN3N08AbDHQhTrEvTnn1LTgGlTWyWG+mj
	0oNhruLN3XQVLI/G0uIMMdW6pRbgEtK6Wl74q3C3y9hun/rVEcy5713c8dVL5CHv
	Yw3D9+ARdhxSLlF4PempVBa3Qol74wPeLzYo4upa9e6rL5PWi9zjUcYRcxFgy8cN
	QmBhqW7K2eefWuOGaYP5bGQnJdgAw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fm3t2dx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 18:14:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IIBI1L016134;
	Tue, 18 Aug 2026 18:14:11 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354ycfaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 18:14:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IIE8f838142398
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 18:14:08 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3898D2004D;
	Tue, 18 Aug 2026 18:14:08 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 886A420043;
	Tue, 18 Aug 2026 18:14:07 +0000 (GMT)
Received: from li-d2cd37cc-2ca3-11b2-a85c-84ed3706e5a0.ibm.com (unknown [9.87.142.99])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 18:14:07 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>, Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>
Cc: linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com>,
        linux-s390@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] rseq: Out-of-line rseq_exit_user_update() for KMSAN
Date: Tue, 18 Aug 2026 20:12:49 +0200
Message-ID: <20260818181328.2963038-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Rth__ZDKU1atolB_Z0s1vOlrITZsLJUu
X-Proofpoint-ORIG-GUID: 9HoS9nQBnbhUbhGlj_iOHJoLT0nHkEYy
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEzMyBTYWx0ZWRfX+9YABC+a0Of+
 S7reecgzODwjaSFKb050v0CduCMPIReXYNOd5h/2xF/CJPQgG7Z1ffaJoBDl5nWBzYlpegBY2Yx
 jizlc6sdLwFiwxeFQw6YDtUFCDtYkrA=
X-Authority-Analysis: v=2.4 cv=WtQb99fv c=1 sm=1 tr=0 ts=6a84a0f5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=4DPV4PFdrL5DSAU6TMgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEzMyBTYWx0ZWRfX86URenIvRDuT
 fMyqxpwgobcIVhcHbk5bFaAtstqWeXYvHrndrq3Uz254smpKO/r73ncQrkACoYUOVtq44QSy2aR
 TvxoDSVH5mCUO6q0md8MZXzT1dkse9jKVJEIjtGuth6OJ6XemGP9XujUbDKvIL0cfZEupMKOlB9
 kKIIomphd+XnDw9+uHvg6/fSaMoEzqYJx8zY11t0zdDekB2UE0nx0GJd8ltpm9OceqG0o4Qzm7q
 orwckRw2K+aYVBZSyoXCVOqUjpW81xnJa0ja2OoNLQpzPatR1yFaZem6TWyNSehLFc1n7qHfbcw
 /AJPT8IdP/AeDJajT1MwSAI0kmS9MS3ikxsEk5ZnaMrT7Y4eFr0IZRuz6JS+F2jrhzvFNVh8ejW
 EiRVDS42lq/faoTSnycawWoerTsMN3LRqBr1zfYFkU98CV7hB6h3GtnCbtvibyxHG5JgFbOSlpk
 tooONN79X0m0Gjene/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180133

KMSAN produces the following false positive on s390x:

    [    4.232136] Kernel panic - not syncing: kmsan.panic set ...
    [    4.232339] CPU: 7 UID: 0 PID: 1 Comm: virtme-init Tainted: G    B            N  7.2.0-rc6-virtme #27 PREEMPTLAZY
    [    4.232676] Tainted: [B]=BAD_PAGE, [N]=TEST
    [    4.232808] Hardware name: IBM 3931 A01 701 (KVM/Linux)
    [    4.232971] Call Trace:
    [    4.233065]  [<000002dcfb993140>] vpanic+0xb50/0x1080
    [    4.239698]  [<000002dcfb9925ec>] panic+0x22c/0x230
    [    4.239879]  [<000002dcfcec5d32>] kmsan_report+0x322/0x330
    [    4.240081]  [<000002dcfcec3592>] kmsan_internal_check_memory+0x222/0x280
    [    4.240304]  [<000002dcffe3444e>] irqentry_exit+0x50e/0x8f0
    [    4.240522]  [<000002dcffe33454>] __do_pgm_check+0x1b4/0x2b0
    [    4.240740]  [<000002dcffe75304>] pgm_check_handler+0x114/0x160

The reason is that the following call chain inlined into the noinstr
irqentry_exit() function:

    irqentry_exit()
      irqentry_exit_to_user_mode()
        irqentry_exit_to_user_mode_prepare()
          __exit_to_user_mode_prepare()
            exit_to_user_mode_loop()
              rseq_exit_to_user_mode_restart()
                __rseq_exit_to_user_mode_restart()
                  rseq_exit_user_update()

does not set KMSAN shadow on struct rseq_ids, which is then verified by

    rseq_exit_user_update()
      rseq_update_usr()
        rseq_set_ids_get_csaddr()
          unsafe_put_user()

regardless of presence of KMSAN instrumentation.

Fix by out-of-lining rseq_exit_user_update() and compiling the
out-of-lined version with KMSAN instrumentation.

This should affect other architectures as well, but whether one
actually sees it depends on the leftover shadow of struct rseq_ids
stack location: s390 is not special here.

Fixes: 05b44aef709c ("rseq: Implement fast path for exit to user")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 include/linux/rseq_entry.h | 9 ++++++++-
 kernel/rseq.c              | 7 +++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/rseq_entry.h b/include/linux/rseq_entry.h
index ed9da6e41a2aa..a396050f771cc 100644
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -595,7 +595,8 @@ static rseq_inline bool rseq_update_usr(struct task_struct *t, struct pt_regs *r
  * tells the caller to loop back into exit_to_user_mode_loop(). The rseq
  * slow path there will handle the failure.
  */
-static __always_inline bool rseq_exit_user_update(struct pt_regs *regs, struct task_struct *t)
+static __always_inline bool rseq_exit_user_update_inline(struct pt_regs *regs,
+							 struct task_struct *t)
 {
 	/*
 	 * Page faults need to be disabled as this is called with
@@ -647,6 +648,12 @@ static __always_inline bool rseq_exit_user_update(struct pt_regs *regs, struct t
 	return false;
 }
 
+#ifdef CONFIG_KMSAN
+bool rseq_exit_user_update(struct pt_regs *regs, struct task_struct *t);
+#else
+#define rseq_exit_user_update rseq_exit_user_update_inline
+#endif
+
 static __always_inline bool __rseq_exit_to_user_mode_restart(struct pt_regs *regs)
 {
 	struct task_struct *t = current;
diff --git a/kernel/rseq.c b/kernel/rseq.c
index e75e3a5e312c8..be759d7d266b5 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -329,6 +329,13 @@ void __rseq_handle_slowpath(struct pt_regs *regs)
 	rseq_slowpath_update_usr(regs);
 }
 
+#if defined(CONFIG_KMSAN) && defined(CONFIG_GENERIC_ENTRY)
+bool rseq_exit_user_update(struct pt_regs *regs, struct task_struct *t)
+{
+	return rseq_exit_user_update_inline(regs, t);
+}
+#endif
+
 void __rseq_signal_deliver(int sig, struct pt_regs *regs)
 {
 	rseq_stat_inc(rseq_stats.signal);
-- 
2.55.0

