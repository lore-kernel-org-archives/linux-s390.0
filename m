From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 2/4] vfio: ccw: refactor and improve
 pfn_array_alloc_pin()
Date: Mon, 26 Mar 2018 15:28:46 +0200
Message-ID: <20180326152846.2ef1ae07.cohuck@redhat.com>
References: <20180321020822.86255-1-bjsdjshi@linux.vnet.ibm.com>
        <20180321020822.86255-3-bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180321020822.86255-3-bjsdjshi@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, 21 Mar 2018 03:08:20 +0100
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> This refactors pfn_array_alloc_pin() and also improves it by adding
> defensive code in error handling so that calling pfn_array_unpin_free()
> after error return won't lead to problem. This mains does:
> 1. Merge pfn_array_pin() into pfn_array_alloc_pin(), since there is no
>    other user of pfn_array_pin(). As a result, also remove kernel-doc
>    for pfn_array_pin() and add kernel-doc for pfn_array_alloc_pin().
> 2. For a vfio_pin_pages() failure, set pa->pa_nr to zero to indicate
>    zero pages were pinned.
> 3. Set pa->pa_iova_pfn to NULL right after it was freed.
> 
> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_cp.c | 84 ++++++++++++++++++------------------------
>  1 file changed, 36 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> index 2be114db02f9..3abc9770910a 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -46,65 +46,32 @@ struct ccwchain {
>  };
>  
>  /*
> - * pfn_array_pin() - pin user pages in memory
> + * pfn_array_alloc_pin() - alloc memory for PFNs, then pin user pages in memory
>   * @pa: pfn_array on which to perform the operation
>   * @mdev: the mediated device to perform pin/unpin operations
> + * @iova: target guest physical address
> + * @len: number of bytes that should be pinned from @iova
>   *
> - * Attempt to pin user pages in memory.
> + * Attempt to allocate memory for PFNs, and pin user pages in memory.
>   *
>   * Usage of pfn_array:
> - * @pa->pa_iova     starting guest physical I/O address. Assigned by caller.
> + * @pa->pa_iova     starting guest physical I/O address. Assigned by callee.
>   * @pa->pa_iova_pfn array that stores PFNs of the pages need to pin. Allocated
> - *                  by caller.
> + *                  by callee.
>   * @pa->pa_pfn      array that receives PFNs of the pages pinned. Allocated by
> - *                  caller.
> - * @pa->pa_nr       number of pages from @pa->pa_iova to pin. Assigned by
> - *                  caller.
> - *                  number of pages pinned. Assigned by callee.
> + *                  callee.
> + * @pa->pa_nr       initiated as 0 by caller.

s/initiated/initialized/

but see below

> + *                  number of pages pinned from @pa->pa_iova. Assigned by callee.

So, basically everything is filled by pfn_array_alloc_pin()? Should we
expect a clean struct pfn_array handed in by the caller, then (not just
pa_nr == 0)?

Would it make sense to describe the contents of the struct pfn_array
fields at the struct's definition instead? You could then shorten the
description here to "we expect pa_nr == 0, any field in this structure
will be filled in by this function".


>   *
>   * Returns:
>   *   Number of pages pinned on success.
> - *   If @pa->pa_nr is 0 or negative, returns 0.
> + *   If @pa->pa_nr is not 0 initially, returns -EINVAL.
>   *   If no pages were pinned, returns -errno.
>   */

The change itself looks good to me.
