From: Sebastian Ott <sebott@linux.vnet.ibm.com>
Date: Wed, 20 Mar 2013 12:45:15 +0000
Subject: Re: [PATCH] s390/scm_blk: fix error return code in scm_blk_init()
Message-Id: <alpine.LFD.2.03.1303201342440.1588@linux.vnet.ibm.com>
In-Reply-To: <CAPgLHd83Q_5_8siTwo77Pb2UqN0PzXocObKW4Fs-t34THO-ymQ@mail.gmail.com>
References: <CAPgLHd83Q_5_8siTwo77Pb2UqN0PzXocObKW4Fs-t34THO-ymQ@mail.gmail.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 20 Mar 2013, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Fix to return a negative error code from the error handling
> case instead of 0, as returned elsewhere in this function.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/s390/block/scm_blk.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/s390/block/scm_blk.c b/drivers/s390/block/scm_blk.c
> index 5ac9c93..54556b8 100644
> --- a/drivers/s390/block/scm_blk.c
> +++ b/drivers/s390/block/scm_blk.c
> @@ -463,12 +463,15 @@ static int __init scm_blk_init(void)
>  		goto out;
> 
>  	scm_major = ret;
> -	if (scm_alloc_rqs(nr_requests))
> +	ret = scm_alloc_rqs(nr_requests);
> +	if (ret)
>  		goto out_unreg;
> 
>  	scm_debug = debug_register("scm_log", 16, 1, 16);
> -	if (!scm_debug)
> +	if (!scm_debug) {
> +		ret = -ENOMEM;
>  		goto out_free;
> +	}
> 
>  	debug_register_view(scm_debug, &debug_hex_ascii_view);
>  	debug_set_level(scm_debug, 2);
> 

Thanks, applied.
Sebastian
