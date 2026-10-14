Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF1622126C;
	Wed, 14 Oct 2026 18:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792001261; cv=none; b=qEugUhCmWesyfu+3UA3HDlAS3e/HpjdzosqH2z4jEUE/1xiFJ0Hf5deZqqYWhJH6etI/9QitFLyCNTXFv+bDHqSh0uhOckqHCzWNv1m8Da6Tans5d8TjVYg++zEzaSdQyWZ5Noh+mXw5XuEIQYBBuKvE5R1HZ+9EzYutIxao+W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792001261; c=relaxed/simple;
	bh=wkwYdOr63f/JI40BoX+7nrxEE71cttreoT2BEs5UrNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bkGjOrwoI6fquWqEg46KhXbg2RaCruOG6/IyA9PWivCV5/Mw+ggVJLrl8QS+fy38NaK7luG8VGBLKu5hOMSe8UpaW+vKvsPfyHFsRKSAPU1Bpng/TKCQWhdkoFDxZwqHD2UD59Rfc3Jf9HxAC9Uj2U4uXvNhIzPQ9h3AMxY111I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JzSlUvF4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JzSlUvF4"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EEiW9W2466239;
	Wed, 14 Oct 2026 18:07:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=EmnPmx
	L3du/C+LbrJal3Gz4GJnbBp9tnF/99OsXjsqU=; b=JzSlUvF4IkXYX5k2l+HphV
	+/ddmyHahysCjaXQKg0pT7ticiTqmjutD2FYTBGGdpzfE2CxUO4dj3XDpNvAPqQp
	rfgiTJPyqJcOP6Vp4IlwZsOZtGlIs6K592LvtrCtBQ01YRXaqutWOROkU7hTMsSQ
	lobXpxf8SVyJubeXKXZ9tCv3idck86bxE0QG7OTInHeRHhQ1Gtt0pVRO8c2ZQLA0
	Dqo2/8i9h0num+t7U8lIQgtm/NWJxM+1AxiQtKGV3R195LIkg/gYh6jQiVwspRv0
	kk4I5e+MI3t0xD+gNzAd2ExNNtc6Mn7HfzpX2tFkVZj4dN2XnjIUHJwAf1ddWYTA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1wdck9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 18:07:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69EEbXwt702814;
	Wed, 14 Oct 2026 18:07:38 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h816h8j8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 18:07:38 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69EI7bT737552524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Oct 2026 18:07:37 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E3245805E;
	Wed, 14 Oct 2026 18:07:37 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C908758043;
	Wed, 14 Oct 2026 18:07:36 +0000 (GMT)
Received: from [9.61.132.24] (unknown [9.61.132.24])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Oct 2026 18:07:36 +0000 (GMT)
Message-ID: <52748d0e-0663-41f9-88dd-55fc4069a21f@linux.ibm.com>
Date: Wed, 14 Oct 2026 14:07:36 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 07/15] s390/vfio-ap: File ops called to save the vfio
 device migration state
