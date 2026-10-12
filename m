Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0F73ABDA5;
	Mon, 12 Oct 2026 10:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791801720; cv=none; b=n6uyMGyqTLGCEj20ijFYHlmeOkLKf1IeIKCKHuMO3cI09Y7eguF4NkMv2vqmsX/CnnFN8vSng0Swu/SYvCaaGPvcC7xSw9nRSqoDAiEDYQEqeOKulgciy8TflF7jGJl5l6z9fXHUbc7Zijy78U3AgMbCOIYXjYcEMcTtxvwfk84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791801720; c=relaxed/simple;
	bh=BZIbGLvDd3HgUKNzdWi2HLJU38vZpIq1HV+91E3zfmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UcIEO4TJas28TrmfZM7DXRhbJHlLcq3YOzlo8Tl2DUMUDxIc6JAjBNtsfhLL2LE8LQF25h8+5FB2ndmfLuZV+CYiQzAahXN4EBNTQV8xH2uCtjKizR860Af06TL8Rdg0weFICV8UK3LMQAUso3CYn0sziAmm6ngUYdRgKCJTWLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WAE4k3jR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WAE4k3jR"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8iMDk3918037;
	Mon, 12 Oct 2026 10:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=m2Mftx
	7uH7fHxV9Q/Qnwn9gEEKKNUvkP8tcqnAIq0Jw=; b=WAE4k3jRhNzWysd1+0PjUF
	sxsbnM4b01KM9nZ9Pl3EvvW5RfF86IdBduSekYV0ex1hS9fIQb5ZEiQ2sU5niq2t
	Idv7jlNXtZBkzvIA5kXLprjeT2aoyUuKOHHIHkCdalGfgC6cgCYs9FnbhIxyWKlZ
	1MFZ5ElXVcrhc3oXWQ59GJUbSXkEpPaz1+HH5GlYYSNUIBD2E7dkq+sl7P+gdMZO
	AgKQkUTc5OEGqMYGrljuFPsVnpYkulUbJWVykQ1X12CAxuxpNRL6Tf9ntS4cg5jS
	2vF6gF8sM89MFOFe8z0ektR2XM34VNYU1xurvZBZzLJKrvGSzGO1GY4mzvIT+9tw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv38d3k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 10:41:30 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8K2bl1014092;
	Mon, 12 Oct 2026 10:41:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h816gvnyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 10:41:29 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CAfPvR16974320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 10:41:25 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13AB520040;
	Mon, 12 Oct 2026 10:41:25 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 536852004B;
	Mon, 12 Oct 2026 10:41:24 +0000 (GMT)
Received: from [9.111.22.209] (unknown [9.111.22.209])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 10:41:24 +0000 (GMT)
Message-ID: <9d813d35-2962-4981-9fc4-fc59d5e64865@linux.ibm.com>
Date: Mon, 12 Oct 2026 12:41:23 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] sched: Introduce idle SMT priority for asymmetric
 capacity systems
