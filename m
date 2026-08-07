Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D7E3E558C;
	Fri,  7 Aug 2026 11:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786103231; cv=none; b=RKFPJ0WD0OOLxKVUsFPwhuM81nRvDMN4bSMyeRM3bZ3skBuHhJAmP0d00MhKIH+rwSFolC1BUz34VfHpzhB6N4F/tacMKShdou14GNd0jlamg+ELc6Rkt34xvxBD7L+u9OeepuDOMr/ihARS5uVACjprtaGm4WtkPiiB9c16G4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786103231; c=relaxed/simple;
	bh=5FY3FdiY8uUkFfbG5JPb+FAhb0onqh2yrBlsWEd+3L0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TsCLUU7SF+AYUyw7mUyApJPov9RDUgH93Yc2lLfYJmLeRSC4j92cWzTIu1KFXEx8eCGBEpWvBzGMJaQyJ2NKN6ndh7GPTqobd+PgSqiCunTUurIYdQiRZmdXNnUHHvjQI/jPyOsg4q28vnoUyA3TWwiFqpn7RreXc359KHNeCYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JZ8eDHWj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JZ8eDHWj"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770Hiem4133803;
	Fri, 7 Aug 2026 11:46:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nX5kIl
	5fPgXKqkWo0BBtEMROCrNyOFYk/hZcgBJvYpI=; b=JZ8eDHWjNzUxJ50zzuS3ya
	9fsBjcM3wMUO2rX9pw9UW1C1Wook0XKUyprMhs++ia/vJEuAjj9s1CoJWsu3njon
	8iRTamliB8WCs7tWR3+BqzQZB2q1COdZHqC51xHcBmFHQdGOAthjp4KW/qedBjW/
	nrEJqIlOV+nel0FSPrV8d1E4q7pSMYKTCvMHiMJm+oSfakOfxOJc3alYJIU9GPF9
	8FkYlu+w+pAtSDmmGLPfMAE5iBI1iOSUwME1LIijZwmkchnpWqNPR2wWG6G2rgze
	vLCN2Km8Ko5LlXFQbqjRlLM33RUI5UnQb5aDsmwjg4WHoUS6k7B1b+1HAuoXBJKQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy043p1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 11:46:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677BfOca005956;
	Fri, 7 Aug 2026 11:46:49 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgqahp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 11:46:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677BkjPi37683522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 11:46:45 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F6382004B;
	Fri,  7 Aug 2026 11:46:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0460020043;
	Fri,  7 Aug 2026 11:46:45 +0000 (GMT)
Received: from [9.111.38.160] (unknown [9.111.38.160])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 11:46:44 +0000 (GMT)
Message-ID: <3c6b0cc3-18db-404b-9419-fdc1d3249bd5@linux.ibm.com>
Date: Fri, 7 Aug 2026 13:46:44 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/cpum_cf: Handle CPU hotplug add and delete
To: sashiko-reviews@lists.linux.dev
Cc: Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
References: <20260806131131.2073914-1-tmricht@linux.ibm.com>
 <20260806132951.11CE41F000E9@smtp.kernel.org>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20260806132951.11CE41F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA4NyBTYWx0ZWRfXyNRMwNC/eTL0
 7O/Q4h03Ocu2M91hx7fHYtqTeccAEccMllRWLRI6xtJDmqu7ThHyspI6Gc2fanLdmD+m9U2LjCW
 9K2ddxLEQLCsp+PqVQUBlzbaUrf4c0O27f1HEGCb7B6k8ySkMRYjdptB8z+GlizFbIBdAW1+Yll
 86Aq4qx2xR9X6+ajPuHifwezZrnSfdnjs84qgOY4rBdyGcdGks7GR3aQ7pd0AHeJNinkiWqVNJM
 kGqgVT4Ni+V7DN+LZdCnrw9wpJAg7REp5LskOMymyLN3oT6g+cqlnKyFC4F4FnGNYyzaJgHw59y
 i/+SvbE47XEkdUMGdfMNMTw9DKn3+jcHbHmnqD6p362pm35zJ4QOJ/3Eh8jSuWeRW6jj2Xv+AV0
 w4AipKkjcZd1ddcFbmIfopl02f7xFp7Lmo3qNMKQj62PJRYM/qtEcV60gKstwQoF+AfWX7HDmS3
 +iWalfQHr9FRRRcSjnQ==
