Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F1E3CF1FD
	for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2026 10:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786964374; cv=none; b=HwvGJciBh6lH9lHoKkw/xS9xyexp+axebKA6yPe54HRfPlQY39rkoHctaV7UjWxiaVSyL9DQ+d3WjhPEAPbGw9+kWgpzmkIQWzsls6ZGqyUqVFIZQe3jWD6+3ql/JJKcQwHnApj1VwZw+5TEnIN3rj1hsv3stTn2LGuhaxwJSx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786964374; c=relaxed/simple;
	bh=CsLQmnHKmLeRZirXcgxpCIDEmYQGFtA26JDakKMJ5/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RAiFwJE0ScbF18etsk5q/rr3e2AOfXi1avGx0O1eyWbw18hTR80+JbZORFWX6SAwfxhLaR/6RrnwA3ehQ+1ajzE9BybNouWQRs4x//c1JVFXxEWTTnxnDlswHXyEWhL5NsaUC73FQU/eSDJU+LB5/7wOi2RTHrQfufzZwvQTTIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KY7zn+5u; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KY7zn+5u"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67GLVsua3636286
	for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2026 10:59:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=2T78GOnu6/7Nuc1PgJYs23lgL+V8w0s6LQ/8V0SJA
	t8=; b=KY7zn+5uj1WoTELvj1Ra+nXCbauBaZzQCMtzK52mYwkXNI6u7MUBXCa+D
	/0F9DIXYsagPYxC3pfDz8M6Io075kFrFYdS8CIH/9yTZgU/W1ZxSsB/9ay6QY81p
	QUXeqXS2i54uSB8eYhkhRsLOTtyymbVJnOER/QUgWdjV/C3kbUX2OGnSt6JNARAu
	RenFjutzgw3+VM6rV+IOUk/clG2R2tUBYBZxh620WdnunB+CgXwO6n49n2lMhFUQ
	HN+bC5KFHj8Vz8bSeE/aujn5w+6IeLBm2u9FmJKDyj5D6rYctulTVTGyKWdos2Uz
	qcPbD5EmwYVFLMft/T71ZS0BdgGZA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2dhksuh9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2026 10:59:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HAuQFL030915
	for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2026 10:59:25 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354y5ey6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2026 10:59:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67HAxL3v25362840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 10:59:21 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5E1C2004D;
	Mon, 17 Aug 2026 10:59:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D9EE2004B;
	Mon, 17 Aug 2026 10:59:21 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Aug 2026 10:59:21 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH v3] s390/pai: Handle multiple PMU stop callback invocations
Date: Mon, 17 Aug 2026 12:59:04 +0200
Message-ID: <20260817105904.3933179-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA3OCBTYWx0ZWRfXw6t6CsCkDn5M
 fiE+xChiHgF0JX3J64RHTyOh5ya9PslGF7R1hexdDWH/GYFt9CqNj5ly1Zce5Q9ASj13rRd5ts9
 YZcW+HlxUX7mll4qxTNlL8Bml+xvmRk9sZBqkPTUgd+hImwOTed2lqcgSI6d0YVUqQP+ARYPEoo
 A2u6zSGWJtD2Bn6dTNjczKIMueiXmLeZMBMjRIjqHA6isztcCnfQhyqNS+53iDKFij36l9UeDXC
 kEpRcrO48iDYMjFtDZxfy7W+BnMiNOMWpgkHak+se5zDrq00Y69MtMgr4Y5M8w+FEPDbnH2fnzJ
 pyX+vsCCP+MMkvi3HwAAr434fyc6KwDuR8XUrMgTjO/b4dTM7trwmesepc1uURi8nhmJVabyWuy
 MKn16C24IGIa+diZVupmOWWPTiUmtxHv6dPTHuem4wmmqjGD2+tTmHnEu2d9a2vURq89574bM6M
 R2Bz2vfP4n8Xps8R7/g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA3OCBTYWx0ZWRfXxRARJ7AxVMqc
 FnV/qSjuTJ8yyVTb/oj3xRIfmEwdAWeNVgjYgFSi8aWSPmbewvK1aOGz0NMESLYX8VW+DFLV7ur
 Kg/9gBb/aQDqFxMn/XFoTQWmUGhiOY4=
X-Authority-Analysis: v=2.4 cv=JKkLdcKb c=1 sm=1 tr=0 ts=6a82e98e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=OIqSdt047_wi2S7goKUA:9
X-Proofpoint-ORIG-GUID: UpAz5Pf1PQkCcsb01FFs68IfhsibeOR_
X-Proofpoint-GUID: UpAz5Pf1PQkCcsb01FFs68IfhsibeOR_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170078

