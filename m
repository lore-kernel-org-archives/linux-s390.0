From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC v2 09/12] vfio/ccw: get irqs info and
 set the eventfd fd
Date: Wed, 18 Jan 2017 13:55:02 +0800
Message-ID: <29076.8780898818$1505296754@news.gmane.org>
References: <20170112072513.98411-1-bjsdjshi@linux.vnet.ibm.com>
	<20170112072513.98411-10-bjsdjshi@linux.vnet.ibm.com>
	<20170117155313.02de9785@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
Content-Disposition: inline
In-Reply-To: <20170117155313.02de9785@t450s.home>
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

* Alex Williamson <alex.williamson@redhat.com> [2017-01-17 15:53:13 -0700]:

> On Thu, 12 Jan 2017 08:25:10 +0100
> Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> 
> > From: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
> > 
> > vfio-ccw resorts to the eventfd mechanism to communicate with userspace.
> > We fetch the irqs info via the ioctl VFIO_DEVICE_GET_IRQ_INFO,
> > register a event notifier to get the eventfd fd which is sent
> > to kernel via the ioctl VFIO_DEVICE_SET_IRQS, then we can implement
> > read operation once kernel sends the signal.
> > 
> > Signed-off-by: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
> > ---
> >  hw/vfio/ccw.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 102 insertions(+)
> > 
> > diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> > index 93394c2..c6bfce7 100644
> > --- a/hw/vfio/ccw.c
> > +++ b/hw/vfio/ccw.c
> > @@ -21,6 +21,7 @@
> >  #include "hw/vfio/vfio-common.h"
> >  #include "hw/s390x/s390-ccw.h"
> >  #include "hw/s390x/ccw-device.h"
> > +#include "qemu/error-report.h"
> >  #include "standard-headers/asm-s390/vfio_ccw.h"
> >  
> >  #define TYPE_VFIO_CCW "vfio-ccw"
> > @@ -30,6 +31,7 @@ typedef struct VFIOCCWDevice {
> >      uint64_t io_region_size;
> >      uint64_t io_region_offset;
> >      struct ccw_io_region *io_region;
> > +    EventNotifier io_notifier;
> >  } VFIOCCWDevice;
> >  
> >  static void vfio_ccw_compute_needs_reset(VFIODevice *vdev)
> > @@ -54,6 +56,98 @@ static void vfio_ccw_reset(DeviceState *dev)
> >      ioctl(vcdev->vdev.fd, VFIO_DEVICE_RESET);
> >  }
> >  
> > +static void vfio_ccw_io_notifier_handler(void *opaque)
> > +{
> > +    VFIOCCWDevice *vcdev = opaque;
> > +
> > +    if (!event_notifier_test_and_clear(&vcdev->io_notifier)) {
> > +        return;
> > +    }
> > +}
> > +
> > +static void vfio_ccw_register_io_notifier(VFIOCCWDevice *vcdev, Error **errp)
> > +{
> > +    VFIODevice *vdev = &vcdev->vdev;
> > +    struct vfio_irq_info *irq_info;
> > +    struct vfio_irq_set *irq_set;
> > +    size_t argsz;
> > +    int32_t *pfd;
> > +
> > +    if (vdev->num_irqs != VFIO_CCW_NUM_IRQS) {
> > +        error_setg(errp, "vfio: unexpected number of io irqs %u",
> > +                   vdev->num_irqs);
> > +        return;
> > +    }
> 
> Same issue here as with region info, we may find reasons to add new
> interrupts in the kernel, it's happened for PCI support with things
> like device error recovery and requests to release the device.  Don't
> lock us into never expanding these, just make sure that the index that
> this implementation depends on is here.
> 
Ok. Will change it to:
    if (vdev->num_irqs < VFIO_CCW_IO_IRQ_INDEX + 1) {
        ... ...
    }

> > +
> > +    argsz = sizeof(*irq_set);
> > +    irq_info = g_malloc0(argsz);
> > +    irq_info->index = VFIO_CCW_IO_IRQ_INDEX;
> > +    irq_info->argsz = argsz;
> > +    if (ioctl(vdev->fd, VFIO_DEVICE_GET_IRQ_INFO,
> > +              irq_info) < 0 || irq_info->count < 1) {
> > +        error_setg(errp, "vfio: Error getting irq info");
> > +        goto get_error;
> > +    }
> > +
> > +    if (event_notifier_init(&vcdev->io_notifier, 0)) {
> > +        error_setg(errp, "vfio: Unable to init event notifier for IO");
> > +        goto get_error;
> > +    }
> > +
> > +    argsz = sizeof(*irq_set) + sizeof(*pfd);
> > +    irq_set = g_malloc0(argsz);
> > +    irq_set->argsz = argsz;
> > +    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD |
> > +                     VFIO_IRQ_SET_ACTION_TRIGGER;
> > +    irq_set->index = VFIO_CCW_IO_IRQ_INDEX;
> > +    irq_set->start = 0;
> > +    irq_set->count = 1;
> > +    pfd = (int32_t *) &irq_set->data;
> > +
> > +    *pfd = event_notifier_get_fd(&vcdev->io_notifier);
> > +    qemu_set_fd_handler(*pfd, vfio_ccw_io_notifier_handler, NULL, vcdev);
> > +    if (ioctl(vdev->fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
> > +        error_setg(errp, "vfio: Failed to set up io notification");
> > +        qemu_set_fd_handler(*pfd, NULL, NULL, vcdev);
> > +        event_notifier_cleanup(&vcdev->io_notifier);
> > +        goto set_error;
> > +    }
> > +
> > +set_error:
> > +    g_free(irq_set);
> > +
> > +get_error:
> > +    g_free(irq_info);
> > +}
> > +
[...]

-- 
Dong Jia
