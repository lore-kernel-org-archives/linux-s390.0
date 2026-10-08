Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CDD22157B
	for <linux-s390@vger.kernel.org>; Thu,  8 Oct 2026 07:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791444044; cv=none; b=OGRUGHZ662lNQ3H8C45wpR/LdDxcG7zVpYwbADxPs4Wo14zN7Hqe7ZQDSOLy+bw6lfmFU5HFTWidbrreR4Ywh5HPHlYFTAwhEhlaWvSOdOeO9194apH/MNrdIIEYIrK7TL1jKKH1uB8eIBLfTadVfYx1BNZrN9PeqKix3O90LBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791444044; c=relaxed/simple;
	bh=mYK/JvBPUhzwABc/U2un/FCEUwQxG2LMD3Ymiishhbo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=TiYipQSPMpD6SJCwKfoVGaxAvVeWsEF1UK5K95/cjiryN4iTyW98LE4mXDg87baMdQv7S6rRR6wm1Up65HM05JRG7kevBp9+wDfhVm67qTBseBWBZcprjEvxzFD+MGVz1mnu5Kd7CcG2hgoO4tRrAyJXROmojl/GEoI4oQPbhx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TjbwvwAi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TjbwvwAi"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6984ZVJZ317602
	for <linux-s390@vger.kernel.org>; Thu, 8 Oct 2026 07:20:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=CTFZ9Vcu0TwrLn/6xS6aCJ88UosbRpDv02U9uesWMDY=; b=TjbwvwAit7Zt
	ApkpDhkVElkVFDNGjJjpvYje/H4/Z9eSQSaiuhN7NF1TcDK4vjaDK1xVDyIkPU+N
	hmKyNBN57F287m49oLdCRi+33CIi41IhQt1KXgFpW5bRU3ZkA9wLAIK66XPfadHT
	8dzNkwf71oEEXHDzbnbF2DX9EauqClE2DfCGxvrIoipTYjD0A9hljbyXq1662LWT
	DRUVZK7C+0q7tSQK+zPbJAh7bYwrxCcRBPNXd3cGv7XI+cVFpbwRICG5eyvM9aYd
	xv8Lf5qB91LyDCZ3q+DAb0r+wtYJWRj/YEMNZstDp3wzOhi9mtaX203Zg+fU2Hy3
	6WWqixBmbg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjva34f-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 08 Oct 2026 07:20:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6984WMUj2915420
	for <linux-s390@vger.kernel.org>; Thu, 8 Oct 2026 07:20:41 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h5s34tvc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 08 Oct 2026 07:20:41 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6987KdYU15598102
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Oct 2026 07:20:40 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFD2B5805C;
	Thu,  8 Oct 2026 07:20:39 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 863395805E;
	Thu,  8 Oct 2026 07:20:39 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Oct 2026 07:20:39 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 08 Oct 2026 09:20:39 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Finn Callies <fcallies@linux.ibm.com>
Cc: dengler@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>
Subject: Re: [PATCH v2] s390/ap: Support new APMLM field with PQAP/TAPQ
 instruction
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <214462b0-6ea1-4153-951e-8d583224a79e@linux.ibm.com>
References: <20261006145823.8421-1-freude@linux.ibm.com>
 <214462b0-6ea1-4153-951e-8d583224a79e@linux.ibm.com>
Message-ID: <6f8cf61a084da5d7fbe540c36b3fe331@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: f8XRs9VS72EntkiPahxu0nqrhQ6dyJgV
X-Proofpoint-ORIG-GUID: f8XRs9VS72EntkiPahxu0nqrhQ6dyJgV
X-Authority-Analysis: v=2.4 cv=H8NOUOYi c=1 sm=1 tr=0 ts=6ac7444a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=iIjqj-nShx5EN4xQi_cA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAyOCBTYWx0ZWRfX99VmpZxGQGGH
 +H8sHmeZbgykpWnk1FpSOvIly7oeHiEU2Kcry7UE+Zp8kly21B7RS4DQn5qwg1FxqXtSOD9eGvF
 EVaVCAo5CllPAd/5ZcPEaTncaYBr9ssvaVm0Rl+e9XANeyVuUEEMSGgd0xWBRBwgbt19kr1vAce
 DyLDMylOPoNxSFpIw3NaekEQrk8k72NgDugxfq4c7vkwuHUbldEMV0DBI14AcyVlHmCz8z9dMq1
 vxa06NfSLypoAsqaZ9KQg9K6KKvQBUgsijLpCkEDHqnnJfSBVSp1Fhcl9fYhs2Lxn0sx4bf2GyU
 hWBEsGEiZ9GPdt4T3Xc3Flqj2H8iXLpaa7RhmZ2Zt538pBMHhsN29vxt4n+C3kbm6hlr1THdTAS
 fQWBKcedErEB+S8dVujjCQy8E5xJN7wkamv3YyPVw5d54H1TU+hRMEETI6RvTzBwdhntzNslHlZ
 5TWfenfz57dJep8jjsA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAyOCBTYWx0ZWRfX2ylV48BgeNd9
 IG7+Hcpr7GOAnc50r7TEF5oYyse3h4WvYlyzVq7sPQ3U8cgF6grk5ZlogIj2CeQx17KBDcSUOnH
 zzcySvWyboUGnSFXddpi9ir/YOoDr1I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_02,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080028

