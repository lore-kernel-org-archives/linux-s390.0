Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46700 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfGIOTB (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 9 Jul 2019 10:19:01 -0400
Date: Tue, 9 Jul 2019 16:18:56 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC v2 2/5] vfio-ccw: Fix memory leak and don't call cp_free
 in cp_init
Message-ID: <20190709161856.269aca0d.cohuck@redhat.com>
In-Reply-To: <1a6f6e71-037f-455a-062d-0e8fdd2476c5@linux.ibm.com>
References: <cover.1562616169.git.alifm@linux.ibm.com>
        <fbb44bc85f5dfe4fdaebaf9cb74efcfae4743fba.1562616169.git.alifm@linux.ibm.com>
        <20190709120651.06d7666e.cohuck@redhat.com>
        <1a6f6e71-037f-455a-062d-0e8fdd2476c5@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: farman@linux.ibm.com, pasic@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Tue, 9 Jul 2019 10:07:57 -0400
Farhan Ali <alifm@linux.ibm.com> wrote:

> On 07/09/2019 06:06 AM, Cornelia Huck wrote:
> > On Mon,  8 Jul 2019 16:10:35 -0400
> > Farhan Ali <alifm@linux.ibm.com> wrote:
> >   
> >> We don't set cp->initialized to true so calling cp_free
> >> will just return and not do anything.
> >>
> >> Also fix a memory leak where we fail to free a ccwchain
> >> on an error.
> >>
> >> Fixes: 812271b910 ("s390/cio: Squash cp_free() and cp_unpin_free()")
> >> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> >> ---
> >>   drivers/s390/cio/vfio_ccw_cp.c | 11 +++++++----
> >>   1 file changed, 7 insertions(+), 4 deletions(-)  
> > 
> > (...)
> >   
> >> @@ -642,8 +647,6 @@ int cp_init(struct channel_program *cp, struct device *mdev, union orb *orb)
> >>   
> >>   	/* Build a ccwchain for the first CCW segment */
> >>   	ret = ccwchain_handle_ccw(orb->cmd.cpa, cp);
> >> -	if (ret)
> >> -		cp_free(cp);  
> > 
> > Now that I look again: it's a bit odd that we set the bit in all cases,
> > even if we have an error. We could move that into the !ret branch that
> > sets ->initialized; but it does not really hurt.  
> 
> By setting the bit, I am assuming you meant cmd.c64?
> 
> Yes, it doesn't harm anything but for better code readability you have a 
> good point. I will move it into !ret branch in the first patch since I 
> think it would be more appropriate there, no?

Yes to all of that :)

> 
> >   
> >>   
> >>   	/* It is safe to force: if it was not set but idals used
> >>   	 * ccwchain_calc_length would have returned an error.  
> > 
> > The rest of the patch looks good to me.
> > 
> >   
> 
