Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3873B351C31;
	Thu, 13 Aug 2026 09:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786612167; cv=none; b=INZspmWe2ckYLRe/ipszWJ1Qbjlk3Xr6TQIdcSpCq3hgUcdgqIkSKweOQjcgyDYX3q+Oiu1sGooTR5ZZ7CiGLig3IO9UjDTx6zw76RqopkeQHxneJBdDCkrvNp1n3wxw89hTE1aGgy41u6pim6vPlE+0vRQvOlDrohChdAAMzZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786612167; c=relaxed/simple;
	bh=ILnQH/Pn24RjwKX3+uR+kRobOzEyfQEGmwkhXvMmdYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ApK8rVntWFLiaIERpKFlle26PoKTA59EdJiQVxV61zg6SeTJk1E/6Txmg+hTcYGOKKHUueUeIX1XmtX5somoercmwGXMPCILKlQ6AJWuGT5CnTT8o5gq+SyyD4RQmnxWxaMsTQABRuD/qL4l6q/+f5h5Eha46Az+TUS+txwXhCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qrfJWhnR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qrfJWhnR"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D995rN043083;
	Thu, 13 Aug 2026 09:09:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1yi/2L
	BRpP5z3cvk1Tz5ogDldtHkxaGs8QR09hHKk7U=; b=qrfJWhnRNoGYAUUuzpR4hP
	Wt0qYsAgc7t0KNNUcNOIUx/NuzwKUgvVG/BhAnOrK51vwS/U1FsY1i292+U6WtKV
	Lh6KDBt3DfKZE5KioFEvX2RGr2SQ6mA2VXi94Fa7QzDTyn7CEryLD2aumrzHdfiV
	1Ul1E18Xo3LY4o1JWuGVHaoUkGwBDz0AJSY+gm3QMBX/ZH5cETuYMuSWJuBUOqxh
	nv8J0ecpd9B3tyQ71PMm5CjJrxNF5r/3wxIe+GhRAp4rS4gudYOpYhy4E0YHIglk
	46Whpwq6J3VRsvHKPGwBJkgmaw3W1oTSRyl8In+5qZQnMvtOWB/67Mk4SEmZ+aFQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvk0746n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 09:09:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67D8uIjH030573;
	Thu, 13 Aug 2026 09:09:24 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesqagcn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 09:09:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67D99K2s44040594
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 09:09:20 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9479320043;
	Thu, 13 Aug 2026 09:09:20 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6EE8B20040;
	Thu, 13 Aug 2026 09:09:20 +0000 (GMT)
Received: from [9.224.77.157] (unknown [9.224.77.157])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Aug 2026 09:09:20 +0000 (GMT)
Message-ID: <c6d645af-0fe0-43dc-94cc-a9f5421c783e@linux.ibm.com>
Date: Thu, 13 Aug 2026 11:09:20 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/pai: Handle multiple PMU stop callback invocations
To: sashiko-reviews@lists.linux.dev
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.vom>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20260813070815.2692398-1-tmricht@linux.ibm.com>
 <20260813072156.9C4311F000E9@smtp.kernel.org>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20260813072156.9C4311F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA2MiBTYWx0ZWRfXxjLaO8mJARI0
 fjqLN1fA16/NWdzIAEKuTpzeqS9nF5854l8fWTliXHqlW8ifWYfKvKTpK0hafdIrXD9H3c5uEnG
 M7mIvgrZVjci1JnoyNTjOOwI1FAGKxgmE/6EeLhxsxhggGFAmBqWyPRMj/yfIa7CBlpIdY6plgN
 0zwFwYiT3WhV/ayK8pTzioiz+Q8h2gFEuQ+GeV4CAzCSH5dLnJOrvRhMXknV6pRbL8BzP2Luwmq
 iTjsiDfw5o8FYH8FSBC76IwNFjc1qW096BNwGryOBxR7fTGSrXOzN7hq71FYUeNOW3jOw9k+44w
 Ps6B0v+F69kqpssVUGY+E8a5tZpIBNjCH5UmKNqd+7Gwt3FeLyNOj+3AcysyeweeVibSx0n4Us9
 NJzHwCrStuFsuX2z0JT3inpeXkan3XmdahsF7Z9STSo4k8tNXuffpWAXiw5plvnA9bs2hWBYkA8
 6OdM6calDjDzFVGtavQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA2MiBTYWx0ZWRfXydxyvGlA4HUB
 QD8eb6Bj1i8PxcKGuQZ+G/DWWWQLaRI5nm0w0EDQoq69DI8pFzYkBLWxJYqXSabndryn4q33DWW
 HYfTqGq8ut75n+yLpGV96nOfrq8si9k=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7d89c5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=DIdfOIAipRHJpifU0fUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: eXRUChIEkLjRgHtdCyMbHonQpBgjxJLp
