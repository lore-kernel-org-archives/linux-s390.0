Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187B732F75B;
	Wed, 29 Apr 2026 18:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486711; cv=none; b=X5BF90R8WWc30oBPd4GKvyFM0wv0ku2XhH3vfyaA1fEX4p5L/8zqMoGAMSaCw0/BaA5QPhhXJfck8/tyohRFmyoL/p7jYTCma7csgeedxzgbOjILbVr7iO9xzUfGN5hs4NwJevOobBKpSdi9se2biN8u9anMdb3muM5ojrwKQCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486711; c=relaxed/simple;
	bh=bXKQyK4hZ8cMUnBgFj3RPgW5/qXxugpqiwecJrl5WQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G6BwAgR97hVqUsk8vSHw3vniwyFFq8HdJ9CaEVRVJAKXZM7DMpHu/hgmf0VditzO5HYOUtQ2Wt0Xqr8KQuFvgveKnKa1tlWhyUFt4dW86bYaQdPi8GPhdB6bzLj9g7o3s/5BqSV8GzlZCPP8AWJTpeIncRw6MdcZct7vOaO8gsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Cr3N2HWD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Cr3N2HWD"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TFKRj71693197;
	Wed, 29 Apr 2026 18:18:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Aq5fOc
	fb5ztvLkD10LQa++2+YV1EfvhtyLwlILR9NiA=; b=Cr3N2HWDWt5yca0i4MpweH
	ihzYm1fs+aa+iMHyYfOZNHRT+DclGI/6HkCZ0h3T/26U6PCi+PS7g8xxo0HilIVe
	B0SsnBnXmgIrwBd6cUm8FyDy24puwkw2qkWGFUkvYhJ8ZOvKnzdmoghd9BhrZS46
	OPlIswgjq/acEPWg637WBZU+LiYM+U0UsfNtpuu7ZrRO+X94NO5XqqmAbExEsWbQ
	ENKd0ylVrgqgABE4SSvVseW+49jaxRTClnr/8B4anpN3QihFSB8is67mbkrBidsb
	plGMNUeNDRZ/ZWq6NGuG2I+dq5GNrW0Cssf5CysLpI5WE8qcuvcpvq5YmQwwnRnw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn44v45m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 18:18:13 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63TI8jp1023111;
	Wed, 29 Apr 2026 18:18:12 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsa5gfcu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 18:18:12 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63TIIAOg53805514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Apr 2026 18:18:10 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4617458061;
	Wed, 29 Apr 2026 18:18:10 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A06558043;
	Wed, 29 Apr 2026 18:18:02 +0000 (GMT)
Received: from [9.84.253.116] (unknown [9.84.253.116])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Apr 2026 18:18:01 +0000 (GMT)
Message-ID: <a4858d09-e63a-4b23-9110-133778df6fff@linux.ibm.com>
Date: Wed, 29 Apr 2026 23:47:59 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG: workqueue lockup - SRCU schedules work on not-online CPUs
 during size transition
To: Tejun Heo <tj@kernel.org>, Boqun Feng <boqun@kernel.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        "Paul E. McKenney"
 <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
        Joel Fernandes <joelagnelf@nvidia.com>,
        Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>
References: <ttd89ul@ub.hpns> <adfhWQr1yFImSM2Q@tardis.local>
 <adfkdRCxmhpRverB@tardis.local> <adfmHZfABu64Kv4D@slm.duckdns.org>
 <adfrfJGrglg0bGw_@tardis.local> <adlHKowvhn8AGXCc@slm.duckdns.org>
Content-Language: en-US
From: Samir M <samir@linux.ibm.com>
In-Reply-To: <adlHKowvhn8AGXCc@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 6fWS8bZebiO5y_-y8HtrKv5UQO9yRDcd
X-Authority-Analysis: v=2.4 cv=Ft81OWrq c=1 sm=1 tr=0 ts=69f24b65 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=MGFYNAFaT_Uyj2g7ncoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 5lz_L1iO-SpYGbWZwWHpP60-uFZfzIzm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE4NCBTYWx0ZWRfXwN722XLcjvsn
 yoh7rhnHjm8KE5KkDiEsg+zpgGN5B/fWbH37PqqMsFOy//M+7CzNNVZpkNUStCle8/1cwx3N2rC
 VV+OrDJ92vKzSbtEYmSzLGZoOuv9TWDV+zaKcBWmb3k8/W4NZ4KZ/bSzWGNykaLCQvQ6aiOd7pE
 NTSN3V2om32WfqgYZTaUOT/yMY4VLUMMa7NUkNaELaX8OO8WOOh38D7U3ZINmg590kkoMgPEzOf
 h5jdNLmIlSY3r0/L/qxNBRF34przKwegCMjQOUvqRwSReHYZZ4FkFzRJzYKPl/wZrk7SqPd4bXb
 78KznETyY9XedUaMRmUWGdzmukUFqEGLZcxty4+8MKfBsyWQjzy5u9jOfTO92aAQiQpwRHviXNl
 8ffS5JpXdzPietOZsZ2sK6qHndGyuxJjAPYUQaDmqc3jUEv24QiptduSvYvKIq9kYEeaJxDU4S+
 /vZQY+we5tfwixx581w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1011 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290184


