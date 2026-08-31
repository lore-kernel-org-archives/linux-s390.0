Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4E62EDD58;
	Mon, 31 Aug 2026 09:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788169565; cv=none; b=B2ezkqmSzVhiLzp/g6Vx+G8Ha8VsWJ0Bl2aODtYG2OBmQxsinb4oCLqaJwmoo2WUNCuXbMUFJ/er2EngCI6rx/v1TOenYVdzpZM4/3ZVlfmsKr9h7lB/1aWvZyTLU1snBrIBhgJtpRuw/YYB7I+9mucqug4mxBBLwo2h64gc1yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788169565; c=relaxed/simple;
	bh=as7/h87CJrSKdiExzIP9kWlyW8yUhqofyrfZ/i0b3hg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dg7ub9nu91ZNxbyDxDWlGaXr7Hy5V0e71AtiCE8aQJsxn/h6EMZSOUAo46/sSlLtgjdsTLkJDT1ho+2l1PSNsFEY0A1QIJB8G4noc2G3SurUHx7wbg+jCpgAK5+0xqDt21SkkjsrL2GoT5bKW+pOLVLvHVi81rwt64DD3U0qjF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FcHkSMvU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FcHkSMvU"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V82ckK1698544;
	Mon, 31 Aug 2026 09:46:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DJDlk+
	21iEyGdiob6pnueUqF8yRN/cK/rq6kM/U/zqo=; b=FcHkSMvUDnp0Sd9NdBOad0
	4YAr3eyIA/pCqUKGFQCpwn+tlM7Wp9AnTcehK/+qd1ZteDEziQSkf8RKfA/07023
	DRP0Fbgo53wgf8cbGoMfpWAR3oEzriNpF9xE1u/+iQM2DYbHPDLcYtxF7IvyuVUl
	sghR4O7bXXluPywk+w5ZfJIVhEa5zOI3mnJ5L8p0prE5sdhy0kH9+7FaxDpKHxki
	kIfajPIbmiCxAnLjdypqEzRBRTWDp08rUlj6fyVYMoLw+wHWnTx+DwG0Llvjp2mD
	r32RH9M0DGFQjF569QTg1wnLG/tpv0zZbZJWXNBvbfW8KESr5V4qOSolF/vmyzcw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq2t097y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 09:46:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67V9fp38009855;
	Mon, 31 Aug 2026 09:46:01 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarjw5sr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 09:46:01 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67V9jvqm42598812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 09:45:57 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3F0F2004B;
	Mon, 31 Aug 2026 09:45:57 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FE7F20049;
	Mon, 31 Aug 2026 09:45:57 +0000 (GMT)
Received: from [9.224.77.157] (unknown [9.224.77.157])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 09:45:57 +0000 (GMT)
Message-ID: <d3ad41b1-909d-48a7-af89-2234a9a84627@linux.ibm.com>
Date: Mon, 31 Aug 2026 11:45:57 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/pai: Prevent ioctl(PERF_EVENT_IOC_REFRESH)
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20260827064612.3161950-1-tmricht@linux.ibm.com>
 <20260827065709.D6E561F000E9@smtp.kernel.org>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20260827065709.D6E561F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=bc1bluPB c=1 sm=1 tr=0 ts=6a954d5a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=xFIhE92wB2fsFhFsdGIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA4MiBTYWx0ZWRfX56T71mQYRMJw
 HVNnvKT1WZLDTP7rlg387WaRYrHxqxp3Y7S3oqgGZrnc6rpGJuWhJi0pO2/EyAj7n+lJ9+Gdvtc
 cP/8FLA0+S49mfAlBCaZrKUgYnwFMrI=
