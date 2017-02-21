From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH RFC v3 04/15] vfio: ccw: basic implementation for
 vfio_ccw driver
Date: Tue, 21 Feb 2017 16:43:07 +0100
Message-ID: <20170221164307.514141ee.cornelia.huck@de.ibm.com>
References: <20170217082939.33208-1-bjsdjshi@linux.vnet.ibm.com>
        <20170217082939.33208-5-bjsdjshi@linux.vnet.ibm.com>
        <20170220193113.3ba5af2c.cornelia.huck@de.ibm.com>
        <20170221073623.GJ562@bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170221073623.GJ562@bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, wkywang@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Tue, 21 Feb 2017 15:36:23 +0800
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> * Cornelia Huck <cornelia.huck@de.ibm.com> [2017-02-20 19:31:13 +0100]:
> 
> > On Fri, 17 Feb 2017 09:29:28 +0100
> > Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> > 
> > > To make vfio support subchannel devices, we need a css driver for
> > > the vfio subchannels. This patch adds a basic vfio-ccw subchannel
> > > driver for this purpose.
> > > 
> > > To enable VFIO for vfio-ccw, enable S390_CCW_IOMMU config option
> > > and configure VFIO as required.
> > > 
> > > Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > > Acked-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> > > ---
> > >  arch/s390/Kconfig                   |  10 ++
> > >  arch/s390/include/asm/isc.h         |   1 +
> > >  drivers/iommu/Kconfig               |   8 ++
> > >  drivers/s390/cio/Makefile           |   3 +
> > >  drivers/s390/cio/vfio_ccw_drv.c     | 262 ++++++++++++++++++++++++++++++++++++
> > >  drivers/s390/cio/vfio_ccw_private.h |  25 ++++
> > >  6 files changed, 309 insertions(+)
> > >  create mode 100644 drivers/s390/cio/vfio_ccw_drv.c
> > >  create mode 100644 drivers/s390/cio/vfio_ccw_private.h

> > > diff --git a/arch/s390/include/asm/isc.h b/arch/s390/include/asm/isc.h
> > > index 68d7d68..8a0b721 100644
> > > --- a/arch/s390/include/asm/isc.h
> > > +++ b/arch/s390/include/asm/isc.h
> > > @@ -16,6 +16,7 @@
> > >  #define CONSOLE_ISC 1			/* console I/O subchannel */
> > >  #define EADM_SCH_ISC 4			/* EADM subchannels */
> > >  #define CHSC_SCH_ISC 7			/* CHSC subchannels */
> > > +#define VFIO_CCW_ISC IO_SCH_ISC		/* VFIO-CCW I/O subchannels */
> > 
> > This is OK for now, I guess; but do we want to have the isc
> > configurable in the long run? I.e., if a host wants to run its own I/O
> > devices at a different priority than the devices it passes to a guest?
> > 
> I think we can keep this as the default value, and provide a driver
> param to customize the ISC value in the future once we need this. I put
> this on my LATER list, or I do it in next version?

This should a per-device knob, I think. It's ok to default to the
normal I/O subchannel isc.

We probably can add this at a later time when we're clear about the
requirements.

> 
> > >  /* Adapter interrupts. */
> > >  #define QDIO_AIRQ_ISC IO_SCH_ISC	/* I/O subchannel in qdio mode */
> > >  #define PCI_ISC 2			/* PCI I/O subchannels */
> > 
> > (...)
> > 
> > > diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
> > > new file mode 100644
> > > index 0000000..b068207
> > > --- /dev/null
> > > +++ b/drivers/s390/cio/vfio_ccw_drv.c
> > > @@ -0,0 +1,262 @@
> > > +/*
> > > + * VFIO based Physical Subchannel device driver
> > > + *
> > > + * Copyright IBM Corp. 2017
> > > + *
> > > + * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > > + *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
> > > + */
> > > +
> > > +#include <linux/module.h>
> > > +#include <linux/init.h>
> > > +#include <linux/device.h>
> > > +#include <linux/slab.h>
> > > +
> > > +#include <asm/isc.h>
> > > +
> > > +#include "vfio_ccw_private.h"
> > > +
> > > +/*
> > > + * Helpers
> > > + */
> > > +static int vfio_ccw_sch_quiesce(struct subchannel *sch)
> > > +{
> > > +	struct vfio_ccw_private *private = dev_get_drvdata(&sch->dev);
> > > +	DECLARE_COMPLETION_ONSTACK(completion);
> > > +	int iretry, ret = 0;
> > > +
> > > +	spin_lock_irq(sch->lock);
> > > +	if (!sch->schib.pmcw.ena)
> > > +		goto out_unlock;
> > > +	ret = cio_disable_subchannel(sch);
> > > +	if (ret != -EBUSY)
> > > +		goto out_unlock;
> > > +
> > > +	do {
> > > +		iretry = 255;
> > > +
> > > +		ret = cio_cancel_halt_clear(sch, &iretry);
> > > +		while (ret == -EBUSY) {
> > > +			/*
> > > +			 * Flushing all I/O and wait the
> > 
> > "Flush all I/O and wait for..."
> > 
> Ok.
> 
> > > +			 * cancel/halt/clear completion.
> > > +			 */
> > > +			private->completion = &completion;
> > > +			spin_unlock_irq(sch->lock);
> > > +
> > > +			wait_for_completion(&completion);
> > 
> > What happens for cancel? It won't generate an interrupt.
> > 
> Right! How about using:
> 	wait_for_completion_timeout(&completion, 3*HZ);
> 
> (I stole '3*HZ' from ccw_device_kill_io.)

That's likely a good place to steal from :)

> 
> > > +
> > > +			spin_lock_irq(sch->lock);
> > > +			private->completion = NULL;
> > > +			ret = cio_cancel_halt_clear(sch, &iretry);
> > > +		};
> > > +
> > > +		ret = cio_disable_subchannel(sch);
> > > +	} while (ret == -EBUSY);
> > > +
> > > +out_unlock:
> > > +	spin_unlock_irq(sch->lock);
> > > +	return ret;
> > > +}

