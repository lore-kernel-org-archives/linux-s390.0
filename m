Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 21/22] crypto: qce - add check for xts input length equal
 to zero
References: <20200807162010.18979-1-andrei.botila@oss.nxp.com>
 <20200807162010.18979-22-andrei.botila@oss.nxp.com>
From: Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <ecf46ef2-3ef5-7ce1-ebd7-09774df67a47@mm-sol.com>
Date: Fri, 7 Aug 2020 20:59:04 +0300
MIME-Version: 1.0
In-Reply-To: <20200807162010.18979-22-andrei.botila@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andrei Botila <andrei.botila@oss.nxp.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
Cc: linux-s390@vger.kernel.org, Andrei Botila <andrei.botila@nxp.com>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com, linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

Hi,

Thanks for the patch!

On 8/7/20 7:20 PM, Andrei Botila wrote:
> From: Andrei Botila <andrei.botila@nxp.com>
> 
> Standardize the way input lengths equal to 0 are handled in all skcipher
> algorithms. All the algorithms return 0 for input lengths equal to zero.
> 
> Signed-off-by: Andrei Botila <andrei.botila@nxp.com>
> ---
>  drivers/crypto/qce/skcipher.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Stanimir Varbanov <svarbanov@mm-sol.com>

> 
> diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
> index 5630c5addd28..887fd4dc9b43 100644
> --- a/drivers/crypto/qce/skcipher.c
> +++ b/drivers/crypto/qce/skcipher.c
> @@ -223,6 +223,9 @@ static int qce_skcipher_crypt(struct skcipher_request *req, int encrypt)
>  	int keylen;
>  	int ret;
>  
> +	if (!req->cryptlen && IS_XTS(rctx->flags))
> +		return 0;
> +
>  	rctx->flags = tmpl->alg_flags;
>  	rctx->flags |= encrypt ? QCE_ENCRYPT : QCE_DECRYPT;
>  	keylen = IS_XTS(rctx->flags) ? ctx->enc_keylen >> 1 : ctx->enc_keylen;
> 

-- 
regards,
Stan
