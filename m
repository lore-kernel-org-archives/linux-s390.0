From: =?UTF-8?Q?Jan_H=c3=b6ppner?= <hoeppner@linux.ibm.com>
Date: Thu, 06 Sep 2018 13:11:17 +0000
Subject: Re: [PATCH] s390/dasd: remove unnecessary condition check
Message-Id: <acb600b1-029d-4e8b-73fd-13bf0503c34c@linux.ibm.com>
In-Reply-To: <20180827235130.14115-1-cgxu519@gmx.com>
References: <20180827235130.14115-1-cgxu519@gmx.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 28.08.2018 01:51, Chengguang Xu wrote:
> kmem_cache_destroy() can handle NULL pointer correctly, so there is
> no need to check NULL pointer before calling kmem_cache_destroy().
> 
> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
> ---
>  drivers/s390/block/dasd.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
> index a23e7d394a0a..5e9ebdb0594c 100644
> --- a/drivers/s390/block/dasd.c
> +++ b/drivers/s390/block/dasd.c
> @@ -3309,10 +3309,8 @@ dasd_exit(void)
>  	dasd_proc_exit();
>  #endif
>  	dasd_eer_exit();
> -        if (dasd_page_cache != NULL) {
> -		kmem_cache_destroy(dasd_page_cache);
> -		dasd_page_cache = NULL;
> -	}
> +	kmem_cache_destroy(dasd_page_cache);
> +	dasd_page_cache = NULL;
>  	dasd_gendisk_exit();
>  	dasd_devmap_exit();
>  	if (dasd_debug_area != NULL) {
> 

Applied. Thanks a lot!

Regards,
Jan
