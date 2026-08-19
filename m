Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7102C3CBE6E
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 05:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787119147; cv=none; b=JO1Y1Mc1TIKkLl135f9l9puUzrufteKbcmyrACMVLu0R4BQkKINDEabpwxG3ZEFFVKZfW8Qmh/bLZPjtcLLojWsBrh2XBAppnIWLtBg4s2Vyjdyf/20ZjzJoXBq5Lgcf36W7uzxAg/n7PLs3uckgYnFZFjYBIYyO2YQcRSZ7hLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787119147; c=relaxed/simple;
	bh=/TNOmhi7UZ4n0XZNlBEr9nNcsNrmJeqCk2TEL+pVMAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Skn8MEjmDTlIREq6TaiNTWONpXuLxEbS0BdH32q3hY2XP+usDMeFfUuYb1kOKf9POUHlc94dPBjRBoKNSC2fKPUxcw77ktSGUUSfxSKyuOuKvIOPTDLxOg6LCFcYo2haeaO0ZZU2l7wJa/VM58UyzZfqP0JcURqmEoRddhDSBIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gXOhAffo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gXOhAffo"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67J31xpx353108
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 05:59:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=d/y+WiotUYaXINdSFBoX6jbLJoS3UYTzAvxRacL6o
	Ss=; b=gXOhAffo+OymDYLdCAbNTrGzCiSQ19wcCe+jpDzHz2sU4VAxU1Er/8Bia
	j99dNh1Zl1UnRwGkabYJjuLAUyBwLH8gwwjc8hAuytFAOz0efNzmAS6wRrRB07l0
	7ujVew9TWWeBUBk7YRI9bOmJmR2WYxizIfnxsm6BiRyyHQJ69+aKpTPzLsXSkqCQ
	6DKPyGcmMvcuW395p6ZP3qX1mon7JBDPy1fltxWMr7Y9mQKLtEzBkV0xWOB6OW/o
	kDEa3ta0s7R7ysuKV3Qznf1eVpCHzYf2lFwqVf853MxQkrT8nxat7jfo82bhMHXU
	mnIE5iSBG8ha9nzb6GErZDG6QqdCg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu01tx6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 05:59:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67J5uG2j013962
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 05:59:04 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngf55q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 05:59:04 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67J5x04K27001416
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 05:59:00 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A318D20043;
	Wed, 19 Aug 2026 05:59:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8763D2004D;
	Wed, 19 Aug 2026 05:59:00 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 05:59:00 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH v4] s390/pai: Handle multiple PMU stop callback invocations
Date: Wed, 19 Aug 2026 07:58:55 +0200
Message-ID: <20260819055855.1001578-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8a_Oe4fjK02fRWAklUuv03ILd7SSDIJ3
X-Proofpoint-GUID: 8a_Oe4fjK02fRWAklUuv03ILd7SSDIJ3
X-Authority-Analysis: v=2.4 cv=RoX16imK c=1 sm=1 tr=0 ts=6a854629 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Fo9EMwYq_bmgDG0ZVhAA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDAzOSBTYWx0ZWRfX2lclRYpaJGY9
 JqLS0wz6Kqwfe5ejPaKxYxiBDI4ePuFkohH/NBFnzEgvv0xZRc4NK7CTnFmKTYc0QtQ3wW3n8pe
 A5D0a+2LHpeXi57m4TLkFv3/qox/S/U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDAzOSBTYWx0ZWRfX0qnVmnYy7mzf
 jugYSRaKwAzRcM5gbizSJq60IvgcZ0d+OKy8uM35Cdawk+rju1gfzT8ThmLvV4xxniIGfgXqqfe
 pExk9sW4dqwgUt1DJGCpOU58kXxb18MOENfJ6K1PnsYO+0THOIaued4hI+gkczTzzBMH1m9LYGw
 F3q8Luk/mnA7ZUakuGoTjpHTHTUatGzNn7cctJKrFdH+rr3AR587e9xEEt2KrcMn+2RdKofaKQX
 Xj0PmJC0y0z8Ez71cKt6GR1dsCsFDKfiaxaGa6AD6A555KBaP75Qb+XPcJc0cwqIbOaRHrRe9V0
 euV4faBXhimaVDeiluObWipYyADU771KnD64ELMWSTbybw/W1RYrXpQXD1WKr1eMCrpiQZwtuAE
 /GUWfllwzZ4hTMiD2ckr6lvLenLB6fE4ZcIljETDiibBvIMzsmk0lRT7wCjhoJrrmyqWrckD1gQ
 eP8J9mqeW5f8Zh8pJng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_01,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190039

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

