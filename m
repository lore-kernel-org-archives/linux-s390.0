From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 1/2] vfio: ccw: bypass bad idaw address when fetching
 IDAL ccws
Date: Mon, 16 Oct 2017 11:09:37 +0200
Message-ID: <20171016110937.253b0158.cohuck@redhat.com>
References: <20171011023822.42948-1-bjsdjshi@linux.vnet.ibm.com>
        <20171011023822.42948-2-bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171011023822.42948-2-bjsdjshi@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, 11 Oct 2017 04:38:21 +0200
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> We currently returns the same error code (-EFAULT) to indicate two

s/returns/return/

> different error cases:
> 1. a bug in vfio-ccw implementation has been found.
> 2. a buggy channel program has been detected.
> 
> This brings difficulty for userland program (specifically Qemu) to
> handle.
> 
> Let's use -EFAULT to only indicate the first case. For the second
> case, we simply hand over the ccws to lower level for further
> handling.
> 
> Notice:
> Once a bad idaw address is detected, the current behavior is to
> suppress the ssch. With this fix, the channel program will be
> accepted, and partial of the channel program (the part ahead of

s/partial/part/

> the bad idaw) could possibly be executed by the device before
> I/O conclusion.

That actually sounds more sensible than the current behaviour.

I'll fix up the typos when applying.

> 
> Suggested-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_cp.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> index 5ccfdc80d0ec..722f8b8c7273 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -569,10 +569,6 @@ static int ccwchain_fetch_idal(struct ccwchain *chain,
>  
>  	for (i = 0; i < idaw_nr; i++) {
>  		idaw_iova = *(idaws + i);
> -		if (IS_ERR_VALUE(idaw_iova)) {
> -			ret = -EFAULT;
> -			goto out_free_idaws;
> -		}
>  
>  		ret = pfn_array_alloc_pin(pat->pat_pa + i, cp->mdev,
>  					  idaw_iova, 1);
