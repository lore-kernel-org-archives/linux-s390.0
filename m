Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8416423A85
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787577487; cv=none; b=MQaaf+G+ygmpHz73osZ4KCk7DCcgIWj89kR0GoBL2iZNo/jN9fNOu5EUouFrdNyF1ZFLty3dqiEKZ0s2dMcCCuBclgTE6xen/UKYSKaE1Nd+oqRXY9qnEWVta8S2ro89Pw+pS6FN4E9GDhPwlqweFUmEHmfFb/ou6vZArcS/OG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787577487; c=relaxed/simple;
	bh=rU+j6YACAuMAHIZTs7NfxWIvdaWmI/d+WrYgdnbLT44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c2KDqnSL11iFUVCwSMJFdobXH/0nG7U+UcWUycGOKaGlrh3TbpnRCm2jhXnLq5Ct8m/OXkB2rDDh3GyeMQ37RYJByMrx4w/aPR8YL+rgGRShZnITZIeMyNEvR4Ep63bsaQX0YF67hyGSHIlN0t9T3Fd3ShtL375KoGf8Mm428ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Fym+wQ9a; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Fym+wQ9a"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OD1kUr085669
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 13:18:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=HQyui/JwuWYPFnahe
	NbM8NIJ4++vJ0MM14qn1GPbEeM=; b=Fym+wQ9a2vaZHOpFukMBGHluTCw/HWAei
	YsuTgXMcFepCWbSVWCLlv49jEYZUXp9p72yAgdeFNHcG9UimiCprR6irid5sBs4r
	nJTt970qNgKtuYZH3618n+oLKgicw65L9BeXIwBfJK5xNrwX7r69ouT/2+JMRP01
	/6xW5ud6OZZp4DPn4ncHtIqbfffw+B5fPUwlzbNKsNCUiukC36ljI0enxdeWo7wi
	DyJddMVhv5+VbBYr4H+rNW3hNfShnDKTw0z7RjGOxRWmxaGNUidXUwHjQKLCBF9j
	EFKifSUZ4xshS4skluGxlS0ULk9a4qaftpV/UW1gysrCTmgFLLHUg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqhfs6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 13:18:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ODBLrK028929
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 13:18:03 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfvx6gb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 13:18:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67ODHxFu51904922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 13:17:59 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41B602004D;
	Mon, 24 Aug 2026 13:17:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C7A720043;
	Mon, 24 Aug 2026 13:17:59 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 13:17:59 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [PATCH 1/3] s390/pai: Use PAI PMU index as parameter replacing event
Date: Mon, 24 Aug 2026 15:17:49 +0200
Message-ID: <20260824131751.179275-2-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824131751.179275-1-tmricht@linux.ibm.com>
References: <20260824131751.179275-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: u63xeLM8OiW8VEhObc2y9DqqcA_mNPfW
X-Proofpoint-ORIG-GUID: u63xeLM8OiW8VEhObc2y9DqqcA_mNPfW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEwOSBTYWx0ZWRfXwFMj0611g/Xf
 CCT4gNkfiXwGIE8N4YSTB6DA4OWxy0QC5RW6d7v/I1Ivliki8+4XWlfAT7rwCxAaZymRIVI5Bst
 N3g5yXRLa1pH8/j3YwVrsIUx5lttWyadRmJOQWrnx8a27WVj8/GkE6VCO6/RV6BTl4LYsvcCAnN
 pniWYvj3OqvexKqytkodJztTPpr1E9CoVWCU8MMeCLiubt/XcDDZSIyftlORGvPe68Zcv8jedmw
 eY6HiW88s7EnGB+neesyhXxtNMzzAYoU9SyFePxzDqNqRLchoGBmZj7Z66+2zD4qUUv7ucYZWkA
 euCQzeCIvxYjIjgypEb18JgpUWaTmR2iGVJgki0C1jbDpKFI+UvZn+uojFrpStz65uemx3LA493
 bb/IrXAHIn1x67dbhJ+WmBrZVxJUwbKJmV6Ae2nIhZXsEvY2RTyNdt+NFuWPkcfk2/etD2rt/St
 IaUpMMFgQD1Nd8GbNBg==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8c448c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=JMlX-6JAepFCzwN66roA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEwOSBTYWx0ZWRfX3b53cHrLbaVi
 8DYAgo/lgV+TDYw8+Fem52wQdC0fOudYelQj+izcroMjCX5Hf0UqoPU/UgS2/l7JlzqdaVTXEc4
 m9BKLm+hct4Prdig4Bb8yiAVfe9Ye5E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240109

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

