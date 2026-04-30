Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F63539A07B;
	Thu, 30 Apr 2026 07:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777532916; cv=none; b=isnQSA3UQXW7jYk0ft/BZFeyqPtA6DTNyhqfz7GaOVYSjEtUrBBe30vAPNkNTlb6tyrkE2Hv+ikOjplDfMb6zC/Cm/DqR9WGdQWTXpEkf5/3aAYeQk3AhwNL670ctWsZCxIrKsD84VE005uuD29Bqzjfc0x15t+aRVA2EZ4rAzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777532916; c=relaxed/simple;
	bh=FAnv6LG3uppanLitZxS2+wtksEbIp/SAvUcVwuCRFbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tKaqqxIII4/XGKt2pAbTch1H9mEG3SQn3ImPIu8hZEgkovqD6ZoA/ABmLklE//5ZciQV7FVZm1KIPMzhX8GkuJr4OhZppwKtHSAwAuOrFNZCxSO2toNu31IxLT0PBARtAdnWBLzdubxpMTn+r8oGCUB9twFQmRueWF/S04NJErY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DloasYxR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DloasYxR"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TInL9O2688397;
	Thu, 30 Apr 2026 07:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=R3XxjD
	kkhfa328K+AWP8Zweav112m51dlURxGRxS54E=; b=DloasYxRJ4VPrHQbxftUcb
	41gGGLhRessRlcENnubvw6CWp9G1TqtWmyFHiJmeXz1KS1kQ4SbpdrYnUSpTdQ5v
	QKrNf7Al7AfyaKFQqG7CGKXD5ZIGdvwM+3/1hT4fR+H3Sb9vmUAhrknht9QvVdEu
	WvaAlabOE/w5S3SuSyj3E1FcrpRSK+zG4sHsrAeVZgA+N+O856+0iooiZRyvccpK
	kpQH4FxAXEp7yiUleQYFjFfJihme0P28UetbLz3hH+xEQewaEaswHDW/c/YQKrg0
	zxUQenB2QMDjRb3G1q7xe6hAHS0afQ9TftVt8RdSvTZYMMNEj17I+m2N/1xUfbSg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9recdt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 07:08:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63U6rpiO024424;
	Thu, 30 Apr 2026 07:08:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsamyhkue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 07:08:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63U78MXM53019094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Apr 2026 07:08:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDF0E2004E;
	Thu, 30 Apr 2026 07:08:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 470D820043;
	Thu, 30 Apr 2026 07:08:17 +0000 (GMT)
Received: from [9.123.5.233] (unknown [9.123.5.233])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Apr 2026 07:08:17 +0000 (GMT)
Message-ID: <868cbc25-45a9-4476-b77e-7f878f1cd42c@linux.ibm.com>
Date: Thu, 30 Apr 2026 12:38:16 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG: workqueue lockup - SRCU schedules work on not-online CPUs
 during size transition
To: paulmck@kernel.org
Cc: Tejun Heo <tj@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
        Srikar Dronamraju <srikar@linux.ibm.com>,
        Boqun Feng <boqun@kernel.org>,
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
 <3f6d1123-6e1a-4566-8be7-ce95efe0609c@linux.ibm.com>
 <7b5665b4-ddd0-404a-8314-fd0a170db458@paulmck-laptop>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <7b5665b4-ddd0-404a-8314-fd0a170db458@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 6kFkMQZ6xgPUVW804RZfEpM_iLepMS3H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA2NSBTYWx0ZWRfX1eGA+z8+yzsp
 S7Ar2MOitozrZoXN0xNwSPGArCLxXhZEy5y8OqOdmoxTixZHDo6Hbaa/6/tcgC9YGnXMeWB2rxx
 /NEsP7TKtas1ATL05B1gdgo4owxA67AJNtZEyLGIQV7p+UmpU8Yqls1GrBZ1qC4EP402JpAmzHa
 FKg3Lmn2GB9CDQ+N+xFSM6cH9Y5sMyIqSaRqmWZPDIyys6to88Ihy6KwyvSbHjOZNaTvKyoCwRx
 0R2TRX8aQqsO87P03jfe2f/c2GpQUNsWoeHAmBT1paWoC3sqJEtfG80FrUmZBDWAHv7xkljOtLO
 p6S5p8eoTKI+DQ0fmBLxT1xptRe9L0eh4lPt/yv2W51oSDjxHllNCFoGBCNs7tJW2YgN9/BBCkb
 nV93xtCTEoqYTr3nH8mVPgtvHUO5qCJaq43WNSneVoZ1YiGyWP2ITsvGTFP0O5A/xL/zIDGqLDf
 ba9JzszTREBkXulCEmA==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69f2ffec cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=e3K_sr4fstJ4hurmY1cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3WGH3OpalX2waNy5LWOflQxoC5lUDXuF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300065

Hi Paul.

On 4/29/26 11:31 PM, Paul E. McKenney wrote:

