Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8657A3D25AF
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 07:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787642986; cv=none; b=lvcx/QFO1zjEDOHfxsf1d226SHu2OesjnQm+cJa+zJ1n5Fb5Z1dVU8+iDxeeqzke9J2wwrrlWmV6ut68hJ0s3RcsX5drq5vs33JBGGsHSMVB887Lm4rVx/0LIAhMjcVnveoqhfXuLT1GwK0kcfGgH1xb98bVa2xcCuKFDXBct2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787642986; c=relaxed/simple;
	bh=eQ6Ip39Q1b4sDOZ/rNVAlC6gvqu/jwziTL08iyHMs+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VI/PSxBiO0q5v91NZoBFh8HQda9Be2afQEnDl7/vQXpf/yv5zCAa4GpiSgxJwI6GBrXr5vDzR0n7eYTwvSwHkfErwUFykYCJDLxqO6NmQpBcJKbKqqTr/bF5B0sEfxt5pdY8lBYjALCdlJ5ujwwGqMSCYfK5U/4YbfaOnZHE9l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GLdRdPJW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GLdRdPJW"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P2VeN33730138
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 07:29:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NMibR4teOYdYkghrk
	XCTY3hUZuOnevJOiLyz9Oe7WJg=; b=GLdRdPJW9cOFae/SSWEXjyYsmQRYI5FUC
	WpYAoj2KmcCtJWSIeKbswxmrhsyL7FdjBLus/Yq47B0gf8AJJxp8JAca0J3dIlQg
	RMUmEejiOUI2IipTXbUoyeJzZGa3D/95LuYR7H9F20dMqXJFyS9uf6somUCZ6eZZ
	VzQXBqyPcrCRrVACX8rnUzLbvJVSDM1V502F7YD5CUJeMZfEwTbky3/BcXJBDZ26
	b0+Dh9t8sekPc04UZWTvd5ficHEo7EOP1PnZLtZkU6D7eN+lBxaz0iuJ2tvv3dl/
	J9oET/GlpXrZe1zDNIiquRVOI8DB3GhU+W6+BxISsXYjFwF0TLKDg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7393xp43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 07:29:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67P7QGcg031876
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 07:29:43 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3q338c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 07:29:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67P7TdpH46137688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Aug 2026 07:29:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC05A2004E;
	Tue, 25 Aug 2026 07:29:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A658C20049;
	Tue, 25 Aug 2026 07:29:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Aug 2026 07:29:39 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [PATCH 2/3] s390/pai: Move locking to event init and delete
Date: Tue, 25 Aug 2026 09:29:30 +0200
Message-ID: <20260825072931.3738180-3-tmricht@linux.ibm.com>
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
X-Proofpoint-GUID: EWQpb8rLrIzd9ZOavANI6b6B6i-OZ_yw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA1OCBTYWx0ZWRfXzEKT99+gwkUb
 wZR2LiwasMQL0koCgmCtTfEW7xSV0QU60XMqKOz6bpD0ZjAoQHbQwuGLTaL6/3KHR9h+f8mSJvy
 MChy/k7QeoeLQZuHZ4SGJUqKeHyLXeGhSdsqD7ymZA0QiBDgk4feLdaig3bJNtLa20Lq1S5cXqC
 z7RLuI+G3zGRBTbiHeyQNyX3WQXzimnc7KiY5sgBJ+O5nowZLGq3zGKfRAQGXm3bGdXmpFGG1MA
 FnEKoO1dBhREk/2WuKDCYsDS3viznWQXZeV1PO00vcLsO2T1CvL2K9xq1D751dI3JZdRhnu6fYQ
 71dP11I+QF6CwoieOwe7DHQX3cLOCAsuwGuyuOe7a6Od8wrNAR3rEpjceb0N4Q2dOX/4A/SILX8
 IRus9NNqmU5vWO7oALr9zNCi+k521OtPKGFGTd0kqLnFJlr+xwQC5ijaKL3ryDgGckujhaoZorl
 RafA+IIEOVaynGrcoXg==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a8d4468 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=X5N5VOIQNw_dEAXGeB4A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA1OCBTYWx0ZWRfX6pHGbwv6OxKm
 HYkFQJpZ8XPk19gU/HWAlfy3ngwq231Sn4IJdflcebVmK2XP0G3a4nLnA0o5iwm0epBKgZ/mDwV
 vvmEZ2iZMP4wwiBj68hU9tvoQccsfgk=
X-Proofpoint-ORIG-GUID: EWQpb8rLrIzd9ZOavANI6b6B6i-OZ_yw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250058

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

