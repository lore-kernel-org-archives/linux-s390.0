From: Halil Pasic <pasic@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/4] vfio: ccw: fix cleanup if cp_prefetch fails
Date: Wed, 21 Mar 2018 13:49:54 +0100
Message-ID: <682d8b1c-5aca-7015-043b-a3f1446bf378@linux.vnet.ibm.com>
References: <20180321020822.86255-1-bjsdjshi@linux.vnet.ibm.com>
 <20180321020822.86255-2-bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180321020822.86255-2-bjsdjshi@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, pmorel@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>



On 03/21/2018 03:08 AM, Dong Jia Shi wrote:
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
> error by setting ch_len to 0 for the ccw chains those are not prefetched.

This sentence used to be:

Let's make sure cp_free works properly after cp_prefetch returns with an
error.

@Dong Jia
I find the 'by setting ch_len to 0 for the ccw chains those are not prefetched'
you added for clarification (I guess) somewhat problematic.
The chain in which the translation failure occurred
+	chain->ch_len = idx;
is shortened so that only the translated elements (ccws) are going to
get cleaned up (on a per element basis) by cp_free. This may or may
not be the first ccw. Subsequent chains are shortened to 0 as there
no translation took place.

So as a result of this change only properly translated ccws are going
to get (re)visited by cp_free as only those may have resources bound
to them which need to be released.

I'm not against improving the commit message. But this ain't
an improvement to me.

> 
> Acked-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_cp.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> index d9a2fffd034b..2be114db02f9 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -749,11 +749,18 @@ int cp_prefetch(struct channel_program *cp)
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
> +	/* Only cleanup the chain elements that where actually translated. */
> +	chain->ch_len = idx;
> +	list_for_each_entry_continue(chain, &cp->ccwchain_list, next) {
> +		chain->ch_len = 0;
> +	}
> +	return ret;
>  }
> 
>  /**
> 
