Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43936 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732237AbfFLKbv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 12 Jun 2019 06:31:51 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5CAT8ib071146
        for <linux-s390@vger.kernel.org>; Wed, 12 Jun 2019 06:31:49 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t2x1kn1u7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 12 Jun 2019 06:31:49 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <freude@linux.ibm.com>;
        Wed, 12 Jun 2019 11:31:47 +0100
Subject: Re: [PATCH v2 2/4] s390/crypto: ghash: Use -ENODEV instead of
 -EOPNOTSUPP
References: <20190612102248.18903-1-david@redhat.com>
 <20190612102248.18903-3-david@redhat.com>
From: Harald Freudenberger <freude@linux.ibm.com>
Date: Wed, 12 Jun 2019 12:31:42 +0200
MIME-Version: 1.0
In-Reply-To: <20190612102248.18903-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <9853af8c-fa55-8128-fffb-b48579174e67@linux.ibm.com>
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
>  arch/s390/crypto/ghash_s390.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/s390/crypto/ghash_s390.c b/arch/s390/crypto/ghash_s390.c
> index 86aed30fad3a..eeeb6a7737a4 100644
> --- a/arch/s390/crypto/ghash_s390.c
> +++ b/arch/s390/crypto/ghash_s390.c
> @@ -137,7 +137,7 @@ static struct shash_alg ghash_alg = {
>  static int __init ghash_mod_init(void)
>  {
>  	if (!cpacf_query_func(CPACF_KIMD, CPACF_KIMD_GHASH))
> -		return -EOPNOTSUPP;
> +		return -ENODEV;
>  
>  	return crypto_register_shash(&ghash_alg);
>  }
fine with me
Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
