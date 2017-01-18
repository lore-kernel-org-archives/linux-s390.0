From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC v2 11/15] vfio: ccw: introduce ioctls
 to get/set VFIO_CCW_IO_IRQ
Date: Wed, 18 Jan 2017 10:41:36 +0800
Message-ID: <4.56415950811362$1505296736@news.gmane.org>
References: <20170112071947.98071-1-bjsdjshi@linux.vnet.ibm.com>
	<20170112071947.98071-12-bjsdjshi@linux.vnet.ibm.com>
	<20170117140240.1a649b60@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
Content-Disposition: inline
In-Reply-To: <20170117140240.1a649b60@t450s.home>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: "Qemu-devel" <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-s390@vger.kernel.org, pasic@linux.vnet.ibm.com, kvm@vger.kernel.org, pmorel@linux.vnet.ibm.com, qemu-devel@nongnu.org, borntraeger@de.ibm.com, renxiaof@linux.vnet.ibm.com, wkywang@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, agraf@suse.com
List-ID: <linux-s390.vger.kernel.org>

* Alex Williamson <alex.williamson@redhat.com> [2017-01-17 14:02:40 -0700]:

> On Thu, 12 Jan 2017 08:19:43 +0100
> Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> 
> > Realize VFIO_DEVICE_GET_IRQ_INFO ioctl to retrieve
> > VFIO_CCW_IO_IRQ information.
> > 
> > Realize VFIO_DEVICE_SET_IRQS ioctl to set an eventfd fd for
> > VFIO_CCW_IO_IRQ. Once a write operation to the ccw_io_region
> > was performed, trigger a signal on this fd.
> > 
> > Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> > ---
> >  drivers/s390/cio/vfio_ccw_ops.c     | 125 +++++++++++++++++++++++++++++++++++-
> >  drivers/s390/cio/vfio_ccw_private.h |   4 ++
> >  include/uapi/linux/vfio.h           |  10 ++-
> >  3 files changed, 136 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
> > index b702735..3c47eb6 100644
> > --- a/drivers/s390/cio/vfio_ccw_ops.c
> > +++ b/drivers/s390/cio/vfio_ccw_ops.c
> > @@ -203,6 +203,9 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
> >  	if (region->ret_code != 0)
> >  		return region->ret_code;
> >  
> > +	if (private->io_trigger)
> > +		eventfd_signal(private->io_trigger, 1);
> > +
> >  	return count;
> >  }
> >  
> > @@ -211,7 +214,7 @@ static int vfio_ccw_mdev_get_device_info(struct mdev_device *mdev,
> >  {
> >  	info->flags = VFIO_DEVICE_FLAGS_CCW | VFIO_DEVICE_FLAGS_RESET;
> >  	info->num_regions = VFIO_CCW_NUM_REGIONS;
> > -	info->num_irqs = 0;
> > +	info->num_irqs = VFIO_CCW_NUM_IRQS;
> >  
> >  	return 0;
> >  }
> > @@ -233,6 +236,84 @@ static int vfio_ccw_mdev_get_region_info(struct mdev_device *mdev,
> >  	}
> >  }
> >  
> > +int vfio_ccw_mdev_get_irq_info(struct mdev_device *mdev,
> > +			       struct vfio_irq_info *info)
> > +{
> > +	if (info->index != VFIO_CCW_IO_IRQ_INDEX)
> > +		return -EINVAL;
> > +
> > +	info->count = VFIO_CCW_NUM_IRQS;
> > +	info->flags = VFIO_IRQ_INFO_EVENTFD | VFIO_IRQ_INFO_NORESIZE;
> 
> 
> VFIO_CCW_NUM_IRQS is not being used correctly here, info->count is the
> number of interrupts within this index, VFIO_CCW_NUM_IRQS is the number
> of indexes.  This is meant to handle things like PCI where we have 3
> different interrupts types (INTx, MSI, MSI-X) and some of those (MSI/X)
> support multiple vectors.  In this case I think you want info->count =
> 1 and you don't need the NORESIZE flag since that only makes sense for
> describing indexes where a subset of the available vectors may be
> enabled.  So info->count comes out to the same thing, but should not
> use the same macro to get there.
> 
Hi Alex,

I indeed use VFIO_CCW_NUM_IRQS here in a wrong way. Thanks for your
explanation. I will change it to:
	info->count = 1;

> > +
> > +	return 0;
> > +}
> > +
[...]

> > @@ -281,6 +362,48 @@ static ssize_t vfio_ccw_mdev_ioctl(struct mdev_device *mdev,
> >  
> >  		return copy_to_user((void __user *)arg, &info, minsz);
> >  	}
> > +	case VFIO_DEVICE_GET_IRQ_INFO:
> > +	{
> > +		struct vfio_irq_info info;
> > +
> > +		minsz = offsetofend(struct vfio_irq_info, count);
> > +
> > +		if (copy_from_user(&info, (void __user *)arg, minsz))
> > +			return -EFAULT;
> > +
> > +		if (info.argsz < minsz || info.index >= VFIO_CCW_NUM_IRQS)
> > +			return -EINVAL;
> > +
> > +		ret = vfio_ccw_mdev_get_irq_info(mdev, &info);
> > +		if (ret)
> > +			return ret;
> > +
> > +		if (info.count == -1)
> > +			return -EINVAL;
> > +
> > +		return copy_to_user((void __user *)arg, &info, minsz);
> > +	}
> > +	case VFIO_DEVICE_SET_IRQS:
> > +	{
> > +		struct vfio_irq_set hdr;
> > +		size_t data_size;
> > +		void __user *data;
> > +
> > +		minsz = offsetofend(struct vfio_irq_set, count);
> > +
> > +		if (copy_from_user(&hdr, (void __user *)arg, minsz))
> > +			return -EFAULT;
> > +
> > +		ret = vfio_set_irqs_validate_and_prepare(&hdr,
> > +							 VFIO_CCW_NUM_IRQS,
> > +							 VFIO_CCW_NUM_IRQS,
> > +							 &data_size);
> 
> 
> This is another instance, max_irq_type is referring to the index while
> num_irqs is referring to the count of vectors within this index.
> VFIO_CCW_NUM_IRQS should only be used for max_irq_type.

Ok. Will use 1 instead of VFIO_CCW_NUM_IRQS for @num_irqs.

> 
> > +		if (ret)
> > +			return ret;
> > +
> > +		data = (void __user *)(arg + minsz);
> > +		return vfio_ccw_mdev_set_irqs(mdev, hdr.flags, data);
> > +	}
> >  	case VFIO_DEVICE_RESET:
> >  		return vfio_ccw_mdev_reset(mdev);
> >  	default:
[...]

-- 
Dong Jia
