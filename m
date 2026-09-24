Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC3D242925;
	Thu, 24 Sep 2026 21:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790286433; cv=none; b=IWFfK43EIhKw5CzyWdtA8tjjT0ng/hpwDYs5oPIb5V/mxef/d3M4d346PXzzgVC4rPwY7nTXd3KRuaiFQ8uSKoRqG510WEYPRupI+YGb+k7wObiR5wtVOivls93eHlSwppH/e3bmI7+ePdoscsNZXxteASQ2iErHZ6jAaDMPSfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790286433; c=relaxed/simple;
	bh=By+orAmivfFph/4Pp4KGg0gf6vQlQvaRbFP78qt4u8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sTIGMB9VA87bUfu7EdYUEglPcJm6AWR0sKZIaInuOocPED0tU8YM3cqmhKUp8sgJMiq6zFuy1qArKe4vaXKKUx6LqO36Lj2boAgMmfs7wgFQLoJRNoxCfr5sIm+eBrngrsK+LM8iTAzBb8p791DhHnA0pXziyhyhc+dogVSXIw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aQp3cMP+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aQp3cMP+"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OJ5k0T3079487;
	Thu, 24 Sep 2026 21:47:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=r7jXVs
	RxYauBKt36pI/M7tRGg7/lUkj5oqapcJKREpE=; b=aQp3cMP+5E02tbAr5XZC3F
	5vQmWBSRrI+YnmESr2+XPk9KAb8X0/NpZWBvfxSBlinbbybFJOAa6jNUgxnnkqVw
	GAIbchv79xeRar2SmuarMPAR8sFhgdlMo7IaP1TSxrT/heS/FFIp19O3Hy4KtM2r
	Jfp1oEmxlaeD34bWQBBFvxj0Q1uyhPgMMvbTqawJrcUlSR14bk5ZP06tfd42fiZ0
	jzDvS4d/sVtX/xvB8agPcGsHkeVUMCPkdEk19RwrF+STB0BqmGQsbskLMUm+pTm+
	FQMIVMpvjLNJNzeokDgX6v1bNDkiXpyl9Mt0/gaOoveIKerP3Mo6j5f2bmyFBAqg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2uvn6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 21:47:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68OIlbaP2516022;
	Thu, 24 Sep 2026 21:47:09 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbu8yryr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 21:47:09 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68OLl8eQ24838714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 21:47:08 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 265915805A;
	Thu, 24 Sep 2026 21:47:08 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91E5F58052;
	Thu, 24 Sep 2026 21:47:07 +0000 (GMT)
Received: from [9.61.5.111] (unknown [9.61.5.111])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Sep 2026 21:47:07 +0000 (GMT)
Message-ID: <bb74e30c-ee6c-474e-b60c-f2f55928f49b@linux.ibm.com>
Date: Thu, 24 Sep 2026 17:47:07 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/6] s390/vfio-ap: fix queue state leakage to guest and
 host
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
References: <20260904223531.1611088-1-akrowiak@linux.ibm.com>
 <20260904223531.1611088-6-akrowiak@linux.ibm.com>
 <20260904224637.A2C711F00A3D@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260904224637.A2C711F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ck98XoivYAs1lshw2vz3zo3KlUOhM33e
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab59a5e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=OB2yBHD6Z5LEc4g70-sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA4OCBTYWx0ZWRfX/sJ59/R/KTos
 X4JGPIHjGf4suz3xq37YidnMsHSZTeIlfS7fM0HSvlxR3fBwSz30/WxMPoMscfkkVrPiAMEuMkP
 75p8G91IG0I+bKmczr6mudl0eLiaYmzcZj8kIpoc/ratvZefZUHMXkd6ldkHi97NpB+Z59CDlF2
 31x6cxqopwSAmHBazMnKGgJ02VrvqBZdd/hkSTvsSPF7FXsDN3MQPQpkL1kAdphIQFtiOYMLOmr
 MmC3swaHO+hj1trP4LsskL1dtyFb1qj2m1Ozubz8g3ILkCS4vL645Q967ksAVDToxHkwJI0pTDf
 2Qypk2CIru7mVXobe2cqDjs6q0KOj7OZi8c1ZV5shyKHnUAYy05bXbKBuGl4KwZJG1dMePqc52L
 C8xmKY1VzHye2TlmX6z6QT+79woIoTtT8RkRG3X6tJwPEodmHeAdfSR50hAZPAI75KLomVuFG8Z
 Q4aE4OQSSS4VNSQ6t2w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA4OCBTYWx0ZWRfX/STh3xfGRfh6
 CDE9Q78/4qNK77t4ACJWijnhTpAXwP/SFTJqdnjHt5L19SYPUVGuPZcZ6uLy4XbjNSQiZN/lt5i
 OrH+7hx9vuwCFa3JAwDgJEFw7I37zUI=
