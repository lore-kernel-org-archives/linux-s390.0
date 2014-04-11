From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Fri, 11 Apr 2014 11:48:07 +0000
Subject: Re: [PATCH] s390/sclp: replace PTR_RET with PTR_ERR_OR_ZERO
Message-Id: <20140411134807.393a135b@mschwide>
In-Reply-To: <1397210706-28665-1-git-send-email-duanj.fnst@cn.fujitsu.com>
References: <1397210706-28665-1-git-send-email-duanj.fnst@cn.fujitsu.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 11 Apr 2014 18:05:06 +0800
Duan Jiong <duanj.fnst@cn.fujitsu.com> wrote:

> PTR_RET is deprecated. Do not recommend its usage anymore.
> Use PTR_ERR_OR_ZERO instead.
> 
> Signed-off-by: Duan Jiong <duanj.fnst@cn.fujitsu.com>
> ---
>  drivers/s390/char/sclp_cmd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/char/sclp_cmd.c b/drivers/s390/char/sclp_cmd.c
> index 6e8f90f..6e14999 100644
> --- a/drivers/s390/char/sclp_cmd.c
> +++ b/drivers/s390/char/sclp_cmd.c
> @@ -515,7 +515,7 @@ static int __init sclp_detect_standby_memory(void)
>  	if (rc)
>  		goto out;
>  	sclp_pdev = platform_device_register_simple("sclp_mem", -1, NULL, 0);
> -	rc = PTR_RET(sclp_pdev);
> +	rc = PTR_ERR_OR_ZERO(sclp_pdev);
>  	if (rc)
>  		goto out_driver;
>  	sclp_add_standby_memory();

Applied to our internal tree and will be added to the linux-s390 tree.
Thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
