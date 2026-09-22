Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1641F55D887;
	Tue, 22 Sep 2026 14:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790087347; cv=none; b=O/JAhYhyUEe7VF63M+Wxnx3U7bC0ObvtGrsl45+WuIA7iAvc9fos5r616UF6pL8yjjvTmZY4aUq99ebjkkyynoqdv9sBEyaqX/MHscXUuBSiYBo5uGHVYtMm8NUROTDptv0JlQNqVD4baftAvjw4eVz/wbhvlSZzo3eKCi5LsMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790087347; c=relaxed/simple;
	bh=XrxCk65hl7n0FqqWmRGuFx3CHO/v2wAoD4VXvSGV4jQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nLDAVfdFACbQttt9XKMf9HoaG4EGXXqT9YUnUNSp+Z/rOY3p47hU8U+33gPBlZlK96zXvj3CqrJ8QI1uxs0WAxM277cZGacGvFT4PpEC1+InRQB/YEtZJwPnPk3m1ZTSNuJ7m1N6AXJsmQCbKBgAilpw6nyxRSqhQ3NqGdSsqiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kwJ67Q7k; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kwJ67Q7k"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MBa0Tg314617;
	Tue, 22 Sep 2026 14:29:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5BxkOh
	8Gm21eteZ26fD2JOwFEX4eZGVrtN5wncdOGeo=; b=kwJ67Q7kpBrowul3Wqc4hs
	mcWq+bvqKP3DGuYFGMNDHntjnD4ioBhWQQHWj2SbrFdPGDjCkvn0GN2dBcNEaC8K
	42FW+uyO6VKLuknyBfwpSTqGWxxirDuJYKwbh6O3K6fGqTo2Qj40SZmuNcI0LPD4
	qG6f0i2jDilud43UCZ6jyVjvATL4mFevEYxarW1jbxGRKz7tmjwqCfOvaguw8N3v
	1qHxuiBwiZMh/3iC57gFvV5oxS6HOfhSw2ebYNbPSyFzKRD86B9u7JJHj2eTqsqw
	Yo6kFaMBoY1/hJXYF3alS0hX8rIZYw2iTeP5kn5hyzjBKO6jQsgb7QcuwCUJxSjA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2e9tm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 14:29:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68MBWUEO2774587;
	Tue, 22 Sep 2026 14:29:04 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt53vj94w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 14:29:04 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68MET2UR8847972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Sep 2026 14:29:02 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 788695804B;
	Tue, 22 Sep 2026 14:29:02 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96B2B58059;
	Tue, 22 Sep 2026 14:29:01 +0000 (GMT)
Received: from [9.61.66.235] (unknown [9.61.66.235])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Sep 2026 14:29:01 +0000 (GMT)
Message-ID: <a0a5fbf4-829f-42bc-98f1-a8ee022b6c4b@linux.ibm.com>
Date: Tue, 22 Sep 2026 10:29:01 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/6] s390/vfio-ap: Fix leaks of pinned NIB and
 registered GISC
To: sashiko-reviews@lists.linux.dev
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>, kvm@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>
References: <20260904223531.1611088-1-akrowiak@linux.ibm.com>
 <20260904223531.1611088-2-akrowiak@linux.ibm.com>
 <20260904225127.A201D1F00A3E@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260904225127.A201D1F00A3E@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ByrIu9-Bbs4H4mMxBRHCI8XWR6Mu_eHd
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab290b1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=_Gr4TuwbsKNQjbsvYFgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDIwNSBTYWx0ZWRfX/bE+nfW/bv3j
 H4N2w5B3nsGEVQzlQOaMbEbrf96soVG45KAjD4esibbdkwCq94HXN4peM6MnoaeZfBgzrS6NNgK
 lPdL4K5NeVEGN3nmGTDcyu+zRYxgRsYFKZSohGSTmhft3JYwWvqQPwbcJpTgxz77E5CXM+EcYc2
 4ErQbi9dlKOC7BZd1SP/BAHyebPHCRpLMQ71ckjp1EeNl5aqhRu+V5Xs25UJhHEFdA6gpHzHh8R
 pHXCGwHLWtknbtxc9n4iErqHh4uGaCbPg9z5Xbe8FZJd+k+sskWRO34ZOqivE4vCylNSHvC8Xfv
 0AlFprYwFMowyjxZp16kMg2aL9n6trnzgEld+ii0E8OANgZqgKOdWnhDcRwobAF9dKw/VTrtcDQ
 Qmryg/J22s9VkBfesgTpl6wZOUEgZY0vDt2JmqUN81FWxEyqWDxdA0oNWbeUTB8OrEUa/eZStqp
 1QpqXbTCD54giocNvcg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDIwNSBTYWx0ZWRfX/3v0v2nDiCk2
 Brm3MQ0twZqrP/ys8V11WbMizgK6u0NCETlwk6QudlvGSp4T9pqAYAlh9krdXwHaDreJHOfMP+p
 BoN6Rkuh04lHsSLFLoSYXdhCI/HWX0w=
