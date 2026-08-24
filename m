Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2283022A817
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 12:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574202; cv=none; b=F3MQT+P7FEWG1zwwsSJy/bU7Of0nd9edvZbjHVVWn2vpDisMTzDgmLy02RieOQpfKMdHEOjeuyMOp8nUvJxWPrGvh7TmE+Y8iGF9pG5XnD1WXXLROuuJz8JcG5HdPrY2fhj4+EdNxJrBUxzLMvZ3DtBxeFnFbOlXexrrxHMApMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574202; c=relaxed/simple;
	bh=rU+j6YACAuMAHIZTs7NfxWIvdaWmI/d+WrYgdnbLT44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lFDZg++f8Nx4lfg84vzXivTUtL8SOCfnRTfdsaCwrADmiita0SoriqUcOPgofkSKCfC2WKxJFizJkOYacc3k+omjtkWCWMzuKeTf02i6U85IxUMFcRK9z22ZBRNN0QPwyozBYsIzhr8rix0I9m2xswDg/p+XZ2TEr6aSqOw6888=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MX3ZPhBI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MX3ZPhBI"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OBVW2t1799443
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 12:23:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=HQyui/JwuWYPFnahe
	NbM8NIJ4++vJ0MM14qn1GPbEeM=; b=MX3ZPhBISIxFPryNl8/JwmEItHPIwh5JQ
	yaanta6OMIv18DlTfaJhKhgs1cHV05cLQTovxlrAynERTZrpmejGEnn5tV/NnOJ4
	4Z2p8qb7fw0Ngl+SF+9zZdmSp7UxXxCVdohxrGOCf1EkorzWHL0UF4Ic9E5B4MnH
	C4UnN4RERVqxzJ6PMrZVA/uqELBf+/SmXcqh+PoXyr9lO8t4XQPMlCluUDV+I+RU
	KYq5cvg6qqey+wK/pP5zcGV+vQIebxLXnLWOaEBXSPWp+lqhhYYf+xacV2PjqvPN
	Jhjs/rK+F5iLWZlSuBX7//rfFjOuBQyg8wq7IGRRxhpk0ERueioDg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dx115a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 12:23:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OCBNwP010776
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 12:23:19 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkgwqe7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 12:23:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OCNFVt47514096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 12:23:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 324722004E;
	Mon, 24 Aug 2026 12:23:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19F832004B;
	Mon, 24 Aug 2026 12:23:15 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 12:23:15 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [PATCH 1/3] s390/pai: Use PAI PMU index as parameter replacing event
Date: Mon, 24 Aug 2026 14:23:05 +0200
Message-ID: <20260824122307.86133-2-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824122307.86133-1-tmricht@linux.ibm.com>
References: <20260824122307.86133-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEwMSBTYWx0ZWRfX1tw5VBLqwjCg
 6qfRocG0elX2VAOLhJavAi1p4199p4HH+6NXFtDqML93PdhfgeCPqljG/qUl/VXCvzjfFUizAO9
 jjKpf1jYYg6D7ExxARX8bZw/qLk4lP8=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8c37b7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=JMlX-6JAepFCzwN66roA:9
X-Proofpoint-ORIG-GUID: TVF5VEnRYKo6C0xOv4rtstg3KpMJYtJT
X-Proofpoint-GUID: TVF5VEnRYKo6C0xOv4rtstg3KpMJYtJT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEwMSBTYWx0ZWRfXwcxBk6MvxKae
 A2yy9UXp+PiW+Vz4qK44CRHfKhRjS/OAzjl/3wtlIxg6dODkn2vB/G+Nb0TEjxjWGHGYM7fKmQb
 V3fxF23s4wGAk1Sab1qnA40Cq+4QBk2g6NtBdQNN0lgKqKPLLpiWBEK2ZIM0MRVBusZrtX5IB7Q
 kDImkhS7dJOrtC8BsubyrGTGBNLKcbeT4N26m6QDHVfUwImll29mBeFfhGb1oEXhmlgkOeqP+il
 glElH9h5iCKhX/PK9Sj51Zn/3PjLxik0pwK9zJo5e0furtLCU302knKmRJ8rzaHoXvb6Pvhk6PX
 qvnMNWPeodQcDeAL/eV8gXtHVALNp9XJy2pG8chzwqT/CNxBrf5ZsVNjs7vW3ZQTtq8HVd0S/tP
 jayNmQdM22XnjceMwAGjTn1WUXYxN0hs88S6DcssTD2FnoO0UADe2xq1WNVHbTIwKFlX2+AIQIB
 1re3lvfkCgfX3WrFz/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240101

