Return-Path: <SRS0=l9rD=TG=vger.kernel.org=kvm-owner@kernel.org>
Date: Mon, 6 May 2019 16:47:10 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 1/7] s390/cio: Update SCSW if it points to the end of
 the chain
Message-ID: <20190506164710.5fe0b6c8.cohuck@redhat.com>
In-Reply-To: <20190503134912.39756-2-farman@linux.ibm.com>
References: <20190503134912.39756-1-farman@linux.ibm.com>
        <20190503134912.39756-2-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri,  3 May 2019 15:49:06 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> Per the POPs [1], when processing an interrupt the SCSW.CPA field of an
> IRB generally points to 8 bytes after the last CCW that was executed
> (there are exceptions, but this is the most common behavior).
> 
> In the case of an error, this points us to the first un-executed CCW
> in the chain.  But in the case of normal I/O, the address points beyond
> the end of the chain.  While the guest generally only cares about this
> when possibly restarting a channel program after error recovery, we
> should convert the address even in the good scenario so that we provide
> a consistent, valid, response upon I/O completion.
> 
> [1] Figure 16-6 in SA22-7832-11.  The footnotes in that table also state
> that this is true even if the resulting address is invalid or protected,
> but moving to the end of the guest chain should not be a surprise.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_cp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> index 384b3987eeb4..f86da78eaeaa 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -870,7 +870,7 @@ void cp_update_scsw(struct channel_program *cp, union scsw *scsw)
>  	 */
>  	list_for_each_entry(chain, &cp->ccwchain_list, next) {
>  		ccw_head = (u32)(u64)chain->ch_ccw;
> -		if (is_cpa_within_range(cpa, ccw_head, chain->ch_len)) {
> +		if (is_cpa_within_range(cpa, ccw_head, chain->ch_len + 1)) {

Maybe add a comment

/* On successful execution, cpa points just beyond the end of the chain. */

or so, to avoid head-scratching and PoP-reading in the future?

>  			/*
>  			 * (cpa - ccw_head) is the offset value of the host
>  			 * physical ccw to its chain head.
