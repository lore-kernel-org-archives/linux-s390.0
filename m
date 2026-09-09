Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787992D3727;
	Wed,  9 Sep 2026 05:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788933457; cv=none; b=P4TluzOCopwaMyNd4t5dPKfRCgFj6D0IdpoI91wwwXK+vAwygOPwn+7ixb+wnZACLb4xlib0oYa+4rSurpAdCiPkgQIpLsxgckPUr4l/4HwiFbHE3bFqSQ1S8sb+TaOGkuIAh17MRg852nkz6Kfb5Xy/WqMfe2I1F4ROvBh7l6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788933457; c=relaxed/simple;
	bh=U5nlvTTN9wZ5ZfagKh9n4xZBqQYFJ45pNseJZ83BPXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UJKbgjc8fZoUGZOwPQf/i3+c1SbgSXbL+QH/9/woxuQKxRV2OYUHHLl6hHyN7qCxnRsYG0cw0xTwgUZFJ44H2N21vku0ZaI9vh/C1WUR6ktvhBwpUtVOjWUYAo8aX5dz8KYoc1s8BKZSGZDWxXA45SKS2Up5xj8L7FjmCHn4cqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dQ69+kgK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dQ69+kgK"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688N1m1S1116891;
	Wed, 9 Sep 2026 05:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=p5KIJ6
	azA5hLlaqanJLK0t2FaZ9Ah59brkwkMhoq+6c=; b=dQ69+kgKfRB5xgMnYPupN8
	tcyvdWb92XqfO3JOA+9nu1UVfU2CM/GDirLg0GlCWOvqK34wZU8EO9GoXB/pcHqU
	8KGix+W+zAABakSOx50w5WuQLKCEpSWBFMfRUBlzmm8ABgKPBZX87zTq8bSSWVlp
	XvzN2lLh3ZY9k+v7bG6IkBooQ+ZsIYlmwfEL7FhFU7XDAEixHHrqLa3TZ09aI+nK
	Z1AqvwGm0rNLEPKFDrOU/I/ukIyoS1V6C0pABrZW9AEkY3OWvER7110xqNj80JZj
	xr2RYRFmaCCSB0JKZ6kdirAneXtqD4hjcxtFLZmfUI19LextZ7lqmOJx9ugIx7pA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbjruku7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 05:57:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6895uGol010461;
	Wed, 9 Sep 2026 05:57:33 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggwsw8mh3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 05:57:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6895vSf440174008
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 05:57:29 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D97DE2004B;
	Wed,  9 Sep 2026 05:57:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAE2120043;
	Wed,  9 Sep 2026 05:57:26 +0000 (GMT)
Received: from [9.124.214.180] (unknown [9.124.214.180])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Sep 2026 05:57:26 +0000 (GMT)
Message-ID: <34a27ebe-e9fb-4300-9d5c-beac88744bd4@linux.ibm.com>
Date: Wed, 9 Sep 2026 11:27:25 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] s390/qdio: Ensure QDIO_IRQ_STATE_ACTIVE is set only
 after firmware activates.
To: sashiko-reviews@lists.linux.dev
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
References: <20260907051016.1296884-1-niharp@linux.ibm.com>
 <20260907052157.AC6D51F00A3A@smtp.kernel.org>
Content-Language: en-US
From: Nihar Ranjan Panda <niharp@linux.ibm.com>
In-Reply-To: <20260907052157.AC6D51F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E7T9Y6dl c=1 sm=1 tr=0 ts=6aa0f54e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=RNO6l7jBmMAO9tALM8AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDA2MCBTYWx0ZWRfXyPbXCViWjowj
 6c+i2TR4Vx6ziyA2f5Wrap3ZRL9DXJqdNLCwjbf2cdFD8x+fgaEcrjEuDQmcyC1o1vh3/yNxDwN
 aocLToL7vWXzm7Fj+swOGUmpmUinVFU=
