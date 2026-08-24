Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993E9376465
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 09:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787563267; cv=none; b=UZSKLN/eqoEy2NxP5BprklIdr1l/bXpIF8ua1L6VXqaAEDuYMEYznv34l983/dO3hKjK/Na8jlT61hu2ec9jR+39A1qotozc6Z2COFOijYfkBAraZJuf0xgopHvk9vTo5WY830aD8nM6+T07Zt8ZjZEdlAFxcqgOS6m8uqMEqbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787563267; c=relaxed/simple;
	bh=eQ6Ip39Q1b4sDOZ/rNVAlC6gvqu/jwziTL08iyHMs+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uMQ4GBeIsZvPftfQPiuDgaN16WrXcnyFvJqJAPqmzx1rKaWXvrD0tGYynZ5L7PzFHMFsA6T9SZqbHaBpfB22r5ciCL7CI7K93heQzIxx8WQ4Q0KAmK0aqBMnAmAGRou2KFRmm7A4BHWSlz2zBSdvwwmWg1Tnr66sUojqtidaGZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L8gpH/bC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L8gpH/bC"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O5WFIh858644
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 09:21:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NMibR4teOYdYkghrk
	XCTY3hUZuOnevJOiLyz9Oe7WJg=; b=L8gpH/bCN9ysReIzJ4HAE00B703gYu9mE
	yvPcOATgipj7a3s5TxRuj7OElx4y0ur1DaNLn/yFdredd1yObSo3Oh+OK8OCc98S
	wDP9VzsvoGgMeh/66YNXf26164TpYImb3vvvv2aotKl5EKxEFXKIlC4huK5/47iX
	J+HhL6lBtZgsrN93O9iu1lR7SExq+kyytAmioM2sajSiWM6SailmapjySJ/8WX/r
	u7L7Dzk9ZEW4dabz5lYhEMsot/PBK1lkqV/sf5X/OH9DebfcLGYhuFqmfRlwLffk
	Cm2MxNXLo99clLLkUksVSE4PdBrgKK5toUsNqpAakQvFZy3npVGLg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hgj0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 09:21:02 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67O9C6C4008211
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 09:21:01 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3pw6kd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 09:21:01 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67O9KwIe25493820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 09:20:58 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 085562004D;
	Mon, 24 Aug 2026 09:20:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E742D2004B;
	Mon, 24 Aug 2026 09:20:57 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 09:20:57 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [PATCH 2/3] s390/pai: Move locking to event init and delete
Date: Mon, 24 Aug 2026 11:20:35 +0200
Message-ID: <20260824092036.3075553-3-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824092036.3075553-1-tmricht@linux.ibm.com>
References: <20260824092036.3075553-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA3OSBTYWx0ZWRfX3cvVH0z6ZSKe
 l5gtOr/N1+QayDnjOnvfJvtj+qXCRTPu0CERe8mL+6e210coL2qB/YRYnd0RAq0f7Pb/DapAle4
 M/ioKsGT2+WDQRWb+wDeqPPLpgcgxNU=
X-Proofpoint-GUID: iSZw3RVaRAGDXMIDhk41uATVi0V1gRBR
X-Proofpoint-ORIG-GUID: iSZw3RVaRAGDXMIDhk41uATVi0V1gRBR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA3OSBTYWx0ZWRfX1ICP8JbfE3ro
 AUdcuku614AO7iS/x2ENNCuOG7RYXT2uuaNPYdrUI8ZGbrZYyfSlRRF1x5jo2n+Gl3W2tUdk/et
 EnEPGGiX5Vw0rCUMYWnL7eJlEhPYKWPqtVv3rMRPcqsKhIMxnB1jEA8decwgcesoCSarYucx2gl
 dpOTijJOB8rrD6ZQEsmIabazcvyVk8z4MTThOGQMLMprorz43uzPGb1SO6QNLSnXWMkv4wd1ghG
 llfQicE1cEi3OR1VW9edfN98tEoidMyDxWr4FE7oOHCtWZUrSYx3EPvocrhaHNxLvDykesJABGB
 MGIu5AQ5nfhagTeEqqVFD5RwQAvgx27ZYxbZ2kguB7+2h6Xh5dc6glICHbCq//Ae4FStRxuC+n/
 i11ZFFh9Hvo/G1/OY81IF8Z8Aq4L+/R+fLuC3VKoENrWLLY1hs7CeT+ulnUAd2yosZBiZa4h0Uz
 WPSCmRt7qf/xEXAq1dg==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8c0cfe cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=X5N5VOIQNw_dEAXGeB4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240079

Move mutex locking from per CPU allocation to event allocation.
No functional change.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 arch/s390/kernel/perf_pai.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/s390/kernel/perf_pai.c b/arch/s390/kernel/perf_pai.c
index 7c13f5586c79..52d9f654346a 100644
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

