From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Date: Mon, 03 Jun 2013 10:37:39 +0000
Subject: Re: [PATCH] s390/net/netiucv: remove unused macro
Message-Id: <1370255859.14163.5.camel@BR9GV9YG.de.ibm.com>
In-Reply-To: <1369734927-28401-1-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1369734927-28401-1-git-send-email-andriy.shevchenko@linux.intel.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Thanks, Andy. We will add your patch to one of our next submissions to
Dave Miller.

Regards, Ursula Braun


On Mon, 2013-05-28, Andy Shevchenko wrote:

> If someone is interested to dump something they may consider to use
> print_hex_dump() or print_hex_dump_bytes() kernel helpers.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> drivers/s390/net/netiucv.c | 20 --------------------
> 1 file changed, 20 deletions(-)
> 
> diff --git a/drivers/s390/net/netiucv.c b/drivers/s390/net/netiucv.c
> index 4ffa66c..533454a 100644
> --- a/drivers/s390/net/netiucv.c
> +++ b/drivers/s390/net/netiucv.c
> @@ -130,26 +130,6 @@ static inline int iucv_dbf_passes(debug_info_t
> *dbf_grp, int level)
> /**
>  * some more debug stuff
>  */
> -#define IUCV_HEXDUMP16(importance,header,ptr) \
> -PRINT_##importance(header "%02x %02x %02x %02x  %02x %02x %02x %02x
>  " \
> -                                     "%02x %02x %02x %02x  %02x %02x
> %02x %02x\n", \
> -
> *(((char*)ptr)),*(((char*)ptr)+1),*(((char*)ptr)+2), \
> -
> *(((char*)ptr)+3),*(((char*)ptr)+4),*(((char*)ptr)+5), \
> -
> *(((char*)ptr)+6),*(((char*)ptr)+7),*(((char*)ptr)+8), \
> -
> *(((char*)ptr)+9),*(((char*)ptr)+10),*(((char*)ptr)+11), \
> -
> *(((char*)ptr)+12),*(((char*)ptr)+13), \
> -
> *(((char*)ptr)+14),*(((char*)ptr)+15)); \
> -PRINT_##importance(header "%02x %02x %02x %02x  %02x %02x %02x %02x
>  " \
> -                                     "%02x %02x %02x %02x  %02x %02x
> %02x %02x\n", \
> -
> *(((char*)ptr)+16),*(((char*)ptr)+17), \
> -
> *(((char*)ptr)+18),*(((char*)ptr)+19), \
> -
> *(((char*)ptr)+20),*(((char*)ptr)+21), \
> -
> *(((char*)ptr)+22),*(((char*)ptr)+23), \
> -
> *(((char*)ptr)+24),*(((char*)ptr)+25), \
> -
> *(((char*)ptr)+26),*(((char*)ptr)+27), \
> -
> *(((char*)ptr)+28),*(((char*)ptr)+29), \
> -
> *(((char*)ptr)+30),*(((char*)ptr)+31));
> -
> #define PRINTK_HEADER " iucv: "       /* for debugging */
> 
> /* dummy device to make sure netiucv_pm functions are called */
