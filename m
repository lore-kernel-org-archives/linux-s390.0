Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26877 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726712AbgEFLYk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 May 2020 07:24:40 -0400
Date: Wed, 6 May 2020 13:24:27 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 1/1] vfio-ccw: Enable transparent CCW IPL from DASD
Message-ID: <20200506132427.2f64a07d.cohuck@redhat.com>
In-Reply-To: <20200506001544.16213-2-jrossi@linux.ibm.com>
References: <20200506001544.16213-1-jrossi@linux.ibm.com>
        <20200506001544.16213-2-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jared Rossi <jrossi@linux.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue,  5 May 2020 20:15:44 -0400
Jared Rossi <jrossi@linux.ibm.com> wrote:

> Remove the explicit prefetch check when using vfio-ccw devices.
> This check does not trigger in practice as all Linux channel programs
> are intended to use prefetch.
> 
> It is expected that all ORBs issued by Linux will request prefetch.
> Although non-prefetching ORBs are not rejected, they will prefetch
> nonetheless. A warning is issued up to once per 5 seconds when a
> forced prefetch occurs.
> 
> A non-prefetch ORB does not necessarily result in an error, however
> frequent encounters with non-prefetch ORBs indicate that channel
> programs are being executed in a way that is inconsistent with what
> the guest is requesting. While there is currently no known case of an
> error caused by forced prefetch, it is possible in theory that forced
> prefetch could result in an error if applied to a channel program that
> is dependent on non-prefetch.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>  Documentation/s390/vfio-ccw.rst |  6 ++++++
>  drivers/s390/cio/vfio_ccw_cp.c  | 19 ++++++++++++-------
>  2 files changed, 18 insertions(+), 7 deletions(-)
> 

(...)

> @@ -625,23 +626,27 @@ static int ccwchain_fetch_one(struct ccwchain *chain,
>   * the target channel program from @orb->cmd.iova to the new ccwchain(s).
>   *
>   * Limitations:
> - * 1. Supports only prefetch enabled mode.
> - * 2. Supports idal(c64) ccw chaining.
> - * 3. Supports 4k idaw.
> + * 1. Supports idal(c64) ccw chaining.
> + * 2. Supports 4k idaw.
>   *
>   * Returns:
>   *   %0 on success and a negative error value on failure.
>   */
>  int cp_init(struct channel_program *cp, struct device *mdev, union orb *orb)
>  {
> +	static DEFINE_RATELIMIT_STATE(ratelimit_state, 5 * HZ, 1);
>  	int ret;
>  
>  	/*
> -	 * XXX:
> -	 * Only support prefetch enable mode now.
> +	 * We only support prefetching the channel program. We assume all channel
> +	 * programs executed by supported guests (i.e. Linux) likewise support
> +	 * prefetching. Even if prefetching is not specified the channel program
> +	 * is still executed using prefetch. Executing a channel program that
> +	 * does not specify prefetching will typically not cause an error, but a
> +	 * warning is issued to help identify the problem if something does break.
>  	 */
> -	if (!orb->cmd.pfch)
> -		return -EOPNOTSUPP;

/* custom ratelimiting to avoid flood during boot */

(to avoid people stumbling over this)

> +	if (!orb->cmd.pfch && __ratelimit(&ratelimit_state))
> +		dev_warn(mdev, "executing channel program with prefetch, but prefetch isn't specified");

hmm... what about

"prefetching channel program even though prefetch not specified in orb"?

>  
>  	INIT_LIST_HEAD(&cp->ccwchain_list);
>  	memcpy(&cp->orb, orb, sizeof(*orb));

(...)

Apart from the bikeshedding, looks sane to me; but would like more
opinions.
