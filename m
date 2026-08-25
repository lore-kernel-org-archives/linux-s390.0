Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600613D1AB9
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 07:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787642986; cv=none; b=PKl0ZL23DudKJDgODGxBem9CF5gnOGMFo8dbcuVOUZMdydMs0XOQJU5Qf8WGaPfEmTG/6J4n2j0qrUnVdcF+8c8UMs56pVN6mduI1uXtxyD2LEuEXxt4Xlg7bJdZsGVqWq3qQ4OaNHophxT9ycrltryE2bjpg8jW/nwERn9GwmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787642986; c=relaxed/simple;
	bh=rU+j6YACAuMAHIZTs7NfxWIvdaWmI/d+WrYgdnbLT44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QkHjPw3BEvIQ/W8XXZriWBM9eFl/LssNAVrbXTrud6JjcaofgAqeLQDJUf2Pnbu9BDMjTuRh4cF7KuFNK1Ja802wV8Eb++L5K6rI1VxJ08bCtDM8h3ikdV7rwq2gB6Ccvyqwh8oiTtXJSctDPt2wA4pBrXCN5obciNJjLNiYaFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=O0PEcufb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="O0PEcufb"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P2VcCa3750901
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 07:29:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=HQyui/JwuWYPFnahe
	NbM8NIJ4++vJ0MM14qn1GPbEeM=; b=O0PEcufbFYK5C64WivB2BKQubsKWgGVtt
	9BbgHXxoJFwPaUsBlQJ30dfUEBagC+IJy2Ee+27GiG5ZW2t90FjDbLPmtEReQoK+
	b3E76ipOTNhPjfysamag4SJW61AKRO3t9MpJfr39KDchl1A6wBrWVGP5agrrmTmc
	IWeih4JtOKmp3IzgqKDCfWqy65s6IxYIev5NPghcr5E9ua/oL0YmE0XqwK+bba43
	F8BGNBvHBBRpeBsXxs75tsDmMcCrGXx2VFNwauayolCxsOtZcqCwZshT4dU2ocei
	P+8Gpu9zdx11GHFCrJz3ehKVxqEUgf+1OG6A3S9pEk2PsUtqyGzKw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4pn2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 07:29:44 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67P7QQxv029580
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 07:29:43 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkh2s9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 07:29:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67P7TcAJ46399918
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Aug 2026 07:29:38 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A64972004D;
	Tue, 25 Aug 2026 07:29:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D60B2004B;
	Tue, 25 Aug 2026 07:29:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Aug 2026 07:29:38 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [PATCH 1/3] s390/pai: Use PAI PMU index as parameter replacing event
Date: Tue, 25 Aug 2026 09:29:29 +0200
Message-ID: <20260825072931.3738180-2-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825072931.3738180-1-tmricht@linux.ibm.com>
References: <20260825072931.3738180-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OfJLFlQoCrFf3kHBC9rLh9udvxWRQyRl
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA1OCBTYWx0ZWRfX3QDlDg9L9kv2
 oYEwS/yhNwmkiPkXAyTVfUtH22L3vmuAXL9gq1GmvT5WVOIBEs9Ar/ovC7OOBecmmgSvu/roLKf
 STYbJ9duJicRa0uEdh0pWmHoCj/W/ZI=
X-Proofpoint-GUID: OfJLFlQoCrFf3kHBC9rLh9udvxWRQyRl
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8d4468 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=JMlX-6JAepFCzwN66roA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA1OCBTYWx0ZWRfX0RCIbPPs/j7w
 e8qJQDeXkm9LFSBIgN9fKlFKDsRqD0u7xz2lkIR2TKZbqeWa7++/WWZTBgKTGZZZ1qfmz7w1PqT
 niP7K/oRKhKOdw79GPCAbS+hUFwHXwNc2IwW4SzD0LxeNnu2h1WjCGcvpDwKKFZIaLBp1ECX635
 rdWBUMsmEmT325gPrBNMjK+IUthdqdpM4pAuXOssWDt4Fxg+MN4tn9B8xSvNgCK/MTM2MMhXek1
 a48Xsa3NnHvq7OV5ZC1QRklYmgNz95b8hnOJka3cNZG32DDZi5KMjJwhlT2oW+4cWb0s+3Sa6nd
 QPUo0QFaTUt4Bp1FexaZKQRQtje/8P/zZJKRyCBIzEvvoWErB/AM7WGSjxggNA7+Z+uxnAcHXrk
 LfcfrVlQ8O6G8p/HrMdkhLusGSexzFYiw+fJ1pPC6Y4FdGItMUlBsfksgZbkwWhAqqtZoWhAeK7
 8xZ4NG6/zUXFqHjB/7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250058

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