Use PAI PMU index value as function argument instead of pointer
to struct perf_event. Only that index value is used inside
functions pai_alloc_cpu() and pai_event_destroy_cpu().
No functional change.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 arch/s390/kernel/perf_pai.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/s390/kernel/perf_pai.c b/arch/s390/kernel/perf_pai.c
index cdb8006220ca..7c13f5586c79 100644
--- a/arch/s390/kernel/perf_pai.c
+++ b/arch/s390/kernel/perf_pai.c
@@ -140,16 +140,14 @@ static void pai_free(struct pai_mapptr *mp)
 /* Adjust usage counters and remove allocated memory when all users are
  * gone.
  */
-static void pai_event_destroy_cpu(struct perf_event *event, int cpu)
+static void pai_event_destroy_cpu(int idx, int cpu)
 {
-	int idx = PAI_PMU_IDX(event);
 	struct pai_mapptr *mp = per_cpu_ptr(pai_root[idx].mapptr, cpu);
 	struct pai_map *cpump = mp->mapptr;
 
 	mutex_lock(&pai_reserve_mutex);
-	debug_sprintf_event(paidbg, 5, "%s event %#llx idx %d cpu %d users %d "
-			    "refcnt %u\n", __func__, event->attr.config, idx,
-			    event->cpu, cpump->active_events,
+	debug_sprintf_event(paidbg, 5, "%s users %d refcnt %u\n",
+			    __func__, cpump->active_events,
 			    refcount_read(&cpump->refcnt));
 	if (refcount_dec_and_test(&cpump->refcnt))
 		pai_free(mp);
@@ -159,17 +157,17 @@ static void pai_event_destroy_cpu(struct perf_event *event, int cpu)
 
 static void pai_event_destroy(struct perf_event *event)
 {
-	int cpu;
+	int cpu = 0, idx = PAI_PMU_IDX(event);
 
 	free_page(PAI_SAVE_AREA(event));
 	if (event->cpu == -1) {
 		struct cpumask *mask = PAI_CPU_MASK(event);
 
 		for_each_cpu(cpu, mask)
-			pai_event_destroy_cpu(event, cpu);
+			pai_event_destroy_cpu(idx, cpu);
 		kfree(mask);
 	} else {
-		pai_event_destroy_cpu(event, event->cpu);
+		pai_event_destroy_cpu(idx, event->cpu);
 	}
 }
 
@@ -241,12 +239,12 @@ static u64 paicrypt_getall(struct perf_event *event)
  *
  * Allocate the memory for the event.
  */
-static int pai_alloc_cpu(struct perf_event *event, int cpu)
+static int pai_alloc_cpu(int idx, int cpu)
 {
-	int rc, idx = PAI_PMU_IDX(event);
 	struct pai_map *cpump = NULL;
 	bool need_paiext_cb = false;
 	struct pai_mapptr *mp;
+	int rc;
 
 	mutex_lock(&pai_reserve_mutex);
 	/* Allocate root node */
@@ -318,6 +316,7 @@ static int pai_alloc_cpu(struct perf_event *event, int cpu)
 
 static int pai_alloc(struct perf_event *event)
 {
+	int idx = PAI_PMU_IDX(event);
 	struct cpumask *maskptr;
 	int cpu, rc = -ENOMEM;
 
@@ -326,10 +325,10 @@ static int pai_alloc(struct perf_event *event)
 		goto out;
 
 	for_each_online_cpu(cpu) {
-		rc = pai_alloc_cpu(event, cpu);
+		rc = pai_alloc_cpu(idx, cpu);
 		if (rc) {
 			for_each_cpu(cpu, maskptr)
-				pai_event_destroy_cpu(event, cpu);
+				pai_event_destroy_cpu(idx, cpu);
 			kfree(maskptr);
 			goto out;
 		}
@@ -392,7 +391,7 @@ static int pai_event_init(struct perf_event *event, int idx)
 	}
 
 	if (event->cpu >= 0)
-		rc = pai_alloc_cpu(event, event->cpu);
+		rc = pai_alloc_cpu(idx, event->cpu);
 	else
 		rc = pai_alloc(event);
 	if (rc) {
-- 
2.55.0

