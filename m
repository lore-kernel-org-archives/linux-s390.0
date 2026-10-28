Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793185114;
	b=w5hsFbOVM+Le1SmRb4PxfdQRScWHV063ckaDhfkj5I+CgZkPwiGJDOnr1Jg2kO3AkquL
	 SwBCiz6JFihRHhAJGBz0RRp6XeIintgbq1Wv3A3ZNm/5JutQA8K36yFX72ADzh3ZUrETa
	 IZp97SSQUgFjz6P1kY0uwKa7glNNTVhM8phC4VcIguHaGuem+cIHoVHh40zXPin2GfxjC
	 g3ELBq66cjKMCqQQNbLkwE4wufIWAir7sfKUE2TKf9tSStXsv1ICEu0KJaXkEOXSbNVJ5
	 UzyTFhH5qEZ4Azq/hF4JuuEh0VuImIqCKosw1zXXRg0Zz7o/KbINm/QB/HIV0V+278g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793185114;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=nAWaCIBXb8sbz/4QxX0Kt00aAcizBvDshZzCx9vXlgI=;
	b=vSaXfo2b3ccs5QtEoTljNdShxaaWacjOK4wQc1WeeR0fyYaYSWbmCrVmnkTXvf8Fk0Q7
	 EsazWblLsRCgav9xDaIvxOVfS5cJL7wDiipPqRCMz3AWghqod39doIHSZV/EnkwBGAVve
	 +rInsUT6fz06fiWR4jP9OPAPN/kdA573UG5C+rJEQ+/Gu10VpAmsU3cQ7yaS+/NMNdxvw
	 QMpv5aJ5dkfmRDrrWgKjYRGiuvpH35sTfsIOGkFxC/5PNvT7UAVsmDcb/jbTYOPM+GR5J
	 IDIMTXFga5ZURu1v14FnegcmU8iLq9+lzCSGcoB++YY+SARTlFhETqHsC2zQSlMPUgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="U3au0mm/";
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A39606A31C;
	Wed, 28 Oct 2026 10:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9A39606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=U3au0mm/
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S8i3j23339052;
	Wed, 28 Oct 2026 10:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nAWaCI
	BXb8sbz/4QxX0Kt00aAcizBvDshZzCx9vXlgI=; b=U3au0mm/8d4KUkd2eqGJQb
	AqTZvZWmCyN9wA0G6fMWdoW7DOzozmhLZzS/th9x/4Suc6CFpeKnPNmp/fuAWmyH
	WbSamBLoU9rFRsQMmRSHV8dgruB9s3Yfn7HYddqq5UZq2x9i48tlqAgDOUoazp9f
	ekmdZws6Xs3ICwEwlRuMlRTgPHE6WpiDxxKdQL3hBfOTLbviJDfT4oY0xavWvO9I
	nlZC1cQ5IK/03kTAYiAcdNtkNWwbspgR0APfOym54sj5w6tMpzuDDl6sA8+NrJFn
	zfBnWcuQhQmKyvZKsKWu4WHlQlj5C/m70+1xVgAUqFoassj4qu0iqVOvUBXOCYOA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmbt49pg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 10:58:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69S8Jtkf1274944;
	Wed, 28 Oct 2026 10:58:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hjsu7vuqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 10:58:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69SAwSTq40174046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Oct 2026 10:58:28 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43F3E20043;
	Wed, 28 Oct 2026 10:58:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0155920040;
	Wed, 28 Oct 2026 10:58:28 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.73.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Oct 2026 10:58:27 +0000 (GMT)
Message-ID: <034dc4fa-520b-4ad5-9d9d-8ae469692698@linux.ibm.com>
Date: Wed, 28 Oct 2026 11:58:27 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/10] s390/runtime-const: Serialize text patching with
 text_mutex
To: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20261027143030.3154657-1-hca@linux.ibm.com>
 <20261027143030.3154657-5-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261027143030.3154657-5-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA0MiBTYWx0ZWRfX3KJS99Prvmkw
 Lgj+6mpLsIuvjalrp21eXrjocFUiQ0pNzUonNLX2WPm+YuyE7GYm24rDgzDDd3E4s8NFOcau13b
 J5f7INyONdNF6W7IQtgR9bmNBz9JaeWK+yTriuV4p1WyZxp0AotYg3qxhgvUL/bOGHQoKVsQ4ZO
 r+qhmzpC668WVj1Fwwtg14rKhqZzkUGMwa6m8IhRbTySWRmeQaWu3S7KClNEw0W5athBZhmLn4P
 cJzjob1tN43vl90bf6mNDvoNu/Am0rm48JjV1iYNDDkaWjGPLkbczzUlGE78yQxAdqXhiwknCin
 aFBBn9kAGhqb643ALaPzJgNWLWoxPUNEp1amtZ6F3uuyBiEwb8sb9HLKktldl+Yz8rYQ12Md3Om
 KlMZJXXuexV17sXO7uXRKUCe3NO1UrwTGtyaSCAVx/C5V35hnRZ6gK1rzKl4hiUUYAvGG0vROXf
 x004yu/NETYVdcTTAcQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA0MiBTYWx0ZWRfX74Ec2bgR67uT
 joGPWI1EBlfGQcjTyRabXjeTeSH5okOgX+b4/plbIOCQXHNjY/MNQ4okmjQ+q6C5W6qbBFjZ6Mr
 fkRiV+ta5HuGl0qU13t0ZZaEC2A8pFU=
X-Proofpoint-ORIG-GUID: 16TztK2aCmwpkWkaQfk6aITMdzfRmcLT
X-Proofpoint-GUID: 16TztK2aCmwpkWkaQfk6aITMdzfRmcLT
X-Authority-Analysis: v=2.4 cv=CeKdd7rl c=1 sm=1 tr=0 ts=6ae1d558 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=VjvWslgL-g36twPfmkYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280042



On 10/27/26 15:30, Heiko Carstens wrote:
> Acquire text_mutex inside runtime_const_fixup() around the patching
> loop.
> 
> Serialization is not required for runtime_const_fixup(), however this is
> part of larger series where at the end s390_kernel_write() requires that
> callers hold text_mutex.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   arch/s390/include/asm/runtime-const.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/s390/include/asm/runtime-const.h b/arch/s390/include/asm/runtime-const.h
> index 7b71156031ec..0e2402717e8b 100644
> --- a/arch/s390/include/asm/runtime-const.h
> +++ b/arch/s390/include/asm/runtime-const.h
> @@ -3,6 +3,7 @@
>   #define _ASM_S390_RUNTIME_CONST_H
>   
>   #include <linux/uaccess.h>
> +#include <linux/memory.h>
>   
>   #define runtime_const_ptr(sym)					\
>   ({								\
> @@ -88,6 +89,7 @@ static inline void __runtime_fixup_mask(void *where, unsigned long val)
>   static inline void runtime_const_fixup(void (*fn)(void *, unsigned long),
>   				       unsigned long val, s32 *start, s32 *end)
>   {
> +	guard(mutex)(&text_mutex);
>   	while (start < end) {
>   		fn(*start + (void *)start, val);
>   		start++;

Interesting, so clang is able to propagate context even through indirect
calls without explicit annotations?


Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

