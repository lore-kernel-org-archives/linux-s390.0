Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AEB126C02
	for <linux-s390@vger.kernel.org>; Tue, 18 Mar 2025 14:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742307427; cv=none; b=Jd6kEDInq9cJn19WGD3uXTY6GkuEpUOL3fPqLY7/9QO3ugtP7XmprZHrU11LcTsrMCNEnjvYjVHgI9woMlP6oGSa3nU/HIzFCU41+jIYJn7u1QrEx2H/PYoT0GIk7mZgQSVSqO5Uemw2pU23Sx/WiIaoxLBcc/NnVY3gkKCQtlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742307427; c=relaxed/simple;
	bh=l+V5LS2mFX/RzzBFhLFNSaQ/05aXCYz6UyRL++gsOqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IB5A2hp4NIARTcAJ6XwfYiWomxOXHIV9WIWI4yzN8nwdRJNB9Fu9aoNhVhUS2ZTMwU9pcsyCMB5zN87dUMwTDYr/WQVlfrjkUK6NjwdqbBV5CPqHe7gwHX3xQg2KBUZ/qPz6Pav1bBFdoKABilAP3va8CGwNoAH1tmuc4fG/lF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KIfHZG7S; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KIfHZG7S"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IAGnib011307;
	Tue, 18 Mar 2025 14:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kSvYRT
	N9Z9MNyIjiSzHewcp9k9GA+FFITaRX7PK0Wko=; b=KIfHZG7SstD0W9ySuX9xoJ
	EsqPpUaMosXprdF7yICudNQHIfxZ2XN2wtJCdnKTLBihOxNQXjUtDgb8L38t6Onc
	e3PNw6EJgiD3UckNOGTnrK7RmcZz9EIVEWjiwtBERVIJO61BL3ouJF2w+3B5llYm
	dETrmeEBrGCoTqtMUeT4tTc3jQmTG+j+0ZnIKKp5gkS4gdP9poQ9XtdQsgP8tMPj
	+BGG6xrxb7OR2gPa0Oc03BkzQ+ThpL9zJGT6iGK/LKMZUO3ajsoU24YNZSd4mgW2
	hHyqOpWbv0XdvvOYJ1W59Ha2d0dURUaM+JMVzQ1kbIXnO81maojdAQsJKUdpnc7w
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45eu55v5pe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 14:16:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52ICgnoR005819;
	Tue, 18 Mar 2025 14:16:57 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dpk2bv1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 14:16:57 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52IEGs9139780784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 14:16:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B0952004B;
	Tue, 18 Mar 2025 14:16:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C199A20043;
	Tue, 18 Mar 2025 14:16:53 +0000 (GMT)
Received: from [9.171.69.178] (unknown [9.171.69.178])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Mar 2025 14:16:53 +0000 (GMT)
Message-ID: <a9e5cebe-7d68-46df-a194-d6ef393322fb@linux.ibm.com>
Date: Tue, 18 Mar 2025 15:16:53 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/20] s390/zcrypt: Introduce cprb mempool for cca misc
 functions
To: Harald Freudenberger <freude@linux.ibm.com>, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
References: <20250304172116.85374-1-freude@linux.ibm.com>
 <20250304172116.85374-6-freude@linux.ibm.com>
Content-Language: en-US
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250304172116.85374-6-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6rKnVuKzNyA6Hill32dT6mesFsGXPPKh
X-Proofpoint-GUID: 6rKnVuKzNyA6Hill32dT6mesFsGXPPKh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_06,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503180104

On 04/03/2025 18:21, Harald Freudenberger wrote:
> Introduce a cprb mempool for the zcrypt cca misc functions
> (zcrypt_ccamisc.*) do some preparation rework to support
> a do-not-allocate path through some zcrypt cca misc functions.
> 
> The mempool is by default space for 4 cprbs with each 16KB.
> For CCA a CPRB needs to hold the request and the reply, so
> the pool items only support requests/replies with a limit of
> about 8KB. The minimal number of items in the mempool can get
> adjusted via module parameter zcrypt.cca_cprbpool_min_items
> on module load.
> 
> This is only part of an rework to support a new xflag
> ZCRYPT_XFLAG_NOMEMALLOC but not yet complete.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

One minor comment below. Beside that
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

> ---
>  drivers/s390/crypto/zcrypt_api.c     |  13 ++-
>  drivers/s390/crypto/zcrypt_api.h     |   2 +
>  drivers/s390/crypto/zcrypt_ccamisc.c | 116 ++++++++++++++++++++-------
>  drivers/s390/crypto/zcrypt_ccamisc.h |   1 +
>  4 files changed, 101 insertions(+), 31 deletions(-)
> 
[...]
> diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
> index 521baaea06ff..2c2ca2d67e2d 100644
> --- a/drivers/s390/crypto/zcrypt_ccamisc.c
> +++ b/drivers/s390/crypto/zcrypt_ccamisc.c
[...]
> @@ -229,7 +241,15 @@ static int alloc_and_prep_cprbmem(size_t paramblen,
>  	 * allocate consecutive memory for request CPRB, request param
>  	 * block, reply CPRB and reply param block
>  	 */
> -	cprbmem = kcalloc(2, cprbplusparamblen, GFP_KERNEL);
> +	if (xflags & ZCRYPT_XFLAG_NOMEMALLOC) {
> +		if (cprb_mempool &&
> +		    2 * cprbplusparamblen <= CPRB_MEMPOOL_ITEM_SIZE) {
> +			cprbmem = mempool_alloc_preallocated(cprb_mempool);
> +			memset(cprbmem, 0, 2 * cprbplusparamblen);
> +		}
> +	} else {

Just a nit: let the compiler decide, if code should be duplicated or not.

if (xflags & ZCRYPT_XFLAG_NOMEMALLOC) {
	size_t len = 2 * cprbplusparamblen;

	if (cprb_mempool && len <= CPRB_MEMPOOL_ITEM_SIZE) {
		cprbmem = mempool_alloc_preallocated(cprb_mempool);
		memset(cprbmem, 0, len);
	}
} else {

> +		cprbmem = kcalloc(2, cprbplusparamblen, GFP_KERNEL);
> +	}
>  	if (!cprbmem)
>  		return -ENOMEM;
>  
[...]

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

