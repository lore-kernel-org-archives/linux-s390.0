Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B742D2D63E5;
	Thu,  7 May 2026 10:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778150542; cv=none; b=licTedNtWgWHZU2Ga7s074OwyP5FIFvcOktyvdTFJHD3CNgBI5FPqpyGX2xuuYn8YA+P+CvUSL75ikh3TYZE20mQdIpseFBXt3SaSwAM3peWDcaPcbgwGcevSi68Kw3iCrnRIhwkhFsFy3cSF2Aybh/0WKFjCw7lQPCvrH2RnZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778150542; c=relaxed/simple;
	bh=PjinT7tiraG1S6a40BSKxF3WKdS/o9XMEvAmSIMqUkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=annWvY4EX85w23bxt43RcSuzCgPxxBjj1ZOUwCJOp96lVdkZOMb62k+shasCcKeOJ6vhbIoP+5Sm0ohpOQ9DX9SCS1WnOHiFc8Y1Djgv0YKagYhkYKDKegSeKXakzljWbt77JWLXkeIOxYfPD8D3wEy7dD94WbzCw4IfHacVqKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fKTMZUeY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fKTMZUeY"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6471Cxvt837252;
	Thu, 7 May 2026 10:42:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=WO99NNWu/VEdAvrd3Gt3tt75cdopfi
	IZaVngJwl7O2E=; b=fKTMZUeYLu1gEL54NzN2fVow3rSpKGJd1jKitoaKVyi/RZ
	EheNxNsTp/C0HVjtGwJas8EzrGf5ynjy3HrvHeJpjgrpzuoPTTZx1KvgtsV0H7E5
	XbxNU/RxRSVzWbIFqJyTGP9h2PlEiG9duV6myqBNK2GWLAePVQwSIDqpRhQd0znu
	cmb++O14n+FgrwkfWVRnbIzNtLHX4KAn7nLx0aP3GbGz+Ucr38IY+iJ2xsZjJUVi
	A7Elk48YNT8qhjFL/BKhx2riK6bHJWxBulZ0sQtEMz/cewp0I130C2Yjw6yQthwi
	WU0AcczpAF6yom6ntus5ypzLUHayVFtXjJhfzPUQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9x4wm5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 10:42:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 647AdZH4017281;
	Thu, 7 May 2026 10:42:02 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwvkk2s1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 10:42:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 647AfwPi21627304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 May 2026 10:41:58 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FB4020043;
	Thu,  7 May 2026 10:41:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B4462004B;
	Thu,  7 May 2026 10:41:57 +0000 (GMT)
Received: from localhost (unknown [9.111.2.188])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  7 May 2026 10:41:57 +0000 (GMT)
Date: Thu, 7 May 2026 12:41:56 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        John Stultz <jstultz@google.com>,
        Vineeth Pillai <vineethrp@google.com>,
        Joel Fernandes <joelagnelf@nvidia.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] sched/core: Don't steal a proxy-exec donor
Message-ID: <p01-02.v2.g318c298267e3.ttenwd4@ub.hpns>
References: <c00-02.v2.ttenwd4@ub.hpns>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c00-02.v2.ttenwd4@ub.hpns>
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEwNSBTYWx0ZWRfXzrkE6AVc9tPD
 tjKY9EwvyU1pCcjVnx+6fcPvgE6tf92E05DXcfl8lvLm5nfV3UeMEDFREcHcyMqkzC7MkT0itVN
 11Wdy8rXfuuMnM9A+kWjhFlfxST1RxWeEycxSkRmjRv+JrKRbxDIA+SnYpYH7oidiijTIoKdf0J
 aUq4U/V34fYmeKGGtm7AX0Y4ld+6d6sLwKEOhoi0BkrOujcWyZbDjAYJTw/K+FACQajTkhLT6p/
 2Tdne/YvVGJH82jOqeBd6M/+R4sYMeUqobPpbTjBce1kzc5McWvJ+nvYHZYBshIege9bg8tFm97
 CnjpdnMFowDlAyYi+DD/B0xDAE48r4EqRhUcugaw/E35lTkjkvdzHYxwViAfo8EN69yXp7voXas
 Fioj11jEF7JCbQu5VxrnCiwoQQU4VppwTmzMDq3yfqOkzk/3iD1fY2q2I5ObkqtDmrS2cW+texd
 YmGe5rkSjftt8cWpeTQ==
X-Proofpoint-ORIG-GUID: _ZV2UZGYgpWjWY8Prd-GnVQBRj1xbN6s
X-Proofpoint-GUID: kx4ecCa1V--M_cSHNvklz9_M9e5R5YYU
X-Authority-Analysis: v=2.4 cv=W7UIkxWk c=1 sm=1 tr=0 ts=69fc6c7b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=i_mD11TinqcGUWm_tM0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070105

try_steal_cookie() avoids stealing src->core_pick and src->curr before
moving a task with the same cookie via move_queued_task_locked().

With proxy-exec, src->donor is the current scheduling context and may
differ from src->curr. Stealing it migrates a task that the source rq
still treats as current, leaving src's scheduler state for that task
stale. For CFS this means cfs_rq->curr points at the stolen entity,
and the next pick on the source rq hits the WARN_ON_ONCE in
put_prev_entity().

Commit 7de9d4f94638 ("sched: Start blocked_on chain processing in
find_proxy_task()") tweaked the fair class logic so that the donor task
isn't migrated away while we're running the proxy. Do it similarly for
try_steal_cookie() and skip src->donor as well.

Fixes: 7de9d4f94638 ("sched: Start blocked_on chain processing in find_proxy_task()")
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b905805bbcbe..8aed55592ca9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6366,7 +6366,7 @@ static bool try_steal_cookie(int this, int that)
 		return false;
 
 	do {
-		if (p == src->core_pick || p == src->curr)
+		if (p == src->core_pick || p == src->curr || p == src->donor)
 			goto next;
 
 		if (!is_cpu_allowed(p, this))
-- 
2.53.0

