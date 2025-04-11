Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC49A1B7F4
	for <linux-s390@vger.kernel.org>; Fri, 11 Apr 2025 13:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744376805; cv=none; b=q33KjUs4GlsevOj7u4IBkrrfBa3VfbxOadiOS1bokQvXQKNb023g1qLIr0ZTXClu1erAtuXF1rHf22oB4v0p2MHknkMIQd3agolmTZH5Gtb1bhbUAGyb/pO38ogqVpEoapupnNKCrEPgY/0nt14DD62WV351yFq0x/y8WIHRp98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744376805; c=relaxed/simple;
	bh=81BUyKhpRQob6BGsK+0o/XamrKjDRxEu7J20GjGKzQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XaGAmHqCw0pg9+Y3eVqtJaPvEX7jOqJDJibzN6gbDT3XFMhNhdKCz25FRa3mpUmfQ5uiGpNMCvrytQrSBJG0r+W34ZEDbgr7Eg9Ab5ZaY5pgk5q+EzZZJPTASM+DlTIaeOp3ZBPWHkFUc7pF0nWZ8zffSYaBLPFfTVSONcvNYk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cv/Tt9WL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cv/Tt9WL"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B9YX04015515;
	Fri, 11 Apr 2025 13:06:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Op+Q63
	3tvWDVe9hBgQkElWzq5dZQBa8A+IoAJx67NUI=; b=cv/Tt9WLGSEKi1Rc8L5cAz
	6qTVQqf5WSmI+51svp9jv4m8nkY4TUDAgAuKzheALZUptm9XM6/0qLjojgoN1Bwk
	AmITumKnlq3TaIj5W4B3ilyFMdfqD1lge5pz5vbPMhYbUKgGWG4gv+GFn4ECiiwE
	euV5goZlvBrPpKeAip5Gh7wpXIahLa/YONTDte/uf1vWZIEfzXqED+im0vXF6iHZ
	CC1f2DHlpk9EpHPM/qc3MdEWnnfBlDayHu5OD+kCdo9804ZY4DeQP5foDgvlYHfa
	tX1etmpDHGAUC8128N9QipLT1B7x8XS3YIALgOZ2XpisWjMYqcHM/Q4gYTdiaK5A
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45xn5qkm1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 13:06:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53BBUlv8018451;
	Fri, 11 Apr 2025 13:06:39 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45uh2m2w8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 13:06:39 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53BD6Z8d49742278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 13:06:35 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9951E20043;
	Fri, 11 Apr 2025 13:06:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE60220040;
	Fri, 11 Apr 2025 13:06:34 +0000 (GMT)
Received: from [9.171.54.209] (unknown [9.171.54.209])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Apr 2025 13:06:34 +0000 (GMT)
Message-ID: <c5458cf9-1de9-47b4-89c3-a49d36fa563e@linux.ibm.com>
Date: Fri, 11 Apr 2025 15:06:33 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/24] s390/zcrypt: Introduce pre-allocated device
 status array for cca misc
To: Harald Freudenberger <freude@linux.ibm.com>, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, seiden@linux.ibm.com,
        borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
References: <20250409140305.58900-1-freude@linux.ibm.com>
 <20250409140305.58900-10-freude@linux.ibm.com>
Content-Language: en-US
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250409140305.58900-10-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hywvf6VqE4eMpiytBHKFiQI-2ZeDN4vL
X-Proofpoint-GUID: hywvf6VqE4eMpiytBHKFiQI-2ZeDN4vL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 mlxscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110083

On 09/04/2025 16:02, Harald Freudenberger wrote:
> Introduce a pre-allocated device status array memory together with
> a mutex controlling the occupation to be used by the findcard2()
> function. Limit the device status array to max 128 cards and max
> 128 domains to reduce the size of this pre-allocated memory to 64 KB.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
> ---
>  drivers/s390/crypto/zcrypt_ccamisc.c | 49 ++++++++++++++++++++++------
>  1 file changed, 39 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
> index 0d3bf6b1fcb4..f2af3cb7a917 100644
> --- a/drivers/s390/crypto/zcrypt_ccamisc.c
> +++ b/drivers/s390/crypto/zcrypt_ccamisc.c
> @@ -51,6 +51,22 @@ static DEFINE_SPINLOCK(cca_info_list_lock);
>  #define CPRB_MEMPOOL_ITEM_SIZE (16 * 1024)
>  static mempool_t *cprb_mempool;
>  
> +/*
> + * This is a pre-allocated memory for the device status array
> + * used within the findcard() functions. It is currently

findcard() --> findcard2()?

> + * 128 * 128 * 4 bytes = 64 KB big. Usage of this memory is
> + * controlled via dev_status_mem_mutex. Needs adaption if more
> + * than 128 cards or domains to be are supported.
> + */
> +#define ZCRYPT_DEV_STATUS_CARD_MAX 128
> +#define ZCRYPT_DEV_STATUS_QUEUE_MAX 128
> +#define ZCRYPT_DEV_STATUS_ENTRIES (ZCRYPT_DEV_STATUS_CARD_MAX * \
> +				   ZCRYPT_DEV_STATUS_QUEUE_MAX)
> +#define ZCRYPT_DEV_STATUS_EXT_SIZE (ZCRYPT_DEV_STATUS_ENTRIES * \
> +		sizeof(struct zcrypt_device_status_ext))
> +static void *dev_status_mem;
> +static DEFINE_MUTEX(dev_status_mem_mutex);
> +
>  /*
>   * Simple check if the token is a valid CCA secure AES data key
>   * token. If keybitsize is given, the bitsize of the key is
[...]

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

