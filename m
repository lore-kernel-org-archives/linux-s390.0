Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAEF583AD1;
	Mon, 31 Aug 2026 13:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184203; cv=none; b=NKS9Rpz3BYzsPXa/9TRjIyxBKp4jy0/YYGxolP5ng5A6x5a3/RlZVjzY0+WRDG9nt3Xtkl15LqmtwfcaK/lMUNC5E+yXyVsBPBydVFHErMg0hVmzp2Tw/a13/6UrAOhio9/dq/Gvrg+9O7J9TOGsVT6nzX7krk1esY/2ztQ0eUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184203; c=relaxed/simple;
	bh=mWFuC8NsnzyczBwqKOggbbR5YZsG1bvt5EJYLDusQIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCMSHUIaAI4a+CsZvyuJYOk8l6YcbpMGibEzuGHVQCPdFgDXkG+soGI3kF97RAwast/b7zKYYD+55aDX4rnGB8xKGzTe1nNKGGtYLdU6inRO7tpF40gTqrKFLlA+HjYsRU8hOe9OBgR+vvHzBOCMiE9/uFjf2pr89+UjQ9yeYAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mOqKDHcp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mOqKDHcp"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VBVeqK2083869;
	Mon, 31 Aug 2026 13:50:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=qCw/GPI2+MoYHnR0vQ+plbASqeCQ2G
	rQ/nIOh98JAPU=; b=mOqKDHcpPPSAtF4FTOE7KbKaVyq30FAzoTuUtTDhpTSiYT
	Fsoqkg9Yjyrg/UYr0huLm4s0B4frFGj/EtvuY5BCSSSehNcOsSV9uahMFCxMERKq
	z58otfJWoAZ8oJLSqpSLRlFm5eyeDyo1WBOEKtYdHLuqLZn4cjtdkLHr0JGrWkPt
	1P9OHw6ShOc2FhYZ6fI2Y6EKWw9fRHQkq1CHWslHgJHJoyWCY4QDwBhSVo8l3gMP
	5vf3OAKBpHN9gQphH+hirre5ixoos3GVB2lXA1lUR8Q7Nt84MVhhDVeglp0SP6po
	A/aYK7+hehIKrmeUAXM0JLR3pe6mOZOVtY1bEVYA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq54hkwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 13:50:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VDfL9A021508;
	Mon, 31 Aug 2026 13:49:59 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarjx5xd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 13:49:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VDns0J49021372
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 13:49:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98C9F2004B;
	Mon, 31 Aug 2026 13:49:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 569B720043;
	Mon, 31 Aug 2026 13:49:54 +0000 (GMT)
Received: from osiris (unknown [9.111.81.24])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 31 Aug 2026 13:49:54 +0000 (GMT)
Date: Mon, 31 Aug 2026 15:49:52 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: sashiko-reviews@lists.linux.dev, linux-s390@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH] s390/pai: Prevent ioctl(PERF_EVENT_IOC_REFRESH)
Message-ID: <20260831134952.34274C64-hca@linux.ibm.com>
References: <20260827064612.3161950-1-tmricht@linux.ibm.com>
 <20260827065709.D6E561F000E9@smtp.kernel.org>
 <d3ad41b1-909d-48a7-af89-2234a9a84627@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3ad41b1-909d-48a7-af89-2234a9a84627@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDExNyBTYWx0ZWRfXwapv9TVrmhMd
 PbSMb96MpwlLjzNWj06r5n0jrgAFUKnVV3R6TCSm737Sjbp33uP5/a02Ma3jjoIDvk53Jrmy6wG
 B9iCcXJyb4sDqll9D+/w+xj6vciV117GKjMMkZAwvbJ1ZiPWhJUwTgR+T+wHXosCPobhIGP/eXd
 grq0Q7WSedkrm01zRAspoi1JGbITzgdyyavSQi1Dyxt4Ycrq0KCUT8lR3X3m+V8SH/hqXPiGhCf
 vgecYS44f1dPzjUaRGc+glWYWhQak2XiK4+PIw74quiBO47Rqgsz+gd9wjmn4PQIs9sp1hzuPjE
 qzqkYwFIBRDrtguXkFRL4YUZuuv+vYLSw+f1dKEBSxegQ6hxXrovV+k50hQgiIdXWLvNTJtq90R
 minRvL9iVj4Mf6Qz5gcvDqbwexkv4a2KVojsQF8qof6PUH33ZSPnZXGG91fd7R+Zj/EgeFhVTdI
 I6ZTxfdRkWGlMQ2Zg0g==
