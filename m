From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 12 Nov 2018 10:20:23 +0000
Subject: Re: [PATCH v2 2/2] vfio: ccw: Register mediated device once all structures are initialized
Message-Id: <20181112112023.47fc9350.cohuck@redhat.com>
In-Reply-To: <f5c5cf53-9a18-4a4b-1b8d-1b5b9f5f7c9b@linux.ibm.com>
References: <f5c5cf53-9a18-4a4b-1b8d-1b5b9f5f7c9b@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 9 Nov 2018 15:13:17 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> On 11/09/2018 12:16 PM, Cornelia Huck wrote:
> > On Thu, 25 Oct 2018 19:15:20 +0200
> > Pierre Morel <pmorel@linux.ibm.com> wrote:
> >   
> >> Let's register the mediated device when all the data structures
> >> which could be used are initialized.
> >>
> >> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> >> Reviewed-by: Eric Farman <farman@linux.ibm.com>
> >> ---
> >>  drivers/s390/cio/vfio_ccw_drv.c | 8 ++++----
> >>  1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
> >> index f47d16b5810b..33fd53f49bf2 100644
> >> --- a/drivers/s390/cio/vfio_ccw_drv.c
> >> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> >> @@ -134,14 +134,14 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
> >>  	if (ret)
> >>  		goto out_free;
> >>  
> >> -	ret = vfio_ccw_mdev_reg(sch);
> >> -	if (ret)
> >> -		goto out_disable;
> >> -
> >>  	INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
> >>  	atomic_set(&private->avail, 1);
> >>  	private->state = VFIO_CCW_STATE_STANDBY;
> >>  
> >> +	ret = vfio_ccw_mdev_reg(sch);
> >> +	if (ret)
> >> +		goto out_disable;
> >> +
> >>  	return 0;
> >>  
> >>  out_disable:  
> > 
> > This patch looks fine, but ISTR that Halil was unhappy with the patch
> > description.
> > 
> > Any opinion on that? I'd like to queue this for 4.20.
> >   
> 
> That was the v1 patch description, which had multiple issues. The problem that got
> carried over is, that we still don't know if it is a bug-fix or just a readability
> improvement.
> 
> In the v1 discussion I questioned this being a bugfix, but we never finished the discussion
> because of KVM Forum.
> 
> Anyway, the new commit message does not read as bad (although I would drop 'which could
> be used' and if it isn't a bugfix also explain that the code was ok -- if it is a bugfix
> shouldn't we cc stable?).
> 
> Connie, if you don't feel like figuring out the bug or not question, feel free to just
> add an Ack by me and queue for 4.20.

I'm not sure we should spend more time on this, especially as the code
change looks fine.

Therefore, added your ack and applied.
