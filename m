Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF60313277;
	Tue, 25 Aug 2026 16:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787676289; cv=none; b=ajeXRrlzH57guTtCt3b/7mPsjoppJI4MR04HZUko3Yz6kb4PRNtOy+nM3cAKjE8IHO5ShOMOSVVw0flrFJ4aq79+yqcNNg8qqoALfciANjfWH/plZADOAIuvmdaPlH/7wao9C9WVJjk19tYaidM2IChu9NPprDyMjoHKvxwgiHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787676289; c=relaxed/simple;
	bh=ZD5f55GpiA+x6ovlG3Ilmw+iNQH4hpxWxI+/7DJp8hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pLBwiCrfo7R0KsfCZ0BtAC2zizbUlb/vcdq/UHtnTDsoFtzAhTcLJI1AsTY7qb/hxOMP7jlr6oZYjkj4EferM+SpRUB2oSoACIDbsTQCjdu3UH2OAlkWfx6VjMXA8Rf6J7diEBxaeU/pcTcSHrk85aOVHLG8GWx/CmPyL5GasMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E+4ZxeTd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E+4ZxeTd"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PEYXNO3461678;
	Tue, 25 Aug 2026 16:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=p7MisM
	6EHdZZJlZ+jksdnE0TRLat/nBOc2QmshVRUME=; b=E+4ZxeTd39v0FZvAh/icvF
	ai+RL0m2oSSXWuDok+Ui2P76a/5OuZarJ1UhgeWdvbRzrHFOQX1a4VU/uL/ccv0t
	djRRO+8NxBQQalw78jUCcifUYUSTqPeG1/OpkzOe+Y0xJSvS6HNSckXdgksUww4j
	SPnWST1dY7LDLGaS7P7z/Rf18HnYNcgwFnwAuKhGFmA5YDOrto4l6rF7JY650VWe
	yJCZG436RuTzw2dpPHYl64QhFuRgzjJLUpTiyKtkzLqjqHS6qxrZpkHvlxLm1+FM
	mgxiFYAmQ816FdnEk7qHCMxYPUplT4DB3DzHv38yc+eXzWRVhQfxV1oEucfgpi8w
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqsd3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 16:44:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67PGfOJ8003413;
	Tue, 25 Aug 2026 16:44:46 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7ragd2f2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 16:44:46 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67PGijhp58982794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Aug 2026 16:44:45 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14D7558055;
	Tue, 25 Aug 2026 16:44:45 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E2E15804B;
	Tue, 25 Aug 2026 16:44:44 +0000 (GMT)
Received: from [9.61.150.162] (unknown [9.61.150.162])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Aug 2026 16:44:44 +0000 (GMT)
Message-ID: <dfe22a19-49a0-413f-96e8-35fab4be1a84@linux.ibm.com>
Date: Tue, 25 Aug 2026 12:44:43 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] s390/vfio-ap: Fix leak of pinned NIB and
 registered NISC in vfio_ap_irq_enable()
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
References: <20260824215603.819379-1-akrowiak@linux.ibm.com>
 <20260824215603.819379-2-akrowiak@linux.ibm.com>
 <20260824220737.95C7C1F00A3A@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260824220737.95C7C1F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: alujLJKviTYLMthXsLI5gYj88kN8vcY-