Prohibit ioctl(fd, PERF_EVENT_IOC_PERIOD, ...) call for this event.
It sets perf_event::event_limit to a positive value and causes
perf_event_overflow() to invoke pai_stop() call back function when
perf_event::event_limit hits zero. This is not supported because the
sample events CRYPTO_ALL and NNPA_ALL are only taken at schedule out
of a task.

Use list_for_each_entry_safe() for safe iteration over syswide_list
in pai_have_samples().

 #Cc: stable@vger.kernel.org # v6.19+
Fixes: 9f66572f2889 ("s390/pai_crypto: Enable per-task and system-wide sampling event")
Fixes: 582cc1b28e8c ("s390/pai_ext: Enable per-task and system-wide sampling event")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Suggested-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/perf_pai.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/perf_pai.c b/arch/s390/kernel/perf_pai.c
index cdb8006220ca..05f74d74fad1 100644
--- a/arch/s390/kernel/perf_pai.c
+++ b/arch/s390/kernel/perf_pai.c
@@ -464,6 +464,7 @@ static void pai_start(struct perf_event *event, int flags,
 			cpump->event = event;
 		}
 	}
+	event->hw.state &= ~PERF_HES_STOPPED;
 }
 
 static void paicrypt_start(struct perf_event *event, int flags)
@@ -510,6 +511,13 @@ static void pai_stop(struct perf_event *event, int flags)
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
@@ -672,9 +680,9 @@ static void pai_have_samples(int idx)
 {
 	struct pai_mapptr *mp = this_cpu_ptr(pai_root[idx].mapptr);
 	struct pai_map *cpump = mp->mapptr;
-	struct perf_event *event;
+	struct perf_event *event, *e2;
 
-	list_for_each_entry(event, &cpump->syswide_list, hw.tp_list)
+	list_for_each_entry_safe(event, e2, &cpump->syswide_list, hw.tp_list)
 		pai_have_sample(event, cpump);
 }
 
@@ -691,6 +699,17 @@ static void paicrypt_sched_task(struct perf_event_pmu_context *pmu_ctx,
 		pai_have_samples(PAI_PMU_CRYPTO);
 }
 
+/* Prevent ioctl(fd, PERF_EVENT_IOC_PERIOD, ...) call.
+ * It sets perf_event::event_limit to a positive value and causes
+ * perf_event_overflow() to invoke pai_stop() call back function when
+ * perf_event::event_limit hits zero. This is not supported because the
+ * sample events CRYPTO_ALL and NNPA_ALL are always taken at schedule out
+ * of a task.
+ */
+static int pai_check_period(struct perf_event *event, u64 value)
+{
+	return -EINVAL;
+}
 /* ============================= paiext ====================================*/
 
 static void paiext_event_destroy(struct perf_event *event)
@@ -804,6 +823,7 @@ static struct pmu paicrypt = {
 	.stop	      = paicrypt_stop,
 	.read	      = paicrypt_read,
 	.sched_task   = paicrypt_sched_task,
+	.check_period = pai_check_period,
 	.attr_groups  = paicrypt_attr_groups
 };
 
@@ -1015,6 +1035,7 @@ static struct pmu paiext = {
 	.stop	      = paiext_stop,
 	.read	      = paiext_read,
 	.sched_task   = paiext_sched_task,
+	.check_period = pai_check_period,
 	.attr_groups  = paiext_attr_groups,
 };
 
-- 
2.55.0