X-Proofpoint-ORIG-GUID: OGBmHOebqKNQgP4FcZauEpQyaw4N_E1O
X-Proofpoint-GUID: OGBmHOebqKNQgP4FcZauEpQyaw4N_E1O
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA4NyBTYWx0ZWRfX+kju+0BMG90E
 8IamrxiSy0dYLQ5jT6v9X+UzxU0YzH7FTsEpgsWkFBZw4ndN9KOj2ID3vpXSyQaArWNXdOCm2lD
 lleIadDzQtN1IXkOppVaTGam2VMFx1Y=
X-Authority-Analysis: v=2.4 cv=WLpPmHsR c=1 sm=1 tr=0 ts=6a75c5aa cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=35vN5rJ4Y1sxIBqEldUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1011
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070087

On 8/6/26 15:29, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> 
> New issues:
> - [High] Unbounded reference count leak and memory leak on CPU hotplug for task events.
> - [High] Per-CPU events are permanently broken and suffer data loss when a CPU is offlined.
> - [High] Reference count overwrite on CPU online leads to Use-After-Free for per-CPU and hardware counter events.
> 
> Pre-existing issues:
> - [High] Data race in `cpum_cf_free_cpu` leads to Use-After-Free if interrupted by hardware counter alert.
> --
> 
> --- Patch [1]: [PATCH] s390/cpum_cf: Handle CPU hotplug add and delete ---
> commit 29becd857d549bdc0388325fd158df7d2f158812
> Author: Thomas Richter <tmricht@linux.ibm.com>
> 
> s390/cpum_cf: Handle CPU hotplug add and delete
>     
> The command 'perf stat -e cycles -- <command>' crashes the kernel when CPUs
> are hotplug added during that run. This commit tracks task-context users to
> ensure per-CPU structures are allocated when a new CPU is brought online.
> 
> Cc: <stable@vger.kernel.org> # v6.5+
> 
>> diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
>> index 2076ac22e2c49..9e8c3d2e71d57 100644
>> --- a/arch/s390/kernel/perf_cpum_cf.c
>> +++ b/arch/s390/kernel/perf_cpum_cf.c
> 
> [ ... ]
> 
>> @@ -206,20 +207,19 @@ static int cpum_cf_alloc_root(void)
>>  	return rc;
>>  }
>>  
>> -/* Free CPU counter data structure for a PMU */
>> +/* Free CPU counter data structure for a PMU. Called under mutex lock */
>>  static void cpum_cf_free_cpu(int cpu)
>>  {
>>  	struct cpu_cf_events *cpuhw;
>>  	struct cpu_cf_ptr *p;
>>  
>> -	mutex_lock(&pmc_reserve_mutex);
>>  	/*
>>  	 * When invoked via CPU hotplug handler, there might be no events
>>  	 * installed or that particular CPU might not have an
>>  	 * event installed. This anchor pointer can be NULL!
>>  	 */
>>  	if (!cpu_cf_root.cfptr)
>> -		goto out;
>> +		return;
>>  	p = per_cpu_ptr(cpu_cf_root.cfptr, cpu);
>>  	cpuhw = p->cpucf;
>>  	/*
>> @@ -227,15 +227,13 @@ static void cpum_cf_free_cpu(int cpu)
>>  	 * installed on that CPU, but on different CPUs.
>>  	 */
>>  	if (!cpuhw)
>> -		goto out;
>> +		return;
>>  
>>  	if (refcount_dec_and_test(&cpuhw->refcnt)) {
>>  		kfree(cpuhw);
>>  		p->cpucf = NULL;
> 
> [Severity: High]
> This is a pre-existing issue, but is it possible for an interrupt to
> dereference this pointer after it is freed?
> 
> Since cpum_cf_free_cpu() executes with interrupts enabled, if a CPUMF
> measurement alert interrupt triggers right after kfree(cpuhw) but before
> p->cpucf is set to NULL:
> 
> cpum_cf_free_cpu()
>   kfree(cpuhw);
>   
>   --- interrupt occurs ---
>   cpumf_measurement_alert()
>     this_cpu_cfhw() -> returns p->cpucf
>     ... accesses freed memory ...
> 
> Would it be safer to clear the pointer before calling kfree?

The interrupt handler is shared an protects against a NULL ptr:
        /*                                                                    
         * Measurement alerts are shared and might happen when the PMU        
         * is not reserved.  Ignore these alerts in this case.                
         */                                                                   
        cpuhw = this_cpu_cfhw();                                              
        if (!cpuhw)                                                           
                return;
> 
>>  	}
>>  	cpum_cf_free_root();
>> -out:
>> -	mutex_unlock(&pmc_reserve_mutex);
>>  }
> 
> [ ... ]
> 
>> @@ -290,9 +286,12 @@ static int cpum_cf_alloc(int cpu)
>>  	cpumask_var_t mask;
>>  	int rc;
>>  
>> +	mutex_lock(&pmc_reserve_mutex);
>>  	if (cpu == -1) {
>> -		if (!zalloc_cpumask_var(&mask, GFP_KERNEL))
>> -			return -ENOMEM;
>> +		if (!zalloc_cpumask_var(&mask, GFP_KERNEL)) {
>> +			rc = -ENOMEM;
>> +			goto out;
>> +		}
>>  		for_each_online_cpu(cpu) {
>>  			rc = cpum_cf_alloc_cpu(cpu);
>>  			if (rc) {
>> @@ -303,20 +302,27 @@ static int cpum_cf_alloc(int cpu)
>>  			cpumask_set_cpu(cpu, mask);
>>  		}
>>  		free_cpumask_var(mask);
>> +		if (!rc)
>> +			atomic_inc(&cpu_cf_root.tskcnt);
>>  	} else {
>>  		rc = cpum_cf_alloc_cpu(cpu);
>>  	}
>> +out:
>> +	mutex_unlock(&pmc_reserve_mutex);
>>  	return rc;
>>  }
>>  
>>  static void cpum_cf_free(int cpu)
>>  {
>> +	mutex_lock(&pmc_reserve_mutex);
>>  	if (cpu == -1) {
>>  		for_each_online_cpu(cpu)
>>  			cpum_cf_free_cpu(cpu);
>> +		atomic_dec(&cpu_cf_root.tskcnt);
> 
> [Severity: High]
> Does this loop potentially leak the per-CPU data structure if a CPU is
> offline?
> 
> If task events are closed while a CPU is offline, iterating only over
> for_each_online_cpu(cpu) skips that offline CPU.
> 
> Will this permanently leave the cpuhw structure and root references orphaned
> for that CPU?

If the CPU is offline, the removal of that per-CPU variable is handled by the
CPU hotplug remove path.

> 
>>  	} else {
>>  		cpum_cf_free_cpu(cpu);
>>  	}
>> +	mutex_unlock(&pmc_reserve_mutex);
>>  }
> 
> [ ... ]
> 
>> @@ -992,6 +1003,12 @@ static void cpumf_pmu_stop(struct perf_event *event, int flags)
>>  	struct hw_perf_event *hwc = &event->hw;
>>  	int i;
>>  
>> +	/* Might be zero when a per-task context event is active. Happens
>> +	 * when CPUs are made offline and process migration takes place.
>> +	 */
>> +	if (!cpuhw)
>> +		return;
>> +
> 
> [Severity: High]
> Could this early return cause us to lose accumulated performance counter data?
> 
> Since CPU hotplug teardown in s390 executes CPUHP_AP_PERF_S390_CF_ONLINE
> (state 209) before the generic perf core's CPUHP_AP_PERF_ONLINE (state 204),
> the per-CPU data structure has already been freed by cpum_cf_offline_cpu().
> 
> When the perf core eventually calls cpumf_pmu_stop() to stop the event, this
> check evaluates to true, aborting the function without updating the hardware
> counter state.
> 

