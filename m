Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from helcar.hmeau.com ([216.24.177.18]:58420 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730851AbfHVF5T (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 22 Aug 2019 01:57:19 -0400
Date: Thu, 22 Aug 2019 15:57:12 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] crypto: s390/xts-aes - invoke fallback for ciphertext
 stealing
Message-ID: <20190822055711.GG3860@gondor.apana.org.au>
References: <20190816123545.22848-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816123545.22848-1-ard.biesheuvel@linaro.org>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-crypto@vger.kernel.org, ebiggers@kernel.org, linux-s390@vger.kernel.org

On Fri, Aug 16, 2019 at 03:35:45PM +0300, Ard Biesheuvel wrote:
> For correctness and compliance with the XTS-AES specification, we are
> adding support for ciphertext stealing to XTS implementations, even
> though no use cases are known that will be enabled by this.
> 
> Since the s390 implementation already has a fallback skcipher standby
> for other purposes, let's use it for this purpose as well. If ciphertext
> stealing use cases ever become a bottleneck, we can always revisit this.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/s390/crypto/aes_s390.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
