Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73F325CC79
	for <linux-s390@vger.kernel.org>; Fri, 14 Aug 2026 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786715446; cv=none; b=YOl9WERX234ypo/RxPswo+85HETIbBHZHyMksemf37nesLh+IRIZ4yI1L+hWPi7hmAkY9WpCBwxDYizA9UPiaxV5Q8nMoDBOqbRkkflXnRuU6pq24fifi/Il4MjfBZ6wWz9JCi8TvmWb7Frkow8jSh66djxhY414Whq8Vbn+zZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786715446; c=relaxed/simple;
	bh=z9LdDdMcbtaH7jqzwv9jy7WWTEA3vYaRMKAw0nIrI9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yxxt9XN/TzsZEwBryZ2/XPKHgBpgeJrTLL6z8s0aPlZZ270nBChQZpK0ACev4Sy0bB4S91Re3oLqq4AsNhUKaHT9xo2JmcAANFvxM1dXEhpgzjbA7B76dr9mnd6E/6b7psex9xrIB47r7InOnBFYM1VIjXYoeV7b5JKK3n4o8gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GSnDywUN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GSnDywUN"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EB1gBY956566
	for <linux-s390@vger.kernel.org>; Fri, 14 Aug 2026 13:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=NrJFp8x1fq28Fmrp+dhu+9bRtoMXC7Hylin730MCx
	es=; b=GSnDywUNlaP+QjEU3sbi4xOCN0DpQicqfe19f98U6DB/mEHjFWbDMJwk6
	oYGqg5YRuhlwwb5QwD3CcZDTRdwg2fcj2Sc9nkOGKdmOBXLdG6DU1avIJgkxIlUX
	GLhdvR6L/nOTksj38BGhmNtfqclbz/kf43rqaEUGsmTrr7OjKBN7YrrPhUXv9feD
	rRAvCZeB2Nlkbb5COJLTeGSavyPZNQ7ZCo0gwXHp0UjZN3YBH02LC4WHfcaL3WRJ
	QCdTNu+IOTDRZYZel8E15EwFQfZn++wF7/F3MYuYYO01wcpGyVuMEY/id3AbTA1+
	qeMKkHuRGk9FdAdpnYTccvm6J7Urw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvma54a4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 14 Aug 2026 13:50:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67EDfNaZ016314
	for <linux-s390@vger.kernel.org>; Fri, 14 Aug 2026 13:50:42 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsk7fw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 14 Aug 2026 13:50:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67EDocct41353698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 13:50:38 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C245F2004F;
	Fri, 14 Aug 2026 13:50:38 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A39A72004E;
	Fri, 14 Aug 2026 13:50:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 13:50:38 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-s390@vger.kernel.org, sumanthk@linux.ibm.com, japo@linux.ibm.com
Cc: agordeev@linux.ibm.com, iii@linux.ibm.com, hca@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v2] s390/pai: Handle multiple PMU stop callback invocations
Date: Fri, 14 Aug 2026 15:50:27 +0200
Message-ID: <20260814135027.2910179-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDEwMyBTYWx0ZWRfXy3wBQUMmn3Xa
 RTLewb/MlK9rAlOlwHEEiWeox+zbpiw/yEzJaDw5ZoCyWJD3pXoXtmP5vZv1rln8HuQlZ0+6HAR
 tL8eHZjG28NVElmwMbfX755tut41oIQfffRyfFikVjV3HxUDs5aH9cOXhSm4ofrcc2IAnzoSMe3
 3M4zZZyNrJF4oAoLVYd3A2mc6WzZdV1VPgkmKijZXqQ0aGqnvXUwtJQlfnKnsfQhfHS//Qbs3Sz
 +dyd4mjhiVJQt4++yLy+Bx0QwH7zEC2CjLE7A39c2bHuXGCx4xoutWlDhBRv+BFBoL0cgIwxKaA
 fFvG/hGFm2+IpgtSt5GEqrmbAqmKuypTYpX8FCbDahCpNUWVAFkVlFvm6aouV+mzO31S16LOerT
 ychOv6V7E5+sJcyfjCePQRu+5nlPKWUEs/8LquCkQGQ0lYcklbpXghO2sqHPeFLxIONKCftPLHN
 ANPDcn+p3DjupEZ3q0w==
X-Proofpoint-ORIG-GUID: GkvqOCEF89172vIsH1VWht40JYG2oER7
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDEwMyBTYWx0ZWRfX6xi+L2sYcmzx
 d200Fizl0YNmfaB64EdMYdjtCnAADV4eDOVST3qsck3YNyP7kf52BY6kkP5dHuzhJK6XBh130d0
 YsEjsILjHPFTx1VKIkVfWfYNK+3gn6k=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7f1d34 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=IdDqa-fQ3nNm70vTrW4A:9
X-Proofpoint-GUID: GkvqOCEF89172vIsH1VWht40JYG2oER7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140103

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

Cc: stable@vger.kernel.org # v6.19+
Fixes: 9f66572f2889 ("s390/pai_crypto: Enable per-task and system-wide sampling event")
Fixes: 582cc1b28e8c ("s390/pai_ext: Enable per-task and system-wide sampling event")

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Suggested-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/perf_pai.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/perf_pai.c b/arch/s390/kernel/perf_pai.c
index cdb8006220ca..6d0bf4ddec8f 100644
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
 
-- 
2.55.0

