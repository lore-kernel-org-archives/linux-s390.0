Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79494CB8D7;
	Tue, 13 Oct 2026 10:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791888646; cv=none; b=UeNDxGnBNfB5rXGXZFUlT/WX3eMHD/l1nONlfH1E7E6xGvOkUcxgiY1QceO6M39Z2buPsuNhn9usg+hKy9e7X+a4xiLPu85IWWi7lSSmZuW5wzmpfZOX9JSwyhygFqOxuz26VgNRQPFTfRCQYV030R2oPupSSkSR4XDSI31vbmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791888646; c=relaxed/simple;
	bh=XgnmF2YgwAt+dP+vLHjJO26js0PFTZ9QSq5rROxIW64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rmDGeBBsKKWdUvR78ldpPOgs7/yGojyJU777DugJfJxByouyO4FApRSwj8UEipkG25ejvhIhaaqwhPkn+mwmZqdIQ3V5Q43PrixnZKF6++X50swxZqR54ngt99Ukf5Tnovr9q2YvMhI6nKTr7N/+9GZOUqrYBgCkgqWcQTmwbTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NcXV8s4y; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NcXV8s4y"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D2Exaa727076;
	Tue, 13 Oct 2026 10:50:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=O2aDD2
	7dnQNnDMjEKgskhMm98/OczVteYy0IZf3/lv4=; b=NcXV8s4ybhwq0ZRbsAmk3p
	YDQrxKS6aHwASnKy9711HQi9SMp2TRCOH4NHQ4YaEgeKzWgqNi53zCZI5BWXjy0S
	brI1yvoeChTyOaP2miRgWjrZLKMim8fsDHi0rfoAOWFA9EwPeMbihcqfOYnm6sCZ
	fRvCc0+B7KXTagjY7krIykr1qyDGQwTrYVdmDBT/0e3IwAgE8T8H3fl7RE/D0pYp
	ciec3x4NvR2w+dF/+LHHkzXB7v8vATzrFv8U9p2cT/gVG6mh6jyf5KPRfRoad5Jl
	a06sH4jKGBX3mKR6A3kOybBICsDC6h+CYGVPF9CpuDZny3k/oJEsSokYDHoXcqyg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv0d2sa-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 10:50:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69D8Tqx42660311;
	Tue, 13 Oct 2026 10:50:20 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h7yppsfv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 10:50:20 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69DAoGRX55640384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 10:50:16 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F9C92004D;
	Tue, 13 Oct 2026 10:50:16 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5468B2004B;
	Tue, 13 Oct 2026 10:50:15 +0000 (GMT)