X-Proofpoint-ORIG-GUID: 7x5Vp2YK51Aaxhn88BYGt-ua7H-axAE_
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a958688 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=IudQombhriBO-dYWWWwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 7x5Vp2YK51Aaxhn88BYGt-ua7H-axAE_
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDExNyBTYWx0ZWRfX2cH5yetDehR3
 8eA44HsrQrZH5ey7kl6F7Hdhi0lMVMs206Jf/JgW7kt1FQ4VA68WmRS8ITz2m4WCWEbS7qchmn9
 8tUePJDOwHdww1qVuxshjlbnNSFBIzA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310117

On Mon, Aug 31, 2026 at 11:45:57AM +0200, Thomas Richter wrote:
> On 8/27/26 08:57, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [High] Unprotected modification of core perf_event state (pending_kill, event_limit) causes data races, dropped signals, and silently breaks the PERF_EVENT_IOC_REFRESH API.
...
> >> diff --git a/arch/s390/kernel/perf_pai.c b/arch/s390/kernel/perf_pai.c
> >> index cdb8006220ca0..e43b2f1c94471 100644
> >> --- a/arch/s390/kernel/perf_pai.c
> >> +++ b/arch/s390/kernel/perf_pai.c
> >> @@ -658,6 +658,8 @@ static void pai_have_sample(struct perf_event *event, struct pai_map *cpump)
> >>  
> >>  	if (!event)		/* No event active */
> >>  		return;
> >> +	event->pending_kill = 0;	/* prevent ioctl(IOC_REFRESH) */
> >> +	atomic_set(&event->event_limit, 0);
> > 
> > [Severity: High]
> > Does this unprotected modification of core perf_event state (pending_kill,
> > event_limit) cause data races, dropped signals, and silently break the
> > PERF_EVENT_IOC_REFRESH API?
> > 
> > Bypassing core perf locking rules to directly mutate event_limit and
> > pending_kill causes data races, silently drops pending SIGIO signals, and
> > breaks the API contract. The ioctl will return success, but userspace will
> > never receive the requested signal, leading to application hangs.
> 
> A: The PERF_EVENT_IOC_REFRESH API is disabled on purpose. The PAI PMU
>    relies on data collection on schedule out of a task. This is
>    done by design. Invoking ioctl(fd, PERF_EVENT_IOC_REFRESH API, X)
>    breaks this behavior and should be blocked.
> 
>    The modifications of members perf_event::event_limit and
>    perf_event::pending_kill are protected. The invocation
>    is triggered by the schedule out path and protected via
>    perf_pmu_sched_task()
>    +--> __perf_pmu_sched_task()
>         +--> perf_ctx_lock()
> 
>    This locks the event and protects the states of the event.
> 
> > 
> > If a userspace application calls ioctl(fd, PERF_EVENT_IOC_REFRESH, N) on a
> > PAI event, and concurrently, a context switch calls pai_have_sample(),
> > writing to event_limit will race with atomic_add() in the core subsystem,
> > and clearing pending_kill will race with perf_event_wakeup().
> 
> This requires a common code change to block an ioctl(fd, PERF_EVENT_IOC_REFRESH, N)
> similar to the PMU check_period call back function.

The above looks like a layering violation to me. Please resend with common
code maintainers on cc, so they can yell if this is not acceptable.
