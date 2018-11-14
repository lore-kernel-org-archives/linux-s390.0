From: Pierre Morel <pmorel@linux.ibm.com>
Date: Wed, 14 Nov 2018 18:12:48 +0000
Subject: Re: [RFC PATCH v1 03/10] s390/cio: Squash cp_free and cp_unpin_free
Message-Id: <e394816f-27b4-78ae-3c75-67d178697d13@linux.ibm.com>
In-Reply-To: <7f33c9d8-cead-e81a-a5cf-0da7fa938ab8@linux.ibm.com>
References: <7f33c9d8-cead-e81a-a5cf-0da7fa938ab8@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 09/11/2018 03:39, Eric Farman wrote:
> The routine cp_free() does nothing but call cp_unpin_free(), and while
> most places call cp_free() there is one caller of cp_unpin_free().
> 
> Let's avoid the confusion, and make cp_free() do all the work.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>   drivers/s390/cio/vfio_ccw_cp.c | 30 ++++++++++++------------------
>   1 file changed, 12 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> index 70a006ba4d05..a5a701451ef8 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -329,22 +329,6 @@ static void ccwchain_cda_free(struct ccwchain *chain, int idx)
>   	kfree((void *)(u64)ccw->cda);
>   }
>   
> -/* Unpin the pages then free the memory resources. */
> -static void cp_unpin_free(struct channel_program *cp)
> -{
> -	struct ccwchain *chain, *temp;
> -	int i;
> -
> -	list_for_each_entry_safe(chain, temp, &cp->ccwchain_list, next) {
> -		for (i = 0; i < chain->ch_len; i++) {
> -			pfn_array_table_unpin_free(chain->ch_pat + i,
> -						   cp->mdev);
> -			ccwchain_cda_free(chain, i);
> -		}
> -		ccwchain_free(chain);
> -	}
> -}
> -
>   /**
>    * ccwchain_calc_length - calculate the length of the ccw chain.
>    * @iova: guest physical address of the target ccw chain
> @@ -695,7 +679,7 @@ int cp_init(struct channel_program *cp, struct device *mdev, union orb *orb)
>   	/* Now loop for its TICs. */
>   	ret = ccwchain_loop_tic(chain, cp);
>   	if (ret)
> -		cp_unpin_free(cp);
> +		cp_free(cp);
>   	/* It is safe to force: if not set but idals used
>   	 * ccwchain_calc_length returns an error.
>   	 */
> @@ -715,7 +699,17 @@ int cp_init(struct channel_program *cp, struct device *mdev, union orb *orb)
>    */
>   void cp_free(struct channel_program *cp)
>   {
> -	cp_unpin_free(cp);
> +	struct ccwchain *chain, *temp;
> +	int i;
> +
> +	list_for_each_entry_safe(chain, temp, &cp->ccwchain_list, next) {
> +		for (i = 0; i < chain->ch_len; i++) {
> +			pfn_array_table_unpin_free(chain->ch_pat + i,
> +						   cp->mdev);
> +			ccwchain_cda_free(chain, i);
> +		}
> +		ccwchain_free(chain);
> +	}
>   }
>   
>   /**
> 

LGTM
Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>



-- 
Pierre Morel
Linux/KVM/QEMU in B�blingen - Germany
