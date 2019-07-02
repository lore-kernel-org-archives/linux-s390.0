Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49050 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfGBI0J (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 2 Jul 2019 04:26:09 -0400
Date: Tue, 2 Jul 2019 10:26:06 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC v1 1/4] vfio-ccw: Set orb.cmd.c64 before calling
 ccwchain_handle_ccw
Message-ID: <20190702102606.2e9cfed3.cohuck@redhat.com>
In-Reply-To: <050943a6f5a427317ea64100bc2b4ec6394a4411.1561997809.git.alifm@linux.ibm.com>
References: <cover.1561997809.git.alifm@linux.ibm.com>
        <050943a6f5a427317ea64100bc2b4ec6394a4411.1561997809.git.alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: farman@linux.ibm.com, pasic@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Mon,  1 Jul 2019 12:23:43 -0400
Farhan Ali <alifm@linux.ibm.com> wrote:

> Because ccwchain_handle_ccw calls ccwchain_calc_length and
> as per the comment we should set orb.cmd.c64 before calling
> ccwchanin_calc_length.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_cp.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> index d6a8dff..5ac4c1e 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -640,16 +640,16 @@ int cp_init(struct channel_program *cp, struct device *mdev, union orb *orb)
>  	memcpy(&cp->orb, orb, sizeof(*orb));
>  	cp->mdev = mdev;
>  
> -	/* Build a ccwchain for the first CCW segment */
> -	ret = ccwchain_handle_ccw(orb->cmd.cpa, cp);
> -	if (ret)
> -		cp_free(cp);
> -
>  	/* It is safe to force: if not set but idals used
>  	 * ccwchain_calc_length returns an error.
>  	 */
>  	cp->orb.cmd.c64 = 1;
>  
> +	/* Build a ccwchain for the first CCW segment */
> +	ret = ccwchain_handle_ccw(orb->cmd.cpa, cp);
> +	if (ret)
> +		cp_free(cp);
> +
>  	if (!ret)
>  		cp->initialized = true;
>  

Hm... has this ever been correct, or did this break only with the
recent refactorings?

(IOW, what should Fixes: point to?)
