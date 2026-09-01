Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4181327703
	for <linux-s390@vger.kernel.org>; Tue,  1 Sep 2026 12:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788266016; cv=none; b=Bb4Zn/yCj0ZVovSinsMBkbgP+hFoB9ZA9Mxplwx/HNoJVBNiT3TDNBcgNAtSdZaWY6np9GJNu6zo5ehay688MZPqxsS2+Cd9V8q0dprs7CXX6UdiDwHiuTLZd8vpMl85q9F9lPP60YFJCqQTR20WyuwAxAKUlGDXaHiUuIuJJXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788266016; c=relaxed/simple;
	bh=mm1eloLFUYOqOW9oL6+cLGBZWMvkqZXtK0GPzEvczqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2aKIVyoDbHu4uCW7rWZUNu8N/wmPdzpcxn/YYjWSuLhuSuLH1Vm5gk1MkvJ5TpV57MYFpuzJOJlQL+8r7oaXZoL4nFupI4nSOITntdBvQSRpwUi5B5KgXJCD2vYGzn7+SOBPmGTLM2Fk2F4HkGDPa+17wtYqjyA/kXf8nBxRbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oAKuAbc0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oAKuAbc0"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681AVf454009806
	for <linux-s390@vger.kernel.org>; Tue, 1 Sep 2026 12:33:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=bznUrJhoW4SZi0ohC
	TxmokG43AfB19nIpUx5q8BHNP4=; b=oAKuAbc0bwNzdin3U2B1tuFMfWKYXFN7y
	PcDeQFJmoOYSsJLt43WofrAbvkgdp/L38eBq70eOR0OVL1btBqFhAX0BOnhSvnoW
	NU/BZQlYPnFZQXxFdW1ZrYGFX66mu5Al4Y4kDgdY3h23WfQlVhPu7s/mQAzjwdPn
	trfTzy3uF6QTvWzZFC2njd8qAPHMe8loX2jXfMzIcW3ilkjIPRnP8m8W8puANETN
	2cS9EjbJ+8MzuYZUKMsxhCY6q0dVeFbhMEINH4R3DtaM97P570MknSmcOpdK/IsT
	KDvdi5RPLt1jDyfWfEeAkrKfKDQSTYMZcpl2PAnA8SewKTtv5mA0Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnudqme8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 01 Sep 2026 12:33:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 681CQJgl000594
	for <linux-s390@vger.kernel.org>; Tue, 1 Sep 2026 12:33:33 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8hbk2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 01 Sep 2026 12:33:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 681CXTJ815991066
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Sep 2026 12:33:29 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61BBD2004B;
	Tue,  1 Sep 2026 12:33:29 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CBC120040;
	Tue,  1 Sep 2026 12:33:29 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Sep 2026 12:33:29 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [PATCH v9 2/3] s390/pai: Move locking to event init and delete
Date: Tue,  1 Sep 2026 14:33:19 +0200
Message-ID: <20260901123320.670897-3-tmricht@linux.ibm.com>
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
X-Proofpoint-GUID: V4-crfw9epT7Wo_VHEM_GWhNC0FX9p3p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDExMSBTYWx0ZWRfX3YRR8eUhYGi3
 mMc5+GSw0lR1aJvLFhF4tCakEn/+pjA+HYtEuF2Wu/gtDkJd/fOmH+0cxwuWPUNizUaSn5Yyjv2
 9u/PdOhDrzW8aa0KMdbo4i50Cl1CmJOsq+tsN544AcMeRlOyexN+CrAGPBDb7H7+AMlN7PYPLsK
 610ddGq9A72pVGEZigO2cdhTkMg+HbAtfYEUiuayukrC+m8xsEYdffFVl9qoqyHcd/p7pl8MBKn
 MJL2QHNUXgpX4hTj+zqruIm6wQSGo7jGSJqKO2lv0NJHSSOdCX2UQmaJpKp4DHMU7mGorc7JLJ0
 7WIXhbLUheYxPdebM6FBANR/XeGmX3K4LxWuBMQwo9DcyE14PJTUx1N+UG0J+tL0N/ZkuaNINb4
 Pd2Y9Mje6HIimyv/bYgcoEzSywwRWjI9JQ5FLV2x8aZmlvKLf7bfW2D2Rl8sHSnkHprEDny5ArF
 mSjl58oisb28K4xSPHQ==
