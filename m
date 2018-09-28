From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 28 Sep 2018 08:30:28 +0000
Subject: Re: [PATCH v2 1/2] s390/cio: Convert ccw_io_region to pointer
Message-Id: <20180928103028.1d27ecd3.cohuck@redhat.com>
In-Reply-To: <ac9024f0-f328-a838-a513-acb3bc7e4355@linux.ibm.com>
References: <ac9024f0-f328-a838-a513-acb3bc7e4355@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 27 Sep 2018 09:05:20 -0400
Eric Farman <farman@linux.ibm.com> wrote:

> On 09/27/2018 07:13 AM, Cornelia Huck wrote:
> > On Fri, 21 Sep 2018 22:40:12 +0200
> > Eric Farman <farman@linux.ibm.com> wrote:
> >   
> >> In the event that we want to change the layout of the ccw_io_region in the
> >> future[1], it might be easier to work with it as a pointer within the
> >> vfio_ccw_private struct rather than an embedded struct.
> >>
> >> [1] https://patchwork.kernel.org/comment/22228541/
> >>
> >> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> >> ---
> >>   drivers/s390/cio/vfio_ccw_drv.c     | 12 +++++++++++-
> >>   drivers/s390/cio/vfio_ccw_fsm.c     |  6 +++---
> >>   drivers/s390/cio/vfio_ccw_ops.c     |  4 ++--
> >>   drivers/s390/cio/vfio_ccw_private.h |  2 +-
> >>   4 files changed, 17 insertions(+), 7 deletions(-)
> >>  
> >   
> >> @@ -114,6 +114,14 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
> >>   	private = kzalloc(sizeof(*private), GFP_KERNEL | GFP_DMA);
> >>   	if (!private)
> >>   		return -ENOMEM;
> >> +
> >> +	private->io_region = kzalloc(sizeof(*private->io_region),
> >> +				     GFP_KERNEL | GFP_DMA);  
> > 
> > Any particular reason for this to be under 2G? Looking through the
> > code, I did not spot a place where we feed things in there directly to
> > an interface that is 2G sensitive.
> > 
> > I'm inclined to just keep it for now (as the structure it was taken
> > from was also allocated below 2G), but this might be a remainder of the
> > original implementation that was not using idals (and we might be able
> > to get rid of GFP_DMA here).  
> 
> I suspect you are right and it can be removed, since I don't see any 
> reason it needs to be.  But I don't know the history here, so I just 
> kept the same allocation.  I guess it makes sense to look into that 
> cleanup here.  But I did say this was a quick attempt.  :)

Yes, it makes sense to just keep the flags for now. We can still change
it easily on top.