X-Proofpoint-ORIG-GUID: alujLJKviTYLMthXsLI5gYj88kN8vcY-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE0MSBTYWx0ZWRfX1u4Hll8uLax/
 jDpoNzoCfm4z51EgnStQfnMHfmdx/3fJjMnaVs22qbCUGLtm+rvAd2zIe/lKS4cGpHSfuo2dKv9
 g1B45pvKEPWClTktJd1i8QDlqjjMGZmHyj7RSCKcV6FWeNs/EhTJNXnxvbYG0LPz8wAvydY5J/E
 IkrBR13rvjLunIzfhI4nF1J2hP8PcxmYPycyZPojYW3TzUGxUsJ9qnsZdnAIpLE2tMCAq+JzT6R
 0IKeSUrRPRrW9T1VlNbOpAGKYRQeILuA6WW7OZO3Kp/ZSBuUawDrtkg+dtINrnKAxgzjcVG/5YI
 a0wGHXrzi5i3wwH3CRU1F4pltxvPnpw0+8k46EyeuYhsKM6xaCZcF0slBZcpTRUAqR+zb3DJ3Pg
 l7QmuB5EDMuYzC0qiTEr1qurw1Luj8pWRq2NluNoxji7SafqXulTQTjsfVpssJkR3OaLoxvYqq7
 9V505u8p0MSTOw6QBKw==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8dc67f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=rwj9XuUJh5HgoYXlIQcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE0MSBTYWx0ZWRfX8nQzzV8EivT2
 5QiD7kFm/DP3yS9Z7aK5l7GUfFLjh1lP8V8EH4GrLLihC38JLa+YysCC/Wqb3W1ZdtO2p+UWyDB
 5K1hz270PvZs5X5+YvvdO8cWBjyOHeo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250141



On 8/24/26 6:07 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [Critical] Potential host memory corruption if `vfio_ap_irq_disable` times out while the hardware queue is busy.
> --
>
> --- Patch [1]: [PATCH v2 1/4] s390/vfio-ap: Fix leak of pinned NIB and registered NISC in vfio_ap_irq_enable() ---
> commit 85cfee5e61842e2a3b3b8993da6d14f25c2209a2
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: Fix leak of pinned NIB and registered NISC in vfio_ap_irq_enable()
>
> This commit fixes a resource leak in vfio_ap_irq_enable() by explicitly
> unregistering the NISC and unpinning the NIB in the default switch case,
> rather than relying on vfio_ap_irq_disable().
>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 940c0ff668bee..22a6ceaa7b562 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> [ ... ]
>
>> @@ -503,9 +503,12 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
>>   		vfio_unpin_pages(&q->matrix_mdev->vdev, nib, 1);
>>   		break;
>>   	default:
>> -		pr_warn("%s: apqn %04x: response: %02x\n", __func__, q->apqn,
>> -			status.response_code);
>> -		vfio_ap_irq_disable(q);
> [Severity: Critical]
> This isn't a bug introduced by this patch, but pre-exists in the
> vfio_ap_irq_disable() function that was previously called here.
>
> Can this lead to host memory corruption if vfio_ap_irq_disable() times out
> while the hardware queue is busy?
>
> If a guest repeatedly sends requests to keep the AP queue busy, then issues a
> PQAP(AQIC) instruction with the IR bit cleared (or unmaps memory),
> vfio_ap_irq_disable() is invoked. If the queue remains busy, ap_aqic() returns
> AP_RESPONSE_BUSY repeatedly.
>
> After retries, vfio_ap_irq_disable() falls through to end_free:
>
> drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_irq_disable() {
> 	...
> 	} while (retries--);
>
> 	WARN_ONCE(1, "%s: ap_aqic status %d\n", __func__,
> 		  status.response_code);
> end_free:
> 	vfio_ap_free_aqic_resources(q);
> }
>
> By unconditionally unpinning the NIB (Notification Indicator Byte) page via
> vfio_ap_free_aqic_resources() while the hardware still holds its address and
> expects to write to it, the page may be reallocated to another process.
>
> When the hardware eventually triggers an interrupt, wouldn't it perform a DMA
> write to this freed page, causing host memory corruption?

This is a valid concern and is similar to the problem fixed by this patch.
It was also introduced by the same patch identified in the Fixes: tag,
so I will add the fix for the issue pointed out above to this patch and
resubmit it.

>
>> +		/* We could not modify IRQ settings: clear new configuration */
>> +		ret = kvm_s390_gisc_unregister(kvm, isc);
>> +		if (ret)
>> +			VFIO_AP_DBF_WARN("%s: kvm_s390_gisc_unregister: rc=%d isc=%d, apqn=%#04x\n",
>> +					 __func__, ret, isc, q->apqn);
>> +		vfio_unpin_pages(&q->matrix_mdev->vdev, nib, 1);
>>   		break;
>>   	}