X-Proofpoint-GUID: ByrIu9-Bbs4H4mMxBRHCI8XWR6Mu_eHd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220205



On 9/4/26 6:51 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] Eagerly freeing AQIC resources when ap_zapq() or ap_tapq() returns an unrecognized response allows wild DMA writes to freed host memory.
> --
>
> commit 6c73d9ea4d311d5d68e8f5501374842cccbe2c90
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: Fix leaks of pinned NIB and registered GISC
>
> Several code paths in the vfio_ap driver failed to free the AQIC
> resources — the pinned guest NIB page and the registered guest ISC
> used to enable interrupts for a queue — when a queue became unavailable
> or when unexpected response codes were returned. This could cause memory
> exhaustion and depletion of KVM interrupt subclass registrations over time
> with repeated dynamic AP reconfiguration.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 940c0ff668bee..9d4f5b9e3301f 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> [ ... ]
>> @@ -1959,8 +2087,16 @@ static void apq_reset_check(struct work_struct *reset_work)
>>   		elapsed += AP_RESET_INTERVAL;
>>   		status = ap_tapq(q->apqn, NULL);
>>   		ret = apq_status_check(q->apqn, &status);
>> -		if (ret == -EIO)
>> +		if (ret == -EIO) {
>> +			/*
>> +			 * TAPQ returned an invalid response code. This
>> +			 * indicates a hardware or firmware bug; the queue
>> +			 * cannot generate AP interrupts or DMA-write to the
>> +			 * NIB, so free the AQIC resources rather than leak them.
>> +			 */
>> +			vfio_ap_free_aqic_resources(q);
>>   			return;
>> +		}
> [Severity: Critical]
> If apq_status_check() returns -EIO due to an unrecognized TAPQ response,
> is it safe to eagerly free the AQIC resources?
>
> If the hardware is in an unknown state (due to a bug or unrecognized code),
> could it still be actively DMA-writing to the pinned Notification Indicator
> Byte (NIB) page?
>
> If vfio_ap_free_aqic_resources() unpins the page and returns it to the
> system allocator, could a subsequent wild DMA write from the malfunctioning
> AP queue corrupt memory belonging to a new owner, potentially causing a host
> panic?

Since we don't know the state of the queue, the AQIC resources should be
intentionally leaked here lest the NIB page be re-allocated to another
process potentially resulting in a wild DMA-write.

>
> [ ... ]
>> @@ -1995,22 +2135,30 @@ static void vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
>>   	switch (status.response_code) {
>>   	case AP_RESPONSE_NORMAL:
>>   	case AP_RESPONSE_RESET_IN_PROGRESS:
>> -	case AP_RESPONSE_BUSY:
>>   	case AP_RESPONSE_STATE_CHANGE_IN_PROGRESS:
>>   		/*
>>   		 * Let's verify whether the ZAPQ completed successfully on a work queue.
>>   		 */
>>   		queue_work(system_long_wq, &q->reset_work);
>>   		break;
>> +	case AP_RESPONSE_Q_NOT_AVAIL:
>>   	case AP_RESPONSE_DECONFIGURED:
>>   	case AP_RESPONSE_CHECKSTOPPED:
>>   		vfio_ap_free_aqic_resources(q);
>>   		break;
>>   	default:
>> +		/*
>> +		 * The architecture defines only the response codes above as
>> +		 * valid for ZAPQ. Any other response code indicates a hardware
>> +		 * or firmware bug. Since a malfunctioning queue cannot generate
>> +		 * AP interrupts or DMA-write to the NIB, free the AQIC resources
>> +		 * rather than leak them.
>> +		 */
>>   		WARN(true,
>>   		     "PQAP/ZAPQ for %02x.%04x failed with invalid rc=%u\n",
>>   		     AP_QID_CARD(q->apqn), AP_QID_QUEUE(q->apqn),
>>   		     status.response_code);
>> +		vfio_ap_free_aqic_resources(q);
>>   	}
>>   }
> [Severity: Critical]
> Similarly, if ZAPQ fails with an unrecognized response code in
> vfio_ap_mdev_reset_queue(), does freeing the AQIC resources here present the
> same wild DMA risk?
>
> Even if a later patch in this series adds a retry loop that explicitly
> handles AP_RESPONSE_BUSY, does this default case still expose the host to
> memory corruption if any other unexpected response code is returned?

Same as the above response

>

