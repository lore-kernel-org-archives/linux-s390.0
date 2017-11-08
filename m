From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 08 Nov 2017 13:58:53 +0000
Subject: Re: [PATCH v2] s390: vfio-ccw: Do not attempt to free no-op, test and tic cda.
Message-Id: <20171108145853.33690c97.cohuck@redhat.com>
In-Reply-To: <6b67da7d-c468-9951-cecc-12ee484c5276@de.ibm.com>
References: <6b67da7d-c468-9951-cecc-12ee484c5276@de.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue,  7 Nov 2017 10:22:32 -0500
"Jason J. Herne" <jjherne@linux.vnet.ibm.com> wrote:

> Because we do not make use of the cda (channel data address) for test,
> no-op ccws no address translation takes place. This means cda could
> contain a guest address which we do not want to attempt to free. Let's
> check the command type and skip cda free when it is not needed.
> 
> For a TIC ccw, ccw->cda points to either a ccw in an existing chain or
> it points to a whole new allocated chain. In either case the data will
> be freed when the owning chain is freed.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
> Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_cp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> index 5ccfdc8..325a9f4 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -329,6 +329,8 @@ static void ccwchain_cda_free(struct ccwchain *chain, int idx)
>  {
>  	struct ccw1 *ccw = chain->ch_ccw + idx;
>  
> +	if (ccw_is_test(ccw) || ccw_is_noop(ccw) || ccw_is_tic(ccw))
> +		return;
>  	if (!ccw->count)
>  		return;
>  

Thanks, applied.