On 11/04/26 12:23 am, Tejun Heo wrote:
> Hello,
>
> On Thu, Apr 09, 2026 at 11:10:04AM -0700, Boqun Feng wrote:
>> On Thu, Apr 09, 2026 at 07:47:09AM -1000, Tejun Heo wrote:
>>> On Thu, Apr 09, 2026 at 10:40:05AM -0700, Boqun Feng wrote:
>>>> On Thu, Apr 09, 2026 at 10:26:49AM -0700, Boqun Feng wrote:
>>>>> On Thu, Apr 09, 2026 at 03:08:45PM +0200, Vasily Gorbik wrote:
>>>>>> Commit 61bbcfb50514 ("srcu: Push srcu_node allocation to GP when
>>>>>> non-preemptible") defers srcu_node tree allocation when called under
>>>>>> raw spinlock, putting SRCU through ~6 transitional grace periods
>>>>>> (SRCU_SIZE_ALLOC to SRCU_SIZE_BIG). During this transition srcu_gp_end()
>>>>>> uses mask = ~0, which makes srcu_schedule_cbs_snp() call queue_work_on()
>>>>>> for every possible CPU. Since rcu_gp_wq is WQ_PERCPU, work targets
>>>>>> per-CPU pools directly - pools for not-online CPUs have no workers,
>>>>> [Cc workqueue]
>>>>>
>>>>> Hmm.. I thought for offline CPUs the corresponding worker pools become a
>>>>> unbound one hence there are still workers?
>>>>>
>>>> Ah, as Paul replied in another email, the problem was because these CPUs
>>>> had never been onlined, so they don't even have unbound workers?
>>> Hahaha, we do initialize worker pool for every possible CPU but the
>>> transition to unbound operation happens in the hot unplug callback. We
>> ;-) ;-) ;-)
>>
>>> probably need to do some of the hot unplug operation during init if the CPU
>> Seems that we (mostly Paul) have our own trick to track whether a CPU
>> has ever been onlined in RCU, see rcu_cpu_beenfullyonline(). Paul also
>> used it in his fix [1]. And I think it won't be that hard to copy it
>> into workqueue and let queue_work_on() use it so that if the user queues
>> a work on a never-onlined CPU, it can detect it (with a warning?) and do
>> something?
> The easiest way to do this is just creating the initial workers for all
> possible pools. Please see below. However, the downside is that it's going
> to create all workers for all possible cpus. This isn't a problem for
> anybody else but these IBM mainframes often come up with a lot of possible
> but not-yet-or-ever-online CPUs for capacity management, so the cost may not
> be negligible on some configurations.
>
> IBM folks, is that okay?
>
> Also, why do you need to queue work items on an offline CPU? Do they
> actually have to be per-cpu? Can you get away with using an unbound
> workqueue?
>
> Thanks.

Hi Tejun,

Thank you for the patch addressing the workqueue lockup issue.
workqueue lockup issue(PowerPC): 
https://lore.kernel.org/lkml/97a7d011-d573-4754-9e5d-68b562c64089@linux.ibm.com/

Regarding the approach of creating workers for all possible CPUs: On IBM 
PowerPC, we commonly see configurations with a large number of possible 
CPUs for capacity management. For example, systems with 384 possible 
CPUs but only 80 online. This is by design - the additional capacity 
exists for dynamic activation based on licensing and workload requirements.

Creating workers for all 384 possible CPUs upfront would mean allocating 
resources for 304 workers that may never be used. While I understand 
this is the simplest solution to the race condition, I'm concerned about 
the memory overhead on such configurations.

Two questions:
1. What is the per-worker memory footprint? Can we quantify the overhead 
for systems with large possible-but-offline CPU counts?
2. Would an alternative approach be feasible - such as lazy worker 
creation during CPU hotplug, or deferring worker creation until a CPU 
actually comes online?

I can test this patch on our IBM PowerPC systems to measure the actual 
memory impact and verify the POOL_DISASSOCIATED handling works correctly 
with large offline CPU counts. Would that be helpful?

Please let me know your thoughts.

Thanks,
Samir


> From: Tejun Heo <tj@kernel.org>
> Subject: workqueue: Create workers for all possible CPUs on init
>
> Per-CPU worker pools are initialized for every possible CPU during early boot,
> but workqueue_init() only creates initial workers for online CPUs. On systems
> where possible CPUs outnumber online CPUs (e.g. s390 LPARs with 76 online and
> 400 possible CPUs), the pools for never-onlined CPUs have POOL_DISASSOCIATED
> set but no workers. Any work item queued on such a CPU hangs indefinitely.
>
> This was exposed by 61bbcfb50514 ("srcu: Push srcu_node allocation to GP when
> non-preemptible") which made SRCU schedule callbacks on all possible CPUs
> during size transitions, triggering workqueue lockup warnings for all
> never-onlined CPUs.
>
> Create workers for all possible CPUs during init, not just online ones. For
> online CPUs, the behavior is unchanged - POOL_DISASSOCIATED is cleared and the
> worker is bound to the CPU. For not-yet-online CPUs, POOL_DISASSOCIATED
> remains set, so worker_attach_to_pool() marks the worker UNBOUND and it can
> execute on any CPU. When the CPU later comes online, rebind_workers() handles
> the transition to associated operation as usual.
>
> Reported-by: Vasily Gorbik <gor@linux.ibm.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Boqun Feng <boqun@kernel.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> ---
>   kernel/workqueue.c |    5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -8068,9 +8068,10 @@ void __init workqueue_init(void)
>   		for_each_bh_worker_pool(pool, cpu)
>   			BUG_ON(!create_worker(pool));
>
> -	for_each_online_cpu(cpu) {
> +	for_each_possible_cpu(cpu) {
>   		for_each_cpu_worker_pool(pool, cpu) {
> -			pool->flags &= ~POOL_DISASSOCIATED;
> +			if (cpu_online(cpu))
> +				pool->flags &= ~POOL_DISASSOCIATED;
>   			BUG_ON(!create_worker(pool));
>   		}
>   	}
