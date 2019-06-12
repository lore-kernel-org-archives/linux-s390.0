Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39430 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732093AbfFLKad (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 12 Jun 2019 06:30:33 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5CASLSE033000
        for <linux-s390@vger.kernel.org>; Wed, 12 Jun 2019 06:30:31 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t2xm1u8dn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 12 Jun 2019 06:30:31 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <freude@linux.ibm.com>;
        Wed, 12 Jun 2019 11:30:28 +0100
Subject: Re: [PATCH v2 4/4] s390/crypto: sha: Use -ENODEV instead of
 -EOPNOTSUPP
References: <20190612102248.18903-1-david@redhat.com>
 <20190612102248.18903-5-david@redhat.com>
From: Harald Freudenberger <freude@linux.ibm.com>
Date: Wed, 12 Jun 2019 12:30:23 +0200
MIME-Version: 1.0
In-Reply-To: <20190612102248.18903-5-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <10b7259b-3c73-1c87-6ccd-914da9c796dd@linux.ibm.com>
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
>  arch/s390/crypto/sha1_s390.c   | 2 +-
>  arch/s390/crypto/sha256_s390.c | 2 +-
>  arch/s390/crypto/sha512_s390.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/s390/crypto/sha1_s390.c b/arch/s390/crypto/sha1_s390.c
> index 009572e8276d..7c15542d3685 100644
> --- a/arch/s390/crypto/sha1_s390.c
> +++ b/arch/s390/crypto/sha1_s390.c
> @@ -86,7 +86,7 @@ static struct shash_alg alg = {
>  static int __init sha1_s390_init(void)
>  {
>  	if (!cpacf_query_func(CPACF_KIMD, CPACF_KIMD_SHA_1))
> -		return -EOPNOTSUPP;
> +		return -ENODEV;
>  	return crypto_register_shash(&alg);
>  }
>  
> diff --git a/arch/s390/crypto/sha256_s390.c b/arch/s390/crypto/sha256_s390.c
> index 62833a1d8724..af7505148f80 100644
> --- a/arch/s390/crypto/sha256_s390.c
> +++ b/arch/s390/crypto/sha256_s390.c
> @@ -117,7 +117,7 @@ static int __init sha256_s390_init(void)
>  	int ret;
>  
>  	if (!cpacf_query_func(CPACF_KIMD, CPACF_KIMD_SHA_256))
> -		return -EOPNOTSUPP;
> +		return -ENODEV;
>  	ret = crypto_register_shash(&sha256_alg);
>  	if (ret < 0)
>  		goto out;
> diff --git a/arch/s390/crypto/sha512_s390.c b/arch/s390/crypto/sha512_s390.c
> index be589c340d15..ad29db085a18 100644
> --- a/arch/s390/crypto/sha512_s390.c
> +++ b/arch/s390/crypto/sha512_s390.c
> @@ -127,7 +127,7 @@ static int __init init(void)
>  	int ret;
>  
>  	if (!cpacf_query_func(CPACF_KIMD, CPACF_KIMD_SHA_512))
> -		return -EOPNOTSUPP;
> +		return -ENODEV;
>  	if ((ret = crypto_register_shash(&sha512_alg)) < 0)
>  		goto out;
>  	if ((ret = crypto_register_shash(&sha384_alg)) < 0)
fine with me
Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