>> That mask = ~0 is really looks uncomfortable to me. What does it mean?
>> It might end up even sending to non possible CPUs without proper checks.
>>
>> It should use either cpumask_setall? or use cpu_online_mask?
>>
>> Your current patch rcu_cpu_beenfullyonline indicates that code around
>> srcu_schedule_cbs_sdp handles hotplug already right?
>> in that case, just setting mask = cpu_online_mask would work?
> 
> Agreed.  Which is why I have this commit queued:
> 
> f8d5aaaf90f8 ("srcu: Don't queue workqueue handlers to never-online CPUs")
> 
> This is currently slated for the upcoming merge window, but if you
> need it sooner, please let us know.  Please see the end of this email
> for the full commit.
> 
> 
> 							Thanx, Paul
> 
>>> /**
>>>    * queue_work_on - queue work on specific cpu
>>>    * @cpu: CPU number to execute work on
>>>    * @wq: workqueue to use
>>>    * @work: work to queue
>>>    *
>>>    * We queue the work to a specific CPU, the caller must ensure it
>>>    * can't go away.  Callers that fail to ensure that the specified
>>>    * CPU cannot go away will execute on a randomly chosen CPU.
>>>    * But note well that callers specifying a CPU that never has been
>>>    * online will get a splat.
>>>    *
>>>    * Return: %false if @work was already on a queue, %true otherwise.
>>>    */
>>
>>
>> In that case, making offline CPUs have a unbound workqueue is wrong. no?
>>
>> It might encourage more users to abuse queue_work_on interface to
>> send to offline CPUs without any checks and onus now falls onto
>> workqueue to disaptch to unbound wqs.
>>
>> So I think it is better to put the guardrails in SRCU instead of any change in
>> workqueue.
> 
> ------------------------------------------------------------------------
> 
> commit f8d5aaaf90f8294890802ce8dccbafd9850ac5f9
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Thu Apr 9 11:16:02 2026 -0700
> 
>      srcu: Don't queue workqueue handlers to never-online CPUs
>      
>      While an srcu_struct structure is in the midst of switching from CPU-0
>      to all-CPUs state, it can attempt to invoke callbacks for CPUs that
>      have never been online.  Worse yet, it can attempt in invoke callbacks
>      for CPUs that never will be online due to not being present in the

for CPUs that never will be online due to being present in the cpu_possible_mask?

>      cpu_possible_mask.  This can cause hangs on s390, which is not set up to
>      deal with workqueue handlers being scheduled on such CPUs.  This commit
>      therefore causes Tree SRCU to refrain from queueing workqueue handlers
>      on CPUs that have not yet (and might never) come online.
>      
>      Because callbacks are not invoked on CPUs that have not been
>      online, it is an error to invoke call_srcu(), synchronize_srcu(), or
>      synchronize_srcu_expedited() on a CPU that is not yet fully online.
>      However, it turns out to be less code to redirect the callbacks
>      from too-early invocations of call_srcu() than to warn about such
>      invocations.  This commit therefore also redirects callbacks queued on
>      not-yet-fully-online CPUs to the boot CPU.
>      
>      Reported-by: Vasily Gorbik <gor@linux.ibm.com>
>      Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>      Tested-by: Vasily Gorbik <gor@linux.ibm.com>
>      Cc: Tejun Heo <tj@kernel.org>
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 0d01cd8c4b4a7b..7c2f7cc131f7ae 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -897,11 +897,9 @@ static void srcu_schedule_cbs_snp(struct srcu_struct *ssp, struct srcu_node *snp
>   {
>   	int cpu;
>   
> -	for (cpu = snp->grplo; cpu <= snp->grphi; cpu++) {
> -		if (!(mask & (1UL << (cpu - snp->grplo))))
> -			continue;
> -		srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, cpu), delay);
> -	}
> +	for (cpu = snp->grplo; cpu <= snp->grphi; cpu++)
> +		if ((mask & (1UL << (cpu - snp->grplo))) && rcu_cpu_beenfullyonline(cpu))
> +			srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, cpu), delay);
>   }
>   
>   /*
> @@ -1322,7 +1320,9 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
>   	 */
>   	idx = __srcu_read_lock_nmisafe(ssp);
>   	ss_state = smp_load_acquire(&ssp->srcu_sup->srcu_size_state);
> -	if (ss_state < SRCU_SIZE_WAIT_CALL)
> +	// If !rcu_cpu_beenfullyonline(), interrupts are still disabled,
> +	// so no migration is possible in either direction from this CPU.
> +	if (ss_state < SRCU_SIZE_WAIT_CALL || !rcu_cpu_beenfullyonline(raw_smp_processor_id()))

How can this happen? To get a CPU offline in raw_smp_processor_id() you need to run on the offline
CPU.

>   		sdp = per_cpu_ptr(ssp->sda, get_boot_cpu_id());
>   	else
>   		sdp = raw_cpu_ptr(ssp->sda);

