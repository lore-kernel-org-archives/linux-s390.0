Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946CE1ADC7E;
	Wed, 29 Apr 2026 17:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777484717; cv=none; b=mXzBPn/wupUyQeB8hEw3UHKhXFoM5jcbQ4qbwMbYOvbWyCOI7x675NCWMzm1gFBk7WVcxTIgIHohMhfQ+ii5LwNUpouY2pyCv1bLdtrt0QxohHqsxVCb59plC7gxKHIafmLMY/9P0W76/meWr+lCYdsmFB+p2+TNGTtKIJ+fbTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777484717; c=relaxed/simple;
	bh=TEKhSER6KtUGlV/tH6247cVEvQPRMn4TOwXweMRamPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CzcJOA+CzpOkJYlu2cb0l/B881XTQjlxszz3UxvivxJGfA/ruSatDRSOzVmxlQnqixCTGLXv16pVIHVlrVkvZ+CDKQuoKmHJoJobYRKMKyWpAJeQZTdEu/eODebISUlq3JJLIwU2n1eaKJ4Rb0c1f8+4bgoxNsieHR+F+buvlfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bSoIfItz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bSoIfItz"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TGp4AN2167211;
	Wed, 29 Apr 2026 17:45:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UIUDUR
	2kjBBi4SYRliVGx9oJ0aIlGOUBjIlA+sJlGGA=; b=bSoIfItzBN16hZ0rwbW3kJ
	4YyLc1HsPcznyHcvo+g005e6D44lkCC5xYxWqi8z8W/68LpBCyPhjKGShrJPAHrc
	giW3/XEzqRfGenHCWTiD0PcpQOE4IDvCmvkJg+vZO769KV3mCmG2QKk8LGC6Rdnv
	O5AUO99EGHIDFFVI3HP348INDecPpSY4sTk5yU8JNsjsICTwXuwwvNPWW2iGYp6N
	lVkFdG8jHTiB1eUQwnETEoVrYH+fKenY/ssZaGLQGQxj0bE2PaQrOYhr5PL1/3+G
	V1JWHPFURLi8/11K078DYSZLPnCkyImpoZUlZT/8R+xUe+59+K6DokH52cSdDBLg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drm1e2d5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 17:45:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63THcoVv032398;
	Wed, 29 Apr 2026 17:45:07 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8avyfkb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 17:45:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63THj3K830867862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Apr 2026 17:45:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B45D20043;
	Wed, 29 Apr 2026 17:45:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18E4E20040;
	Wed, 29 Apr 2026 17:44:58 +0000 (GMT)
Received: from [9.124.221.220] (unknown [9.124.221.220])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Apr 2026 17:44:57 +0000 (GMT)
Message-ID: <3f6d1123-6e1a-4566-8be7-ce95efe0609c@linux.ibm.com>
Date: Wed, 29 Apr 2026 23:14:56 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG: workqueue lockup - SRCU schedules work on not-online CPUs
 during size transition
To: paulmck@kernel.org, Tejun Heo <tj@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc: Srikar Dronamraju <srikar@linux.ibm.com>, Boqun Feng <boqun@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
        Joel Fernandes <joelagnelf@nvidia.com>,
        Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>, samir@linux.ibm.com
References: <ttd89ul@ub.hpns> <adfhWQr1yFImSM2Q@tardis.local>
 <adfkdRCxmhpRverB@tardis.local> <adfmHZfABu64Kv4D@slm.duckdns.org>
 <adfrfJGrglg0bGw_@tardis.local> <adlHKowvhn8AGXCc@slm.duckdns.org>
 <afIdFgDD9w2U6hZy@linux.ibm.com> <tte9m9z@ub.hpns>
 <3b1563df-b1aa-40b9-b83e-650d967df09c@paulmck-laptop>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <3b1563df-b1aa-40b9-b83e-650d967df09c@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: MxCfL4x0lzFXnZIHsxPy4KSK7r5lhc8F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE3NCBTYWx0ZWRfX0GeJyB3RvH33
 pvhtiPYwFlpjR7mg5JEqb3DIJuOB4x1bBDbiQq/xSm9Es46EZDMu9LMiKjMkgurh324iArbu698
 C+aC9B993bpWg3T3VoErDmu254aQomoyQds1vxNto81Vn/vf03owUA2gNdQWVE/QZhUejs/iJST
 Fu/fEa3IKh2M4Q0XKlr0SlUhwvqlG+AFAOcYT8A7jg+Nn/GaG/xjt8Xg6CkVgrsEiKxPghizPrn
 bxXx5cGy+FLBwAfPYCc4YYucITM1WQbLXYE6Pljv1fURQKACi6jCCzz6ZMz7DqFwO7CxRObsX7f
 Dn8q5syAFcXk2tJdAKXpIJc/6X2qJ2YR1C7y77/YJjM5B9DNsmpLf+/WKYPBNNAGn6PEb5icEqu
 uFxCNi7Y8BuSIKKsc6RwRa01in5vAM/WD2wWskPNeRjdPlrbXved6BTb64ab0yZiKVAdEKvZ44P
 i0zBxqGXlYgY/bZtb4g==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=69f243a4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=1HvI2w3n6jE6L6oVU9sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: UUJaTNG6TEa-nyr9LnKeyIKzPdJhzj7o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290174


I have limited understanding in rcu or workqueues, but my two cents.

