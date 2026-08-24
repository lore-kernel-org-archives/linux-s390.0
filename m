Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA50E44684C;
	Mon, 24 Aug 2026 15:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585480; cv=none; b=UA3CBjvKqBWZF9XkNUmsMOJcaqGUchLCVx4RpP7XBoPqB0X5F3nseFFz6ecWxGRBPqGksJTTjq9ry2aS0JbLX3w/uXYq3GLFaA+2K3ezPXEnlzI1PZXF0wR43zkfR8XjSMdxvpVI0ELqBdriWLc9BW4U23KApyDw0b6g1i9t2OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585480; c=relaxed/simple;
	bh=02QD3ZQ96j67yphsUSPOpFX1YraqGBHdzwBA9ggD6tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p5CIkecYMWo8r5tOi+w4iZdfxWe9aYFiwNrJSR8weIX26s5oe5YQMujamZnZZsMpY7/UL0wYV3vObWsyycjGdTpB6VVcO13qXZvVhvHx462dm8PMi+K+uZnaKmfRrkrvGMYNsDZgTaSijguzYLPtWQ0G8CM7k7B/fUoZ5QWfqac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JNEgl6ih; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JNEgl6ih"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OD1k0A827102;
	Mon, 24 Aug 2026 15:31:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=g1yEZC
	LdgevlvdulBqeAYepqJyB3PXTnI3s+iJar6Ic=; b=JNEgl6ihqcSaiztcIkCtbj
	+B2aaE6QpPb19INAm/Oi+Dwa3G+GvLti6rh1hBS6pYU6XiCtLqeEGk6zxjC9dvN1
	MngiDifIBLB2G/8zgZZ7/S8trcskGWlFkx/fWybGBzHl/HhemkTGGVkCRFPM3Fo9
	K3XPhgMYbLXLXacEz7ulwvnKlm/JoXyBGZgs3NTX4LjNKjTsBxFrLcaMEQ6EHMqq
	V+XQTTYfYRqFTlxnPjETUbW/cJG6D/C7mZWO/1aCB+LMFQXq83UjrwHUzSjeAycw
	CAUl6BzJxpj1IwvqEVy2MwQqQQ0+KFONVwIt3XsOoJkIeVVcYRCPdjkncthM1U9A
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726eab4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 15:31:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OFQKQf011983;
	Mon, 24 Aug 2026 15:31:12 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkgxr4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 15:31:12 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OFVAW47668706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 15:31:10 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8285058051;
	Mon, 24 Aug 2026 15:31:10 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 562F25805C;
	Mon, 24 Aug 2026 15:31:09 +0000 (GMT)
Received: from [9.61.96.163] (unknown [9.61.96.163])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 15:31:09 +0000 (GMT)
Message-ID: <3a8470ce-8da8-4b1c-b703-47aac581e33c@linux.ibm.com>
Date: Mon, 24 Aug 2026 11:31:08 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 01/15] s390/vfio-ap: Provide function to get the number
 of queues assigned to mdev
To: "Jason J. Herne" <jjherne@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-2-akrowiak@linux.ibm.com>
 <abb3cf85-52da-4375-accd-287d5df98eb8@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <abb3cf85-52da-4375-accd-287d5df98eb8@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8c63c0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=XhlgcvxzY8LAHhgN2-0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyNiBTYWx0ZWRfX1/LXt3N+tAE8
 iq68IcPnPb+OEH1EXW0kfQ+fRSj7RGOw2ZbNX9MXG4E025cVV+RmaC3mxRiLD0XanWubuPDWTuo
 b0bAg347ulyH8qeS/HW4NzZreE73YCE=
X-Proofpoint-GUID: JvVwa83mHaIGexUSM2XUEdgZNCy_6DIi
X-Proofpoint-ORIG-GUID: JvVwa83mHaIGexUSM2XUEdgZNCy_6DIi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyNiBTYWx0ZWRfX8otxMH5rRmDD
 dl8QNi0IP4+UWb92sUlauF3ajPdaepxpG7B8NN8YZshUcC9FTMR7gUN9O4qk8mPLNhuNe/FNemw
 Z6BzkGLeMYv0nlujy/5HLPYpxPcKw+CHeGqdH7doPgPtBG5SNEHdTdSWs12fJZ0tXF5+lcHtBwI
 6gxtODvrEuHfq+WjO2PLSdV9fOCOup0tDCNBd3oQ64bWSkqAuC26LDtR+PwN9ymJoSXS1HqEYMe
 cSXv1CHlfwAl/5zIoDN3DHcl6RJjnFru1tgKckxm1eRtSM82vp4zxPgd0dPR93aHtK2HZVgES7U
 GWdSILjeJOd8OXAZ6MP70EWp41KpHP4n0vhPhOmerfoBb45ieXBlkP7h3nmVrzo2SEveT/mJ4HU
 Rv4sG4KiNEbTS2qOvAcd7f8cP3RiqDgLjyh8i13CBOXQ/PdJzC6h9bmlXFlQvVwtki0Dki9VRdO
 QPK/htzH1humvotv8WA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240126



On 8/10/26 9:14 AM, Jason J. Herne wrote:
> On 8/7/26 6:18 PM, Anthony Krowiak wrote:
>> Provides a function that returns the number of queues that are or 
>> will be
>> passed through to a guest when the mdev is attached to a guest.
>>
>> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c     | 8 ++++++++
>>   drivers/s390/crypto/vfio_ap_private.h | 2 ++
>>   2 files changed, 10 insertions(+)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c 
>> b/drivers/s390/crypto/vfio_ap_ops.c
>> index 44b3a1dcc1b3..36786d70a88f 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -2098,6 +2098,14 @@ static void vfio_ap_mdev_request(struct 
>> vfio_device *vdev, unsigned int count)
>>       release_update_locks_for_mdev(matrix_mdev);
>>   }
>>   +int vfio_ap_mdev_get_num_queues(struct ap_matrix *ap_matrix)
>> +{
>> +    lockdep_assert_held(&matrix_dev->mdevs_lock);
>> +
>> +    return bitmap_weight(ap_matrix->apm, AP_DEVICES) *
>> +           bitmap_weight(ap_matrix->aqm, AP_DOMAINS);
>> +}
>> +
> static inline unsigned int bitmap_weight(const unsigned long *src, 
> unsigned int nbits)
>
> bitmap_weight returns an unsigned int. I think 
> vfio_ap_mdev_get_num_queues should probably return an unsigned int 
> too, for maximum typw safety?

I'll make the change, thanks for the review.

>
> Other than that:
> Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
>
>
>

