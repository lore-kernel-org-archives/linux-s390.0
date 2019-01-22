From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 22 Jan 2019 10:12:34 +0000
Subject: Re: [RFC v1 1/2] vfio-ccw: Don't assume there are more ccws after a TIC
Message-Id: <20190122111234.181a4bb6.cohuck@redhat.com>
In-Reply-To: <20190121185851.49c7dda5@oc2783563651>
References: <20190121185851.49c7dda5@oc2783563651>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 21 Jan 2019 09:54:08 -0500
Farhan Ali <alifm@linux.ibm.com> wrote:

> When trying to calculate the length of a ccw chain, we assume
> there are ccws after a TIC. This can lead to overcounting and
> copying garbage data from guest memory.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_cp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> index 17a1ee3..a820a21 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -392,7 +392,7 @@ static int ccwchain_calc_length(u64 iova, struct channel_program *cp)
>  			return -EOPNOTSUPP;
>  		}
>  
> -		if ((!ccw_is_chain(ccw)) && (!ccw_is_tic(ccw)))
> +		if (!ccw_is_chain(ccw))
>  			break;
>  
>  		ccw++;

Thanks, applied.