On 2026-10-07 16:05, Finn Callies wrote:
> On 06.10.26 16:58, Harald Freudenberger wrote:
>> There is a new field APMLM (AP message limit multiplier) defined
>> within the GR2 register on successful invocation of the TAPQ
>> subfunction for the PQAP instruction.
>> 
>> So the new formula to calculate the AP max message limit is now:
>> 
>>    if ml field <= 3
>>      AP max message limit is 12KB
>>    else
>>      AP max message limit = apml * (apmlm + 1) * 4KB
> 
> As per architecture it is more like:
> 
> if apml < 3 && apmlm == 0
> 	mapml = 12k
> else if apmlm == 0
> 	mapml = apml * 4k
this
> else if apml > 0
> 	mapml = apml * (apmlm + 1) * 4k
and this come to the same result.
And for ampl == 3 the formula results in 12KB,
> else
> 	// undefined
and this else is unreachable.
> 
> But yours is effectively the same.
Yep
> 
>> 
>> Also adapt the HWINFO mask to have this new apmlm field shine
>> through this bit filter mask.
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/ap.h    | 4 ++--
>>   drivers/s390/crypto/ap_bus.h  | 2 +-
>>   drivers/s390/crypto/ap_card.c | 3 ++-
>>   3 files changed, 5 insertions(+), 4 deletions(-)
>> 
>> diff --git a/arch/s390/include/asm/ap.h b/arch/s390/include/asm/ap.h
>> index c91b6ace199d..01d575c35887 100644
>> --- a/arch/s390/include/asm/ap.h
>> +++ b/arch/s390/include/asm/ap.h
>> @@ -123,8 +123,8 @@ struct ap_tapq_hwinfo {
>>   			unsigned int	   : 14;
>>   			unsigned int at	   :  8; /* ap type */
>>   			unsigned int nd	   :  8; /* nr of domains */
>> -			unsigned int	   :  4;
>> -			unsigned int ml	   :  4; /* apxl ml */
>> +			unsigned int mlm   :  4; /* AP msg limit multiplier */
>> +			unsigned int ml	   :  4; /* AP msg limit */
>>   			unsigned int	   :  3;
>>   			unsigned int qd	   :  5; /* queue depth */
>>   		};
>> diff --git a/drivers/s390/crypto/ap_bus.h 
>> b/drivers/s390/crypto/ap_bus.h
>> index fb4d678336e4..34f9dcd96bc7 100644
>> --- a/drivers/s390/crypto/ap_bus.h
>> +++ b/drivers/s390/crypto/ap_bus.h
>> @@ -181,7 +181,7 @@ struct ap_card {
>>   	bool chkstop;			/* checkstop state */
>>   };
>>   -#define TAPQ_CARD_HWINFO_MASK 0xFFFF0000FFFF0F1FUL
>> +#define TAPQ_CARD_HWINFO_MASK 0xFFFF0000FFFFFF1FUL
>>   #define ASSOC_IDX_INVALID 0x10000
>>     #define to_ap_card(x) container_of((x), struct ap_card, 
>> ap_dev.device)
>> diff --git a/drivers/s390/crypto/ap_card.c 
>> b/drivers/s390/crypto/ap_card.c
>> index c86397f4ddcd..e9a8180f08c2 100644
>> --- a/drivers/s390/crypto/ap_card.c
>> +++ b/drivers/s390/crypto/ap_card.c
>> @@ -242,7 +242,8 @@ struct ap_card *ap_card_create(int id, struct 
>> ap_tapq_hwinfo hwinfo,
>>   	ac->hwinfo = hwinfo;
>>   	ac->id = id;
>>   	ac->maxmsgsize = hwinfo.ml > 3 ?
>> -		hwinfo.ml * AP_TAPQ_ML_FIELD_CHUNK_SIZE : AP_DEFAULT_MAX_MSG_SIZE;
>> +		hwinfo.ml * (hwinfo.mlm + 1) * AP_TAPQ_ML_FIELD_CHUNK_SIZE :
>> +		AP_DEFAULT_MAX_MSG_SIZE;
>>     	return ac;
>>   }
> 
> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
> 
> Have you tested it with your qemu support or my mocking?

Still untested. I am about to test this in my qemu AP emulation soon.
