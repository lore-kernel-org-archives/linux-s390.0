Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAAD36308E;
	Mon, 24 Aug 2026 19:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787600367; cv=none; b=MXHOvq6ciJcBRo9jtFQYWhvXhaVFCm7Xqijurh9nKbZZRCjdxYfx6hKKHMyq2XVO6x+PnppJmxJ8TpuWwxZsWO/Z7AR/eWa819KkeV+z1fV/TcD4UtQHtUDTKYiTbt8wR8cA5CLiubTTJvPd8F9UX38LHxAUCkw7A/X2TUA3eYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787600367; c=relaxed/simple;
	bh=ePef0YIcfKv9kA1goDXyGTRATLgMpyXqvviayrA9k18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ukdhaJi2GS+6pFrLwxn5fk9vkZUXwHfxnkBktAPO6ZJJkiPxnYPHeOdh8XfJifwLTp0SKZ0vsvK6I/GURsrJ42ILxkzvGKcUJ/OFND7kp5zowyKRhGBijsPiQNZTe1SFDEdEwql4GT0JCaGF6wwSG3TBpykYSmMV7PpTbe4JjuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pGU2YGkY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pGU2YGkY"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OJVnhg985218;
	Mon, 24 Aug 2026 19:39:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Wr3upw
	Lw/dmhJ6s5+p0hiUa2rl+PwOQ8qfF+k7Ypcvc=; b=pGU2YGkYi1wGx49WZQPq4F
	YLGZg3XE/7mBjeQNksABf+/J4efKSPGZpp3uDZg3AfcccCdbtbL6UNBYAlg1paT5
	Bt88ZeZZ3B89y1/YT322Kdhmu9As51GYSwOztg9Ydb4IDKfKC9Xocw7cxzTmXfhp
	ryZ1ODH2ErsiOevGYQxz8zDxE/sFm8d4zexYZZwNU0ctc2+ft5SjVESaw4ntqRSL
	6FxoYIt/2npQY686NtUruRyQ9sfj2mQlXdYJ0IjNsyAaT6i5+q2EeGx+fVwWch0+
	WGNohJ3ZGwjyDF1Fa83Xny/HXQ03xbcCZthcFSSPS4sOgeGpAyXdYllwNgzjRnGw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqkr6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 19:39:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OJR40C026723;
	Mon, 24 Aug 2026 19:39:19 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rag7xud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 19:39:19 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OJcba323593504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 19:38:38 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57C525805A;
	Mon, 24 Aug 2026 19:39:17 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A9865805F;
	Mon, 24 Aug 2026 19:39:16 +0000 (GMT)
Received: from [9.61.96.163] (unknown [9.61.96.163])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 19:39:16 +0000 (GMT)
Message-ID: <4bc189fa-ade2-46a9-a749-c9c8067f347a@linux.ibm.com>
Date: Mon, 24 Aug 2026 15:39:15 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] s390/vfio-ap: Fix leak of pinned NIB and registered
 NISC in vfio_ap_irq_enable()
To: Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        stable@vger.kernel.org
References: <20260824135850.503728-1-akrowiak@linux.ibm.com>
 <20260824135850.503728-2-akrowiak@linux.ibm.com>
 <adecc2df-d2c2-48d6-a80a-c84ab9779322@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <adecc2df-d2c2-48d6-a80a-c84ab9779322@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ATfjQQBdy1L70HFhYHe164-8UVn5C-H1
