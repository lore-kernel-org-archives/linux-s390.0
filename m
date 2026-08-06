Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D051A3DC4CE
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 14:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786025192; cv=none; b=sOyeYOWUmUw4HtXa4ZR3sA7iN2qnLxIpqIqMPHSwcmVvq4Sv1s6asXOG88T2K9DpTnn6YWRzzU9AEmBxHOgRH3nUM6oonUJYWmFPHXCqwKk51WYg/TNsz+taP223iHD/0yGcS0hyvPhr5jxsXs2czzCnj9ZTqgJxL5oUpntXyLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786025192; c=relaxed/simple;
	bh=JR49Ocslx/ZEMI3Ij7z153KiCdToDNnLEcoYrjEAFko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6wNWP3MIuobPmovYDizhuf+XSYDSg3wY5XdRERQWvpDhs/dkkwX8I+EMdelvAwO5VSIP+InUoZYcXDUQIvE6nHCCDy9A/9277mHKbjWeeyJ/hy776eO+YEzHiCtJ/xqSpKmL4BAgqUWchEu6EHWoSY5WBGA7Xjn6p9NPaQNBcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P1vqLaqU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P1vqLaqU"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676DO9ix1144240;
	Thu, 6 Aug 2026 14:06:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=IwH5R6oyfqpWBlaIz9VVjJf1JPuiku
	SeIbnzTdfHyaY=; b=P1vqLaqU1f1B/fc3e3vCfv6FHu+sAuoIHhptZj95oqY+kq
	H88hHDhcWthgQArDQu2cxsORGXtRuqhnuLt1wFAyDtNt6G/SSEf3uXtVR7k13i9m
	l8Clk3rcmBHXHxYruIhuFec4eIMEZsZdYFy46sBNHOtVjbAUdmyuWgeDUZBqB58i
	FuWbGe0pqr+ohETN/gCk7s0dTxFXuz+ATL2Bg/NwKCu6v3ZmirySQwChpisFkTjk
	S/MP4F/K8nXJA2kIkJIp4uVo0Hy4kHN3mRbJdQUfm70meX97AkPrbwHfeVjEsp/3
	XhJOH6+TdR/vk5o0UbP6mxvVInrWL/PFSvZjN64Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8euyxwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 14:06:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676DuFYV005935;
	Thu, 6 Aug 2026 14:06:26 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4quk0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 14:06:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676E6MPT43712862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 14:06:22 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA97E2004B;
	Thu,  6 Aug 2026 14:06:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AEECF20043;
	Thu,  6 Aug 2026 14:06:21 +0000 (GMT)
Received: from osiris (unknown [9.111.55.125])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  6 Aug 2026 14:06:21 +0000 (GMT)
Date: Thu, 6 Aug 2026 16:06:20 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>, Stefan Haberland <sth@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH 1/2] s390/dasd: Add __context_unsafe() attribute to
 various functions
Message-ID: <20260806140620.15764D1b-hca@linux.ibm.com>
References: <20260806130050.2057443-1-hca@linux.ibm.com>
 <20260806130050.2057443-2-hca@linux.ibm.com>
 <20260806130917.3DD841F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806130917.3DD841F000E9@smtp.kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iBOEB7yY02pTJXVj6gTTb5ZRzlwajIqd
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEwOCBTYWx0ZWRfXzsZLWjM8gHnT
 5IiTGEvx8agpwwfZRDQwJsm8genAu0nwm+s4RBxeOLN9koLA+g/ItgZ0E7Q8O88/D7dj3QwVLZ/
 DNAgTUmgfuQiixCdAIoKpexpWFC20RU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEwOCBTYWx0ZWRfX39nEqpQhuFiw
 XpM8/N1tUuNyMTNZloiuZ6G4BTnaccpDyBs00JPeCB1/yvtoUFL1UmBjlkN44qTLjcHmmpwZpyL
 EfoSL7NljQTv0sqv+/c8VBAITqnNGbFkHqnakc/tR3yA8B6h8S7/QgpLw8KdoyuXaXcm6bH3DUH
 xb7lk8pO4BKNMfqxj+UBuGjlwdmtq1J0i0YhwmeR+Qqzhycj9WQaR8rNPki/e7q7+baHrrarNfb
 h4Dvir9DztQVMSNkkG7dDRguzcRlgUd2nOtHSM2bvGLWC9BVjCyzrcpcyTTZJZngR8VN7MF4RPL
 g1is9nnxlDiHcVRx6NKUIkPp+Y+gLC0qL9Ou4xk10YZQTPY+cR5n+wgr7nmhIa40fZHtUWZWNr0
 KPd9XJDNbo37OxyBP8Pr/HRZiCB53R9WxMGu2ecfIUwJBixQKLZeQ5h67JiRwLsLk2x5bP5LsxE
 fbk4BYdhtUivkAARVvg==
X-Proofpoint-GUID: iBOEB7yY02pTJXVj6gTTb5ZRzlwajIqd
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a7494e2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=33E_BfKey7mWPERp4HUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060108

On Thu, Aug 06, 2026 at 01:09:16PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
...
> >  static int dasd_eckd_pe_handler(struct dasd_device *device,
> >  				__u8 tbvpm, __u8 fcsecpm)
> > +__context_unsafe(/* Conditional locking */)
> >  {
> >  	struct pe_handler_work_data *data;
> 
> [Severity: High]
> This is a pre-existing issue, but does silencing this warning hide a
> legitimate cross-thread mutex unlock?
> 
> When kzalloc fails in dasd_eckd_pe_handler(), it calls mutex_trylock(),
> establishing the current interrupted task as the lock owner:
> 
> dasd_eckd_pe_handler() {
>     ...
>     data = kzalloc_obj(*data, GFP_ATOMIC | GFP_DMA);
>     if (!data) {
>         if (mutex_trylock(&dasd_pe_handler_mutex)) {
>             data = pe_handler_worker;
>             data->isglobal = 1;
>     ...
>     schedule_work(&data->worker);
> }
> 
> The lock is then released from a different task (the workqueue worker thread)
> in do_pe_handler_work():
> 
> do_pe_handler_work() {
>     ...
>     if (data->isglobal)
>         mutex_unlock(&dasd_pe_handler_mutex);
>     ...
> }
> 
> Unlocking a struct mutex from a task other than the one that acquired it
> strictly violates mutex semantics, which could cause debug warnings or
> panics.
> 
> Additionally, mutex_trylock() in atomic context (inferred from GFP_ATOMIC
> usage) violates lockdep wait-context rules and PREEMPT_RT requirements.
> 
> Could this code be restructured to avoid the cross-thread unlock rather than
> silencing the warning?

This looks indeed like a valid finding. Looking at the code it looks to me
like there is no need for a mutex at all. Instead a simple integer which
indicates if the global pe_handler_work_data is used should be
sufficient. Exclusive access would then be tried to get with xchg().

Jens, Stefan, should this be addressed before or after this small series?
I would prefer after this series, since in the meantime I dislike those
"pre-existing" bugs, which pile up :)