Handle the following scenario:
The kernel protects itself against a very high sampling load and
throttles the sampling using:

  perf_event_throttle() --> PMU->stop()

Shortly later the scheduler may terminate the task and removes it from the
CPU. It again calls

  PMU->stop()

which results in two invocations of PMU->stop() called back to back.
Protect against this and check the PERF_HES_STOPPED bit on function
entry.  If it is already set return.
Clear bit PERF_HES_STOPPED in PMU->start().

Also fix unsafe iteration over syswide_list in pai_have_samples()
which might lead to a kernel crash (LIST_POISON dereference) if an
event overflows and is synchronously throttled during the loop.

Move calls to perf_sched_cb_inc() and perf_sched_cb_dec() to
functions pai_add() and pai_del() to avoid list corruption during
event throttling processing.

 #Cc: stable@vger.kernel.org # v6.19+
Fixes: 9f66572f2889 ("s390/pai_crypto: Enable per-task and system-wide sampling event")
Fixes: 582cc1b28e8c ("s390/pai_ext: Enable per-task and system-wide sampling event")

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Suggested-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/perf_pai.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kernel/perf_pai.c b/arch/s390/kernel/perf_pai.c
index cdb8006220ca..388941d9aec1 100644
--- a/arch/s390/kernel/perf_pai.c
+++ b/arch/s390/kernel/perf_pai.c
@@ -456,14 +456,13 @@ static void pai_start(struct perf_event *event, int flags,
 		local64_set(&event->hw.prev_count, sum);
 	} else {				/* Sampling */
 		memcpy((void *)PAI_SAVE_AREA(event), cpump->area, pp->area_size);
-		/* Enable context switch callback for system-wide sampling */
 		if (!(event->attach_state & PERF_ATTACH_TASK)) {
 			list_add_tail(PAI_SWLIST(event), &cpump->syswide_list);
-			perf_sched_cb_inc(event->pmu);
 		} else {
 			cpump->event = event;
 		}
 	}
+	event->hw.state &= ~PERF_HES_STOPPED;
 }
 
 static void paicrypt_start(struct perf_event *event, int flags)
@@ -492,6 +491,9 @@ static int pai_add(struct perf_event *event, int flags)
 			local_ctl_set_bit(0, CR0_PAI_EXTENSION_BIT);
 		}
 	}
+	/* Enable context switch callback for system-wide sampling */
+	if (!(event->attach_state & PERF_ATTACH_TASK))
+		perf_sched_cb_inc(event->pmu);
 	if (flags & PERF_EF_START)
 		pai_pmu[idx].pmu->start(event, PERF_EF_RELOAD);
 	event->hw.state = 0;
@@ -510,11 +512,17 @@ static void pai_stop(struct perf_event *event, int flags)
 	struct pai_mapptr *mp = this_cpu_ptr(pai_root[idx].mapptr);
 	struct pai_map *cpump = mp->mapptr;
 
+	/* Cope with multiple invocations:
+	 *   1. perf_event_throttle() --> PMU->stop()
+	 *   2. task schedules out --> PMU->stop()
+	 * Check for event already stopped.
+	 */
+	if (event->hw.state & PERF_HES_STOPPED)
+		return;
 	if (!event->attr.sample_period) {	/* Counting */
 		pai_pmu[idx].pmu->read(event);
 	} else {				/* Sampling */
 		if (!(event->attach_state & PERF_ATTACH_TASK)) {
-			perf_sched_cb_dec(event->pmu);
 			list_del(PAI_SWLIST(event));
 		} else {
 			pai_have_sample(event, cpump);
@@ -537,6 +545,9 @@ static void pai_del(struct perf_event *event, int flags)
 	struct paiext_cb *pcb = cpump->paiext_cb;
 
 	pai_pmu[idx].pmu->stop(event, PERF_EF_UPDATE);
+	/* Disable context switch callback for system-wide sampling */
+	if (!(event->attach_state & PERF_ATTACH_TASK))
+		perf_sched_cb_dec(event->pmu);
 	if (--cpump->active_events == 0) {
 		if (!pcb) {		/* PAI crypto */
 			local_ctl_clear_bit(0, CR0_CRYPTOGRAPHY_COUNTER_BIT);
@@ -672,9 +683,9 @@ static void pai_have_samples(int idx)
 {
 	struct pai_mapptr *mp = this_cpu_ptr(pai_root[idx].mapptr);
 	struct pai_map *cpump = mp->mapptr;
-	struct perf_event *event;
+	struct perf_event *event, *e2;
 
-	list_for_each_entry(event, &cpump->syswide_list, hw.tp_list)
+	list_for_each_entry_safe(event, e2, &cpump->syswide_list, hw.tp_list)
 		pai_have_sample(event, cpump);
 }
 
-- 
2.55.0

