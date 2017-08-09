Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 9 Aug 2017 07:52:58 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390/crypto: make cca_public_sec and cca_token_hdr const
References: <1501998747-4094-1-git-send-email-bhumirks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1501998747-4094-1-git-send-email-bhumirks@gmail.com>
Message-Id: <20170809055257.GA4583@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, freude@de.ibm.com, schwidefsky@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sun, Aug 06, 2017 at 11:22:27AM +0530, Bhumika Goyal wrote:
> Declare cca_public_sec and cca_token_hdr structures as const as they are
> only used during copy operations.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---
>  drivers/s390/crypto/zcrypt_cca_key.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/s390/crypto/zcrypt_cca_key.h b/drivers/s390/crypto/zcrypt_cca_key.h
> index 12cff62..7b78ba6 100644
> --- a/drivers/s390/crypto/zcrypt_cca_key.h
> +++ b/drivers/s390/crypto/zcrypt_cca_key.h
> @@ -116,10 +116,10 @@ struct cca_pvt_ext_CRT_sec {
>   */
>  static inline int zcrypt_type6_mex_key_en(struct ica_rsa_modexpo *mex, void *p)
>  {
> -	static struct cca_token_hdr static_pub_hdr = {
> +	static const struct cca_token_hdr static_pub_hdr = {
>  		.token_identifier	=  0x1E,
>  	};
> -	static struct cca_public_sec static_pub_sec = {
> +	static const struct cca_public_sec static_pub_sec = {
>  		.section_identifier	=  0x04,
>  	};
>  	struct {
> @@ -176,7 +176,7 @@ static inline int zcrypt_type6_mex_key_en(struct ica_rsa_modexpo *mex, void *p)
>   */
>  static inline int zcrypt_type6_crt_key(struct ica_rsa_modexpo_crt *crt, void *p)
>  {
> -	static struct cca_public_sec static_cca_pub_sec = {
> +	static const struct cca_public_sec static_cca_pub_sec = {
>  		.section_identifier = 4,
>  		.section_length = 0x000f,
>  		.exponent_len = 0x0003,

If you look at the code, it seems to be questionable why these structures
are declared static and not simply on the stack. In the first case we are
talking of an assignment of two single bytes two a structure that has
already been zeroed.
Besides this, the two functions in the header file are very large and
shouldn't be unconditionally inlined anyway. This needs to be cleaned
up. So I'm not at all in favor of a patch that just adds a const keyword in
addition.
