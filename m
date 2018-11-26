From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 3/3] vfio-ccw: add handling for asnyc
 channel instructions
Date: Mon, 26 Nov 2018 10:47:49 +0100
Message-ID: <20181126104749.1bbff657.cohuck@redhat.com>
References: <20181122165432.4437-1-cohuck@redhat.com>
	<20181122165432.4437-4-cohuck@redhat.com>
	<91b54c7e-a7b1-b721-89be-12a5706a0e21@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
In-Reply-To: <91b54c7e-a7b1-b721-89be-12a5706a0e21@linux.ibm.com>
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
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 23 Nov 2018 14:08:03 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 22/11/2018 17:54, Cornelia Huck wrote:
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
> >   drivers/s390/cio/vfio_ccw_async.c   |  88 ++++++++++++++++
> >   drivers/s390/cio/vfio_ccw_drv.c     |  48 ++++++---
> >   drivers/s390/cio/vfio_ccw_fsm.c     | 158 +++++++++++++++++++++++++++-
> >   drivers/s390/cio/vfio_ccw_ops.c     |  13 ++-
> >   drivers/s390/cio/vfio_ccw_private.h |   6 ++
> >   include/uapi/linux/vfio.h           |   4 +
> >   include/uapi/linux/vfio_ccw.h       |  12 +++
> >   8 files changed, 313 insertions(+), 19 deletions(-)
> >   create mode 100644 drivers/s390/cio/vfio_ccw_async.c

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
> > +	private->state = VFIO_CCW_STATE_BUSY;
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
> > +	default:
> > +		ret = ccode;
> > +	}  
> 
> Shouldn't you set the state back here?

This is handled as for ssch, i.e. the state is restored by the caller.

> 
> > +	spin_unlock_irqrestore(sch->lock, flags);
> > +	return ret;
> > +}
> > +
> > +static int fsm_do_clear(struct vfio_ccw_private *private)
> > +{
> > +	struct subchannel *sch;
> > +	unsigned long flags;
> > +	int ccode;
> > +	int ret;
> > +
> > +	sch = private->sch;
> > +
> > +	spin_lock_irqsave(sch->lock, flags);
> > +	private->state = VFIO_CCW_STATE_BUSY;
> > +
> > +	/* Issue "Clear Subchannel" */
> > +	ccode = csch(sch->schid);
> > +
> > +	switch (ccode) {
> > +	case 0:
> > +		/*
> > +		 * Initialize device status information
> > +		 */
> > +		sch->schib.scsw.cmd.actl = SCSW_ACTL_CLEAR_PEND;
> > +		/* TODO: check what else we might need to clear */
> > +		ret = 0;
> > +		break;
> > +	case 3:		/* Device not operational */
> > +	{
> > +		ret = -ENODEV;
> > +		break;
> > +	}
> > +	default:
> > +		ret = ccode;
> > +	}
> > +	spin_unlock_irqrestore(sch->lock, flags);
> > +	return ret;

Same here, btw.

> > +}
> > +
> >   static void fsm_notoper(struct vfio_ccw_private *private,
> >   			enum vfio_ccw_event event)
> >   {
> > @@ -102,6 +179,20 @@ static void fsm_io_busy(struct vfio_ccw_private *private,
> >   	private->io_region->ret_code = -EBUSY;
> >   }
> >   
> > +static void fsm_async_error(struct vfio_ccw_private *private,
> > +			    enum vfio_ccw_event event)
> > +{
> > +	pr_err("vfio-ccw: FSM: halt/clear request from state:%d\n",
> > +	       private->state);
> > +	private->cmd_region->ret_code = -EIO;
> > +}
> > +
> > +static void fsm_async_busy(struct vfio_ccw_private *private,
> > +			   enum vfio_ccw_event event)
> > +{
> > +	private->cmd_region->ret_code = -EBUSY;
> > +}
> > +
> >   static void fsm_disabled_irq(struct vfio_ccw_private *private,
> >   			     enum vfio_ccw_event event)
> >   {
> > @@ -166,11 +257,11 @@ static void fsm_io_request(struct vfio_ccw_private *private,
> >   		}
> >   		return;
> >   	} else if (scsw->cmd.fctl & SCSW_FCTL_HALT_FUNC) {
> > -		/* XXX: Handle halt. */
> > +		/* halt is handled via the async cmd region */
> >   		io_region->ret_code = -EOPNOTSUPP;
> >   		goto err_out;
> >   	} else if (scsw->cmd.fctl & SCSW_FCTL_CLEAR_FUNC) {
> > -		/* XXX: Handle clear. */
> > +		/* clear is handled via the async cmd region */
> >   		io_region->ret_code = -EOPNOTSUPP;
> >   		goto err_out;  
> 
> What about filtering inside the vfio_ccw_mdev_write_io_region() before 
> the call to the FSM?

We can do that as well, maybe as a patch on top. What I like about
doing it here is that all poking into the I/O region is done in one
place. On the other hand, doing it beforehand saves us some churn.

> 
> 
> >   	}
> > @@ -181,6 +272,59 @@ static void fsm_io_request(struct vfio_ccw_private *private,
> >   			       io_region->ret_code, errstr);
> >   }
> >   
> > +/*
> > + * Deal with a halt request from userspace.
> > + */
> > +static void fsm_halt_request(struct vfio_ccw_private *private,
> > +			     enum vfio_ccw_event event)
> > +{
> > +	struct ccw_cmd_region *cmd_region = private->cmd_region;
> > +	int state = private->state;
> > +
> > +	private->state = VFIO_CCW_STATE_BOXED;
> > +
> > +	if (cmd_region->command != VFIO_CCW_ASYNC_CMD_HSCH) {
> > +		/* should not happen? */  
> 
> I think we should make sure it does not happen before we get here.
> Like serializing HALT and CLEAR before the FSM.

Given that there's only one generator of that event, that really should
not happen :) It would mean that we have messed up our code later on.
Maybe complain loudly here?

> 
> > +		cmd_region->ret_code = -EINVAL;
> > +		goto err_out;
> > +	}
> > +
> > +	cmd_region->ret_code = fsm_do_halt(private);  
> 
> fsm_do_halt() set the state to BUSY.
> Do we need a state change here and in fsm_do_halt ?
> 
> Why not only the BUSY state?

I basically took the ssch implementation and adapted it for halt/clear
handling. We can certainly think about doing state transitions in
different places, but I'd like to do that for all channel instructions
at the same time.

[Also note that this is still based on a version that still contains
the BOXED state.]

> 
> > +	if (cmd_region->ret_code)
> > +		goto err_out;
> > +
> > +	return;
> > +
> > +err_out:
> > +	private->state = state;
> > +}
> > +  
> 
> ...snip...
> 
> Regards,
> Pierre
> 
