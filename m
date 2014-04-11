From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Fri, 11 Apr 2014 11:46:27 +0000
Subject: Re: [PATCH] qeth: replace PTR_RET with PTR_ERR_OR_ZERO
Message-Id: <20140411134627.33b74c74@mschwide>
In-Reply-To: <1397210670-28544-1-git-send-email-duanj.fnst@cn.fujitsu.com>
References: <1397210670-28544-1-git-send-email-duanj.fnst@cn.fujitsu.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 11 Apr 2014 18:04:30 +0800
Duan Jiong <duanj.fnst@cn.fujitsu.com> wrote:

> PTR_RET is deprecated. Do not recommend its usage anymore.
> Use PTR_ERR_OR_ZERO instead.
> 
> Signed-off-by: Duan Jiong <duanj.fnst@cn.fujitsu.com>
> ---
>  drivers/s390/net/qeth_core_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
> index 22470a3..f5bd422 100644
> --- a/drivers/s390/net/qeth_core_main.c
> +++ b/drivers/s390/net/qeth_core_main.c
> @@ -5824,7 +5824,7 @@ static int __init qeth_core_init(void)
>  	if (rc)
>  		goto out_err;
>  	qeth_core_root_dev = root_device_register("qeth");
> -	rc = PTR_RET(qeth_core_root_dev);
> +	rc = PTR_ERR_OR_ZERO(qeth_core_root_dev);
>  	if (rc)
>  		goto register_err;
>  	qeth_core_header_cache = kmem_cache_create("qeth_hdr",

Applied to our internal tree and will be added to the network
patch queue. Thanks.


-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
