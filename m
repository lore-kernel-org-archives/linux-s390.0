Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D72B47F3C0
	for <linux-s390@vger.kernel.org>; Wed,  7 Oct 2026 14:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791381934; cv=none; b=ZOb7eLsPpkh2J7Ff2qUGAqyF7iEDTYk3EXsVFMvwsTWayjRNAcSM047qRVI2g45TH0tkwnbT86Db9wHi8pGwvZGsNkbDWKmBxYTeXzxnjrW2yGqmPO/knssShFmjcDDogKbf8jI92ZuMO/jUuyKJDXi1QW+yT1SzAG+Ac/nR2k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791381934; c=relaxed/simple;
	bh=JBWT+x2TqO8cVvr0DocMazaiq5EnBShcH+rOPR4CQik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Otk0r/VVTGPUcA7VGpQlexWQwNBCksR8myf8J3UH1SYvshQQ17TKNd0VG5WJSDYi+wV6LebSt2CeMNuMG9a1HwHBRLgp/ip9WaMpxcW4kqIYX94dmVATGIyykYgXCW9jnY+bVXoo/raaBNzn5Ku7TI7Bn+o+ple8VnRXvaWLH+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ri1nGg9S; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ri1nGg9S"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697BZwsv597187
	for <linux-s390@vger.kernel.org>; Wed, 7 Oct 2026 14:05:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XHSIUJ
	3tYyV++S7YYRSphEu4cybI/Z8ViapVm+lvNXw=; b=ri1nGg9Sk6MOjavMKllxMJ
	R86j52WkJolL9Bi0TE23SjxQTwvUaMmgNbYcIngZx56/s7XKtcUsm8733EN4Oyqk
	t2HIbJrSELMOtp48CKhyxRGkYasL598vssWQNtgHUmUPzSl/jo5I0KRPAXTUCH3k
	8SN5stQjiYWyRkCElxsL9nEfC8y+BUepauAyf4UC8PAa9IliFAmjoquDqTb4u+57
	EMcJaFwmLaRyyOEF0C7fXz8w3ALtTuRhNYYkHqMYjn5fcUYu2+1K1EQjNWCEHc0e
	0fn94HoI8WYYDsPk5A1sI5E4uzH3YEbnYPUcVq4tFqcjojoQbe2KkJzbo2qD05Gw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2scrnt6a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 07 Oct 2026 14:05:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 697BWp0f1790031
	for <linux-s390@vger.kernel.org>; Wed, 7 Oct 2026 14:05:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h58d5k4m9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 07 Oct 2026 14:05:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697E5Ixj52560206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 14:05:18 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A57E2004B;
	Wed,  7 Oct 2026 14:05:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B242B2004D;
	Wed,  7 Oct 2026 14:05:17 +0000 (GMT)
Received: from [9.111.136.203] (unknown [9.111.136.203])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Oct 2026 14:05:17 +0000 (GMT)
Message-ID: <214462b0-6ea1-4153-951e-8d583224a79e@linux.ibm.com>
Date: Wed, 7 Oct 2026 16:05:17 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] s390/ap: Support new APMLM field with PQAP/TAPQ
 instruction
To: Harald Freudenberger <freude@linux.ibm.com>, dengler@linux.ibm.com
Cc: linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20261006145823.8421-1-freude@linux.ibm.com>
Content-Language: en-GB
From: Finn Callies <fcallies@linux.ibm.com>
In-Reply-To: <20261006145823.8421-1-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA1NiBTYWx0ZWRfX1FDJYCXmCq1E
 BlK/1FZ9QmvFJ5ulf9PNav/XVuKKCXqRoqHGY7zbQH+CxnxKRgTg+siXolWJrwSJy6ShgAIWz/s
 YzBIBzinxgBTLw4nYy0lJrDu3Z3TETQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA1NiBTYWx0ZWRfX0eDq0+sOazP4
 8ffRgCTAeYtWMSRYJAjnRinYJbZY0/hK26mGrQk5ZLJ/WQqrcduCchDYDJn+PcxZB816vqOm4uG
 1sbzPQloJ2FMvOgWk6D/QmvwBZpSZI8JbvoDlJBbIWLxK4twvYnPXzJjAEfkLxMB4Z4UtOMqvgx
 EZL0jzeki4wb4tSt6ltfena1BvHaWTMrFsLf0R90fgMeXlS3ZH+HQ2nhPbPK5f74tnh5mK1P2a4
 mjZoaXsve/oIKiRI7tzyxX43GQ4ODBKGc/berYb/jH5LSGx1zyyXCOjeIzuEozpKzo2C5PlMexg
 GvlZzY5p6bBRm6rhQ+4e7OsvYiosdjnxZT2i6Jil5M5p/iMWlF88gey0s60hE9b50lenR2sL/eB
 pVTlc8LljOdqIHZ/exZVTXbF0AkYfT8ZFfxjfdpLr2DKhc/8zuwbHgVyVZb4F/0HBg3rEo4IzAc
 cCtT1Q4IO/WjS++UJRw==
