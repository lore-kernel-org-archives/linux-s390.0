From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v9 08/22] s390: vfio-ap: base implementation of VFIO AP
 device driver
Date: Tue, 14 Aug 2018 12:42:20 +0200
Message-ID: <20180814124220.355f2ffa.cohuck@redhat.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1534196899-16987-9-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534196899-16987-9-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 13 Aug 2018 17:48:05 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:


> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> new file mode 100644
> index 0000000..5069580
> --- /dev/null
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -0,0 +1,118 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * VFIO based AP device driver
> + *
> + * Copyright IBM Corp. 2018
> + *
> + * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
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
> +#define VFIO_AP_DEV_NAME "matrix"
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
> +struct ap_matrix_dev matrix_dev;

Please don't add new statically allocated devices, but allocate it
dynamically (see the comment in device_add()).

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

You need a release callback as well.

> +
> +static int vfio_ap_matrix_dev_init(void)
> +{
> +	int ret;
> +	struct device *root_device;
> +
> +	root_device = root_device_register(VFIO_AP_ROOT_NAME);
> +	if (IS_ERR(root_device)) {
> +		ret = PTR_ERR(root_device);
> +		return ret;
> +	}
> +
> +	matrix_dev.device.type = &vfio_ap_dev_type;
> +	dev_set_name(&matrix_dev.device, "%s", VFIO_AP_DEV_NAME);
> +	matrix_dev.device.type = &vfio_ap_dev_type;
> +	matrix_dev.device.parent = root_device;
> +	matrix_dev.device.driver = &vfio_ap_drv.driver;
> +
> +	ret = device_register(&matrix_dev.device);
> +	if (ret) {
> +		root_device_unregister(root_device);

And this needs a put_device() for the matrix device. (It is getting
ugly with a statically allocated device.)

> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void vfio_ap_matrix_dev_destroy(void)
> +{
> +	device_unregister(&matrix_dev.device);

This one already does a put_device(). Didn't the driver core complain?

> +	root_device_unregister(matrix_dev.device.parent);
> +}