X-Proofpoint-GUID: ck98XoivYAs1lshw2vz3zo3KlUOhM33e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240088



On 9/4/26 6:46 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] A hardware error during queue reset circumvents the newly introduced security check, incorrectly marking a potentially un-zeroized queue as 'passable'.
> --
>
> commit 239f603c9ac4d1441b4d22a11bde0df9a2b5aa5c
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: fix queue state leakage to guest and host
>
> This commit introduces an upper bound on the wait time for a queue reset
> to complete and prevents the leakage of queue state to guests. It ensures
> zeroization is strictly confirmed by returning true in _queue_passable()
> only when the response code is AP_RESPONSE_NORMAL.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -785,14 +785,14 @@ static bool _queue_passable(struct vfio_ap_queue *q)
>>   	if (!q)
>>   		return false;
>>   
>> -	switch (q->reset_status.response_code) {
>> -	case AP_RESPONSE_NORMAL:
>> -	case AP_RESPONSE_DECONFIGURED:
>> -	case AP_RESPONSE_CHECKSTOPPED:
>> -		return true;
>> -	default:
>> -		return false;
>> -	}
>> +	/*
>> +	 * A queue is only passable if zeroization was confirmed by
>> +	 * apq_reset_check() via TAPQ status bit verification. This is
>> +	 * indicated by reset_status.response_code == AP_RESPONSE_NORMAL (0).
>> +	 * This is to protect against leaking the internal state of the queue
>> +	 * to the guest.
>> +	 */
>> +	return q->reset_status.response_code == AP_RESPONSE_NORMAL;
>>   }
> [ ... ]
>
>> @@ -2129,7 +2153,7 @@ static void apq_reset_check(struct work_struct *reset_work)
>>   			 */
>>   			vfio_ap_free_aqic_resources(q);
>>   			return;
> [Severity: High]
> This is a pre-existing issue, but does this error path leave
> q->reset_status.response_code set to AP_RESPONSE_NORMAL if a hardware or
> firmware fault occurs?
>
> When vfio_ap_mdev_reset_queue() successfully initiates a reset, ap_zapq()
> returns AP_RESPONSE_NORMAL (0), which is initially copied into
> q->reset_status.
>
> If ap_tapq() subsequently returns an invalid response code causing
> apq_status_check() to return -EIO, this workqueue function aborts and frees
> the AQIC resources. However, it exits without updating q->reset_status to a
> failure state.
>
> Because _queue_passable() now strictly checks for AP_RESPONSE_NORMAL, could
> this fail-open state result in an un-zeroized queue being incorrectly passed
> to an untrusted guest, leaking cryptographic key material?

This will be fixed in the next version.

>
>> -
>> +		}
>>   		if (elapsed >= AP_RESET_MAX_WAIT) {
>>   			/*
>>   			 * Zeroization confirmed (ret == 0): the TAPQ status bits
>> @@ -2143,8 +2167,10 @@ static void apq_reset_check(struct work_struct *reset_work)
>>   			 * queue cannot generate interrupts, so the NIB page is
>>   			 * no longer a DMA target and it is safe to free it.
>>   			 */