To: Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc: Chen Yu <yu.c.chen@intel.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
        Andrea Righi <arighi@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20261008-hiperdispatchfix-v1-0-73fe41081070@linux.ibm.com>
 <76e09124223f7adb7f486fd861ead3bdbf595016.camel@linux.intel.com>
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <76e09124223f7adb7f486fd861ead3bdbf595016.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: cJNxaXnei5hc4fhGA0nnNKC_P3PkY2Vf
X-Proofpoint-ORIG-GUID: 73tdreQ9fxBwiUE6C2d7ARZ3pm-tYSSj
X-Authority-Analysis: v=2.4 cv=aqInmiZV c=1 sm=1 tr=0 ts=6accb95a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=7iweQuYWSF4fpDNisKwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0MCBTYWx0ZWRfX3DpKV1G3V7K8
 bUpuIwnucaF6CcYL3KRX09KqZlieTLzLHwedBEuTU3lCtpaS8lMRV2qFv3uGuLpO1PfNLvs9Wi+
 DvZiEHwje6GNhpbLtguERLOVmiu9stQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0MCBTYWx0ZWRfX3yJVsMrGCppI
 pM3+L4eybhl9EAxu/gAQ1hL+SqLouDhZzHGq6grbjJAX5voCAdsXsF9rXuiH9vDg/nuQovBF8b5
 gAuX9p8XCbDQMG3pn4mUPLm4GE1lRjBX224srA/DSQPFZfUrVivcZyCetKA6kYEsSF1wSus2l+u
 N3h4aa1CwwSBNqN5ypjewLCLn5TO/UpluyQUM4dtf/KXN9ln5g9Tgesv9vAumZbZ2iouphf1viS
 cNB3IUiRgBJvOWSyj/U7GaM4ul3KFk+7RAabL2Kv4m3xr5+R4HNz7SUB2makqiZ99vCdi3RcC5w
 M9FWtHAeVm1iGMjtZQN6y0Hzqf5iVvG2X0Z1z4pWz0QunQcoZowB2t6Un3k+nDdTjvozGbqQP+e
 s49NrIzr2NUbVsgj+q5lztpzSt/YG3lTU8yreM9zIeCQ+rG1rhyRzvF+0DrHTZD2vJziqBnQL18
 oRhBL93CEtpfXhn791g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120040

[..snip..]

>>
>> Considerations and Open Questions
>> ===========================================================================
>> The main goal for this series is adding a simple mechanism for
>> architectures to switch between idle core and idle SMT priority while
>> keeping the introduced footprint as small as possible. But there are
>> some ideas and questions to consider;
>>
>> 1. Should arch_needs_idle_smt_prio() hook be removed?
> 
> Hi Mete,
> 
> One assumption in the series should be made explicit, and I think
> it answers your question 1.
> 
> The idea only works if two CPUs that the guest sees as SMT siblings
> really run on the same physical core. "An idle sibling of a busy
> high-capacity core" is cheaper than a fully idle low-capacity core
> only because it uses a physical core the partition already has. That
> holds on an LPAR, where hypervisor dispatches whole cores. 

True, the whole idea is based on this assumption and it is not
mentioned. I'll add this.

> It does not
> hold in general for a guest whose hypervisor schedules vCPUs one at a
> time, such as a typical KVM guest with "threads=2". There the guest's
> sibling masks are just a description, and packing onto "siblings"
> gives no benefit.
Right, if the whole topology is virtual, the vCPUs are just
separate independent entities from each other. I am not sure
if there is a way to configure a KVM guest to reflect this
and make the KVM hypervisor to schedule whole guest cores.
Regardless, I agree that this has to be explicitly stated
somewhere, probably in Kconfig's help text.

> Nothing in the series checks this, and it is not documented:
> 
> - In patch 1, the default arch_needs_idle_smt_prio() returns true,
>    and the Kconfig help does not mention that siblings must share a
>    physical core. Any arch that selects
>    ARCH_SUPPORTS_SCHED_IDLE_SMT_PRIO takes this on without being told.
> 
> - In patch 2, the hook checks only the topology mode:
> 
>> +bool arch_needs_idle_smt_prio(void)
>> +{
>> +     if (topology_mode != TOPOLOGY_MODE_HW)
>> +             return false;
>> +     return true;
>> +}
> 
> Today s390 seems to be safe because sibling masks are
> only built in HW mode.  It is the only place where this
> precondition can be enforced.
> 
> So I would keep the hook. It is the only place where this
> precondition can be enforced. Removing it and tying the feature to
> "Kconfig + asymmetric capacities" would drop the check entirely.
> Concretely:
> 
> 1) Document the contract in the Kconfig help and above the hook,
>     for example: "Only select this if CPUs reported as SMT siblings
>     are always dispatched on the same physical core."

Will do!

> 2) Make the s390 hook test the conditions from the cover letter,
>     something like:
> 
>          return machine_is_lpar() &&
>                 topology_mode == TOPOLOGY_MODE_HW &&
>                 smp_cpu_mtid;

Makes sense, as this won't help on systems with SMT disabled.

Thanks for the comments!
-Mete
