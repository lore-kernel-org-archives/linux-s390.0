Return-Path: <SRS0=crtG=TI=vger.kernel.org=kvm-owner@kernel.org>
Date: Wed, 8 May 2019 12:43:27 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 3/7] s390/cio: Split pfn_array_alloc_pin into pieces
Message-ID: <20190508124327.5c496c8a.cohuck@redhat.com>
In-Reply-To: <20190503134912.39756-4-farman@linux.ibm.com>
References: <20190503134912.39756-1-farman@linux.ibm.com>
        <20190503134912.39756-4-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri,  3 May 2019 15:49:08 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> The pfn_array_alloc_pin routine is doing too much.  Today, it does the
> alloc of the pfn_array struct and its member arrays, builds the iova
> address lists out of a contiguous piece of guest memory, and asks vfio
> to pin the resulting pages.
> 
> Let's effectively revert a significant portion of commit 5c1cfb1c3948
> ("vfio: ccw: refactor and improve pfn_array_alloc_pin()") such that we
> break pfn_array_alloc_pin() into its component pieces, and have one
> routine that allocates/populates the pfn_array structs, and another
> that actually pins the memory.  In the future, we will be able to
> handle scenarios where pinning memory isn't actually appropriate.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_cp.c | 72 +++++++++++++++++++++++++++---------------
>  1 file changed, 47 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> index f86da78eaeaa..b70306c06150 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -50,28 +50,25 @@ struct ccwchain {
>  };
>  
>  /*
> - * pfn_array_alloc_pin() - alloc memory for PFNs, then pin user pages in memory
> + * pfn_array_alloc() - alloc memory for PFNs
>   * @pa: pfn_array on which to perform the operation
> - * @mdev: the mediated device to perform pin/unpin operations
>   * @iova: target guest physical address
>   * @len: number of bytes that should be pinned from @iova
>   *
> - * Attempt to allocate memory for PFNs, and pin user pages in memory.
> + * Attempt to allocate memory for PFN.

s/PFN/PFNs/

>   *
>   * Usage of pfn_array:
>   * We expect (pa_nr == 0) and (pa_iova_pfn == NULL), any field in
>   * this structure will be filled in by this function.
>   *
>   * Returns:
> - *   Number of pages pinned on success.
> - *   If @pa->pa_nr is not 0, or @pa->pa_iova_pfn is not NULL initially,
> - *   returns -EINVAL.
> - *   If no pages were pinned, returns -errno.
> + *         0 if PFNs are allocated
> + *   -EINVAL if pa->pa_nr is not initially zero, or pa->pa_iova_pfn is not NULL
> + *   -ENOMEM if alloc failed
>   */
> -static int pfn_array_alloc_pin(struct pfn_array *pa, struct device *mdev,
> -			       u64 iova, unsigned int len)
> +static int pfn_array_alloc(struct pfn_array *pa, u64 iova, unsigned int len)
>  {
> -	int i, ret = 0;
> +	int i;
>  
>  	if (!len)
>  		return 0;
> @@ -97,23 +94,33 @@ static int pfn_array_alloc_pin(struct pfn_array *pa, struct device *mdev,
>  	for (i = 1; i < pa->pa_nr; i++)
>  		pa->pa_iova_pfn[i] = pa->pa_iova_pfn[i - 1] + 1;
>  
> +	return 0;
> +}
> +
> +/*
> + * pfn_array_pin() - Pin user pages in memory
> + * @pa: pfn_array on which to perform the operation
> + * @mdev: the mediated device to perform pin operations
> + *
> + * Returns:
> + *   Number of pages pinned on success.
> + *   If fewer pages than requested were pinned, returns -EINVAL
> + *   If no pages were pinned, returns -errno.

I don't really like the 'returns -errno' :) It's actually the return
code of vfio_pin_pages(), and that might include -EINVAL as well.

So, what about mentioning in the function description that
pfn_array_pin() only succeeds if it coult pin all pages, and simply
stating that it returns a negative error value on failure?

> + */
> +static int pfn_array_pin(struct pfn_array *pa, struct device *mdev)
> +{
> +	int ret = 0;
> +
>  	ret = vfio_pin_pages(mdev, pa->pa_iova_pfn, pa->pa_nr,
>  			     IOMMU_READ | IOMMU_WRITE, pa->pa_pfn);
>  
> -	if (ret < 0) {
> -		goto err_out;
> -	} else if (ret > 0 && ret != pa->pa_nr) {
> +	if (ret > 0 && ret != pa->pa_nr) {
>  		vfio_unpin_pages(mdev, pa->pa_iova_pfn, ret);
>  		ret = -EINVAL;
> -		goto err_out;
>  	}
>  
> -	return ret;
> -
> -err_out:
> -	pa->pa_nr = 0;
> -	kfree(pa->pa_iova_pfn);
> -	pa->pa_iova_pfn = NULL;
> +	if (ret < 0)
> +		pa->pa_iova = 0;
>  
>  	return ret;
>  }

(...)