X-Proofpoint-ORIG-GUID: 2YecC8wbBAe95zB_ms4lYvsuAqm2Qmz3
X-Proofpoint-GUID: 2YecC8wbBAe95zB_ms4lYvsuAqm2Qmz3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDA2MCBTYWx0ZWRfX2iTSqiIhVqyt
 Jp8kwIhuSlADHvoLlF/IGTnn85UTxiSCX0RTOfg7wuyYRfo9wzxaBg3f33aUcu9cLgNgqZYKG2S
 J15liG1ab6blRvfY+qjpfxtXTHj2OvLYzK8ibYgrIJXoQcEU2O2RmAjFS6CKB8kANFjsb7JM+RS
 Ul6DHK9GcsFuR86mBgABEBENvS+pHUHkOuN6oJzsqARi5bm0oy+nFmeB7nEWYmXmjn2NYaxD3dT
 sa5ofpBbH/BucLADcEx8l4kzDPotiXADLaMbQUUGrImds4B/2trAY9RhEQN8aGX9iU7o/Vx/qN/
 eNaMuX7yJFGPSPkeeBvYV9CGiSgQzHcAGg4QPWDt1FdTLLBxmWEWpfmzRfXP0ixH1RW9IR4p/Z1
 1+lPev0GJNMPHkFsAiwuivNRfdO16m2eV5SlKHHfmOcY9S/LlKqZCp2wAowV2CBlnx0VQP3/ETd
 t28i0JPgxgPy929u/dQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090060

On 07/09/26 10:51 am, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> 
> New issues:
> - [High] Lockless execution of cio_update_schib() causes a data race on the shared sch->schib structure.
> - [High] The timeout polling loop is vulnerable to a preemption bug resulting in a spurious -ETIMEDOUT failure.
> - [High] Missing I/O cancellation on timeout leaves a dangling channel program.
> 
> Pre-existing issues:
> - [High] qdio_set_state() is called locklessly, potentially overwriting a STOPPED/ERR state.
> --
> 
The above reported issues have been reviewed and determined to be invalid. 
Please find the clarification for each item detailed below.

