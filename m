Return-Path: <linux-kernel-owner+w=401wt.eu-S935146AbZLGODS@vger.kernel.org>
Date: Mon, 7 Dec 2009 15:03:26 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] s390: PTR_ERR return of wrong pointer in
 fallback_init_cip()
Message-ID: <20091207150326.631e564d@mschwide.boeblingen.de.ibm.com>
In-Reply-To: <4B1D0399.2070307@gmail.com>
References: <4B1D0399.2070307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Roel Kluin <roel.kluin@gmail.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 07 Dec 2009 14:31:05 +0100
Roel Kluin <roel.kluin@gmail.com> wrote:

> Return the PTR_ERR of the correct pointer.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
>  arch/s390/crypto/aes_s390.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/s390/crypto/aes_s390.c b/arch/s390/crypto/aes_s390.c
> index 6118890..6be4503 100644
> --- a/arch/s390/crypto/aes_s390.c
> +++ b/arch/s390/crypto/aes_s390.c
> @@ -174,7 +174,7 @@ static int fallback_init_cip(struct crypto_tfm *tfm)
>  	if (IS_ERR(sctx->fallback.cip)) {
>  		pr_err("Allocating AES fallback algorithm %s failed\n",
>  		       name);
> -		return PTR_ERR(sctx->fallback.blk);
> +		return PTR_ERR(sctx->fallback.cip);
>  	}
> 
>  	return 0;

Added to my queue, thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
