From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v5 05/13] s390: vfio-ap: register matrix device with VFIO
 mdev framework
Date: Fri, 11 May 2018 19:18:38 +0200
Message-ID: <5471b194-d7ca-c9c6-132e-fa9539fe44f0@linux.ibm.com>
References: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1525705912-12815-6-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525705912-12815-6-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>



On 05/07/2018 05:11 PM, Tony Krowiak wrote:
> Registers the matrix device created by the VFIO AP device
> driver with the VFIO mediated device framework.
> Registering the matrix device will create the sysfs
> structures needed to create mediated matrix devices
> each of which will be used to configure the AP matrix
> for a guest and connect it to the VFIO AP device driver.
> 
[..]
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> new file mode 100644
> index 0000000..d7d36fb
> --- /dev/null
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -0,0 +1,106 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Adjunct processor matrix VFIO device driver callbacks.
> + *
> + * Copyright IBM Corp. 2017
> + * Author(s): Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> + *
> + */
> +#include <linux/string.h>
> +#include <linux/vfio.h>
> +#include <linux/device.h>
> +#include <linux/list.h>
> +#include <linux/ctype.h>
> +
> +#include "vfio_ap_private.h"
> +
> +#define VFOP_AP_MDEV_TYPE_HWVIRT "passthrough"
> +#define VFIO_AP_MDEV_NAME_HWVIRT "VFIO AP Passthrough Device"
> +
> +static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
> +{
> +	struct ap_matrix *ap_matrix = to_ap_matrix(mdev_parent_dev(mdev));
> +
> +	ap_matrix->available_instances--;
> +
> +	return 0;
> +}
> +
> +static int vfio_ap_mdev_remove(struct mdev_device *mdev)
> +{
> +	struct ap_matrix *ap_matrix = to_ap_matrix(mdev_parent_dev(mdev));
> +
> +	ap_matrix->available_instances++;
> +
> +	return 0;
> +}
> +

The above functions seem to be called with the lock of this auto-generated
mdev parent device held. That's why we don't have to care about synchronization
ourselves, right?

A small comment in the code could be helpful for mdev non-experts. Hell, I would
even consider documenting it for all mdev -- took me some time to figure out.

[..]


> +int vfio_ap_mdev_register(struct ap_matrix *ap_matrix)
> +{
> +	int ret;
> +
> +	ret = mdev_register_device(&ap_matrix->device, &vfio_ap_matrix_ops);
> +	if (ret)
> +		return ret;
> +
> +	ap_matrix->available_instances = AP_MATRIX_MAX_AVAILABLE_INSTANCES;
> +
> +	return 0;
> +}
> +
> +void vfio_ap_mdev_unregister(struct ap_matrix *ap_matrix)
> +{
> +	ap_matrix->available_instances--;

What is this for? I don't understand.

Regards,
Halil

> +	mdev_unregister_device(&ap_matrix->device);
> +}
