From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 1/5] vfio: ccw: fix cleanup if cp_prefetch fails
Date: Mon, 23 Apr 2018 13:40:54 +0200
Message-ID: <20180423134054.2f7692d1.cohuck@redhat.com>
References: <20180423110113.59385-1-bjsdjshi@linux.vnet.ibm.com>
        <20180423110113.59385-2-bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180423110113.59385-2-bjsdjshi@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, borntraeger@de.ibm.com, bjsdjshi@linux.ibm.com, pasic@linux.ibm.com, pmorel@linux.ibm.com, Halil Pasic <pasic@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 23 Apr 2018 13:01:09 +0200
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> From: Halil Pasic <pasic@linux.vnet.ibm.com>
> 
> If the translation of a channel program fails, we may end up attempting
> to clean up (free, unpin) stuff that never got translated (and allocated,
> pinned) in the first place.
> 
> By adjusting the lengths of the chains accordingly (so the element that
> failed, and all subsequent elements are excluded) cleanup activities
> based on false assumptions can be avoided.
> 
> Let's make sure cp_free works properly after cp_prefetch returns with an
> error by setting ch_len of a ccw chain to the number of the translated
> CCWs on that chain.

Should that be cc:stable? This problem has been there probably since we
introduced vfio-ccw, no?

> 
> Acked-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_cp.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> index 2c7550797ec2..62d66e195304 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -715,6 +715,10 @@ void cp_free(struct channel_program *cp)
>   * and stores the result to ccwchain list. @cp must have been
>   * initialized by a previous call with cp_init(). Otherwise, undefined
>   * behavior occurs.
> + * For each chain composing the channel program:
> + * - On entry ch_len holds the count of CCW to be translated.
> + * - On exit ch_len is adjusted to the count of successfully translated CCW.
> + * This allows cp_free to find in ch_len the count of CCW to free in a chain.

s/CCW/CCWs/ (x3)?

Can change on applying.

>   *
>   * The S/390 CCW Translation APIS (prefixed by 'cp_') are introduced
>   * as helpers to do ccw chain translation inside the kernel. Basically
> @@ -749,11 +753,18 @@ int cp_prefetch(struct channel_program *cp)
>  		for (idx = 0; idx < len; idx++) {
>  			ret = ccwchain_fetch_one(chain, idx, cp);
>  			if (ret)
> -				return ret;
> +				goto out_err;
>  		}
>  	}
>  
>  	return 0;
> +out_err:
> +	/* Only cleanup the chain elements that were actually translated. */
> +	chain->ch_len = idx;
> +	list_for_each_entry_continue(chain, &cp->ccwchain_list, next) {
> +		chain->ch_len = 0;
> +	}
> +	return ret;
>  }
>  
>  /**

Else, looks good.