X-Proofpoint-ORIG-GUID: eXRUChIEkLjRgHtdCyMbHonQpBgjxJLp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1011 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130062

On 8/13/26 09:21, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Unsafe iteration over `cpump->syswide_list` in `pai_have_samples()` leads to a kernel crash (LIST_POISON dereference) if an event overflows and is synchronously throttled during the loop.

This can not happen. The syswide_list is anchored by per-CPU pai_map::syswide_list and tracks
all events which are bound to that particular CPU. The event was installed only on that particular
CPU and does not move with the process/task. Each CPU has its own list anchored by
pai_map::syswide_list.

The call chains are either

 paicrypt_sched_task() or paiext_sched_task
 +--> pai_have_samples() iterates over syswide_list and calls
      +--> pai_have_sample
      
or    
 pai_stop()
 +--> list_del() to remove the event from that CPU.

 Since a CPU can only execute one given code path at any one time:
 - either schedule out
 - or stop the event
 both can not happen at the same time. PAI PMU does not install an interrupt handler,
 there is no supoprt for interrupts.

 I think this is safe.


> --
> 
> --- Patch [1]: [PATCH] s390/pai: Handle multiple PMU stop callback invocations ---
> commit 8c88016c23029bda1d214155e79ad2671b8e3eb5
> Author: Thomas Richter <tmricht@linux.ibm.com>
> 
> s390/pai: Handle multiple PMU stop callback invocations
> 
> The kernel protects itself against high sampling load by throttling it via
> perf_event_throttle(), calling PMU->stop(). Shortly after, the task may be
> scheduled out, resulting in a second PMU->stop() invocation. This patch adds
> a check for the PERF_HES_STOPPED bit to prevent duplicate handling.
> 
> Cc: stable@vger.kernel.org # v6.19+
> Fixes: ac03223f0723 ("s390/pai_crypto: Add common pai_stop() function")
> 
>> diff --git a/arch/s390/kernel/perf_pai.c b/arch/s390/kernel/perf_pai.c
>> index cdb8006220ca0..a377f04296563 100644
>> --- a/arch/s390/kernel/perf_pai.c
>> +++ b/arch/s390/kernel/perf_pai.c
> 
> [ ... ]
> 
>> @@ -510,6 +511,13 @@ static void pai_stop(struct perf_event *event, int flags)
>>  	struct pai_mapptr *mp = this_cpu_ptr(pai_root[idx].mapptr);
>>  	struct pai_map *cpump = mp->mapptr;
>>  
>> +	/* Cope with multiple invocations:
>> +	 *   1. perf_event_throttle() --> PMU->stop()
>> +	 *   2. task schedules out --> PMU->stop()
>> +	 * Check for event already stopped.
>> +	 */
>> +	if (event->hw.state & PERF_HES_STOPPED)
>> +		return;
> 
> [Severity: High]
> This is a pre-existing issue, but can this synchronous throttle event
> corrupt the list iteration during sample processing?
> 
> Looking at the iteration in pai_have_samples():
> 
> arch/s390/kernel/perf_pai.c:pai_have_samples() {
>     ...
>     list_for_each_entry(event, &cpump->syswide_list, hw.tp_list)
>         pai_have_sample(event, cpump);
>     ...
> }
> 
> If an event reaches its sample limit, perf_event_overflow() triggers
> synchronously, invoking perf_event_throttle() which then calls pai_stop().
> 
> When pai_stop() is called for a system-wide sampling event, it executes:
> 
>     list_del(PAI_SWLIST(event));
> 
> Will deleting the event currently being iterated leave the list pointer
> at a poison value, causing a panic when the loop in pai_have_samples()
> continues? Does pai_have_samples() need to use list_for_each_entry_safe()
> instead?
> 
>>  	if (!event->attr.sample_period) {	/* Counting */
>>  		pai_pmu[idx].pmu->read(event);
>>  	} else {				/* Sampling */
> 


-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
