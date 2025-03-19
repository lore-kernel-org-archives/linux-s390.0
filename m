Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C73E19F103
	for <linux-s390@vger.kernel.org>; Wed, 19 Mar 2025 14:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394722; cv=none; b=nG+hRT/PQzISuXLHqqQEVUTlYYT9LI+d91LcTSAMR6DC77d9AviSH96W4JiyTVcfQusAoyFTYSglZ49q6eAj7VHH6ey6ZpJwMe1gMJS+PFgETE0mBCuzdhbWuvOgwIMqjacyLbiAEZ1yAoNPJVyATMU9f6nsisdMHfTqAbxddbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394722; c=relaxed/simple;
	bh=DVFqFJm0D2VoBhqHv6xnRkSoerA1Ucj9aFh1kaZlWrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zx1xdrtRJNSa4YJRjZFmSsJohzt23bZzHxuYl0fssTCgCrrdZhPTiaqiLLKN1DeH3gQD5QroyJ7/174Rt7h/w+gZvdXiCsq0APaxNHGIsN5P8i8VUk+33i211FVdrszycy1e6uIUXixt8uhFb1l2TRJq11Kpmk7378H4gjDi1O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H5smd1mD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H5smd1mD"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J9i4wK014721;
	Wed, 19 Mar 2025 14:31:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=X4njDJ
	kad/oYpNC8m4o1XetkWCpAML7P0BvdfUfEKNY=; b=H5smd1mD3iilR69gSYKANe
	4MGfYK5oNZoWRdonidPJULewYx0kHVbZTbNchGWKcmGKMJp/nFFQS0F09FPkjsss
	KuiLwoY8XuYZlArbvDJ/pM7H9ckgPyBx1htznVLD215wfXm0rB0tWeRrvMErJHEg
	8yfuEvuGv6YkEBxcPh5UUluBDOgeonhtoxCXF8LamEXJEq9UAKNId9Zuou5jeYM6
	ubUsmDnJ4xsSU6S8MnpXhYmpses2wSI1XuHYlMkfrbQlYntSF9xUMJRTjYg1kC+Y
	ULJmhyh73N4Z40lDNwyBDUufWAck+ShxEtwP/K2jy9m/JCE0BJe4LCe/hqBllE5w
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45fg0pvb9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 14:31:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52JCuEBE024417;
	Wed, 19 Mar 2025 14:31:55 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dncma0k9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 14:31:55 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52JEVpd546727550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 14:31:51 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3610B20043;
	Wed, 19 Mar 2025 14:31:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF6B22004F;
	Wed, 19 Mar 2025 14:31:50 +0000 (GMT)
Received: from [9.171.26.40] (unknown [9.171.26.40])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Mar 2025 14:31:50 +0000 (GMT)
Message-ID: <887dc169-e62e-4f52-ab29-20e9aa5a31c9@linux.ibm.com>
Date: Wed, 19 Mar 2025 15:31:50 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/20] s390/zcrypt: Introduce pre-allocated device
 status array for cca misc
To: Harald Freudenberger <freude@linux.ibm.com>, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
References: <20250304172116.85374-1-freude@linux.ibm.com>
 <20250304172116.85374-9-freude@linux.ibm.com>
Content-Language: de-DE
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250304172116.85374-9-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: E2X-10kg_xadYPFOrlUtxEESSJf558L1
X-Proofpoint-ORIG-GUID: E2X-10kg_xadYPFOrlUtxEESSJf558L1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_05,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503190098

On 04/03/2025 18:21, Harald Freudenberger wrote:
> Introduce a pre-allocated device status array memory together with
> a mutex controlling the occupation to be used by the two findcard()
> functions. Limit the device status array to max 128 cards and max

As far as I can see, cca_findcard() (and also the static findcard()) are no longer used. If this is the case, I would prefer to remove this unused variant, either in this patch (with a hint in the commit message) or in a separate one (in the order prior to this patch). 

> 128 domains to reduce the size of this pre-allocated memory to 64 KB.

I'm a bit unhappy about introducing a synchronization with this single piece of memory. 

> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>  drivers/s390/crypto/zcrypt_ccamisc.c | 78 +++++++++++++++++++---------
>  1 file changed, 53 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
> index 420895df70f0..65b4cdb9b478 100644
> --- a/drivers/s390/crypto/zcrypt_ccamisc.c
> +++ b/drivers/s390/crypto/zcrypt_ccamisc.c
[...]
> @@ -1801,21 +1817,20 @@ static int findcard(u64 mkvp, u16 *pcardnr, u16 *pdomain,

As mentioned above, please check for users of findcard() and cca_findcard(). If there are no users anymore, please remove the obsolete code.

[...]
> @@ -2023,11 +2041,21 @@ int __init zcrypt_ccamisc_init(void)
>  		cprb_mempool = NULL;
>  		return -ENOMEM;
>  	}
> +
> +	/* Pre-allocate one crypto status card struct used in findcard() */
> +	dev_status_mem = kvmalloc(ZCRYPT_DEV_STATUS_EXT_SIZE, GFP_KERNEL);

The alloc of dev_status_mem should be protected by the mutex as well.

> +	if (!dev_status_mem) {
> +		ZCRYPT_DBF_ERR("%s allocation of dev_status_mem failed\n", __func__);
> +		mempool_destroy(cprb_mempool);
> +		return -ENOMEM;
> +	}
> +
>  	return 0;
>  }
>  
>  void zcrypt_ccamisc_exit(void)
>  {
>  	mkvp_cache_free();
> +	kvfree(dev_status_mem);

Same here: please lock the mutex before releasing dev_status_mem.

>  	mempool_destroy(cprb_mempool);
>  }

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

