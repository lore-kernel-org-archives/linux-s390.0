Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82123CB2D7
	for <linux-s390@vger.kernel.org>; Fri,  7 Aug 2026 08:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786091963; cv=none; b=ip2xm3POh6Ap1en/GfohIw6oBf4NEBo+e88x9PhnQdG2hwoZH0+bcpCmsE7SAbRq7n0H9gn2vBHFX0d/DM5lVouJcQFfIqVjZoAY4Vpj31nSdcQzVEY07y77uaWn0vtXZuZPvwT0iKZnIClT496zLvElqWql8fRe6v0NScF3YUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786091963; c=relaxed/simple;
	bh=vZB1Ie/xZo2G5/7peBCAcEZot+Rdy/Vyag20aBJKHWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nq39kcd6DSoUKAcI7nm47V/fetild2OoArwUUivxPkmHKtbOlTbPXEI8fdOjflQ6N2y4+cvnmBs1w6zcueWXKF0mbDkqlPUMxA9G31yIh33qXlzGQbvmlWcQwtIEVSyW0DWytu6ePhO+Emv5iceHUCWS9zHMcijupCzEhZdxWq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ypbezz2n; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ypbezz2n"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770IXJ64069357
	for <linux-s390@vger.kernel.org>; Fri, 7 Aug 2026 08:39:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7GN7n1zDqgNTw9+Jy
	SAcEwEURMIpYgAF/BWCWmNPGDk=; b=Ypbezz2nNl9R6/phEuIffsF9r2YqRHiBr
	Xe4+2gBb+lv6Feo5OkBgy0JrXpqOo42PtbXzpp6JXhUaxPHctz6ptDQrr8te/yds
	f7QDZ2DDPOTjv83zQbKoGy1rJ0GpQXUaztViEpCFf8scVA14blMDV5vTDFuZhlW0
	yIiYumZCfCjW/J9E6NwD0+PLoJnw3MclRUHaS9V+K+Cm2LxmMufEss0ZFCG28S5O
	7vshzRw9wpg4snIF0v/SJeyTCiNebuvY4PsZoE3WJr6NreH8n7RIM9wDHunMsZh3
	6xwnATC9DqxLap5aXzd9um15nTLxroz+zLWqy8AD04Uz1er6Mln+w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy022xsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 07 Aug 2026 08:39:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6778QG9C009408
	for <linux-s390@vger.kernel.org>; Fri, 7 Aug 2026 08:39:19 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgpryh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 07 Aug 2026 08:39:19 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6778dFx849676576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 08:39:15 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 855C02004D;
	Fri,  7 Aug 2026 08:39:15 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FD9220040;
	Fri,  7 Aug 2026 08:39:15 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 08:39:15 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 2/2] s390/pai: Move locking to event init and delete
Date: Fri,  7 Aug 2026 10:39:09 +0200
Message-ID: <20260807083910.3771502-2-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807083910.3771502-1-tmricht@linux.ibm.com>
References: <20260807083910.3771502-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _tUnpnEbDjhghOz_vPs5mo_PJJnUkSZF
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a7599b8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=jMzBUYzwOhXzX-VpXwUA:9
X-Proofpoint-GUID: _tUnpnEbDjhghOz_vPs5mo_PJJnUkSZF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA2MSBTYWx0ZWRfX70UD3m0OGZ11
 jxs6H9KCifi2UkHDeV068WjhqWHjtvGGZ2y018n+U5aonePH+7itvH1ZYxlmJjTvcyw9RHlFi20
 /jUZmouLK27uYfweBO0tXaiqwVY7x4kyydBH1Lcj6YWaqXNOtm6qTvXTBg+6wMEvMVpmxcngIig
 X+gwwZ3C8gdrp+QqenMznt6ecW+FP1aVZdub5V0YbR9fywfaY2jbABj4V3Ebqary0p8PcrTzbic
 KoT5zjywOm/PeG8HBwtsU53cHbnuuX87wiO6pJy4CTMHCX6r74sIFmNQRpWjWSep2gX74i4loGa
 eWJ8xJJ5tqT4J46/lakJol65a7e59kgiKj+2jYNy4fdMBgvGjBPkkWoKMWB/Bav18uSXRn5kjJ2
 v2iy7lcS+pHM2o3HIKBHGS4ldETyLpY98Ot+LYZVB9h/919YrHVeDjwR9wdiIHkt7Ch8arVeGYN
 9G8Udg7Vp6F7DmiqXMQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA2MSBTYWx0ZWRfXw6PM+0Lpp2wB
 vDthZs+y255jJM5erVum8T6UXIARio2/z1IiN6yq4TXJoeJRnsXowsMVyEy/VF3Tnu/3pM0yd58
 GiRHfTrQvhxipskYLwPcQo/fEiXCnAg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0
 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070061

Move mutex locking from per CPU allocation to event allocation.
No functional change.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 arch/s390/kernel/perf_pai.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kernel/perf_pai.c b/arch/s390/kernel/perf_pai.c
index 7c13f5586c79..03c5bda53ccc 100644
--- a/arch/s390/kernel/perf_pai.c
+++ b/arch/s390/kernel/perf_pai.c
@@ -145,14 +145,12 @@ static void pai_event_destroy_cpu(int idx, int cpu)
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
@@ -246,11 +246,10 @@ static int pai_alloc_cpu(int idx, int cpu)
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
@@ -308,8 +307,7 @@ static int pai_alloc_cpu(int idx, int cpu)
 		 */
 		pai_root_free(idx);
 	}
-unlock:
-	mutex_unlock(&pai_reserve_mutex);
+out:
 	/* If rc is non-zero, no increment of counter/sampler was done. */
 	return rc;
 }
@@ -390,10 +388,12 @@ static int pai_event_init(struct perf_event *event, int idx)
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