X-Proofpoint-ORIG-GUID: ATfjQQBdy1L70HFhYHe164-8UVn5C-H1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE2NSBTYWx0ZWRfX6DiF8jXiBZ7v
 OwW5PxbdObpmzZ4iMncSYoL/GpJwzLEVfLplJIiHzyx0YRv79EnsZWYYUmNTD1k/YxHiYL/4+Eo
 S/Oq4iLXD/Cn7Pynx+HR70IDuwzlIXwdyQM+bfnMA0iQy5IIFPYnnAMu8NwtNUwZ5A+Lr+UbZx8
 JzYT6uZi/kAp04ms2qd3MGhdq0LJCoKNwdxX0SI5IHyVU1LXTg46ccMZy9c2qkoLVvNQXJ1upPY
 VNnBKfme5PcP8pL+oXFznTKsSBojGctrKEJQnzttngvzqz/7pXn4RgPVwtJPlHW3u7pEkoZyHOY
 nLJtfyA8LxDhXGYfSYdKQDy1vdBorfjB3Kgf4mRxMsmeJBdb3TjqqdDOb2Y7NHNxxMG1Njw+vK4
 0kvVELrMb/U/J7Kuug6epvm969XPOcqiRsROZnRnw9sg3XKwCGLLw/8qvuWPpBDrhagrbNccl4Y
 huJEiSLBFfxRXccXCjA==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8c9de8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=oJhS4qge3_J52AN1xGYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE2NSBTYWx0ZWRfX1avNBySAe4V1
 Ec291qXlldWQEN9wawEbt0r5D4CwIeZUf0v5kKvafY7HS4yLQ2VxczdFPRMuNsZnXGVkZnQ3Ds4
 e20oMg6ctXPslEIBdialnc32EgGZVwQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240165



On 8/24/26 12:57 PM, Matthew Rosato wrote:
> On 8/24/26 9:58 AM, Anthony Krowiak wrote:
>> The vfio_ap_irq_enable() function executes the PQAP(AQIC) instruction to
>> enable interrupts for an AP queue. A switch statement is used to examine
>> the status response code returned from the instruction to determine
>> whether it succeeded or failed and react accordingly. For the default case,
>> the vfio_ap_irq_disable function is invoked to disable interrupts for the
>> queue and clean up the AQIC resources (i.e., unpin the NIB and unregister
>> the NISC). There are a number of problems with this:
>>
>> 1. Neither the q->saved_iova nor q->saved_isc has been set, so the
>>     AQIC resources - assuming those values have been previously set - will
>>     be the NIB and NISC resources from a prior call; the NIB and NISC from
>>     the current call are therefore leaked.
>>
>> 2. Interrupts may never have been enabled. Sending a disable instruction to
>>     a queue that the hardware just told you is in a bad state (CHECKSTOPPED,
>>     DECONFIGURED, Q_NOT_AVAIL) is at best wasted work and at worst generates
>>     a further WARN_ONCE from inside vfio_ap_irq_disable's own default.
>>
>> 3. The hardware just rejected the new ap_aqic() enable attempt with an
>>     unexpected status. Disabling a previously-working IRQ config - assuming
>>     that is even possible - as a reaction to a failed enable attempt does
>>     not make sense; it is actively destructive, tearing down something that
>>     was working for no valid reason.
>>
>> The fix is to unregister the NISC and an unpin the NIB in the default case
>> of the switch statement.
>>
>> Fixes: ec89b55e3bce7 ("s390: ap: implement PAPQ AQIC interception in kernel")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 940c0ff668be..a46bf381ab72 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -503,9 +503,14 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
>>   		vfio_unpin_pages(&q->matrix_mdev->vdev, nib, 1);
>>   		break;
>>   	default:
>> -		pr_warn("%s: apqn %04x: response: %02x\n", __func__, q->apqn,
>> -			status.response_code);
>> -		vfio_ap_irq_disable(q);
>> +		pr_warn("%s: PQAP(AQIC) failed with response code %02x for apqn %04x\n",
>> +			__func__, status.response_code, q->apqn);
> LGTM, except Sashiko mentions the pr_warn here that you are updating has
> a pre-existing issue.
>
> Since you're touching it already, do you think it makes sense to switch
> to pr_warn_ratelimited with this patch?

Since this is a pre-existing problem not introduced with this patch and 
there is
likewise another related problem not introduced by this patch, I am 
going to
post a separated series with fixes to those two related issues.

>
>> +		/* We could not modify IRQ settings: clear new configuration */
>> +		ret = kvm_s390_gisc_unregister(kvm, isc);
>> +		if (ret)
>> +			VFIO_AP_DBF_WARN("%s: kvm_s390_gisc_unregister: rc=%d isc=%d, apqn=%#04x\n",
>> +					 __func__, ret, isc, q->apqn);
>> +		vfio_unpin_pages(&q->matrix_mdev->vdev, nib, 1);
>>   		break;
>>   	}
>>   