X-Proofpoint-ORIG-GUID: -huyQ5QNAlefzXP1CRhnPQ6jtnDMQaQJ
X-Proofpoint-GUID: -huyQ5QNAlefzXP1CRhnPQ6jtnDMQaQJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA4MiBTYWx0ZWRfX13ICUpKvxUCK
 JwZWJflGuFTmMOXKswW8B1I4o/cSzqnYuASUH/MqgAQv/J8hEWJV14Dn6Blp2XCt6RKOXAZbtKe
 lYS4Tv8hhOOT3DFsEAcxTgTI2swCxEhYaGOUmduFCFgc8XZkT+UlNBM1itAXqLlU3wYCJgYxM8r
 Z4H8BAOd+gn5tr1lP/an6jXC0p/rIPA77XEFRkdZi0OmyZc9etBSMHiqyqsWKoXsLoJCKV4bBZk
 ZgjCRGyCC0jOrTZ1cTZsT9jiwvZEOFbrdhaOOakqaHfDVUi9AGq2IpPNWx+SSE8VmCksoP9r9oy
 ukO54h30TChCye93d7A0Y0AK5BHnkPqPFoQYleyfq+FiLnBOG/J8pao26HjKPpnwVLPOWOkUAcj
 mHelNxDU3ig9PZ7sVPqnnwPzPFXu/mFpO2shsoQ0vcvwGNdtTk5iTfSgArwNfnjxbYV2VK9Ol2I
 r4hMZyBwTQgBxssFxIg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310082

On 8/27/26 08:57, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Unprotected modification of core perf_event state (pending_kill, event_limit) causes data races, dropped signals, and silently breaks the PERF_EVENT_IOC_REFRESH API.
> --
> 
> commit ae843d6ca679921720078776be6911f36a1931c1
> Author: Thomas Richter <tmricht@linux.ibm.com>
> 
> s390/pai: Prevent ioctl(PERF_EVENT_IOC_REFRESH)
> 
> This commit prevents ioctl(fd, PERF_EVENT_IOC_REFRESH, XXX) from taking effect
> on PAI PMU events by clearing event->pending_kill and event->event_limit. The
> intention is to prevent counter resets that conflict with the schedule-out
> readouts these PMUs are designed for.
> 
>> diff --git a/arch/s390/kernel/perf_pai.c b/arch/s390/kernel/perf_pai.c
>> index cdb8006220ca0..e43b2f1c94471 100644
>> --- a/arch/s390/kernel/perf_pai.c
>> +++ b/arch/s390/kernel/perf_pai.c
>> @@ -658,6 +658,8 @@ static void pai_have_sample(struct perf_event *event, struct pai_map *cpump)
>>  
>>  	if (!event)		/* No event active */
>>  		return;
>> +	event->pending_kill = 0;	/* prevent ioctl(IOC_REFRESH) */
>> +	atomic_set(&event->event_limit, 0);
> 
> [Severity: High]
> Does this unprotected modification of core perf_event state (pending_kill,
> event_limit) cause data races, dropped signals, and silently break the
> PERF_EVENT_IOC_REFRESH API?
> 
> Bypassing core perf locking rules to directly mutate event_limit and
> pending_kill causes data races, silently drops pending SIGIO signals, and
> breaks the API contract. The ioctl will return success, but userspace will
> never receive the requested signal, leading to application hangs.

A: The PERF_EVENT_IOC_REFRESH API is disabled on purpose. The PAI PMU
   relies on data collection on schedule out of a task. This is
   done by design. Invoking ioctl(fd, PERF_EVENT_IOC_REFRESH API, X)
   breaks this behavior and should be blocked.

   The modifications of members perf_event::event_limit and
   perf_event::pending_kill are protected. The invocation
   is triggered by the schedule out path and protected via
   perf_pmu_sched_task()
   +--> __perf_pmu_sched_task()
        +--> perf_ctx_lock()

   This locks the event and protects the states of the event.

> 
> If a userspace application calls ioctl(fd, PERF_EVENT_IOC_REFRESH, N) on a
> PAI event, and concurrently, a context switch calls pai_have_sample(),
> writing to event_limit will race with atomic_add() in the core subsystem,
> and clearing pending_kill will race with perf_event_wakeup().

This requires a common code change to block an ioctl(fd, PERF_EVENT_IOC_REFRESH, N)
similar to the PMU check_period call back function.

> 
> PMU drivers should not directly mutate these core fields to implicitly break
> an ioctl. This approach creates cross-CPU data races because it lacks the
> synchronization (ctx->mutex for limits, irq_work execution order for signals)
> used by the core subsystem. Any user with access to the PAI PMU can trigger
> this state corruption.
> 
>>  	pp = &pai_pmu[PAI_PMU_IDX(event)];
>>  	rawsize = pai_copy(cpump->save, cpump->area, pp,
>>  			   (unsigned long *)PAI_SAVE_AREA(event),
> 


-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
