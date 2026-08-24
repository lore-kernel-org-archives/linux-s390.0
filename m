Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1F1423E96
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787577487; cv=none; b=BzCkgCmfXtJ91J/9mXZ48+kmpm39sBXpvySxw29UZD+f/1RZCiabttURCtK7z2f4tI58JQsuFVoQrZ6ssGpn7U4vhsPtUSlVWRjk2NWTS6vN9U6ckOAr4evbSk1XCRbctpmIrdV1d2FYsh7OotFPfmQFGEiLvPGTT/IiNSXlHG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787577487; c=relaxed/simple;
	bh=eQ6Ip39Q1b4sDOZ/rNVAlC6gvqu/jwziTL08iyHMs+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ox1foC4D2vz+LlOw/w4hz4lzRXsXMc8etjx6uDY3odQ9G/Awgm5o6G2yp4GUJbYLhTMBUBaUtfxNoDpFmPKJF6fVjcbKMaig8YI+deaT97+h7A63yeqEk2hqC/C+YJz15qTCDGcXiUFFjFH4oKzVyvLnDFOrEHYeLbkwVWzv4E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L35hC2Wa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L35hC2Wa"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OD1VvW084936
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 13:18:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NMibR4teOYdYkghrk
	XCTY3hUZuOnevJOiLyz9Oe7WJg=; b=L35hC2WarSCBIjx8bzgL9jj/jEfwTmAd6
	MZ8PqNzMJbt8yb8Lwj4tUjtHGKjKbbS1G1UFiKWAMjGp+nRw/S2TFV5okP0IEh5s
	gbQ2wC9BXhWWKiJ0sRpZh7yKkD4s4pg+apmt0i4+VQ3Dkxa+ITnkPFwP6WPfk+Yh
	UdQcrQB966PZkhuN6iaWq5+NzgIHUbyCIb7wLiB2q+eJgKZdMVYLnlUTQMpserbB
	J4/YGXWniyy6vKpR1EQsEenbGdNyZKJ61q0yO9GzKTR7KOdGBMiUafK0tc8QhLc4
	bWDGFvxtkvQIB2HuBWYpV4+Dh44XYdpIuWjjv9rMBMjxvonUme59g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqhfsa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 13:18:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ODBF7f006311
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 13:18:04 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rag5w75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 13:18:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67ODI0nr44302614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 13:18:00 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 783BF20043;
	Mon, 24 Aug 2026 13:18:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6378520040;
	Mon, 24 Aug 2026 13:18:00 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 13:18:00 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [PATCH 2/3] s390/pai: Move locking to event init and delete
Date: Mon, 24 Aug 2026 15:17:50 +0200
Message-ID: <20260824131751.179275-3-tmricht@linux.ibm.com>
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
X-Proofpoint-GUID: 9Im8mnAQPrEa8bpmQxwGSdTXZwjSdeCy
X-Proofpoint-ORIG-GUID: 9Im8mnAQPrEa8bpmQxwGSdTXZwjSdeCy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEwOSBTYWx0ZWRfX04qBVw0JBbOu
 CXYYFHILT3l1w4DQZKL+RsjR/qS9SjAPlHKK2RcgwBBrvXlP5jwuGaJQON0wmEjdWEAoeZ1EAT8
 g3PIQlfmw9CAT+xq7jNb1nqyIa+rftxJLVjlWFKIm3UrMgKDnodw9dKWkxetEC4cx8+2BHgTR0F
 o0T5+fnpV4homjDck0CC7UnCjUjgo/AVKzRV1a9/jYg6DH6BVPT+yHycF6NQJcMKix5E3F78mCw
 eOpF+ILl5cHAcGTBQphTaryfCW0RBvIlbGNApUBOgQwy/f7vY1dbehzKP120BVFxajJBZO4Pfx9
 kVLBQau9jLV0926vsPQ+2a7aPAHUowSmCEeZjdR9PkSH70Km10p94gKhtHcsblhmoEGgfDi0dkm
 xJ9qAtYheXNBZCmNkKgXPLWTSewQCRy5ee5w17ONueY1JHCV+nRSj4FRIHvZXuXgjVdkr0ihMft
 LcIOCLb8N4/br1MMvGw==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8c448d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=X5N5VOIQNw_dEAXGeB4A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEwOSBTYWx0ZWRfX5MmAlqu0hbGB
 LDR7d7tR9/3a0MCAtvPOzzBwXPCaTEh3Y46umttayO+g/cIeEOmKd8agax9EpsB4XUz9xFMH8tK
 dh4uW6zVTCIeEwbJm2pksRVgcWBJJRs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240109

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