Received: from [9.87.128.189] (unknown [9.87.128.189])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Oct 2026 10:50:15 +0000 (GMT)
Message-ID: <ce85388c-3ea0-4363-8c89-fe2bf71b284a@linux.ibm.com>
Date: Tue, 13 Oct 2026 12:50:14 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] sched: Introduce idle SMT priority for asymmetric
 capacity systems
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, Andrea Righi
 <arighi@nvidia.com>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, Chen Yu <yu.c.chen@intel.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20261008-hiperdispatchfix-v1-0-73fe41081070@linux.ibm.com>
 <aseIPhrDGCYFtJNE@gpd4> <90454932-1d82-450a-ac4c-499acdedb9d7@linux.ibm.com>
 <ffbeae31-0e93-4386-8e0e-dba13960b283@linux.ibm.com>
 <CAKfTPtCianGNWSu0s2J_B_aO_rtKWO17k9guYmwgXXLUHQE+SA@mail.gmail.com>
 <d412d939-4704-4246-a9bd-b49b457099b8@linux.ibm.com>
 <CAKfTPtAGiesy0FZQ3aOny_1QkqaX0P2MCOdkE42ERdihRJL99g@mail.gmail.com>
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <CAKfTPtAGiesy0FZQ3aOny_1QkqaX0P2MCOdkE42ERdihRJL99g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0MiBTYWx0ZWRfXxO2iYJNVGU3W
 7AM6FSw17ZMv+2ehYsqrn7kUVAxYQZWGQuB0RvPsaqCCmmf5lIRi+23OQSMuQByHL9gs6ykVnq5
 FeotQ4yL1VUC5PUtf9PEcE8An6LpVVTRKYd8OV1RseYbROTtQwqcnkTBJdWD/dQPMJ3g2eVmfB+
 Ko0pTIh6bJ8ZyfFrD3OfTWjUWkcJx9OFIdiGn8fK5Hfq5XgJrT5N7wpN1EQO88FBZFboNtCfw6A
 16VY1xKix129X012X5t6zHeA18m5FwCnCKrGLdzlTlnIZqN+GiuzVj1Tr3uOA038F7JjyyMQf6i
 RzQ/+es5S79JjeibVQpDuzkp4h2J2IRVYYR7FZZGg/D0/9Bw10FlqGimzsSYmva/TzMzsBPd1jK
 L7YrX2LWKFxmIRiqduVay+gbOb0klfaA69mDzPy/pHrCdLkYOt9xIzBQUvnUzPwuPOcIhCztQZX
 2rrGZDYHdRYlbCHNCVw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0MiBTYWx0ZWRfXyUfegSFwPkf8
 cJEAvz0q7ZHN6P62xZalAiP1Us69kG8mUthd3dFSAssuqUytwNc4esbj2tdESdCuFQayM1KPfc+
 ANIGi1Ez0rNZlUrJBIhW0Qae+K3MMcQ=
X-Proofpoint-ORIG-GUID: Fhag1p3DR8Ydy9w6JtdMj-JBiqr_blM6
X-Authority-Analysis: v=2.4 cv=a6KlZkSF c=1 sm=1 tr=0 ts=6ace0ced cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=_8vwSg6ZCyrHLbdd9ZAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: -PrOdXHDGfBJ78zp3m1gmlFLTTCUb8aI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130042

On 12/10/2026 16:49, Vincent Guittot wrote:
> On Mon, 12 Oct 2026 at 13:04, Mete Durlu <meted@linux.ibm.com> wrote:
>>
>> On 09/10/2026 17:32, Vincent Guittot wrote:
>>> On Thu, 8 Oct 2026 at 17:25, Mete Durlu <meted@linux.ibm.com> wrote:
>>>>
>>>> On 08/10/2026 16:58, Shrikanth Hegde wrote:
>>>>> Hi Meter/Andrea.
>>>>>
>>>>> On 10/8/26 5:40 PM, Andrea Righi wrote:
>>>>>> Hi Mete,
>>>>>>
>>>>>> On Thu, Oct 08, 2026 at 10:30:46AM +0200, Mete Durlu wrote:
>>>>>>> Summary
>>>>>>> ===========================================================================
>>>>>>> On systems with asymmetric CPU capacities, the scheduler prefers
>>>>>>> fully idle
>>>>>>> cores over idle SMT siblings of busy cores. This works generally well
>>>>>>> but
>>>>>>> virtualized platforms where low capacity cores should be avoided are not
>>>>>>> considered. Introduce a new config option and arch hook to prioritize
>>>>>>> SMT utilization.
>>>>>
>>>>> That's true only under physical CPU contention right? or is it always?
>>>>
>>>> Right, because of that s390 treats all CPUs as equal and starts to
>>>> assign lower capacities to CPUs with low entitlement once a certain
>>>> steal time threshold is crossed (aka physical CPU contention).
>>
>> Hi,
>> Sorry for causing a misunderstanding. I should have been more patient
>> and detailed while writing my reply.
>>
>>> I'm not sure to get what your topology is because "if s390 treats all
>>> CPUs as equal"  then you should never use select_idle_capacity()
>>> because  their capacity should be fixed and equal and
>>> SD_ASYM_CPUCAPACITY_FULL never set.
>>
>> On s390 the entitlement of the vCPUs are signified by an arch specific
>> value we call polarization. We can tell which vCPUs are assigned high
>> and low entitlement. This entitlement value tells us which vCPUs are
>> prone to experience steal time first. Without any contention all
>> vCPUs behave and perform *almost* the same(of course, we want
>> some priority for CPUs with high entitlement).
>>
>> Prior to experiencing steal time(it's what we use to determine
>> contention) to get the most out of the system we assign all vCPUs
>> the same capacities, making the system symmetric like you say.
>> While there is no contention s390's vCPUs also perform better if
>> fully idle cores are selected for task placement.
>>
>>> If your hypervisor lowers the capacity once a certain threshold is
>>> crossed, we already account for the steal time in the scheduler with
>>> irq and remove it from the capacity available for tasks but the
>>> original capacity doesn't change.
>> s390's linux implementation has a mechanism called hiperdispatch,
>> that checks topology changes along with system steal time (and soon
>> the total free capacity of the pyhsical machine) periodically and
>> makes vCPU capacity adjustments accordingly.
>>
>> After steal time starts ramping up and cross a certain threshold,
>> we start assigning lower capacities to vCPUs with low entitlement to
>> hint the scheduler that they should be avoided.
> 
> If all your vCPUs starts with the same capacity, you should not use
> asym_capacity or enabled it . What you describe above is system
> pressure (steal time or other) on your vCPU that change over time but
> not a capacity change. The value returned by arch_scale_cpu_capacity
> is not supposed to change at runtime or you need to rebuild the
> sched_domain topology. As an example, max_allowed_capacity does assume
> capacity fixed otherwise the misfit detection will sometimes fails.

