Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <54A7BB35.9020604@sunrus.com.cn>
Date: Sat, 03 Jan 2015 17:49:41 +0800
From: Chen Gang <gang.chen@sunrus.com.cn>
MIME-Version: 1.0
Subject: Re: [PATCH] s390: boot: compressed: misc: Express the return value
 of _sclp_print_early()
References: <54A7B663.3010507@sunrus.com.cn>
In-Reply-To: <54A7B663.3010507@sunrus.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: linux-s390@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>


Our s390 can pass allmodconfig at present (although it is still has
various warnings).

Thanks.

On 01/03/2015 05:29 PM, Chen Gang wrote:
> _sclp_print_early() has return value: at present, return 0 for OK, 1 for
> failure. It returns '%r2', so use 'long' as return value (upper caller
> can check '%r2' directly). The related warning:
> 
>     CC      arch/s390/boot/compressed/misc.o
>   arch/s390/boot/compressed/misc.c:66:8: warning: type defaults to 'int' in declaration of '_sclp_print_early' [-Wimplicit-int]
>    extern _sclp_print_early(const char *);
>           ^
> 
> At present, _sclp_print_early() is only used by puts(), so can still
> remain its declaration in 'misc.c' file.
> 
> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
> ---
>  arch/s390/boot/compressed/misc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/boot/compressed/misc.c b/arch/s390/boot/compressed/misc.c
> index 57cbaff..09003b2 100644
> --- a/arch/s390/boot/compressed/misc.c
> +++ b/arch/s390/boot/compressed/misc.c
> @@ -63,7 +63,7 @@ static unsigned long free_mem_end_ptr;
>  #include "../../../../lib/decompress_unxz.c"
>  #endif
>  
> -extern _sclp_print_early(const char *);
> +extern long _sclp_print_early(const char *);
>  
>  static int puts(const char *s)
>  {
> 

-- 
Chen Gang

Open, share, and attitude like air, water, and life which God blessed
