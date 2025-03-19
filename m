Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5732B1E22E6
	for <linux-s390@vger.kernel.org>; Wed, 19 Mar 2025 17:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742407092; cv=none; b=P1eeFbzbWNmhq749ZSlhvQpYStxpS+NY9lvajBbt/SW2MRY7OzElXlgghoYJHpjLhAwRXFXiGHfanvtFgwr9e3goTBg7q1KxkAKu391VH4t0Fvnu0RglBk5mNgPSZE9LS/mV2zjdrxY+ltS4hPuSwus4lgydPG2Jyz5n6RqATjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742407092; c=relaxed/simple;
	bh=2rYKRnyJ0vATLT6O48YpB9OJVDRDF/jiVUO+XjGZ6gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=np1bBqLKszcb89GTYpmnwSUDC4p10Oda8WLnEa/kjPJj3b0tvcUxj6x6U9bguVxiCFgzRFX5fQoN82ly6jF4ZAvMVOUXC3zja5ITxKfFXsGXgbnlEk7ierFBC0gjnWpYsW24c4+ro9B4X9lFpmL26C1WYjUcACn6l6MU6K5ZKzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NBAmnKaV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NBAmnKaV"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JE3BL2027105;
	Wed, 19 Mar 2025 17:58:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vtU+Qh
	wBm8pkbVX74y9Pz63GnFTkQ4/j9kmvX/esj+M=; b=NBAmnKaVnAfRUQwFdC5KuG
	z/HIaMhj7+PLhQPdaDUXQUHWkfRBlJ3pUH5ex7eebbF16I9uMh/7qGZz2Ur6Qqr6
	cY8hITZ9mzxY+iMprsKGt5zxczuvif0LPLWjswXo9dd0pwyiDXzFA5CLT2eOgGPU
	oHt6KsrTM57kLeGHkyt40WTaQ8pck9RGW4lK7ybqgi10jciuwk7UgKTUoRSPV/od
	0b+xaSrEm+FpTdn0+9WX+tCQH+4owTx4g4N6VRcauxU4QAfBLcggcIEh6tW5gp/3
	zCAT8AjsCvSieySYjQCMLK1LKd3ZXMVgjca00wN7atk8o8JuSwfHQtHCS65ZO+zg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45fybps9me-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 17:58:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52JGAsfX012451;
	Wed, 19 Mar 2025 17:58:07 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dmvp30e9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 17:58:07 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52JHw3eB58655146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 17:58:04 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4A1820043;
	Wed, 19 Mar 2025 17:58:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6865B20040;
	Wed, 19 Mar 2025 17:58:03 +0000 (GMT)
Received: from [9.171.26.40] (unknown [9.171.26.40])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Mar 2025 17:58:03 +0000 (GMT)
Message-ID: <2fb000bd-1764-4fef-9d6b-fa1ee705da6b@linux.ibm.com>
Date: Wed, 19 Mar 2025 18:58:02 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/20] s390/zcrypt/pkey: Rework cca findcard()
 implementation and callers
To: Harald Freudenberger <freude@linux.ibm.com>, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
References: <20250304172116.85374-1-freude@linux.ibm.com>
 <20250304172116.85374-11-freude@linux.ibm.com>
Content-Language: en-US
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250304172116.85374-11-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AHKefGLX9qU-FuZX3mZoUabKb5dyMddw
X-Proofpoint-GUID: AHKefGLX9qU-FuZX3mZoUabKb5dyMddw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_06,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=802
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 impostorscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503190121

On 04/03/2025 18:21, Harald Freudenberger wrote:
> Rework the memory usage of the cca findcard() implementation:
> - findcard does not allocate memory for the list of apqns
>   any more.
> - the callers are now responsible to provide an array of
>   apqns to store the matching apqns into.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

See my comments below.

> ---
>  drivers/s390/crypto/pkey_cca.c       | 25 +++++++++++--------------
>  drivers/s390/crypto/zcrypt_ccamisc.c | 18 ++++--------------
>  drivers/s390/crypto/zcrypt_ccamisc.h | 12 +++++-------
>  3 files changed, 20 insertions(+), 35 deletions(-)
> 
[...]
> diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
> index 65b4cdb9b478..d3b093dcdf30 100644
> --- a/drivers/s390/crypto/zcrypt_ccamisc.c
> +++ b/drivers/s390/crypto/zcrypt_ccamisc.c
[...]
> @@ -2006,17 +1999,14 @@ int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
>  				continue;
>  		}
>  		/* apqn passed all filtering criterons, add to the array */
> -		if (_nr_apqns < 256)
> -			_apqns[_nr_apqns++] = (((u16)card) << 16) | ((u16)dom);
> +		if (_nr_apqns < *nr_apqns)
> +			apqns[_nr_apqns++] = (((u16)card) << 16) | ((u16)dom);
>  	}
>  
>  	/* nothing found ? */
>  	if (!_nr_apqns) {
> -		kfree(_apqns);
>  		rc = -ENODEV;

In my opinion, the -ENODEV return value can be completely dropped. For the caller it should be sufficient to check for nr_apqns == 0.

>  	} else {
> -		/* no re-allocation, simple return the _apqns array */
> -		*apqns = _apqns;
>  		*nr_apqns = _nr_apqns;

Please update *nr_apqns unconditionally.

>  		rc = 0;
>  	}
> diff --git a/drivers/s390/crypto/zcrypt_ccamisc.h b/drivers/s390/crypto/zcrypt_ccamisc.h
> index 273edf2bb036..bed647a42eb2 100644
> --- a/drivers/s390/crypto/zcrypt_ccamisc.h
> +++ b/drivers/s390/crypto/zcrypt_ccamisc.h
> @@ -229,14 +229,12 @@ int cca_findcard(const u8 *key, u16 *pcardnr, u16 *pdomain, int verify);
>   *   cur_mkvp or old_mkvp values of the apqn are used.
>   * The mktype determines which set of master keys to use:
>   *   0 = AES_MK_SET - AES MK set, 1 = APKA MK_SET - APKA MK set
> - * The array of apqn entries is allocated with kmalloc and returned in *apqns;
> - * the number of apqns stored into the list is returned in *nr_apqns. One apqn
> - * entry is simple a 32 bit value with 16 bit cardnr and 16 bit domain nr and
> - * may be casted to struct pkey_apqn. The return value is either 0 for success
> - * or a negative errno value. If no apqn meeting the criteria is found,
> - * -ENODEV is returned.
> + * The caller should set *nr_apqns to the nr of elements available in *apqns.
> + * On return *nr_apqns is then updated with the nr of apqns filled into *apqns.
> + * The return value is either 0 for success or a negative errno value.
> + * If no apqn meeting the criteria is found, -ENODEV is returned.

Why not just return nr_apqns == 0 to indicate, that no matching device has been found? Anyhow, even if you would stay with the -ENODEV return value, *nr_apqns should be updated in any case.

>   */
> -int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
> +int cca_findcard2(u32 *apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
>  		  int minhwtype, int mktype, u64 cur_mkvp, u64 old_mkvp,
>  		  int verify);
>  

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

