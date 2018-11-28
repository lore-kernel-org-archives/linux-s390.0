From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [qemu-s390x] [PATCH 3/3] vfio-ccw: add handling
 for asnyc channel instructions
Date: Wed, 28 Nov 2018 17:36:04 +0100
Message-ID: <20181128173604.24b301a3@oc2783563651>
References: <20181122165432.4437-1-cohuck@redhat.com>
	<20181122165432.4437-4-cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
In-Reply-To: <20181122165432.4437-4-cohuck@redhat.com>
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org, qemu-s390x@nongnu.org, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 22 Nov 2018 17:54:32 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> Add a region to the vfio-ccw device that can be used to submit
> asynchronous I/O instructions. ssch continues to be handled by the
> existing I/O region; the new region handles hsch and csch.
> 
> Interrupt status continues to be reported through the same channels
> as for ssch.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  drivers/s390/cio/Makefile           |   3 +-
>  drivers/s390/cio/vfio_ccw_async.c   |  88 ++++++++++++++++
>  drivers/s390/cio/vfio_ccw_drv.c     |  48 ++++++---
>  drivers/s390/cio/vfio_ccw_fsm.c     | 158 +++++++++++++++++++++++++++-
>  drivers/s390/cio/vfio_ccw_ops.c     |  13 ++-
>  drivers/s390/cio/vfio_ccw_private.h |   6 ++
>  include/uapi/linux/vfio.h           |   4 +
>  include/uapi/linux/vfio_ccw.h       |  12 +++
>  8 files changed, 313 insertions(+), 19 deletions(-)
>  create mode 100644 drivers/s390/cio/vfio_ccw_async.c
> 
> diff --git a/drivers/s390/cio/Makefile b/drivers/s390/cio/Makefile
> index f230516abb96..f6a8db04177c 100644
> --- a/drivers/s390/cio/Makefile
> +++ b/drivers/s390/cio/Makefile
> @@ -20,5 +20,6 @@ obj-$(CONFIG_CCWGROUP) += ccwgroup.o
>  qdio-objs := qdio_main.o qdio_thinint.o qdio_debug.o qdio_setup.o
>  obj-$(CONFIG_QDIO) += qdio.o
>  
> -vfio_ccw-objs += vfio_ccw_drv.o vfio_ccw_cp.o vfio_ccw_ops.o vfio_ccw_fsm.o
> +vfio_ccw-objs += vfio_ccw_drv.o vfio_ccw_cp.o vfio_ccw_ops.o vfio_ccw_fsm.o \
> +	vfio_ccw_async.o
>  obj-$(CONFIG_VFIO_CCW) += vfio_ccw.o
> diff --git a/drivers/s390/cio/vfio_ccw_async.c b/drivers/s390/cio/vfio_ccw_async.c
> new file mode 100644
> index 000000000000..8c7f51d17d70
> --- /dev/null
> +++ b/drivers/s390/cio/vfio_ccw_async.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Async I/O region for vfio_ccw
> + *
> + * Copyright Red Hat, Inc. 2018
> + *
> + * Author(s): Cornelia Huck <cohuck@redhat.com>
> + */
> +
> +#include <linux/vfio.h>
> +#include <linux/mdev.h>
> +
> +#include "vfio_ccw_private.h"
> +
> +static size_t vfio_ccw_async_region_read(struct vfio_ccw_private *private,
> +					 char __user *buf, size_t count,
> +					 loff_t *ppos)
> +{
> +	unsigned int i = VFIO_CCW_OFFSET_TO_INDEX(*ppos) - VFIO_CCW_NUM_REGIONS;
> +	loff_t pos = *ppos & VFIO_CCW_OFFSET_MASK;
> +	struct ccw_cmd_region *region;
> +
> +	if (pos + count > sizeof(*region))
> +		return -EINVAL;
> +
> +	region = private->region[i].data;
> +	if (copy_to_user(buf, (void *)region + pos, count))
> +		return -EFAULT;
> +
> +	return count;
> +
> +}
> +
> +static size_t vfio_ccw_async_region_write(struct vfio_ccw_private *private,
> +					  const char __user *buf, size_t count,
> +					  loff_t *ppos)
> +{
> +	unsigned int i = VFIO_CCW_OFFSET_TO_INDEX(*ppos) - VFIO_CCW_NUM_REGIONS;
> +	loff_t pos = *ppos & VFIO_CCW_OFFSET_MASK;
> +	struct ccw_cmd_region *region;
> +
> +	if (pos + count > sizeof(*region))
> +		return -EINVAL;
> +
> +	if (private->state == VFIO_CCW_STATE_NOT_OPER ||
> +	    private->state == VFIO_CCW_STATE_STANDBY)
> +		return -EACCES;
> +
> +	region = private->region[i].data;
> +	if (copy_from_user((void *)region + pos, buf, count))
> +		return -EFAULT;

I guess vfio_ccw_async_region_write() is supposed to be reentrant in a
sense that there may be more that one 'instances' of the function
executing at the same time, or am I wrong?

If it is reenarant, I wonder what protects private->region[i].data from
corruption or simply being changed 'while at it'?

Regards,
Halil

> +
> +	switch (region->command) {
> +	case VFIO_CCW_ASYNC_CMD_HSCH:
> +		vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_HALT_REQ);
> +		break;
> +	case VFIO_CCW_ASYNC_CMD_CSCH:
> +		vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_CLEAR_REQ);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return region->ret_code ? region->ret_code : count;
> +}
> +
