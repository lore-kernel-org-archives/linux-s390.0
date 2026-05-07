Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A45F3EB7F8;
	Thu,  7 May 2026 10:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778150544; cv=none; b=S5l6x+13CPoN/clzfa42x/OKb9/d3TxEwD6SJOmkpjNYXj6o0v3trPvSP6L3UVN3vcFQUABKLVaVc5ylwWLg7MqEMFc/u10GoxCds/WmbSyZor+SGE9bVQdCSSy+vUHay+Cs8E395/wrCIbxlNwpf2Y083Qjaxjp4rb5sclOmpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778150544; c=relaxed/simple;
	bh=4HT4DTe36P0Uqm7n6580ZZp9IbuC4oziJ8jrvTdIJUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpI8/YI39xkxVEd27uDt35JCgprSD+V8TPLLtcubyO+HoPhhgbLSA6v8SPPq0e7HkbnnH6bb7UHiXWHkMEwYn9Eb/7AuqzUTB3v2F8QCQNstr9R92WYwwlKWWw/ub4sBgGaPg81f1lhX9/9y7/QIeRZbPvhAUprIuqu1X6DE3Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J0nqymmX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J0nqymmX"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6478UwHw800514;
	Thu, 7 May 2026 10:42:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=VJouRhW043MTZQidCG16xvopELiugw
	TQcwQHT1ND7dg=; b=J0nqymmXb1hoypeCAkfP/b2ePs3lSPa7ywP5I8j9ONiy/W
	eXASR3WBp7S8I/YXW1SNVdqh6P4oljXdZtHqVSSAbglDLnXTmyttne7r07POMMOc
	RS1PhF44wq1YYwBCTulsb9Myjjo8y3UO05fj9TUZPwYJm49/KHXWCCh+jvlcQ3IY
	f5lDxnjLYmi6wtjatQQ6uQO5phZbJgmwY5iCI/Vx9gcJJJLmCsRHysuuSOfFlXUI
	axxgOvoZ4jKFoVSTGMkkdZdjj/xoUEKq5vHQpLhhYG54xxbk7pugvbQQBAIvbZJE
	3X07ni1gXzD8umgK5RGzUvWU67JFy/z1SPC+rAXg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9x4wm5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 10:42:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 647A9TYD027828;
	Thu, 7 May 2026 10:42:04 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dww3haqfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 10:42:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 647Ag0h148628058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 May 2026 10:42:00 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 452912004B;
	Thu,  7 May 2026 10:42:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40CDA20040;
	Thu,  7 May 2026 10:41:59 +0000 (GMT)
Received: from localhost (unknown [9.111.2.188])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  7 May 2026 10:41:59 +0000 (GMT)
Date: Thu, 7 May 2026 12:41:59 +0200
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
Subject: [PATCH v2 2/2] sched/core: Don't proxy-exec unmatched cookie lock
 owners
Message-ID: <p02-02.v2.g990a0c64420d.ttenwd4@ub.hpns>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEwNSBTYWx0ZWRfX40SoSm0iDRJk
 cGd+RXZgsO/2UIC1Sszrvl/3H/0RY8SBHviTtylsdmvAbYO6BQuE5QZOWUe5RBc/kD0XyGE6zWS
 YyQ3onb8cOvqDQskO11fLvCI8K2P3h02WtALrShm9Fm1k3fArfda6rL9VCPEMF3QEPCKiFIUXfE
 jf7HgIbkECph+f56kl0TbuCEWunNA3lA71xxv009D3Nh0l48KsQjT2LW4Glu4YEce6i5hiX2D2g
 L8ZCxEfXETEfcDvAYlqX3yy5ZG4B9qGYBOnk1j+7nAZEXPbfODzuHLQLwbJvCA6TcFyqRSgcIfk
 AEXVSH6KuQnuAgP+GOMVYW3ixdNFlgRcT2ltqKrnW/rbrZfuZQgLXmQ7l3yMfVULpr2gVtQ9Xrs
 O31zcfOU98M6cgoSU0Fp+MkFfd+RXpIXwC6Ei3utUcQQTT4RCeHR5uzqrrZYxy8mjfYQ6RejXD1
 MTmKL+1jMCtCmLtWUVA==
X-Proofpoint-ORIG-GUID: XwjeGZGEYBKe-HHug21ORO6RPhyC-tbz
X-Proofpoint-GUID: 3WsugX8fnBKY6K84u2ojPHtVX7ihGzf-
X-Authority-Analysis: v=2.4 cv=W7UIkxWk c=1 sm=1 tr=0 ts=69fc6c7d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=zd2uoN0lAAAA:8
 a=VnNF1IyMAAAA:8 a=OSSEJBYsAaiz_FGXeO4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070105

Core scheduling chooses a core-wide cookie before __schedule()
installs the next task. With proxy-exec enabled, that task becomes the
donor/scheduling context, and find_proxy_task() may then replace the
execution context with the runnable mutex owner. If its cookie differs
from the selected core cookie, running it would bypass core scheduling's
cookie selection.

When the final mutex owner found by find_proxy_task() does not match the
selected core cookie, stop proxying the donor. If the current execution
context is already in the blocked chain, fall back to idle like the
existing proxy-exec retry paths do. Otherwise deactivate the donor and
let __schedule() pick again. The mutex owner can be picked later under
its own cookie.

Fixes: 7de9d4f94638 ("sched: Start blocked_on chain processing in find_proxy_task()")
Reported-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 kernel/sched/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8aed55592ca9..d338fb714ce8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6960,6 +6960,12 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
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
2.53.0
