Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80663D3315;
	Mon,  4 May 2026 12:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777897953; cv=none; b=b1UuMB5sA87N/baTQtYiqBLoJZ/cFgxGa8ZhQwPrODoLZN53LvWBmHUkCnAkMQf0gS30xbEn1ROM2AbdjnaBiKDbOXhlW+8sHuM0AIVCmR1K/NLsOIzsIhpacpQcHTSEHPzFsLaXlVRe//ijbhKBUv9iGS6HSRYU81qeNI2MPJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777897953; c=relaxed/simple;
	bh=GPf58wMVS3b+Ax7mjt44DtE5xSZJRDqUYj1CQyKJGew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3/69fcmtquTnHnHN3ZBTvsmFN59L3Y3Z12muqgnyf6owXh1BQeiKKPsbE7eGEArCpAE4YMRX1hFNkHxxnejcev9UMNTLRDuZfEExD4jmZGRhvqJEM1v6kr3Jh6B+/klV08osHTuGmLiH2hr7didnaOoVzSawCEr90K20d9IvlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GECnbkXR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GECnbkXR"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 643NoQsx2791324;
	Mon, 4 May 2026 12:32:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=RW75zPvDfCunvKa15TKd9O+2HgU9tG
	qSUrlbesfIdkU=; b=GECnbkXRJYAj//H+aJijCPgSfSsu7VLxieFiHp1388e4Fw
	5yASLUMmEvFH+2njLeFrkQr+Y3FhDgVTXA+Cw6nSt/bwUQD1HNStmbbd3lx2Fhzj
	b+9OIfksfitmOHx7ReSIPBDIx+gF4y5yt0guU6U17C8MP0qCk+Dy3p6M/9pH9n5k
	B4vI39hkmbUbp3ioKRqbn448cAxc6dNh+D9gMXKTOdv4anyda1PhEWWrs42a/5kl
	UFMyA4w+tJveG3nZGZ8w5kuaAQyV1iYgIJySQJhyf4FTK07uLjBsFTTQS6eG+KOW
	UPrPrzHC3f2QOTmp8Y+Hozd+8eMIMdW9KyZHyAFw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y16wj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 12:32:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 644COYqm009985;
	Mon, 4 May 2026 12:31:59 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuyvw60g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 12:31:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 644CVvW752101476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 May 2026 12:31:57 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19F0920043;
	Mon,  4 May 2026 12:31:57 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2457D20040;
	Mon,  4 May 2026 12:31:56 +0000 (GMT)
Received: from localhost (unknown [9.111.75.48])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  4 May 2026 12:31:56 +0000 (GMT)
Date: Mon, 4 May 2026 14:31:56 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        John Stultz <jstultz@google.com>,
        "Connor O'Brien" <connoro@google.com>,
        Vineeth Pillai <vineethrp@google.com>,
        Joel Fernandes <joelagnelf@nvidia.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] sched/core: Don't steal a proxy-exec donor
Message-ID: <p01-01.g703486db8203.ttedd70@ub.hpns>
References: <c00-01.ttedd70@ub.hpns>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c00-01.ttedd70@ub.hpns>
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: _Ff3VtXVSgZv7xaBjyMJzC1FekwiwOA9
X-Proofpoint-GUID: 9poBvFVV01zDoEmHz-gTwNdvL_FRhk2Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDEyOSBTYWx0ZWRfXxt5CFJc5jSF4
 6GHeWkLTHtdjipm1yTlV/NOvaRTB2j6LDIY9nOxDstCz5Cau3wN7E8C3vUJIc+wfbx9LyqZV5aq
 d/DCXpmA9HYjnvZnDUdmFbORIn+lIFHNaTUvBheWn7WomM5KRlLCaeSvPaxSzlQpQEFEQ4N1NJ/
 wU01zYoQ5d0bhPP1i4xwVbijBHKmZckE+7jksUrOzavFOLWQ/0h6c5fPti9oxtOF0NPrYRxXdbn
 vxsR8z/E4FKdEHSEi27m4MDQI7P/dERiuakKr38a6+QkZbx9s6ge429pRV6fGZv9RcLyHQjgYHy
 3t8CE8jF1umQacokqdCXWPatEbMS84IP+8tKbMhthWnsKP/nEzDkd1MuHyIzLl5Jk3lScU+Cy8B
 wiEItR8OfhkYToub6f6TwFMGNpG+wLxw1YCCjK9kYGz8lt6m6YIhK2smCtPShFYMG6hmRHy+OCF
 2aj3EM23L67m+o0/3Pg==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69f891c0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=OAnpjWcG7tVGC2mqRyQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040129

try_steal_cookie() avoids stealing src->core_pick and src->curr before
moving a task with the same cookie via move_queued_task_locked().

With proxy-exec, src->donor is the current scheduling context and may
differ from src->curr. Stealing it migrates a task that the source rq
still treats as current. For CFS, src cfs_rq->curr is left pointing
at the stolen entity and the next pick on src hits the WARN_ON_ONCE
in put_prev_entity().

Commit 7de9d4f94638 ("sched: Start blocked_on chain processing in
find_proxy_task()") tweaked the fair class logic so that the donor task
isn't migrated away while running the proxy. Do it similarly for
try_steal_cookie() and skip src->donor as well.

Fixes: 7de9d4f94638 ("sched: Start blocked_on chain processing in find_proxy_task()")
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b8871449d3c6..3cf5fb70814c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6358,7 +6358,7 @@ static bool try_steal_cookie(int this, int that)
 		return false;
 
 	do {
-		if (p == src->core_pick || p == src->curr)
+		if (p == src->core_pick || p == src->curr || p == src->donor)
 			goto next;
 
 		if (!is_cpu_allowed(p, this))
-- 
2.53.0
