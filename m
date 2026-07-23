Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD03038C42B;
	Thu, 23 Jul 2026 16:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825744; cv=none; b=dciW20veT2Wm50Ym7MkocH5Dy0EhUzQ9mObNwilyX+RUsKFY98qE5Y1vECpiEx1jYh9ZN9dblwEHg0OYEAW7pa7zsquvMWqcerEgKo+MoletIdfdcJJDpRgotTXZLupY7pycKM5Z2UsYkhs3Ospuz3YCqKe+Eu1dMWxob2kFY3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825744; c=relaxed/simple;
	bh=nnzjNsHskpiYcXIZsVFRqqrZQ0h2OGyXhV2YoAMFrM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sRHabVF5bE0+vClT/vSLHPn5spzxW2M8QjbuftlFNeyD3jF7p6jzsx7e7HB5xAnOsrrbkV5wQM6YXjCOCGJQAA42mwGPUgBksZveRlxOR1ewjwRP2BCd90F0eXV+taXG6SwTvdUf38tl1gTtRJoF8HY9lr1C64YprxDr4ATcy7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TIgyfCIp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TIgyfCIp"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NDBjo91210615;
	Thu, 23 Jul 2026 16:55:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Tzexnk
	HwatoB7C6snXuNHibxeb9SL1oW1sO7bzxno0k=; b=TIgyfCIpHKDvRc19f/LmKi
	RcMWORSQJTlciMKyVDuDcHe7MY7//qePjpcp2YbS+d9xySt9BX8hDkclCv/kt5lg
	ygjbsKCLrWj3+xQ3J6E749T7LHClCfhyXkndsLYL0FXf6jNKda+6EJVK71moKb+0
	WSGFnLkcBolRPb/bfVDI+oA9tjzkKo8Omvk07Qa4+ZTe3vnaEfuNLww+A8VIw14s
	W6FAFFORkKXg5yWxPeKUQL/GYQRfCanIhMDLrm80SoaBwKC4U4VXbSvKsVobAY8Y
	cLMQQPLIGF74pMemLOfBIh8mIvhYLOSlKKmDrPg1KIB3vIyH/ymzOWs/fzEB61Mg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77arnpx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 16:55:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NGnkgo005384;
	Thu, 23 Jul 2026 16:55:40 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgymurg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 16:55:40 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NGtcCI31654404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 16:55:39 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC18258055;
	Thu, 23 Jul 2026 16:55:38 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5058358043;
	Thu, 23 Jul 2026 16:55:38 +0000 (GMT)
Received: from [9.61.254.118] (unknown [9.61.254.118])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 16:55:38 +0000 (GMT)
Message-ID: <7a92abbd-3a74-4409-9650-f001086e795f@linux.ibm.com>
Date: Thu, 23 Jul 2026 09:55:37 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] KVM: s390: pci: Fix resource leak on IRQ
 registration failure
To: Matthew Rosato <mjrosato@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@linux.ibm.com, farman@linux.ibm.com
References: <20260722170621.1686-1-alifm@linux.ibm.com>
 <20260722170621.1686-6-alifm@linux.ibm.com>
 <a0044314-5d84-413b-8912-b50907fa0964@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <a0044314-5d84-413b-8912-b50907fa0964@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: w-zXwwSlbBxx5vj7Rtq0MTWmA387axQn
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE2NCBTYWx0ZWRfX0tL5jZAfIBYA
 Rzauk/tFj50vTkjqYHJaBLYwVrwx9um6iePxcsyjGUj5wKDn9hzH7neZ0PjZZyMGAmROgcXPjtw
 f4zkMHI4RSyk2dsciCl60XytUPNm7JQ=
X-Proofpoint-GUID: w-zXwwSlbBxx5vj7Rtq0MTWmA387axQn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE2NCBTYWx0ZWRfX8tZD6vqOZ01v
 gn9lLjZZI+Ygbwjn4EsI50xJxQ7VZ6oCMy0g/P5lDX3BjfzXnI6Iq+gfoY+vPt9O7MYdRKCuEa4
 n3ivrXUUzSyMjoLTFqj+pCq8II+LzPYv6Msed12HjmhzI1Ng2snDoNVWbAM/ChRg8b3eBO8wQtM
 iVkBv7ZiNtk35/ckN2aQt2zqjn0TrP2Eu5ecYn1PzJb6HCZtdHa60cVnA0/a3x0hsVezeqzbICm
 DAyXP8FQPYuMfLQmcHcs44FBDp2ZCUeVUN2++48c44GcyfxQLlZdCjABvywlBp6NdIW6VaOqJt7
 wm69uE49yqXlIYreEiGCZi0PARrU35weTic0S0430+zfeRM70jMZMKi0vAAcjBoMtevFZ/BSOB0
 nRboHFpg0hdfMapfmj6aQfaVe6+Y6gCTFbO0cnihIaAhh6nT9jzdd+BSyfTBoH+/op5rJjzqt5t
 VH2Zu0c/Dg4UzkrU5sA==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a62478d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=2jDyJm2OrcYKjYkbmqkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230164