On 4/29/26 10:48 PM, Paul E. McKenney wrote:
> On Wed, Apr 29, 2026 at 07:08:23PM +0200, Vasily Gorbik wrote:
>> On Wed, Apr 29, 2026 at 08:30:38PM +0530, Srikar Dronamraju wrote:
>>> * Tejun Heo <tj@kernel.org> [2026-04-10 08:53:30]:
>>>> Hello,
>>>>
>>>>> Seems that we (mostly Paul) have our own trick to track whether a CPU
>>>>> has ever been onlined in RCU, see rcu_cpu_beenfullyonline(). Paul also
>>>>> used it in his fix [1]. And I think it won't be that hard to copy it
>>>>> into workqueue and let queue_work_on() use it so that if the user queues
>>>>> a work on a never-onlined CPU, it can detect it (with a warning?) and do
>>>>> something?
>>>>
>>>> The easiest way to do this is just creating the initial workers for all
>>>> possible pools. Please see below. However, the downside is that it's going
>>>> to create all workers for all possible cpus. This isn't a problem for
>>>> anybody else but these IBM mainframes often come up with a lot of possible
>>>> but not-yet-or-ever-online CPUs for capacity management, so the cost may not
>>>> be negligible on some configurations.
>>>>
>>>> IBM folks, is that okay?
>>>
>>> Even on PowerPC LPARS, its not uncommon to have possible cpus != online cpus
>>> at boot.  However your approach will work.
>>>
>>> And Samir has already tested the same too and reported here
>>> https://lkml.kernel.org/r/1b89c25b-7c1d-4ed8-adf3-ac504b6f086a@linux.ibm.com
>>>
>>>> From: Tejun Heo <tj@kernel.org>
>>>> Subject: workqueue: Create workers for all possible CPUs on init
>>>>
>>>> Per-CPU worker pools are initialized for every possible CPU during early boot,
>>>> but workqueue_init() only creates initial workers for online CPUs. On systems
>>>> where possible CPUs outnumber online CPUs (e.g. s390 LPARs with 76 online and
>>>> 400 possible CPUs), the pools for never-onlined CPUs have POOL_DISASSOCIATED
>>>> set but no workers. Any work item queued on such a CPU hangs indefinitely.
>>>>
>>>> This was exposed by 61bbcfb50514 ("srcu: Push srcu_node allocation to GP when
>>>> non-preemptible") which made SRCU schedule callbacks on all possible CPUs
>>>> during size transitions, triggering workqueue lockup warnings for all
>>>> never-onlined CPUs.
>>>>
>>>> Create workers for all possible CPUs during init, not just online ones. For
>>>> online CPUs, the behavior is unchanged - POOL_DISASSOCIATED is cleared and the
>>>> worker is bound to the CPU. For not-yet-online CPUs, POOL_DISASSOCIATED
>>>> remains set, so worker_attach_to_pool() marks the worker UNBOUND and it can
>>>> execute on any CPU. When the CPU later comes online, rebind_workers() handles
>>>> the transition to associated operation as usual.
>>>>
>>>
>>> With these patch, if a CPU has been onlined once, it's should be ok to queue
>>> the work on that CPU even if its offline now.
>>
>> That already seems to hold without this patch, what this patch newly
>> covers is queueing on CPUs that have never been online.
>>
>> Do we actually need to create workers for every possible CPU at boot?
>> On the s390 LPAR in question (76 online / 400 possible) that's a few
>> hundred extra kthreads kept around for the life of the system.
>> That's probably the same on PowerPC.
>>
>> Wouldn't Paul's SRCU-side fix [1] alone be enough here for PowerPC
>> as well? I retested it on s390 (76/400) and on x86 KVM with
>> --smp 16,maxcpus=255 and the lockup didn't reproduce in either case.
>>
>> [1] https://lore.kernel.org/rcu/ed1fa6cd-7343-4ca3-8b9d-d699ca496f83@paulmck-laptop/
> 
> Just to emphasize that SRCU really was buggy before my fix.  The
> queue_work_on() kernel-doc header clearly states the rules.  The bug
> is even more embarrassing given just who it was that wrote those two
> sentences.  ;-)
> 

That mask = ~0 is really looks uncomfortable to me. What does it mean?
It might end up even sending to non possible CPUs without proper checks.

It should use either cpumask_setall? or use cpu_online_mask?

Your current patch rcu_cpu_beenfullyonline indicates that code around
srcu_schedule_cbs_sdp handles hotplug already right?
in that case, just setting mask = cpu_online_mask would work?


> 							Thanx, Paul
> 
> /**
>   * queue_work_on - queue work on specific cpu
>   * @cpu: CPU number to execute work on
>   * @wq: workqueue to use
>   * @work: work to queue
>   *
>   * We queue the work to a specific CPU, the caller must ensure it
>   * can't go away.  Callers that fail to ensure that the specified
>   * CPU cannot go away will execute on a randomly chosen CPU.
>   * But note well that callers specifying a CPU that never has been
>   * online will get a splat.
>   *
>   * Return: %false if @work was already on a queue, %true otherwise.
>   */


In that case, making offline CPUs have a unbound workqueue is wrong. no?

It might encourage more users to abuse queue_work_on interface to
send to offline CPUs without any checks and onus now falls onto
workqueue to disaptch to unbound wqs.

So I think it is better to put the guardrails in SRCU instead of any change in
workqueue.
