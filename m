Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20952 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727545AbgBYOjz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 Feb 2020 09:39:55 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01PEZmls012342
        for <linux-s390@vger.kernel.org>; Tue, 25 Feb 2020 09:39:54 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yb1634bu5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 25 Feb 2020 09:39:53 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <freude@linux.ibm.com>;
        Tue, 25 Feb 2020 14:39:52 -0000
Subject: Re: s390 crypto: explicitly memzero stack key material in aes_s390.c
References: <20200221165511.GB6928@lst.de>
From: Harald Freudenberger <freude@linux.ibm.com>
Date: Tue, 25 Feb 2020 15:39:46 +0100
MIME-Version: 1.0
In-Reply-To: <20200221165511.GB6928@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <5b185871-d94e-2f79-ff42-07b2a10c490c@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Torsten Duwe <duwe@lst.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-crypto@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On 21.02.20 17:55, Torsten Duwe wrote:
> From: Torsten Duwe <duwe@suse.de>
>
> s390 crypto: explicitly memzero stack key material in aes_s390.c
>
> aes_s390.c has several functions which allocate space for key material on
> the stack and leave the used keys there. It is considered good practice
> to clean these locations before the function returns.
>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> ---
> This popped up during our FIPS certification.
> It's obviously a good idea not to leave key material on the stack.
>
> --- a/arch/s390/crypto/aes_s390.c
> +++ b/arch/s390/crypto/aes_s390.c
> @@ -392,6 +392,7 @@ static int cbc_aes_crypt(struct blkciphe
>  		ret = blkcipher_walk_done(desc, walk, nbytes - n);
>  	}
>  	memcpy(walk->iv, param.iv, AES_BLOCK_SIZE);
> +	memzero_explicit(&param, sizeof(param));
>  	return ret;
>  }
>
> @@ -576,6 +577,8 @@ static int xts_aes_crypt(struct blkciphe
>  			 walk->dst.virt.addr, walk->src.virt.addr, n);
>  		ret = blkcipher_walk_done(desc, walk, nbytes - n);
>  	}
> +	memzero_explicit(&pcc_param, sizeof(pcc_param));
> +	memzero_explicit(&xts_param, sizeof(xts_param));
>  	return ret;
>  }
>
>
Thanks Torsten, I've picked this patch. It will go upstream via the s390 subsystem with the next kernel merge window.
regards Harald Freudenberger
