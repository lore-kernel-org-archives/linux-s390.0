From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v8 08/22] s390: vfio-ap: base implementation of VFIO AP
 device driver
Date: Thu, 9 Aug 2018 12:12:03 +0200
Message-ID: <20180809121203.3961e314.cohuck@redhat.com>
References: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1533739472-7172-9-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533739472-7172-9-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed,  8 Aug 2018 10:44:18 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> new file mode 100644
> index 0000000..d7e39ad
> --- /dev/null
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -0,0 +1,115 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * VFIO based AP device driver
> + *
> + * Copyright IBM Corp. 2018
> + *
> + * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
> + *	      Halil Pasic <pasic@linux.ibm.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include "vfio_ap_private.h"
> +
> +#define VFIO_AP_ROOT_NAME "vfio_ap"
> +#define VFIO_AP_DEV_TYPE_NAME "ap_matrix"
> +#define VFIO_AP_DEV_NAME "vfio_ap"
> +
> +MODULE_AUTHOR("IBM Corporation");
> +MODULE_DESCRIPTION("VFIO AP device driver, Copyright IBM Corp. 2018");
> +MODULE_LICENSE("GPL v2");
> +
> +static struct ap_driver vfio_ap_drv;
> +
> +static struct device_type vfio_ap_dev_type = {
> +	.name = VFIO_AP_DEV_TYPE_NAME,
> +};
> +
> +struct ap_matrix_dev matrix_dev = {
> +	/*
> +	 * We may add some fops later to implement a more program friendly
> +	 * management interface for vfio_ap_mdev devices.
> +	 */
> +	.misc_dev = {
> +		MISC_DYNAMIC_MINOR,
> +		VFIO_AP_DEV_NAME,
> +	}

Is there any reason why you embed a struct miscdevice and don't just
use it directly?

> +};
> +
> +/* Only type 10 adapters (CEX4 and later) are supported
> + * by the AP matrix device driver
> + */
> +static struct ap_device_id ap_queue_ids[] = {
> +	{ .dev_type = AP_DEVICE_TYPE_CEX4,
> +	  .match_flags = AP_DEVICE_ID_MATCH_QUEUE_TYPE },
> +	{ .dev_type = AP_DEVICE_TYPE_CEX5,
> +	  .match_flags = AP_DEVICE_ID_MATCH_QUEUE_TYPE },
> +	{ .dev_type = AP_DEVICE_TYPE_CEX6,
> +	  .match_flags = AP_DEVICE_ID_MATCH_QUEUE_TYPE },
> +	{ /* end of sibling */ },
> +};
> +
> +MODULE_DEVICE_TABLE(vfio_ap, ap_queue_ids);
> +
> +static int vfio_ap_queue_dev_probe(struct ap_device *apdev)
> +{
> +	return 0;
> +}
> +
> +static void vfio_ap_queue_dev_remove(struct ap_device *apdev)
> +{
> +	/* Nothing to do yet */
> +}
> +
> +static int vfio_ap_matrix_dev_create(void)
> +{
> +	int ret;
> +
> +	ret = misc_register(&matrix_dev.misc_dev);
> +	if (ret)
> +		return ret;
> +
> +	to_device(&matrix_dev)->type = &vfio_ap_dev_type;
> +	to_device(&matrix_dev)->driver = &vfio_ap_drv.driver;

This looks strange. Why would you want to change the driver for a
miscdevice, and that after it already has been registered? This feels
like a miscdevice is not the right choice here.

> +
> +	return ret;
> +}
> +
> +static void vfio_ap_matrix_dev_destroy(void)
> +{
> +	misc_deregister(&matrix_dev.misc_dev);
> +}
> +
> +int __init vfio_ap_init(void)
> +{
> +	int ret;
> +
> +	ret = vfio_ap_matrix_dev_create();
> +	if (ret)
> +		return ret;
> +
> +	memset(&vfio_ap_drv, 0, sizeof(vfio_ap_drv));
> +	vfio_ap_drv.probe = vfio_ap_queue_dev_probe;
> +	vfio_ap_drv.remove = vfio_ap_queue_dev_remove;
> +	vfio_ap_drv.ids = ap_queue_ids;
> +
> +	ret = ap_driver_register(&vfio_ap_drv, THIS_MODULE, VFIO_AP_DRV_NAME);
> +	if (ret) {
> +		vfio_ap_matrix_dev_destroy();
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +void __exit vfio_ap_exit(void)
> +{
> +	ap_driver_unregister(&vfio_ap_drv);
> +	vfio_ap_matrix_dev_destroy();
> +}
> +
> +module_init(vfio_ap_init);
> +module_exit(vfio_ap_exit);
> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> new file mode 100644
> index 0000000..02c878c
> --- /dev/null
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Private data and functions for adjunct processor VFIO matrix driver.
> + *
> + * Copyright IBM Corp. 2018
> + */
> +
> +#ifndef _VFIO_AP_PRIVATE_H_
> +#define _VFIO_AP_PRIVATE_H_
> +
> +#include <linux/types.h>
> +#include <linux/miscdevice.h>
> +
> +#include "ap_bus.h"
> +
> +#define VFIO_AP_MODULE_NAME "vfio_ap"
> +#define VFIO_AP_DRV_NAME "vfio_ap"
> +
> +struct ap_matrix_dev {
> +	struct miscdevice misc_dev;
> +};
> +
> +extern struct ap_matrix_dev matrix_dev;
> +
> +static inline struct device *to_device(struct ap_matrix_dev *matrix_dev)
> +{
> +	return matrix_dev->misc_dev.this_device;
> +}

Even if you keep it as a miscdevice, I don't like that function,
especially the naming. Frankly, I'd simply drop it.

> +
> +#endif /* _VFIO_AP_PRIVATE_H_ */