To: sashiko-reviews@lists.linux.dev, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20261013153219.3534306-1-akrowiak@linux.ibm.com>
 <20261013153219.3534306-8-akrowiak@linux.ibm.com>
 <sashiko-outbox-170075@kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <sashiko-outbox-170075@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3MCBTYWx0ZWRfX+WKw2FFn68Ll
 0BSgk0jYO0s3RrPbdOaWna/TyGpYQqdH+u2CThJiI+jqlwoNEzk3BcbTB7ba2YWe0pBYgqqmlwy
 W5e8ScPRTe2MJ/n9k4JhjKMyE1NlGqM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3MCBTYWx0ZWRfX6Pc7dx9rP/HS
 f32QtFkdENEbzoS6//MtQYHmStzjaiuRu4KwQMC8aCfehlaKzMXM68GUiXP8t8oXJaIZq48/rl2
 d37GwwUxD64evt8hfDh+pmKsl6QnIl5lwCuYDp3TzyqHZ6ZE0GNvOGDi3+vc+9DK9RbJ1cOCfVh
 lw3J/HvXUTbpjtZl6x72Wn/dEQVbG5YURmc9Cr+4Be8EnrKN5ZbIkfx+DxFKERSy91BfSRnKhyk
 0EDLZqrSU8kzLbowxclx96pX5HsjeQzB/nwV82IX8cJrVJfBWIPqpPcsSSF6o8N5/7dvL7s+MvA
 k0kbkxqLOkbAMKW0LY34nhoAUeo6+z7FwuuPq425pqbmjBiMTiyf+HEB+ffe8ZaYuS84kZGU3N3
 q7xJ5/lhrUkKqBmz0DC/e4AKR30Buxdvk/zMQEcPOi8uA5RS7VjI2F4ni2laa0+wgNAGPBJfeI1
 tX4CACozZe9IOPh+fkQ==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6acfc4eb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=3NBx8cYGc2a4fi9obEEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: STe2AfDGdELOL2q9GSngJlf-Eo1n-x5V
X-Proofpoint-GUID: STe2AfDGdELOL2q9GSngJlf-Eo1n-x5V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140070



On 10/13/26 11:59 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] s390/vfio-ap: Undefined hardware state is used when TAPQ returns an async error
> --
>
> commit 449bfb4f03a8737bf9d26180f1c9b9cb38b82556
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: File ops called to save the vfio device migration state
>
> This commit implements the read callback function to save the state of the
> vfio-ap device during migration. It copies the guest's AP configuration
> information, including queue hardware information, to userspace.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
>> index bbd007c06a776..cf3f95e2846cb 100644
>> --- a/drivers/s390/crypto/vfio_ap_migration.c
>> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> [ ... ]
>> +static int get_hardware_info_for_queue(const char *mdev_name,
>> +				       struct ap_tapq_hwinfo *hwinfo,
>> +				       unsigned long apqn)
>> +{
>> +	struct ap_queue_status status;
>> +
>> +	status = ap_tapq(apqn, hwinfo);
>> +
>> +	switch (status.response_code) {
>> +	case AP_RESPONSE_NORMAL:
> [ ... ]
>> +	default:
>> +		/*
>> +		 * Without a pending async error, the tapq info should be
>> +		 * available
>> +		 */
>> +		if (status.async)
>> +			return 0;
> [Severity: Medium]
> When the ap_tapq function returns with an async error (status.async == 1),
> both the response code and the hardware information returned in general
> register 2 (hwinfo->value) are undefined.
>
> Since we return 0 (success) here, does this cause the caller to save garbage
> data into the migration stream?
>
> Looking at the caller:
>
> vfio_ap_store_queue_info()
>      ret = get_hardware_info_for_queue(..., &source_hwinfo, ...);
>      if (ret)
>          return ret;
>      ap_config->qinfo[num_queues].data = source_hwinfo.value;
>
> If get_hardware_info_for_queue returns 0 when status.async is true,
> source_hwinfo.value could contain uninitialized data that is then stored into
> the ap_config and migrated to userspace.
>
> Should this return an error when an async error is pending so that we don't
> migrate uninitialized state data to the destination host?

RE-examining this function, the conclusion I draw is that it is faulty.
For response codes 1,2,3,4, 0x35 and 0x36, all but the response code
is set to 0, so those queues can't be passed through. For
VFIO_AP_RESPONSE_BUSY and VFIO_AP_RESPONSE_RESET_IN_PROGRESS,
TAPQ ought to be re-executed; that must be bound for a number of
tries with a sleep in between tries.


>
>> +
>> +		pr_err_ratelimited("vfio_ap_mdev %s:Failed to get hwinfo for queue %02lx.%04lx: TAPQ rc=%d",
>> +				   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn),
>> +				   status.response_code);
>> +		return -EIO;
>> +	}
>> +}
> [ ... ]
>