> > > +static int vfio_ccw_sch_probe(struct subchannel *sch)
> > > +{
> > > +	struct pmcw *pmcw = &sch->schib.pmcw;
> > > +	struct vfio_ccw_private *private;
> > > +	int ret;
> > > +
> > > +	if (pmcw->qf) {
> > > +		dev_warn(&sch->dev, "vfio: ccw: do not support QDIO: %s\n",
> > 
> > s/do/does/
> > 
> Ok.
> 
> > > +			 dev_name(&sch->dev));
> > > +		return -ENOTTY;
> > 
> > Is -ENOTTY the right return code here? -EINVAL?
> > 
> Ok. Think it again. -EINVAL makes more sense. It's like:
> "hey, I know it's an I/O subchannel, but not the kind we support".

The driver core treats -ENODEV/-ENXIO as "driver matched, but rejected
the device". That's probably better, as we can't filter on device types
when binding at the subchannel level.

> 
> > > +	}
> > > +
> > > +	private = kzalloc(sizeof(*private), GFP_KERNEL | GFP_DMA);
> > > +	if (!private)
> > > +		return -ENOMEM;
> > > +	private->sch = sch;
> > > +	dev_set_drvdata(&sch->dev, private);
> > > +
> > > +	spin_lock_irq(sch->lock);
> > > +	sch->isc = VFIO_CCW_ISC;
> > > +	ret = cio_enable_subchannel(sch, (u32)(unsigned long)sch);
> > > +	spin_unlock_irq(sch->lock);
> > > +	if (ret)
> > > +		goto out_free;
> > > +
> > > +	ret = sysfs_create_group(&sch->dev.kobj, &vfio_subchannel_attr_group);
> > > +	if (ret)
> > > +		goto out_disable;
> > > +
> > > +	return 0;
> > > +
> > > +out_disable:
> > > +	cio_disable_subchannel(sch);
> > > +out_free:
> > > +	dev_set_drvdata(&sch->dev, NULL);
> > > +	kfree(private);
> > > +	return ret;
> > > +}
> > > +
> > 
> > (...)
> > 
> > > +/**
> > > + * vfio_ccw_sch_event - process subchannel event
> > > + * @sch: subchannel
> > > + * @process: non-zero if function is called in process context
> > > + *
> > > + * An unspecified event occurred for this subchannel. Adjust data according
> > > + * to the current operational state of the subchannel. Return zero when the
> > > + * event has been handled sufficiently or -EAGAIN when this function should
> > > + * be called again in process context.
> > > + */
> > > +static int vfio_ccw_sch_event(struct subchannel *sch, int process)
> > > +{
> > > +	unsigned long flags;
> > > +
> > > +	spin_lock_irqsave(sch->lock, flags);
> > > +	if (!device_is_registered(&sch->dev))
> > > +		goto out_unlock;
> > > +
> > > +	if (work_pending(&sch->todo_work))
> > > +		goto out_unlock;
> > > +
> > > +	if (cio_update_schib(sch)) {
> > > +		/* Not operational. */
> > > +		css_sched_sch_todo(sch, SCH_TODO_UNREG);
> > > +
> > > +		/*
> > > +		 * TODO:
> > > +		 * Probably we should send the machine check to the guest.
> > 
> > Yes, we should do that later on. Will user space notice that the device
> > is gone? (I think crw injection should be done by user space.)
> > 
> Currently we lack this mechanism. I think there are many todos here. I
> will investigate latter.

Yes. We just need to keep that in mind for later.

> 
> > > +		 */
> > > +		goto out_unlock;
> > > +	}
> > > +
> > > +out_unlock:
> > > +	spin_unlock_irqrestore(sch->lock, flags);
> > > +
> > > +	return 0;
> > > +}