> commit f5d84619d7d33842d3cc7f120e8e2f08b030d3f4
> Author: Nihar Panda <niharp@linux.ibm.com>
> 
> s390/qdio: Ensure QDIO_IRQ_STATE_ACTIVE is set only after firmware activates.
>     
> This commit modifies the activation sequence for QDIO queues to poll the
> Subchannel Status Word (SCSW) instead of relying on an intermediate interrupt.
> It checks for both SCSW_ACTL_SCHACT and qact to become set within a loop before
> transitioning the state to QDIO_IRQ_STATE_ACTIVE.
> 
>> diff --git a/drivers/s390/cio/qdio_main.c b/drivers/s390/cio/qdio_main.c
>> index c1e09fa34e774..821d501efdccf 100644
>> --- a/drivers/s390/cio/qdio_main.c
>> +++ b/drivers/s390/cio/qdio_main.c
> 
> [ ... ]
> 
>> @@ -1178,23 +1197,32 @@ int qdio_activate(struct ccw_device *cdev)
>>  			      0, DOIO_DENY_PREFETCH);
>>  	spin_unlock_irq(get_ccwdev_lock(cdev));
>>  	if (rc) {
>> -		DBF_ERROR("%4x act IO ERR", irq_ptr->schid.sch_no);
>> -		DBF_ERROR("rc:%4x", rc);
>> +		DBF_ERROR("%4x act IE:%d", irq_ptr->schid.sch_no, rc);
>>  		goto out;
>>  	}
>>  
>> -	/* wait for subchannel to become active */
>> -	msleep(5);
>> +	rc = -ETIMEDOUT;
>> +	timeout = jiffies + HZ;
>>  
>> -	switch (irq_ptr->state) {
>> -	case QDIO_IRQ_STATE_STOPPED:
>> -	case QDIO_IRQ_STATE_ERR:
>> -		rc = -EIO;
>> -		break;
>> -	default:
>> -		qdio_set_state(irq_ptr, QDIO_IRQ_STATE_ACTIVE);
>> -		rc = 0;
>> +	while (time_before(jiffies, timeout)) {
> 
> [Severity: High]
> Does this loop risk spurious timeouts under preemption or high CPU load?
> 
> By checking the timeout condition before evaluating the hardware state, if
> preemption occurs right after the timeout is set and lasts longer than HZ,
> the loop will terminate immediately.
> 
> This causes a spurious -ETIMEDOUT failure without ever checking the hardware
> status.
> 
NO, the loop is safe because msleep + time_before(jiffies,…) is immune to preemption delay; 
jiffies advances independently
>> +		msleep(1);
>> +		if (irq_ptr->state != QDIO_IRQ_STATE_ESTABLISHED) {
>> +			rc = -EIO;
>> +			DBF_ERROR("%4x act WS:%d", irq_ptr->schid.sch_no, irq_ptr->state);
>> +			break;
>> +		}
>> +		/* Query hardware */
>> +		if (cio_update_schib(sch) == 0) {
> 
> [Severity: High]
> Is it safe to call cio_update_schib() without holding the subchannel lock here?
> 
> The lock get_ccwdev_lock(cdev) was released earlier, and cio_update_schib()
> performs a lockless memcpy():
> 
> drivers/s390/cio/cio.c:cio_update_schib() {
>     ...
> 	if (stsch(sch->schid, &schib))
> 		return -ENODEV;
> 
> 	memcpy(&sch->schib, &schib, sizeof(schib));
>     ...
> }
> 
> This results in a data race with concurrent interrupt handlers that might be
> updating sch->schib, potentially causing torn writes and state corruption.
>
Yes, it is safe to call cio_update_schib() without holding the subchannel lock. 
The implementation is secure for the following reasons:

Subsystem Consistency: The lockless call is consistent with all other invocations of 
cio_update_schib() across the driver subsystem.

Authoritative Data: Both concurrent writers are applying identical, hardware-authoritative state, 
eliminating the risk of conflicting data.
Writer A — the interrupt path (do_cio_interrupt()): memcpy(&sch->schib.scsw, &irb->scsw, …);
Writer B — the poll path (cio_update_schib()):memcpy(&sch->schib, &schib, …);

Fault-Tolerant Design: The polling loop naturally tolerates a missed read and will simply retry, 
preventing state corruption.

>> +			if ((sch->schib.scsw.cmd.actl & SCSW_ACTL_SCHACT)
>> +					&& sch->schib.scsw.cmd.qact) {
>> +				qdio_set_state(irq_ptr, QDIO_IRQ_STATE_ACTIVE);
> 
> [Severity: High]
> This is a pre-existing issue, but is it safe for qdio_set_state() to assign
> the state locklessly?
> 
> By directly assigning irq_ptr->state without serialization, it can overwrite a
> QDIO_IRQ_STATE_STOPPED or QDIO_IRQ_STATE_ERR state set concurrently by an
> interrupt handler.
> 
> This could mask concurrent hardware errors and leave the device in a
> false-active state.
>

Yes overwrite can happen between do_cio_interrupt()  and cio_update_schib().
The mb() inside qdio_set_state() ensures the write is ordered and visible, not exclusive.
The race is not new and is not worsened by the change.
The race window is smaller, the guard is tighter, and the hardware confirmation adds a second condition. 


>> +				rc = 0;
>> +				break;
>> +			}
>> +		}
>>  	}
>> +	if (rc == -ETIMEDOUT)
>> +		DBF_ERROR("%4x act TIMEOUT", irq_ptr->schid.sch_no);
>>  out:
>>  	mutex_unlock(&irq_ptr->setup_mutex);
>>  	return rc;
> 
> [Severity: High]
> If this returns -ETIMEDOUT, is the pending asynchronous I/O left uncancelled?
> 
> When the timeout expires, the function returns the error while the channel
> program started by ccw_device_start() may still be active in hardware.
> 
> This could lead to use-after-free and memory corruption if the uncancelled CCW
> eventually completes and performs DMA writes to memory that has since been
> freed or repurposed.
> 
No, as qdio_shutdown() → qdio_cancel_ccw() → ccw_device_halt/clear() is the 
mandatory error path all callers must invoke, so the channel program will be closed.

