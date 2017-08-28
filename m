Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] s390/zcrypt: make CPRBX const
References: <1503666629-10646-1-git-send-email-bhumirks@gmail.com>
From: Harald Freudenberger <freude@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 08:37:26 +0200
MIME-Version: 1.0
In-Reply-To: <1503666629-10646-1-git-send-email-bhumirks@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <437dfa91-ab0b-985b-0356-69da99a43120@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Bhumika Goyal <bhumirks@gmail.com>, julia.lawall@lip6.fr, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 08/25/2017 03:10 PM, Bhumika Goyal wrote:
> Make this const as it is only used in a copy operation.
>
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---
>  drivers/s390/crypto/zcrypt_msgtype6.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
> index 4fddb43..afd20ce 100644
> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
> @@ -140,7 +140,7 @@ struct function_and_rules_block {
>   *   + 0x000A 'MRP     ' (MCL3 'PK' or CEX2C 'PK')
>   * - VUD block
>   */
> -static struct CPRBX static_cprbx = {
> +static const struct CPRBX static_cprbx = {
>  	.cprb_len	=  0x00DC,
>  	.cprb_ver_id	=  0x02,
>  	.func_id	= {0x54, 0x32},
Applied. Will be available with the next merge.
Thanks and have a nice day.

Harald Freudenberger
