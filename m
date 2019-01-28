From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 5/5] vfio-ccw: add handling for async
 channel instructions
Date: Mon, 28 Jan 2019 18:40:58 +0100
Message-ID: <20190128184058.0eb49051.cohuck@redhat.com>
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-6-cohuck@redhat.com>
	<12de504b-3309-0f8b-fe35-01f870cde423@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
In-Reply-To: <12de504b-3309-0f8b-fe35-01f870cde423@linux.ibm.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 25 Jan 2019 16:00:38 -0500
Eric Farman <farman@linux.ibm.com> wrote:

> On 01/21/2019 06:03 AM, Cornelia Huck wrote:
> > Add a region to the vfio-ccw device that can be used to submit
> > asynchronous I/O instructions. ssch continues to be handled by the
> > existing I/O region; the new region handles hsch and csch.
> > 
> > Interrupt status continues to be reported through the same channels
> > as for ssch.
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >   drivers/s390/cio/Makefile           |   3 +-
> >   drivers/s390/cio/vfio_ccw_async.c   |  91 ++++++++++++++++++++++
> >   drivers/s390/cio/vfio_ccw_drv.c     |  45 +++++++----
> >   drivers/s390/cio/vfio_ccw_fsm.c     | 114 +++++++++++++++++++++++++++-
> >   drivers/s390/cio/vfio_ccw_ops.c     |  13 +++-
> >   drivers/s390/cio/vfio_ccw_private.h |   9 ++-
> >   include/uapi/linux/vfio.h           |   2 +
> >   include/uapi/linux/vfio_ccw.h       |  12 +++
> >   8 files changed, 269 insertions(+), 20 deletions(-)
> >   create mode 100644 drivers/s390/cio/vfio_ccw_async.c

(...)

> > @@ -149,7 +155,10 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
> >   	cio_disable_subchannel(sch);
> >   out_free:
> >   	dev_set_drvdata(&sch->dev, NULL);
> > -	kmem_cache_free(vfio_ccw_io_region, private->io_region);
> > +	if (private->cmd_region)
> > +		kmem_cache_free(vfio_ccw_cmd_region, private->cmd_region);
> > +	if (private->io_region)
> > +		kmem_cache_free(vfio_ccw_io_region, private->io_region);  
> 
> Well, adding the check if private->xxx_region is non-NULL is fine.  I'd 
> have made it a separate patch for io_region, but whatever.
> 
> Since you're adding that check, you should add the same if statement in 
> vfio_ccw_sch_remove().  And you should certainly call 
> kmem_cache_free(private->cmd_region) there too.  :)

Ehm, yes :)

> 
> >   	kfree(private);
> >   	return ret;
> >   }

(...)

> > +static int fsm_do_halt(struct vfio_ccw_private *private)
> > +{
> > +	struct subchannel *sch;
> > +	unsigned long flags;
> > +	int ccode;
> > +	int ret;
> > +
> > +	sch = private->sch;
> > +
> > +	spin_lock_irqsave(sch->lock, flags);
> > +
> > +	/* Issue "Halt Subchannel" */
> > +	ccode = hsch(sch->schid);
> > +
> > +	switch (ccode) {
> > +	case 0:
> > +		/*
> > +		 * Initialize device status information
> > +		 */
> > +		sch->schib.scsw.cmd.actl |= SCSW_ACTL_HALT_PEND;
> > +		ret = 0;
> > +		private->state = VFIO_CCW_STATE_BUSY;
> > +		break;
> > +	case 1:		/* Status pending */
> > +	case 2:		/* Busy */
> > +		ret = -EBUSY;
> > +		break;
> > +	case 3:		/* Device not operational */
> > +	{
> > +		ret = -ENODEV;
> > +		break;
> > +	}  
> 
> Why does cc3 get braces, but no other case does?  (Ditto for clear)
> 
> (I guess the answer is "because fsm_io_helper does" but I didn't notice 
> that before either.  :-)

Yes, the power of copy/paste :) But it makes sense to avoid adding them.

> 
> > +	default:
> > +		ret = ccode;
> > +	}
> > +	spin_unlock_irqrestore(sch->lock, flags);
> > +	return ret;
> > +}

(...)

> > +static void fsm_async_error(struct vfio_ccw_private *private,
> > +			    enum vfio_ccw_event event)
> > +{
> > +	pr_err("vfio-ccw: FSM: halt/clear request from state:%d\n",
> > +	       private->state);  
> 
> Had a little deja vu here.  :)
> 
> Can this message use private->cmd_region->command to tell us if it's a 
> halt, clear, or unknown?  Instead of just saying "halt/clear" statically.

Can do that; need to check if we need the mutex.

> 
> > +	private->cmd_region->ret_code = -EIO;
> > +}
> > +
