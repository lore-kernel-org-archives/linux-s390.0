Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56492 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732235AbfFLKbU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 12 Jun 2019 06:31:20 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5CARvmW181879
        for <linux-s390@vger.kernel.org>; Wed, 12 Jun 2019 06:31:19 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t2wb2pdtu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 12 Jun 2019 06:31:19 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <freude@linux.ibm.com>;
        Wed, 12 Jun 2019 11:31:17 +0100
Subject: Re: [PATCH v2 3/4] s390/crypto: prng: Use -ENODEV instead of
 -EOPNOTSUPP
References: <20190612102248.18903-1-david@redhat.com>
 <20190612102248.18903-4-david@redhat.com>
From: Harald Freudenberger <freude@linux.ibm.com>
Date: Wed, 12 Jun 2019 12:31:11 +0200
MIME-Version: 1.0
In-Reply-To: <20190612102248.18903-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <347f2075-e6ac-5977-c7a4-1f825d0f72f9@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>

On 12.06.19 12:22, David Hildenbrand wrote:
> Let's use the error value that is typically used if HW support is not
> available when trying to load a module - this is also what systemd's
> systemd-modules-load.service expects.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/crypto/prng.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/s390/crypto/prng.c b/arch/s390/crypto/prng.c
> index 12cca467af7d..d977643fa627 100644
> --- a/arch/s390/crypto/prng.c
> +++ b/arch/s390/crypto/prng.c
> @@ -824,7 +824,7 @@ static int __init prng_init(void)
>  
>  	/* check if the CPU has a PRNG */
>  	if (!cpacf_query_func(CPACF_KMC, CPACF_KMC_PRNG))
> -		return -EOPNOTSUPP;
> +		return -ENODEV;
>  
>  	/* check if TRNG subfunction is available */
>  	if (cpacf_query_func(CPACF_PRNO, CPACF_PRNO_TRNG))
> @@ -837,7 +837,7 @@ static int __init prng_init(void)
>  			if (prng_mode == PRNG_MODE_SHA512) {
>  				pr_err("The prng module cannot "
>  				       "start in SHA-512 mode\n");
> -				return -EOPNOTSUPP;
> +				return -ENODEV;
>  			}
>  			prng_mode = PRNG_MODE_TDES;
>  		} else
fine with me
Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
