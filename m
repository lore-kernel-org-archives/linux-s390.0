Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E7533F368
	for <linux-s390@vger.kernel.org>; Tue,  1 Sep 2026 12:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788266015; cv=none; b=R6Ma1ABHICmxOTDY35AyE1IzmVfopOKymt8Kwu2H82nddkujXDcUkHZvbAROt1JleAsZ9ksstguIOlDqdnkXjLv8O9wQPGVNEkBkjagT4Wt+DoJXxs7GRnfV8nLrqDPB/vjCVWn93iT0xzC7xyunKcpSoa7iWAZGFBSPXBZH4fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788266015; c=relaxed/simple;
	bh=IT30jvhZJjRffL7AV786Ruz8LhASwEe6MeKn8l926YE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CY57I1bWnmaVaOaz8dOCexCJigNvHWFKqdVbadKN7/t/r7PI4c4TMWx9U6juZlY9OxfEJoxOkjzHiLZeGxlWFsAS42hVKD7KYULhGt6cN3DNHsLqupfpgb7YC2M+ESUD6V1qetPb38iq1n1KSSF5bxqptG8kjdTP0oSQsgBaK54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tHuBW7E3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tHuBW7E3"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681AVdZl831353
	for <linux-s390@vger.kernel.org>; Tue, 1 Sep 2026 12:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=bA7dD9DhXTTuR+gq7
	RyXBUDxxNr6cq6MY/f7iSClvH0=; b=tHuBW7E3sabtTnKLXgR67mxg51mP1ub/u
	2Yrleo4EHU+Ub4/X704UMzqVYjHP1LprNY72W1aY/zfmuulORXIlM6HThniAgeZ+
	UKiCKoNYWSpKPF2qJ0AtVVuc26vbIBTocGpPBgdEG+UMNkvsDFVKzh34FAzddbKF
	gR8izz3kGZ+aRQR7ncf0QfihOqDgdQB6XHYftd8/NOZwKj0NFiFQXsY4Nix60ZeC
	MOdpoSXp84e/yz9mychitALq1kpLpshaOPz/1k8hhoGnzKg1hBYEec6hegjlBWoE
	qsNAj1I7TpIRxd9HxDd06XRf/SJWuaNz6I2BOlZIPJs4CoAi5OCSw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuhqrta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 01 Sep 2026 12:33:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 681CQNZg032245
	for <linux-s390@vger.kernel.org>; Tue, 1 Sep 2026 12:33:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gca4w3q9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 01 Sep 2026 12:33:32 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 681CXS0I46268740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Sep 2026 12:33:28 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 27E1020049;
	Tue,  1 Sep 2026 12:33:28 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1237E2004D;
	Tue,  1 Sep 2026 12:33:28 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Sep 2026 12:33:28 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [PATCH v9 1/3] s390/pai: Use PAI PMU index as parameter replacing event
Date: Tue,  1 Sep 2026 14:33:18 +0200
Message-ID: <20260901123320.670897-2-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901123320.670897-1-tmricht@linux.ibm.com>
References: <20260901123320.670897-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7aus8rX3ES_WKk17TKdB5W9xp8VRpnxe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDExMSBTYWx0ZWRfX4JiI7NBEmX9e
 dMmYxrEVlgboEKfNK2UGCWjlfbjE70SO0Oiy2XHJr/8Y9cAy6x6yFUy3dagh6EPpWJRgEpBgbzK
 3EmDYFWVim8PVcgUUsn7D+mOgS7VjBRnviFMRyzzO0kWvpAb/1ZemCMHFHs9YuRFYJJZEf9f+fu
 rXiQDpgD9T028N6yVhSVDkNEdpg6x6SmpiHz3CC98sb8nGweJsoTuI7RAEUEV2N6o6lI6EDbF5D
 JzFHZy1JucJrX6R5dsQTh5xGhracGGIMyoB1Lilt3DHwiGkYHF+7JeCm6UiQLjzVnxZiJRGbjnn
 jsz28VesaRakKS2La6FVdwRIJzy6Om+evWkcGs5yvN6G6u+6uySsavuKHtnu6co25zltFLnd/4r
 FShR4lM5oExTqkmDEM13xgwutJ1kNnEtu0Acm9fuhzPAC0pA2CAWQKfh1q1E7c8W0D6zSQP/Ca2
 MhnW4l06v/YQ0KbKCiw==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a96c61c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=JMlX-6JAepFCzwN66roA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDExMSBTYWx0ZWRfXxDTqfTWOHqXI
 hAgGRhfMeG2U/W37hU9FviiLPYkMaZl5+YXh9NjtHDLhtDdK+qJodhi6PnKRytWl2gLJpcYwdyw
 oSrKUHMVxP4PIbpbpqpn78+AJwoI8Qc=
X-Proofpoint-ORIG-GUID: 7aus8rX3ES_WKk17TKdB5W9xp8VRpnxe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_03,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010111

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
index 5c18c8b82ab7..109b15227d8f 100644
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