X-Proofpoint-GUID: 76nRRA1aYC4XqlH2t3MH-9wyDLMeCzJI
X-Proofpoint-ORIG-GUID: 76nRRA1aYC4XqlH2t3MH-9wyDLMeCzJI
X-Authority-Analysis: v=2.4 cv=B7osQ+tM c=1 sm=1 tr=0 ts=6ac651a3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=dawIu9V62vNEu_8xWewA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1011 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070056



On 06.10.26 16:58, Harald Freudenberger wrote:
> There is a new field APMLM (AP message limit multiplier) defined
> within the GR2 register on successful invocation of the TAPQ
> subfunction for the PQAP instruction.
> 
> So the new formula to calculate the AP max message limit is now:
> 
>    if ml field <= 3
>      AP max message limit is 12KB
>    else
>      AP max message limit = apml * (apmlm + 1) * 4KB

As per architecture it is more like:

if apml < 3 && apmlm == 0
	mapml = 12k
else if apmlm == 0
	mapml = apml * 4k
else if apml > 0
	mapml = apml * (apmlm + 1) * 4k
else
	// undefined

But yours is effectively the same.

> 
> Also adapt the HWINFO mask to have this new apmlm field shine
> through this bit filter mask.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>   arch/s390/include/asm/ap.h    | 4 ++--
>   drivers/s390/crypto/ap_bus.h  | 2 +-
>   drivers/s390/crypto/ap_card.c | 3 ++-
>   3 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/include/asm/ap.h b/arch/s390/include/asm/ap.h
> index c91b6ace199d..01d575c35887 100644
> --- a/arch/s390/include/asm/ap.h
> +++ b/arch/s390/include/asm/ap.h
> @@ -123,8 +123,8 @@ struct ap_tapq_hwinfo {
>   			unsigned int	   : 14;
>   			unsigned int at	   :  8; /* ap type */
>   			unsigned int nd	   :  8; /* nr of domains */
> -			unsigned int	   :  4;
> -			unsigned int ml	   :  4; /* apxl ml */
> +			unsigned int mlm   :  4; /* AP msg limit multiplier */
> +			unsigned int ml	   :  4; /* AP msg limit */
>   			unsigned int	   :  3;
>   			unsigned int qd	   :  5; /* queue depth */
>   		};
> diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
> index fb4d678336e4..34f9dcd96bc7 100644
> --- a/drivers/s390/crypto/ap_bus.h
> +++ b/drivers/s390/crypto/ap_bus.h
> @@ -181,7 +181,7 @@ struct ap_card {
>   	bool chkstop;			/* checkstop state */
>   };
>   
> -#define TAPQ_CARD_HWINFO_MASK 0xFFFF0000FFFF0F1FUL
> +#define TAPQ_CARD_HWINFO_MASK 0xFFFF0000FFFFFF1FUL
>   #define ASSOC_IDX_INVALID 0x10000
>   
>   #define to_ap_card(x) container_of((x), struct ap_card, ap_dev.device)
> diff --git a/drivers/s390/crypto/ap_card.c b/drivers/s390/crypto/ap_card.c
> index c86397f4ddcd..e9a8180f08c2 100644
> --- a/drivers/s390/crypto/ap_card.c
> +++ b/drivers/s390/crypto/ap_card.c
> @@ -242,7 +242,8 @@ struct ap_card *ap_card_create(int id, struct ap_tapq_hwinfo hwinfo,
>   	ac->hwinfo = hwinfo;
>   	ac->id = id;
>   	ac->maxmsgsize = hwinfo.ml > 3 ?
> -		hwinfo.ml * AP_TAPQ_ML_FIELD_CHUNK_SIZE : AP_DEFAULT_MAX_MSG_SIZE;
> +		hwinfo.ml * (hwinfo.mlm + 1) * AP_TAPQ_ML_FIELD_CHUNK_SIZE :
> +		AP_DEFAULT_MAX_MSG_SIZE;
>   
>   	return ac;
>   }

Reviewed-by: Finn Callies <fcallies@linux.ibm.com>

Have you tested it with your qemu support or my mocking?
