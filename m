From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Fri, 11 Apr 2014 11:46:16 +0000
Subject: Re: [PATCH] lcs: replace PTR_RET with PTR_ERR_OR_ZERO
Message-Id: <20140411134616.541ba981@mschwide>
In-Reply-To: <1397210657-28486-1-git-send-email-duanj.fnst@cn.fujitsu.com>
References: <1397210657-28486-1-git-send-email-duanj.fnst@cn.fujitsu.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 11 Apr 2014 18:04:17 +0800
Duan Jiong <duanj.fnst@cn.fujitsu.com> wrote:

> PTR_RET is deprecated. Do not recommend its usage anymore.
> Use PTR_ERR_OR_ZERO instead.
> 
> Signed-off-by: Duan Jiong <duanj.fnst@cn.fujitsu.com>
> ---
>  drivers/s390/net/lcs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
> index c461f2a..8d5d969 100644
> --- a/drivers/s390/net/lcs.c
> +++ b/drivers/s390/net/lcs.c
> @@ -2442,7 +2442,7 @@ __init lcs_init_module(void)
>  	if (rc)
>  		goto out_err;
>  	lcs_root_dev = root_device_register("lcs");
> -	rc = PTR_RET(lcs_root_dev);
> +	rc = PTR_ERR_OR_ZERO(lcs_root_dev);
>  	if (rc)
>  		goto register_err;
>  	rc = ccw_driver_register(&lcs_ccw_driver);

Applied to our internal tree and will be added to the network
patch queue. Thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