Exactly for that reason on s390 we do topology updates after
capacity updates. Topology changes caused by the underlying hypervisor
or the cpu capacity changes can get reflected without a problem via
topology rebuilds. Without topology rebuild we wouldn't even get
the correct SD_ flags to trigger asym_capacity behavior like you say.

> What you describe really fit into the prefered core that Shrikanth
> Hegde has developped

I agree, but Shrikanth's solution can not bring some of the
behavior changes required. cpu_preferred_mask can help
direct task placement away from low capacity cores but idle
core first approach still places tasks to fully idle low
capacity cores. This patches proposal tries to move tasks
first to the idle SMT siblings.

Consider the following;
On a system with 2 high capacity and 4 low capacity cpus.
steal governor of vCPU backoff mechanism calculates 2 low capacity
cpus should be taken off from the cpu_preferred_mask to decrease
experienced steal time. cpu_preferred_mask has 2 high capacity
and 2 low capacity cpus.

Current behavior tires to place tasks to fully idle cores first
even if they are low capacity cores.

       c0(high) c1(high)  c2(low)  c3(low)  ...
-------------------------------------------
SMT 0 task     task      task     task
SMT 1


With the proposal, the fully idle core preference is circumvented
and the most fitting SMT thread is selected.

       c0(high) c1(high)  c2(low)  c3(low)  ...
-------------------------------------------
SMT 0 task     task
SMT 1 task     task

This is beneficial because at the time of contention(system pressure)
low capacity cores could perform worse than SMT siblings of busy
high capacity cores, even if there is not enough steal time for
steal governor of Shrikanth's vCPU backoff to mark said low
capacity cores as non-preferred.

Andrea came up with an idea to extend Shrikanth's mechanism further
by adding a soft affinity to a selected set of CPUs. Task placement
would first fully load these CPUs before spilling load onto rest
of the CPUs on cpu_preferred_mask. That would help achieve the
behavior I describe above if the soft affinity covers high
capacity CPUs.

The discussion is still on going though. If Shrikanth thinks this is
a worthwhile concept then I'd be glad to work on the implementation
and provide the patches.
