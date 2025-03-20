Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C083214A71
	for <linux-s390@vger.kernel.org>; Thu, 20 Mar 2025 08:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742459450; cv=none; b=hDXQWU9HosEwJuFv5fgcrAL8I82fhlaJcmeltK2M8+Al1/eUrTFztiTRJH/+dRcpN81p9yRjzz313uGNhZPG46/LvzlpFunfuFg2yoAA7ObJVuS0JQZQ3QGnVfAS0FYJciHFDmNaJKXlv5nu4xtXT12f9dtUc86xa2UfwY/pNJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742459450; c=relaxed/simple;
	bh=otMT2ukbDHJQp1f85sK+39qzQbmshXX/KlzTcX/ya8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HN8JR9vzl2slbOi9eWJFz6yumFj3D646yV3tuM458uRkMMh2iNDZw8/eTZ1D3O9eYSaVJ2ZpMDKLwMbs77mWIWe4KLfnPhtFd6kp1saZL5Op3DWca8gaEQFYWs6kvA94luTPTKALaNhjGPI7NDNZeKekEy+FXFKNL7w1UTX6obw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gx/LGjyl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gx/LGjyl"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K2AZre020653;
	Thu, 20 Mar 2025 08:30:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=N8APeP
	vxGQhjk+h4Q+3VPKvanOhyOKsJhpFOvCPxzc4=; b=gx/LGjyluGTFRZEIBBdUNK
	XtgKLNqqga85ougIsdGH2GIra3RF0kuG+6kEiQM2O/x417lgeNb5UB/dTqfrT92g
	pKpSYMn6uZFbPYsavZL7980V1UFJ/d0Dn1yhMVL0dFyYALfepWfXz2lRMW7Aeef4
	K8FKDvM8iUi6Fv41IjCAscdYffYleuPa1jnEuyvBZ0VFXdYZmDRs7j9x2gh2EWqd
	8HLqPsukZVAEW1ilUJzaSNlonhVRhRtOHj2T2M5MN6TNmwOY0q7QibrdHwgba3xR
	QFvX68/7eCGypwUqToLLau1pRMr2DbnasggwlBJa0O6Nr2hMDOMu1R5pL63yA8Rg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45g23vbws9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 08:30:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52K5FnLA024440;
	Thu, 20 Mar 2025 08:30:11 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dncmetrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 08:30:11 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52K8U77x29295274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 08:30:07 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C83F20040;
	Thu, 20 Mar 2025 08:30:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 278F320049;
	Thu, 20 Mar 2025 08:30:07 +0000 (GMT)
Received: from [9.155.196.190] (unknown [9.155.196.190])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Mar 2025 08:30:07 +0000 (GMT)
Message-ID: <22578a6a-6abb-422b-b9b5-d87b0d1390f2@linux.ibm.com>
Date: Thu, 20 Mar 2025 09:30:06 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/20] s390/zcrypt/pkey: Rework ep11 findcard()
 implementation and callers
To: Harald Freudenberger <freude@linux.ibm.com>, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
References: <20250304172116.85374-1-freude@linux.ibm.com>
 <20250304172116.85374-12-freude@linux.ibm.com>
Content-Language: de-DE
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250304172116.85374-12-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yu3cBogoq8cF34ff__xZzxmomTGmGmWQ
X-Proofpoint-GUID: yu3cBogoq8cF34ff__xZzxmomTGmGmWQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=961
 clxscore=1015 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503200050

On 04/03/2025 18:21, Harald Freudenberger wrote:
> Rework the memory usage of the ep11 findcard() implementation:
> - findcard does not allocate memory for the list of apqns
>   any more.
> - the callers are now responsible to provide an array of
>   apqns to store the matching apqns into.

See my comments below.

> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>  drivers/s390/crypto/pkey_ep11.c       | 19 ++++++++-----------
>  drivers/s390/crypto/zcrypt_ep11misc.c | 18 ++++--------------
>  drivers/s390/crypto/zcrypt_ep11misc.h | 12 +++++-------
>  3 files changed, 17 insertions(+), 32 deletions(-)
> 
[...]
> diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
> index 04153b476168..6005ef79c001 100644
> --- a/drivers/s390/crypto/zcrypt_ep11misc.c
> +++ b/drivers/s390/crypto/zcrypt_ep11misc.c
[...]
> @@ -1678,17 +1671,14 @@ int ep11_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
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
>  	} else {
> -		/* no re-allocation, simple return the _apqns array */
> -		*apqns = _apqns;

Please update *apqns unconditionally.

>  		*nr_apqns = _nr_apqns;
>  		rc = 0;
>  	}
> diff --git a/drivers/s390/crypto/zcrypt_ep11misc.h b/drivers/s390/crypto/zcrypt_ep11misc.h
> index a4b98eca8431..cbd615547bc2 100644
> --- a/drivers/s390/crypto/zcrypt_ep11misc.h
> +++ b/drivers/s390/crypto/zcrypt_ep11misc.h
> @@ -136,14 +136,12 @@ int ep11_clr2keyblob(u16 cardnr, u16 domain, u32 keybitsize, u32 keygenflags,
>   *   key for this domain. When a wkvp is given there will always be a re-fetch
>   *   of the domain info for the potential apqn - so this triggers an request
>   *   reply to each apqn eligible.
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

As mentioned in my comment to patch 10/20: please update nr_apqns in any case. If -ENODEV should be dropped for cca, than also drop it here.

>   */
> -int ep11_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
> +int ep11_findcard2(u32 *apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
>  		   int minhwtype, int minapi, const u8 *wkvp);
>  
>  /*

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

