From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Fri, 11 Apr 2014 11:47:27 +0000
Subject: Re: [PATCH] s390/irq: replace PTR_RET with PTR_ERR_OR_ZERO
Message-Id: <20140411134727.7187bcc6@mschwide>
In-Reply-To: <1397210690-28605-1-git-send-email-duanj.fnst@cn.fujitsu.com>
References: <1397210690-28605-1-git-send-email-duanj.fnst@cn.fujitsu.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 11 Apr 2014 18:04:50 +0800
Duan Jiong <duanj.fnst@cn.fujitsu.com> wrote:

> PTR_RET is deprecated. Do not recommend its usage anymore.
> Use PTR_ERR_OR_ZERO instead.
> 
> Signed-off-by: Duan Jiong <duanj.fnst@cn.fujitsu.com>
> ---
>  drivers/s390/char/sclp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
> index 1990285..c316051 100644
> --- a/drivers/s390/char/sclp.c
> +++ b/drivers/s390/char/sclp.c
> @@ -1252,7 +1252,7 @@ static __init int sclp_initcall(void)
>  		return rc;
> 
>  	sclp_pdev = platform_device_register_simple("sclp", -1, NULL, 0);
> -	rc = PTR_RET(sclp_pdev);
> +	rc = PTR_ERR_OR_ZERO(sclp_pdev);
>  	if (rc)
>  		goto fail_platform_driver_unregister;
> 

Applied to our internal tree with a modified subject line. It
will go out over the linux-s390 tree. Thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
