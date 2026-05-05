Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CCB1EF09B;
	Tue,  5 May 2026 10:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777975419; cv=none; b=WUwDdf3L2P/tvJHco0TGzZ+hwXbp8WEavq4Aw6SuuwnDXm4+R1Wr3v8KlEo9XiByHtlEq//TRiSsH1OYr1sQ1uhgnagCND0b4s89u+nTF4oqhaBxaLzYN4B2IuCrYITWnWhYhINpYT+cfUj8onIeUQgqgS3y+buek99XTxmUQFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777975419; c=relaxed/simple;
	bh=rEv4iadz4cn8zezvajgcLDcsiVZXq2zsdafTBeo3gp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpeSQB8uGW+QYRGqJmintR36DVt8dbKSz8I6b85RZKdG8+yQoQJLcu1m5xuufPsBWAOk8XPBD+xlJlAOHm/CKnCV4oF2l9hSInti+suKUo1UWpR1ZYXHm0uSZ8Gt7jniIH7xcTZ/lUod33r6oZ2pmTztqQVRqt8ET1nLxHT7PUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Pa1uqgyi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Pa1uqgyi"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6457LFci2292859;
	Tue, 5 May 2026 10:03:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=LRSll72Z0sVGkl4mYwmsnZ55Zwi4p1
	rrr2XnRYLIGf8=; b=Pa1uqgyiyVWXNhSGnTrq0U+HgECxbrES6AYVRrrh/nyyAp
	uMH+cCmMbeXwSo7K3g4u1ztCOIFkH2zKy//UDSsY3nfxDimVFlAFJJovJIW9LWxJ
	5Eah3ErYZl4zrXiPhVVkNhBsWcCF34qHh1vpEwKbODUo7XqdU4UUiEc9ZFzM7lyT
	fso+zHxxDhZqHw/EjWzMFAMxXyuN3l6KUmsnbND5jRYqn1OoL3jBJ7M/u/fU+QMQ
	ANQxCkhgnWReqcuqjXUOPdQBrQeXPeW+GXR9lZDc9AodBcfxLfJBM/uZP/UEH/CQ
	j9IXm9dlsT6lnzxWsgJk/AZPSom0dEKW8nfgMRyw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9x4k0jk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 10:03:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6459sXHU002825;
	Tue, 5 May 2026 10:03:06 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwx9y8t6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 10:03:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 645A35uo46268820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 May 2026 10:03:05 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCA722006A;
	Tue,  5 May 2026 10:03:04 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10E282004E;
	Tue,  5 May 2026 10:03:04 +0000 (GMT)
Received: from localhost (unknown [9.111.75.48])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  5 May 2026 10:03:03 +0000 (GMT)
Date: Tue, 5 May 2026 12:03:02 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        John Stultz <jstultz@google.com>,
        "Connor O'Brien" <connoro@google.com>,
        Vineeth Pillai <vineethrp@google.com>,
        Joel Fernandes <joelagnelf@nvidia.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] sched/core: Don't steal a proxy-exec donor
Message-ID: <ttek6l2@ub.hpns>
References: <c00-01.ttedd70@ub.hpns>
 <p01-01.g703486db8203.ttedd70@ub.hpns>
 <10282ce9-f4ae-498f-9b57-f4e1e61fffbc@amd.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <10282ce9-f4ae-498f-9b57-f4e1e61fffbc@amd.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA4OSBTYWx0ZWRfXxYGdsg5Af43Z
 Kp/C2w4YfdKigAZfXwhZG4wUZDlqmABEKQeai0cXZJCiN0st6vX5glwYmv6U0qCkhVReq+X9ab0
 rtJOvjmPwC9NxttmiDocP73WpmFxFfhuni1wJVbwmXsKLDcPD6KXzhd3Gs2cFE2xuesAZZIBkGQ
 MJiViM3uiizyda9XPY+tuZWCXNIGpK95fQiY5W9C7C+z0idpAcQ7wZj8uIEP8czvzkkvvKNvGD6
 QxpypZRgQsdMKEZRFLrzQRIyI/a6625YkcG4eS581NmHUpYFgugBPkShV+03D3hqNN2wtrB74ro
 KxsT8N9ZOk7pe6q1/YoxxoORGT69IWfX7so9qvhnlPOg4Thk8gzLxRs1MYSVXtAXpPCMK3RXChY
 JovCdafbbCb18+TS2trHLlehKt+nUkF1uaL1ZA6/jkHt7Gj8/uu3RqZQqC0M+gedXWMzdgw1vcU
 CHBy/j1ZlU18AwCjEKA==
X-Proofpoint-ORIG-GUID: 1CFdqXYUJwZJgPySmnoBH7lhMnUGV3T-
X-Proofpoint-GUID: mRQjUoC_ZrP6ZvNapkwovWUolEinJVFR
X-Authority-Analysis: v=2.4 cv=W7UIkxWk c=1 sm=1 tr=0 ts=69f9c05c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=WWO3Wv_cxqnUzhJZ8lcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050089

On Mon, May 04, 2026 at 06:49:05PM +0530, K Prateek Nayak wrote:
> On 5/4/2026 6:01 PM, Vasily Gorbik wrote:
...
> > Commit 7de9d4f94638 ("sched: Start blocked_on chain processing in
> > find_proxy_task()") tweaked the fair class logic so that the donor task
> > isn't migrated away while running the proxy. Do it similarly for
> > try_steal_cookie() and skip src->donor as well.
> > 
> > Fixes: 7de9d4f94638 ("sched: Start blocked_on chain processing in find_proxy_task()")
> > Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> > ---
> >  kernel/sched/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index b8871449d3c6..3cf5fb70814c 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -6358,7 +6358,7 @@ static bool try_steal_cookie(int this, int that)
> >  		return false;
> >  
> >  	do {
> > -		if (p == src->core_pick || p == src->curr)
> > +		if (p == src->core_pick || p == src->curr || p == src->donor)
> 
> Although this solves the issue of stealing the donor, I'm a bit
> skeptical if proxy exec even works with core scheduling at all since
> __schedule() can override the decision of core_pick and the CPU
> may end up running a task with different core-cookie if it found
> the core_pick to be blocked on a mutex :-(

I think this patch is still valid on its own.

The cookie problem probably needs to be handled separately.
Do you mean this path?

   next = pick_next_task(...);
   rq_set_donor(rq, next);
   next = find_proxy_task(...);   /* may replace next with mutex owner */

I'm trying a check in find_proxy_task(), before returning the final owner:
---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3cf5fb70814c..46d21ac83e72 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6952,6 +6952,12 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 		 */
 	}
 	WARN_ON_ONCE(owner && !owner->on_rq);
+
+	if (owner && !sched_cpu_cookie_match(rq, owner)) {
+		if (curr_in_chain)
+			return proxy_resched_idle(rq);
+		goto deactivate;
+	}
 	return owner;
 
 deactivate:
-- 

But I'm not sure this is the right/acceptable/sufficient fix though.

With that check and with temporary debugfs counters I added, on the same
LPAR as in my initial report:

cd strace/tests && make -j$(nproc) check

gives:

attempt_total 157
attempt_cookie 106
attempt_cookie_mismatch 105
exec_total 52
exec_cookie 1
exec_cookie_mismatch 0

So strace tests do exercise mismatched proxy attempts. I'm not sure if
there is a better specific proxy-exec test to run, please let me know.