X-Proofpoint-ORIG-GUID: V4-crfw9epT7Wo_VHEM_GWhNC0FX9p3p
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDExMSBTYWx0ZWRfX9JetebmMLA+m
 rK1P8x8nXfdxFo07u9sxgzHhd86qRnNqKQGaawrFmibAG4OMvsGFE4PTcndPJZa3lewbiS/yL0Z
 XVgU/V3TBZYsdDjI2Jk2stzBWxjhMlA=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a96c61e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=X5N5VOIQNw_dEAXGeB4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_03,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010111

Move mutex locking from per CPU allocation to event allocation.
No functional change.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 arch/s390/kernel/perf_pai.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/s390/kernel/perf_pai.c b/arch/s390/kernel/perf_pai.c
index 109b15227d8f..c333158cc945 100644
--- a/arch/s390/kernel/perf_pai.c
+++ b/arch/s390/kernel/perf_pai.c
@@ -138,21 +138,19 @@ static void pai_free(struct pai_mapptr *mp)
 }
 
 /* Adjust usage counters and remove allocated memory when all users are
- * gone.
+ * gone. Called under mutex_lock.
  */
 static void pai_event_destroy_cpu(int idx, int cpu)
 {
 	struct pai_mapptr *mp = per_cpu_ptr(pai_root[idx].mapptr, cpu);
 	struct pai_map *cpump = mp->mapptr;
 
-	mutex_lock(&pai_reserve_mutex);
 	debug_sprintf_event(paidbg, 5, "%s users %d refcnt %u\n",
 			    __func__, cpump->active_events,
 			    refcount_read(&cpump->refcnt));
 	if (refcount_dec_and_test(&cpump->refcnt))
 		pai_free(mp);
 	pai_root_free(idx);
-	mutex_unlock(&pai_reserve_mutex);
 }
 
 static void pai_event_destroy(struct perf_event *event)
@@ -160,6 +158,7 @@ static void pai_event_destroy(struct perf_event *event)
 	int cpu = 0, idx = PAI_PMU_IDX(event);
 
 	free_page(PAI_SAVE_AREA(event));
+	mutex_lock(&pai_reserve_mutex);
 	if (event->cpu == -1) {
 		struct cpumask *mask = PAI_CPU_MASK(event);
 
@@ -169,6 +168,7 @@ static void pai_event_destroy(struct perf_event *event)
 	} else {
 		pai_event_destroy_cpu(idx, event->cpu);
 	}
+	mutex_unlock(&pai_reserve_mutex);
 }
 
 static void paicrypt_event_destroy(struct perf_event *event)
@@ -232,12 +232,10 @@ static u64 paicrypt_getall(struct perf_event *event)
 	return sum;
 }
 
-/* Check concurrent access of counting and sampling for crypto events.
- * This function is called in process context and it is save to block.
- * When the event initialization functions fails, no other call back will
- * be invoked.
- *
- * Allocate the memory for the event.
+/* Allocate all per-CPU data structures. This function is called in
+ * process context and can block. In case of error all partly allocated
+ * memory is released and the reference counters adjusted correctly.
+ * Called under mutex_lock.
  */
 static int pai_alloc_cpu(int idx, int cpu)
 {
@@ -246,11 +244,10 @@ static int pai_alloc_cpu(int idx, int cpu)
 	struct pai_mapptr *mp;
 	int rc;
 
-	mutex_lock(&pai_reserve_mutex);
 	/* Allocate root node */
 	rc = pai_root_alloc(idx);
 	if (rc)
-		goto unlock;
+		goto out;
 
 	/* Allocate node for this event */
 	mp = per_cpu_ptr(pai_root[idx].mapptr, cpu);
@@ -308,12 +305,12 @@ static int pai_alloc_cpu(int idx, int cpu)
 		 */
 		pai_root_free(idx);
 	}
-unlock:
-	mutex_unlock(&pai_reserve_mutex);
+out:
 	/* If rc is non-zero, no increment of counter/sampler was done. */
 	return rc;
 }
 
+/* Called under mutex_lock */
 static int pai_alloc(struct perf_event *event)
 {
 	int idx = PAI_PMU_IDX(event);
@@ -390,10 +387,12 @@ static int pai_event_init(struct perf_event *event, int idx)
 		}
 	}
 
+	mutex_lock(&pai_reserve_mutex);
 	if (event->cpu >= 0)
 		rc = pai_alloc_cpu(idx, event->cpu);
 	else
 		rc = pai_alloc(event);
+	mutex_unlock(&pai_reserve_mutex);
 	if (rc) {
 		free_page(PAI_SAVE_AREA(event));
 		goto out;
-- 
2.55.0

