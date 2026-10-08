Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D839387364;
	Thu,  8 Oct 2026 18:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791485049; cv=none; b=YQm6wjXXl7tQdtPXKqX9MvYrHPD+6j+KE9bCXljuBbGqv71OW1JmoNLowe5Yt9PjwFppsC2vpMskgDRi1pYMpziP2utxR80TMqAscCHwlV30J/P7/50uWjwM0/5BJ/v0MSF7fKMN2//LTK6doT7cIV3T4BMA3ntKt05RpmAHLSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791485049; c=relaxed/simple;
	bh=pk50AZgjxQG++wZtrt+R6ZuVGM66criJJbMnEGa9kAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KexLRHVO9Jkkv9AtRgcMWT0n+CtGxoNJd6R5OursC8uaUYTMuzmYPzv6M5Q8+q7ai7kAM2ywvGVyAKevUVTZymd6Hnc/kRRX4yoHS2OsRZNzp0yIddgNeF9pFPFq+cQmCypwgL0R+KMDYJI4fLsuLfyIccA6swgSXw6f++74p+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=emsSRPhd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="emsSRPhd"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698HZMNg197194;
	Thu, 8 Oct 2026 18:44:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HvFyZF
	Yocz88fiAeZZY1ekKOcuHLoFyCnTVbqPXReBE=; b=emsSRPhdPStxtlTiZNgtr3
	/Wl0APi310qn7FLYYwgGOVtgFeVmvc7BO95VRwMfOTEMW9j3cTmTuH75gIR/UU96
	mpSZKv2fhqPgA0Sc+Fw+8nhR7S0oJWTC2xiWzrMrPnf0pMa5SwOQiL24bl1VAbW9
	DaHZYY5vnXqJ/po8A0/JULuUtYv0vLHuUTi2Gi8dwOG2ingelLhd6KKwBKfXTQUt
	wD045fQPuR1fdEm5guCo8s219pwv1cDoQ+zcb2vI08KW0wiQo22dsq/Wn8hz7KoG
	6E/AgQE6UXaUxqvjZx90ZG1pXdinzmorVHsPTlq2bXXvDjhy+ZAkLJVnthw+niog
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjw5xud-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 18:44:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 698HWg5s3841836;
	Thu, 8 Oct 2026 18:44:06 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5a6drm4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 18:44:06 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 698Ii5sP24314610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Oct 2026 18:44:05 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3BAF58055;
	Thu,  8 Oct 2026 18:44:05 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A90358043;
	Thu,  8 Oct 2026 18:44:05 +0000 (GMT)
Received: from [9.61.89.182] (unknown [9.61.89.182])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Oct 2026 18:44:05 +0000 (GMT)
Message-ID: <c4e3e6ce-cca7-42a2-811f-efd86d0cb64e@linux.ibm.com>
Date: Thu, 8 Oct 2026 14:44:04 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/15] s390/vfio-ap: Callback to get/set vfio device
 mig state during guest migration
To: sashiko-reviews@lists.linux.dev
Cc: Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>, kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-6-akrowiak@linux.ibm.com>
 <20260807224505.4044C1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260807224505.4044C1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ui4176hctUmz4jYsoo57a20scVY7NHG5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA3NCBTYWx0ZWRfXwzflJRsZm15/
 C96DgBTDAghF1aa7KGD8RtwJwgs4zhgct+CmeL4f5QL2vMktaxphnn6Nqy1fCti3XyMcjNW/Ton
 R36kcDgU57baUnhuXf+C/ajrNOJFX7LSPHUWAJkgNgXc7VygnmmASkYimYLQJW9q8RHGt9pe5np
 wY25+QtMIdnCSxnUB6fZIG9cdQBfEp8DdfvbreJc6bLpfw2ep9bnTYVdyFblUOn8cDxGN/rO1ZU
 xUg/M7MI62uENd1aYtZILdkK9q3j44u3WXX0SIH8Ik5ozm0jtODJBTFQ9Duhr+eTdSPKAqhIv/i
 arB4vjFhxC/P5M6zZPYy/gXRaZFwJyr81fy/CGecsSFD8qwTyJWsyHu5YtjlZuxfMKd9RTkGvzL
 MHoCRfyx2VO654Ri472X/VgC44k7rD3r3bdySpF272g2UsJpHyeCnRjDdHFT5ZQOPJGqRuiPJXr
 GUOxfCQ/8qq3jhYY72w==
X-Authority-Analysis: v=2.4 cv=cIt1IVeN c=1 sm=1 tr=0 ts=6ac7e477 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=93MTjlJF_Fjf7oD1V5QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA3NCBTYWx0ZWRfXyOEuzvbXAISe
 VVZ2lu+JX57QcZdpmT0m+X7XZtiliYrHwdYhZUFChx5hEv9Sug4CJgwuBhGVg3ry0GEO3+JQ5zo
 AE42BEGhPKLrhoC18WkpknJnS4MGd8I=
X-Proofpoint-ORIG-GUID: ui4176hctUmz4jYsoo57a20scVY7NHG5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_06,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080074



On 8/7/26 6:45 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] vfio_ap_set_state falsely reports success when attempting to transition out of the VFIO_DEVICE_STATE_ERROR state.
> --
>
> --- Patch [5]: [PATCH v7 05/15] s390/vfio-ap: Callback to get/set vfio device mig state during guest migration ---
> commit 4d4bb0a626dab0e0e55ea92759151b23e4fe2cdf
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: Callback to get/set vfio device mig state during guest migration
>
> This commit implements two callbacks for the vfio-ap device related to its
> current migration state. It provides the mandatory callbacks to get and set
> the migration state during live migration of guests with pass-through access.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
>> index 1613813124b6f..af740b177c97c 100644
>> --- a/drivers/s390/crypto/vfio_ap_migration.c
>> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> [ ... ]
>
>> +static struct file *vfio_ap_set_state(struct vfio_device *vdev,
>> +				      enum vfio_device_mig_state  new_state)
>> +{
>> +	int ret;
>> +	struct file *filp = NULL;
>> +	struct ap_matrix_mdev *matrix_mdev;
> [ ... ]
>
>> +	while (mig_data->mig_state != VFIO_DEVICE_STATE_ERROR &&
>> +	       mig_data->mig_state != new_state) {
>> +		ret = vfio_mig_get_next_state(vdev, mig_data->mig_state,
>> +					      new_state, &next_state);
>> +		if (ret) {
>> +			filp = ERR_PTR(ret);
>> +			break;
>> +		}
>> +
>> +		filp = vfio_ap_transition_to_state(matrix_mdev, next_state);
>> +		if (IS_ERR(filp))
>> +			break;
>> +
>> +		mig_data->mig_state = next_state;
>> +
>> +		if (WARN_ON(filp && new_state != next_state)) {
>> +			fput(filp);
>> +			filp = ERR_PTR(-EINVAL);
>> +			break;
>> +		}
>> +	}
>> +
>> +	mutex_unlock(&matrix_dev->mdevs_lock);
>> +
>> +	return filp;
> [Severity: High]
> If the device is already in VFIO_DEVICE_STATE_ERROR when vfio_ap_set_state()
> is called, the while loop condition evaluates to false and is skipped entirely.
>
> Since filp is initialized to NULL, does returning NULL here incorrectly
> signal a successful state transition to the VFIO core? Should an attempt to
> transition out of the error state return an explicit error pointer (such as
> ERR_PTR(-EIO)) instead to properly reject the transition?

An ERROR check after the transition loop in vfio_ap_set_state() will be
added: filp will be set to ERR_PTR(-EIO).

>
>> +}