On 7/23/2026 8:19 AM, Matthew Rosato wrote:
> On 7/22/26 1:06 PM, Farhan Ali wrote:
>> Currently if kvm_zpci_set_airq() fails, kvm_s390_pci_aif_enable() returns
>> the error code but doesn't do any resource cleanup thus leaking resources.
> Nits: s/the/an/  ....  and 'resource cleanup, thus leaking' (add a comma)
>
>> Fix this by cleaning up all the resources such as the GAITE, AIBV, AISB and
>> unpinning any pinned pages.
>>
>> Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   arch/s390/kvm/pci.c | 29 +++++++++++++++++++++--------
>>   1 file changed, 21 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
>> index 231a4236fc3c..d76b2c5484ac 100644
>> --- a/arch/s390/kvm/pci.c
>> +++ b/arch/s390/kvm/pci.c
>> @@ -341,19 +341,32 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
>>   	aift->kzdev[zdev->aisb] = zdev->kzdev;
>>   	spin_unlock_irq(&aift->gait_lock);
>>   
>> -	/* Update guest FIB for re-issue */
>> -	fib->fmt0.aisbo = zdev->aisb & 63;
>> -	fib->fmt0.aisb = virt_to_phys(aift->sbv->vector) + (zdev->aisb / 64) * 8;
>> -	fib->fmt0.isc = gisc;
>> -
> OK, I had the same problem as Christian here.
>
> This is dead code because we don't re-use the fib, we make a new one in
> kvm_zpci_set_airq() and fill it with values from the kzdev.  Right?

Yes, this becomes unnecessary and actually overwriting the fib->fmt0.isc 
causes a reference count leak in the cleanup path as we use 
fib->fmt0.isc when calling kvm_s390_gisc_unregister().


>
> I agree adding something to the commit message to that effect would be
> good, even something like 'While at it, remove dead code that stored FIB
> values that were never referenced.'

Ack, will add that.


>
>>   	/* Save some guest fib values in the host for later use */
>> -	zdev->kzdev->fib.fmt0.isc = fib->fmt0.isc;
>> +	zdev->kzdev->fib.fmt0.isc = gisc;
>>   	zdev->kzdev->fib.fmt0.aibv = fib->fmt0.aibv;
>> -	mutex_unlock(&aift->aift_lock);
>>   
>>   	/* Issue the clp to setup the irq now */
>>   	rc = kvm_zpci_set_airq(zdev);
>> -	return rc;
>> +	if (!rc) {
>> +		mutex_unlock(&aift->aift_lock);
> This is subtle; we are now holding the aift_lock a bit longer now (over
> the MPCIFC re-issue) which I don't think is strictly necessary since we
> aren't messing with any of the zpci_aift fields during that timeframe,
> but I think is fine to do.  Maybe also worth a mention in the commit
> message that the lock is held a bit longer in order to handle the error
> case vs drop/re-acquire.

Yeah, will do. I agree, that its not strictly necessary just makes the 
code a little less messier having to drop and re-acquire. FWIW we also 
acquire the lock before doing a kvm_zpci_clear_airq() in the disable path.

Thanks

Farhan

>
> For the code itself:
>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
>
>> +		return rc;
>> +	}
>> +
>> +	/* Start cleanup */
>> +	zdev->kzdev->fib.fmt0.isc = 0;
>> +	zdev->kzdev->fib.fmt0.aibv = 0;
>> +
>> +	spin_lock_irq(&aift->gait_lock);
>> +	gaite->count--;
>> +	gaite->aisb = 0;
>> +	gaite->gisc = 0;
>> +	gaite->aisbo = 0;
>> +	gaite->gisa = 0;
>> +	aift->kzdev[zdev->aisb] = NULL;
>> +	spin_unlock_irq(&aift->gait_lock);
>> +
>> +	airq_iv_release(zdev->aibv);
>> +	zdev->aibv = NULL;
>>   
>>   free_aisb:
>>   	airq_iv_free_bit(aift->sbv, zdev->aisb);
