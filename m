Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 16 Apr 2020 11:06:18 +0200
From: Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: Re: [PATCH v3 2/3] crypto: Remove unnecessary memzero_explicit()
Message-ID: <20200416090618.GB29148@Red>
References: <20200413211550.8307-1-longman@redhat.com>
 <20200414200214.1873-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414200214.1873-1-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Linus Torvalds <torvalds@linux-foundation.org>, Joe Perches <joe@perches.com>, Matthew Wilcox <willy@infradead.org>, David Rientjes <rientjes@google.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Chen-Yu Tsai <wens@csie.org>, linux-mm@kvack.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org

On Tue, Apr 14, 2020 at 04:02:14PM -0400, Waiman Long wrote:
> Since kfree_sensitive() will do an implicit memzero_explicit(),
> there is no need to call memzero_explicit() before it. Eliminate those
> memzero_explicit() and simplify the call sites. For better correctness,
> keylen is cleared if key memory allocation fails.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  .../allwinner/sun8i-ce/sun8i-ce-cipher.c      | 23 +++++++-----------
>  .../allwinner/sun8i-ss/sun8i-ss-cipher.c      | 24 +++++++------------
>  drivers/crypto/amlogic/amlogic-gxl-cipher.c   | 14 ++++-------
>  drivers/crypto/inside-secure/safexcel_hash.c  |  3 +--
>  4 files changed, 24 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
> index aa4e8fdc2b32..a2bac10d2876 100644
> --- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
> +++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
> @@ -366,10 +366,7 @@ void sun8i_ce_cipher_exit(struct crypto_tfm *tfm)
>  {
>  	struct sun8i_cipher_tfm_ctx *op = crypto_tfm_ctx(tfm);
>  
> -	if (op->key) {
> -		memzero_explicit(op->key, op->keylen);
> -		kfree(op->key);
> -	}
> +	kfree_sensitive(op->key);
>  	crypto_free_sync_skcipher(op->fallback_tfm);
>  	pm_runtime_put_sync_suspend(op->ce->dev);
>  }
> @@ -391,14 +388,13 @@ int sun8i_ce_aes_setkey(struct crypto_skcipher *tfm, const u8 *key,
>  		dev_dbg(ce->dev, "ERROR: Invalid keylen %u\n", keylen);
>  		return -EINVAL;
>  	}
> -	if (op->key) {
> -		memzero_explicit(op->key, op->keylen);
> -		kfree(op->key);
> -	}
> +	kfree_sensitive(op->key);
>  	op->keylen = keylen;
>  	op->key = kmemdup(key, keylen, GFP_KERNEL | GFP_DMA);
> -	if (!op->key)
> +	if (unlikely(!op->key)) {
> +		op->keylen = 0;
>  		return -ENOMEM;
> +	}
>  
>  	crypto_sync_skcipher_clear_flags(op->fallback_tfm, CRYPTO_TFM_REQ_MASK);
>  	crypto_sync_skcipher_set_flags(op->fallback_tfm, tfm->base.crt_flags & CRYPTO_TFM_REQ_MASK);
> @@ -416,14 +412,13 @@ int sun8i_ce_des3_setkey(struct crypto_skcipher *tfm, const u8 *key,
>  	if (err)
>  		return err;
>  
> -	if (op->key) {
> -		memzero_explicit(op->key, op->keylen);
> -		kfree(op->key);
> -	}
> +	kfree_sensitive(op->key);
>  	op->keylen = keylen;
>  	op->key = kmemdup(key, keylen, GFP_KERNEL | GFP_DMA);
> -	if (!op->key)
> +	if (unlikely(!op->key)) {
> +		op->keylen = 0;
>  		return -ENOMEM;
> +	}
>  
>  	crypto_sync_skcipher_clear_flags(op->fallback_tfm, CRYPTO_TFM_REQ_MASK);
>  	crypto_sync_skcipher_set_flags(op->fallback_tfm, tfm->base.crt_flags & CRYPTO_TFM_REQ_MASK);
> diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
> index 5246ef4f5430..a24d567a6c36 100644
> --- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
> +++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
> @@ -249,7 +249,6 @@ static int sun8i_ss_cipher(struct skcipher_request *areq)
>  			offset = areq->cryptlen - ivsize;
>  			if (rctx->op_dir & SS_DECRYPTION) {
>  				memcpy(areq->iv, backup_iv, ivsize);
> -				memzero_explicit(backup_iv, ivsize);
>  				kfree_sensitive(backup_iv);
>  			} else {
>  				scatterwalk_map_and_copy(areq->iv, areq->dst, offset,
> @@ -367,10 +366,7 @@ void sun8i_ss_cipher_exit(struct crypto_tfm *tfm)
>  {
>  	struct sun8i_cipher_tfm_ctx *op = crypto_tfm_ctx(tfm);
>  
> -	if (op->key) {
> -		memzero_explicit(op->key, op->keylen);
> -		kfree(op->key);
> -	}
> +	kfree_sensitive(op->key);
>  	crypto_free_sync_skcipher(op->fallback_tfm);
>  	pm_runtime_put_sync(op->ss->dev);
>  }
> @@ -392,14 +388,13 @@ int sun8i_ss_aes_setkey(struct crypto_skcipher *tfm, const u8 *key,
>  		dev_dbg(ss->dev, "ERROR: Invalid keylen %u\n", keylen);
>  		return -EINVAL;
>  	}
> -	if (op->key) {
> -		memzero_explicit(op->key, op->keylen);
> -		kfree(op->key);
> -	}
> +	kfree_sensitive(op->key);
>  	op->keylen = keylen;
>  	op->key = kmemdup(key, keylen, GFP_KERNEL | GFP_DMA);
> -	if (!op->key)
> +	if (unlikely(!op->key))
> +		op->keylen = 0;
>  		return -ENOMEM;
> +	}
>  
>  	crypto_sync_skcipher_clear_flags(op->fallback_tfm, CRYPTO_TFM_REQ_MASK);
>  	crypto_sync_skcipher_set_flags(op->fallback_tfm, tfm->base.crt_flags & CRYPTO_TFM_REQ_MASK);
> @@ -418,14 +413,13 @@ int sun8i_ss_des3_setkey(struct crypto_skcipher *tfm, const u8 *key,
>  		return -EINVAL;
>  	}
>  
> -	if (op->key) {
> -		memzero_explicit(op->key, op->keylen);
> -		kfree(op->key);
> -	}
> +	kfree_sensitive(op->key);
>  	op->keylen = keylen;
>  	op->key = kmemdup(key, keylen, GFP_KERNEL | GFP_DMA);
> -	if (!op->key)
> +	if (unlikely(!op->key))
> +		op->keylen = 0;
>  		return -ENOMEM;
> +	}
>  
>  	crypto_sync_skcipher_clear_flags(op->fallback_tfm, CRYPTO_TFM_REQ_MASK);
>  	crypto_sync_skcipher_set_flags(op->fallback_tfm, tfm->base.crt_flags & CRYPTO_TFM_REQ_MASK);
> diff --git a/drivers/crypto/amlogic/amlogic-gxl-cipher.c b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
> index fd1269900d67..5312bad7534e 100644
> --- a/drivers/crypto/amlogic/amlogic-gxl-cipher.c
> +++ b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
> @@ -341,10 +341,7 @@ void meson_cipher_exit(struct crypto_tfm *tfm)
>  {
>  	struct meson_cipher_tfm_ctx *op = crypto_tfm_ctx(tfm);
>  
> -	if (op->key) {
> -		memzero_explicit(op->key, op->keylen);
> -		kfree(op->key);
> -	}
> +	kfree_sensitive(op->key);
>  	crypto_free_sync_skcipher(op->fallback_tfm);
>  }
>  
> @@ -368,14 +365,13 @@ int meson_aes_setkey(struct crypto_skcipher *tfm, const u8 *key,
>  		dev_dbg(mc->dev, "ERROR: Invalid keylen %u\n", keylen);
>  		return -EINVAL;
>  	}
> -	if (op->key) {
> -		memzero_explicit(op->key, op->keylen);
> -		kfree(op->key);
> -	}
> +	kfree_sensitive(op->key);
>  	op->keylen = keylen;
>  	op->key = kmemdup(key, keylen, GFP_KERNEL | GFP_DMA);
> -	if (!op->key)
> +	if (unlikely(!op->key))
> +		op->keylen = 0;
>  		return -ENOMEM;
> +	}
>  
>  	return crypto_sync_skcipher_setkey(op->fallback_tfm, key, keylen);
>  }

For sun8i-ss/sun8i-ce
Acked-by: Corentin Labbe <clabbe.montjoie@gmail.com>
For amlogic
Acked-by: Corentin Labbe <clabbe@baylibre.com>

Thanks