True, this can cause some counter to miss the last read.
Should be addressed in a follow-on patch.

>>  	if (!(hwc->state & PERF_HES_STOPPED)) {
>>  		/* Decrement reference count for this counter set and if this
>>  		 * is the last used counter in the set, clear activation
> 
> [ ... ]
> 
>> @@ -1090,28 +1117,62 @@ static refcount_t cfset_opencnt = REFCOUNT_INIT(0);	/* Access count */
>>  static DEFINE_MUTEX(cfset_ctrset_mutex);
>>  
>>  /*
>> - * CPU hotplug handles only /dev/hwctr device.
>> - * For perf_event_open() the CPU hotplug handling is done on kernel common
>> - * code:
>> - * - CPU add: Nothing is done since a file descriptor can not be created
>> - *   and returned to the user.
>> - * - CPU delete: Handled by common code via pmu_disable(), pmu_stop() and
>> - *   pmu_delete(). The event itself is removed when the file descriptor is
>> - *   closed.
>> + * CPU hotplug handles /dev/hwctr device.
>> + *
>> + * For perf_event_open() the CPU hotplug handler needs to check the number
>> + * of per-task context events currently active. A per-task context event
>> + * needs per-CPU data structures. The scheduler might schedule the task on
>> + * the new CPU and then the CPUMF per-CPU infrastructure must be available.
>> + * Common code relies on that and calls cpumf_pmu_add(), cpumf_pmu_start(),
>> + * cpumf_pmu_stop() and cpumf_pmu_del() to install PMU backend functions on
>> + * the new CPU.
>> + *
>> + * If no per-task context event has been installed, the events are per-CPU
>> + * and do not care about a new CPU.
>>   */
>>  static int cfset_online_cpu(unsigned int cpu);
>>  
>>  static int cpum_cf_online_cpu(unsigned int cpu)
>>  {
>> -	int rc = 0;
>> +	int i, rc = 0;
>>  
>> -	/*
>> -	 * Ignore notification for perf_event_open().
>> -	 * Handle only /dev/hwctr device sessions.
>> -	 */
>>  	mutex_lock(&cfset_ctrset_mutex);
>> -	if (refcount_read(&cfset_opencnt)) {
>> +	/* Allocate per-CPU infrastructure when per-task context active. */
>> +	mutex_lock(&pmc_reserve_mutex);
>> +	if (atomic_read(&cpu_cf_root.tskcnt)) {
>>  		rc = cpum_cf_alloc_cpu(cpu);
> 
> [Severity: High]
> Are we failing to reallocate the data structure for CPU-bound events here?
> 
> Since per-CPU events do not increment the task context count (tskcnt), this
> check is bypassed.
> 
> Will subsequent attempts to interact with an existing CPU-bound event
> encounter a NULL pointer on this newly onlined CPU?

per-CPU bound events can not be bound to an offline CPU. New hotplug CPUs
are only used when a per-task event is active. Because the scheduler enables
performance measurement only when the event has per-process context.
When a new event is created with CPU-context, the per-CPU data is allocated
with perf_event_open() for that CPU.

> 
>> +		/* Adjust reference counts:
>> +		 * CPU X is offline
>> +		 *   perf_event_open() task event E1: tskcnt = 1, no cpuhw for CPU X
>> +		 *   perf_event_open() task event E2: tskcnt = 2
>> +		 *   CPU X set online
>> +		 *     cpum_cf_online_cpu()
>> +		 *       cpum_cf_alloc_cpu(X): cpuhw->refcnt = 1
>> +		 * E1 closed
>> +		 *   hw_perf_event_destroy()
>> +		 *     cpum_cf_free(-1)
>> +		 *       cpum_cf_free_cpu(X): refcnt 1 -> 0, kfree(cpuhw)
>> +		 * E2's task runs on CPU X
>> +		 *   cpumf_pmu_add(): this_cpu_cfhw() == NULL, -ENODEV
>> +		 *
>> +		 * If tskcnt > 1, adjust the reference counts to the number
>> +		 * of process-context tasks.
>> +		 */
>> +		if (!rc && atomic_read(&cpu_cf_root.tskcnt) > 1) {
>> +			struct cpu_cf_events *cpuhw;
>> +			struct cpu_cf_ptr *p;
>> +
>> +			p = per_cpu_ptr(cpu_cf_root.cfptr, cpu);
>> +			for (i = 1; i < atomic_read(&cpu_cf_root.tskcnt); ++i)
>> +				cpum_cf_alloc_root();
> 
> [Severity: High]
> Is there a risk of an unbounded reference count leak on the root structure
> here?
> 
> When a CPU goes offline, cpum_cf_offline_cpu() drops a single reference to
> cpuhw and cpu_cf_root.refcnt.
> 
> However, when brought back online with multiple active task events
> (tskcnt > 1), this loop adds tskcnt - 1 new references to
> cpu_cf_root.refcnt, causing it to grow indefinitely on every offline/online
> cycle.

No, when a CPU is hotplug added with multiple per-process tasks active, each
of these tasks will close the event and event deletion on a per-process task
uses for_each_online_cpu(). So when 3 per-process tasks were active at hotplug
add, 3 tasks will close the event and call cpumf_cf_free_cpu() 3 time. Which
is in sync with the reference count.

> 
>> +
>> +			cpuhw = p->cpucf;
>> +			refcount_set(&cpuhw->refcnt,
>> +				     atomic_read(&cpu_cf_root.tskcnt));
> 
> [Severity: High]
> Does forcefully setting the reference count here destroy references held by
> other active subsystems?
> 
> The cpuhw->refcnt field tracks all users on a CPU, including task events,
> per-CPU events, and /dev/hwctr sessions.
> 
> By overwriting it with tskcnt, wouldn't this erase any references held by
> other active sessions, causing a premature free of cpuhw later and leading
> to a Use-After-Free?

No the adjustment is done to match the per-process tasks which close events
with for_each_online_cpu() loops.

> 
>> +		}
>> +	}
>> +	mutex_unlock(&pmc_reserve_mutex);
>> +	if (refcount_read(&cfset_opencnt)) {
>>  		if (!rc)
>>  			cfset_online_cpu(cpu);
>>  	}
>> @@ -1123,20 +1184,11 @@ static int cfset_offline_cpu(unsigned int cpu);
>>  
>>  static int cpum_cf_offline_cpu(unsigned int cpu)
>>  {
>> -	/*
>> -	 * During task exit processing of grouped perf events triggered by CPU
>> -	 * hotplug processing, pmu_disable() is called as part of perf context
>> -	 * removal process. Therefore do not trigger event removal now for
>> -	 * perf_event_open() created events. Perf common code triggers event
>> -	 * destruction when the event file descriptor is closed.
>> -	 *
>> -	 * Handle only /dev/hwctr device sessions.
>> -	 */
>>  	mutex_lock(&cfset_ctrset_mutex);
>> -	if (refcount_read(&cfset_opencnt)) {
>> +	/* Handle /dev/hwctr device sessions */
>> +	if (refcount_read(&cfset_opencnt))
>>  		cfset_offline_cpu(cpu);
>> -		cpum_cf_free_cpu(cpu);
>> -	}
>> +	cpum_cf_free(cpu);
> 
> [Severity: High]
> Does unconditionally freeing the data structure here break active per-CPU
> events?

No the CPU is gone, we remove that CPU's data

> 
> As noted earlier, this function runs before the generic perf core can stop
> the event. Unconditionally dropping the refcount to 0 frees cpuhw while the
> hardware counter is still active.

As discussed above, the call backs protect themselves against NULL pointers.

> 
>>  	mutex_unlock(&cfset_ctrset_mutex);
>>  	return 0;
>>  }
> 


-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
