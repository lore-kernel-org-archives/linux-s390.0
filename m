Return-Path: <SRS0=A7Pw=TP=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [PATCH v2 1/7] s390/cio: Update SCSW if it points to the end of
 the chain
References: <20190514234248.36203-1-farman@linux.ibm.com>
 <20190514234248.36203-2-farman@linux.ibm.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Wed, 15 May 2019 10:30:35 -0400
MIME-Version: 1.0
In-Reply-To: <20190514234248.36203-2-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <978ed329-cc81-b08f-8d59-ae92350abc17@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 05/14/2019 07:42 PM, Eric Farman wrote:
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
>   drivers/s390/cio/vfio_ccw_cp.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> index 384b3987eeb4..41f48b8790bc 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -870,7 +870,11 @@ void cp_update_scsw(struct channel_program *cp, union scsw *scsw)
>   	 */
>   	list_for_each_entry(chain, &cp->ccwchain_list, next) {
>   		ccw_head = (u32)(u64)chain->ch_ccw;
> -		if (is_cpa_within_range(cpa, ccw_head, chain->ch_len)) {
> +		/*
> +		 * On successful execution, cpa points just beyond the end
> +		 * of the chain.
> +		 */
> +		if (is_cpa_within_range(cpa, ccw_head, chain->ch_len + 1)) {
>   			/*
>   			 * (cpa - ccw_head) is the offset value of the host
>   			 * physical ccw to its chain head.
> 

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
