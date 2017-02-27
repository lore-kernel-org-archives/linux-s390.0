From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC v3 11/15] vfio: ccw: realize
 VFIO_DEVICE_G(S)ET_IRQ_INFO ioctls
Date: Mon, 27 Feb 2017 09:44:57 +0800
Message-ID: <7191.16824116117$1505298061@news.gmane.org>
References: <20170217082939.33208-1-bjsdjshi@linux.vnet.ibm.com>
	<20170217082939.33208-12-bjsdjshi@linux.vnet.ibm.com>
	<20170224162724.6dd2eb0e@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
Content-Disposition: inline
In-Reply-To: <20170224162724.6dd2eb0e@t450s.home>
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

* Alex Williamson <alex.williamson@redhat.com> [2017-02-24 16:27:24 -0700]:

> On Fri, 17 Feb 2017 09:29:35 +0100
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
> >  drivers/s390/cio/vfio_ccw_ops.c     | 123 +++++++++++++++++++++++++++++++++++-
> >  drivers/s390/cio/vfio_ccw_private.h |   4 ++
> >  include/uapi/linux/vfio.h           |  10 ++-
> >  3 files changed, 134 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
> > index 125818c..ebc38fb 100644
> > --- a/drivers/s390/cio/vfio_ccw_ops.c
> > +++ b/drivers/s390/cio/vfio_ccw_ops.c
> > @@ -202,6 +202,9 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
> >  	if (region->ret_code != 0)
> >  		return region->ret_code;
> >  
> > +	if (private->io_trigger)
> > +		eventfd_signal(private->io_trigger, 1);
> > +
> >  	return count;
> >  }
> >  
> > @@ -209,7 +212,7 @@ static int vfio_ccw_mdev_get_device_info(struct vfio_device_info *info)
> >  {
> >  	info->flags = VFIO_DEVICE_FLAGS_CCW | VFIO_DEVICE_FLAGS_RESET;
> >  	info->num_regions = VFIO_CCW_NUM_REGIONS;
> > -	info->num_irqs = 0;
> > +	info->num_irqs = VFIO_CCW_NUM_IRQS;
> >  
> >  	return 0;
> >  }
> > @@ -230,6 +233,83 @@ static int vfio_ccw_mdev_get_region_info(struct vfio_region_info *info,
> >  	}
> >  }
> >  
> > +int vfio_ccw_mdev_get_irq_info(struct vfio_irq_info *info)
> > +{
> > +	if (info->index != VFIO_CCW_IO_IRQ_INDEX)
> > +		return -EINVAL;
> > +
> > +	info->count = 1;
> > +	info->flags = VFIO_IRQ_INFO_EVENTFD | VFIO_IRQ_INFO_NORESIZE;
> 
> I tend to think that NORESIZE isn't relevant when count is one.  We
> don't expose this flag on vfio-pci for INTx where there's only a single
> interrupt.  I don't really see how it applies, it's really trying to
> indicate if there are multiple sub-indexes within an index, if some are
> enabled, we cannot enable others without first disabling them all.
> Thus we can't resize the number of enabled sub-indexes.  There really
> are no sub-indexes when count is one.  Thanks,
Hi Alex,

I read the description of NORESIZE again, and I think you are right.
Since we do not have a subset of indexes here, I will remove this flag.

Thanks!

> 
> Alex
> 
> > +
> > +	return 0;
> > +}
> > +
[...]

-- 
Dong Jia
