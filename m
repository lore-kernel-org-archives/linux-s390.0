From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v6 08/21] s390: vfio-ap: register matrix device with VFIO
 mdev framework
Date: Mon, 9 Jul 2018 17:44:11 +0200
Message-ID: <e5247d62-60a3-d972-34d4-1019604fd18c@linux.ibm.com>
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1530306683-7270-9-git-send-email-akrowiak@linux.vnet.ibm.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1530306683-7270-9-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 29/06/2018 23:11, Tony Krowiak wrote:
> Registers the matrix device created by the VFIO AP device
> driver with the VFIO mediated device framework.
> Registering the matrix device will create the sysfs
> structures needed to create mediated matrix devices
> each of which will be used to configure the AP matrix
> for a guest and connect it to the VFIO AP device driver.
>
> Registering the matrix device with the VFIO mediated device
> framework will create the following sysfs structures:
>
> /sys/devices/vfio_ap
> ... [matrix]
> ...... [mdev_supported_types]
> ......... [vfio_ap-passthrough]
> ............ create
>
> To create a mediated device for the AP matrix device, write a UUID
> to the create file:
>
> 	uuidgen > create
>
> A symbolic link to the mediated device's directory will be created in the
> devices subdirectory named after the generated $uuid:
>
> /sys/devices/vfio_ap
> ... [matrix]
> ...... [mdev_supported_types]
> ......... [vfio_ap-passthrough]
> ............ [devices]
> ............... [$uuid]
>
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>   MAINTAINERS                           |    1 +
>   drivers/s390/crypto/Makefile          |    2 +-
>   drivers/s390/crypto/vfio_ap_drv.c     |    9 ++
>   drivers/s390/crypto/vfio_ap_ops.c     |  131 +++++++++++++++++++++++++++++++++
>   drivers/s390/crypto/vfio_ap_private.h |   22 +++++-
>   5 files changed, 161 insertions(+), 4 deletions(-)
>   create mode 100644 drivers/s390/crypto/vfio_ap_ops.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0515dae..3217803 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12410,6 +12410,7 @@ W:	http://www.ibm.com/developerworks/linux/linux390/
>   S:	Supported
>   F:	drivers/s390/crypto/vfio_ap_drv.c
>   F:	drivers/s390/crypto/vfio_ap_private.h
> +F:	drivers/s390/crypto/vfio_ap_ops.c
>
>   S390 ZFCP DRIVER
>   M:	Steffen Maier <maier@linux.ibm.com>
> diff --git a/drivers/s390/crypto/Makefile b/drivers/s390/crypto/Makefile
> index 48e466e..8d36b05 100644
> --- a/drivers/s390/crypto/Makefile
> +++ b/drivers/s390/crypto/Makefile
> @@ -17,5 +17,5 @@ pkey-objs := pkey_api.o
>   obj-$(CONFIG_PKEY) += pkey.o
>
>   # adjunct processor matrix
> -vfio_ap-objs := vfio_ap_drv.o
> +vfio_ap-objs := vfio_ap_drv.o vfio_ap_ops.o
>   obj-$(CONFIG_VFIO_AP) += vfio_ap.o
> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> index 93db312..b6ff7a4 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -127,11 +127,20 @@ int __init vfio_ap_init(void)
>   		return ret;
>   	}
>
> +	ret = vfio_ap_mdev_register(matrix_dev);
> +	if (ret) {
> +		ap_driver_unregister(&vfio_ap_drv);
> +		vfio_ap_matrix_dev_destroy(matrix_dev);
> +
> +		return ret;
> +	}
> +
>   	return 0;
>   }
>
>   void __exit vfio_ap_exit(void)
>   {
> +	vfio_ap_mdev_unregister(matrix_dev);
>   	ap_driver_unregister(&vfio_ap_drv);
>   	vfio_ap_matrix_dev_destroy(matrix_dev);
>   }
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> new file mode 100644
> index 0000000..4e61e33
> --- /dev/null
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -0,0 +1,131 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Adjunct processor matrix VFIO device driver callbacks.
> + *
> + * Copyright IBM Corp. 2018
> + * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
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

Isn't it a tipping fault ? VFIO != VFOP

> +#define VFIO_AP_MDEV_NAME_HWVIRT "VFIO AP Passthrough Device"
> +
> +DEFINE_SPINLOCK(mdev_list_lock);
> +LIST_HEAD(mdev_list);
> +
> +static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
> +{
> +	struct ap_matrix_dev *matrix_dev =
> +		to_ap_matrix_dev(mdev_parent_dev(mdev));
> +	struct ap_matrix_mdev *matrix_mdev;
> +
> +	matrix_mdev = kzalloc(sizeof(*matrix_mdev), GFP_KERNEL);
> +	if (!matrix_mdev)
> +		return -ENOMEM;
> +
> +	matrix_mdev->name = dev_name(mdev_dev(mdev));
> +	mdev_set_drvdata(mdev, matrix_mdev);
> +
> +	if (atomic_dec_if_positive(&matrix_dev->available_instances) < 0) {
> +		kfree(matrix_mdev);
> +		return -EPERM;
> +	}
> +
> +	spin_lock_bh(&mdev_list_lock);
> +	list_add(&matrix_mdev->list, &mdev_list);
> +	spin_unlock_bh(&mdev_list_lock);
> +
> +	return 0;
> +}
> +
> +static int vfio_ap_mdev_remove(struct mdev_device *mdev)
> +{
> +	struct ap_matrix_dev *matrix_dev =
> +		to_ap_matrix_dev(mdev_parent_dev(mdev));
> +	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> +
> +	spin_lock_bh(&mdev_list_lock);
> +	list_del(&matrix_mdev->list);
> +	spin_unlock_bh(&mdev_list_lock);
> +	kfree(matrix_mdev);
> +	mdev_set_drvdata(mdev, NULL);
> +	atomic_inc(&matrix_dev->available_instances);
> +
> +	return 0;
> +}
> +
> +static ssize_t name_show(struct kobject *kobj, struct device *dev, char *buf)
> +{
> +	return sprintf(buf, "%s\n", VFIO_AP_MDEV_NAME_HWVIRT);
> +}
> +
> +MDEV_TYPE_ATTR_RO(name);
> +
> +static ssize_t available_instances_show(struct kobject *kobj,
> +					struct device *dev, char *buf)
> +{
> +	struct ap_matrix_dev *matrix_dev = to_ap_matrix_dev(dev);
> +
> +	return sprintf(buf, "%d\n",
> +		       atomic_read(&matrix_dev->available_instances));
> +}
> +
> +MDEV_TYPE_ATTR_RO(available_instances);
> +
> +static ssize_t device_api_show(struct kobject *kobj, struct device *dev,
> +			       char *buf)
> +{
> +	return sprintf(buf, "%s\n", VFIO_DEVICE_API_AP_STRING);
> +}
> +
> +MDEV_TYPE_ATTR_RO(device_api);
> +
> +static struct attribute *vfio_ap_mdev_type_attrs[] = {
> +	&mdev_type_attr_name.attr,
> +	&mdev_type_attr_device_api.attr,
> +	&mdev_type_attr_available_instances.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group vfio_ap_mdev_hwvirt_type_group = {
> +	.name = VFOP_AP_MDEV_TYPE_HWVIRT,
> +	.attrs = vfio_ap_mdev_type_attrs,
> +};
> +
> +static struct attribute_group *vfio_ap_mdev_type_groups[] = {
> +	&vfio_ap_mdev_hwvirt_type_group,
> +	NULL,
> +};
> +
> +static const struct mdev_parent_ops vfio_ap_matrix_ops = {
> +	.owner			= THIS_MODULE,
> +	.supported_type_groups	= vfio_ap_mdev_type_groups,
> +	.create			= vfio_ap_mdev_create,
> +	.remove			= vfio_ap_mdev_remove,
> +};
> +
> +int vfio_ap_mdev_register(struct ap_matrix_dev *matrix_dev)
> +{
> +	int ret;
> +
> +	ret = mdev_register_device(&matrix_dev->device, &vfio_ap_matrix_ops);
> +	if (ret)
> +		return ret;
> +
> +	atomic_set(&matrix_dev->available_instances,
> +		   AP_MATRIX_MAX_AVAILABLE_INSTANCES);
> +
> +	return 0;
> +}
> +
> +void vfio_ap_mdev_unregister(struct ap_matrix_dev *matrix_dev)
> +{
> +	mdev_unregister_device(&matrix_dev->device);
> +}
> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index 19c0b60..3de1275 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -10,20 +10,36 @@
>   #define _VFIO_AP_PRIVATE_H_
>
>   #include <linux/types.h>
> +#include <linux/device.h>
> +#include <linux/mdev.h>
>
>   #include "ap_bus.h"
>
>   #define VFIO_AP_MODULE_NAME "vfio_ap"
>   #define VFIO_AP_DRV_NAME "vfio_ap"
> +/**
> + * There must be one mediated matrix device for every guest using AP devices.
> + * If every APQN is assigned to a guest, then the maximum number of guests with
> + * a unique APQN assigned would be 255 adapters x 255 domains = 72351 guests.
> + */
> +#define AP_MATRIX_MAX_AVAILABLE_INSTANCES 72351
>
>   struct ap_matrix_dev {
>   	struct device device;
> +	atomic_t available_instances;
> +};
> +
> +struct ap_matrix_mdev {
> +	const char *name;
> +	struct list_head list;
>   };
>
> -static inline struct ap_matrix_dev
> -*to_ap_matrix_parent_dev(struct device *dev)
> +static struct ap_matrix_dev *to_ap_matrix_dev(struct device *dev)
>   {
> -	return container_of(dev, struct ap_matrix_dev, device.parent);
> +	return container_of(dev, struct ap_matrix_dev, device);
>   }
>
> +extern int vfio_ap_mdev_register(struct ap_matrix_dev *matrix_dev);
> +extern void vfio_ap_mdev_unregister(struct ap_matrix_dev *matrix_dev);
> +
>   #endif /* _VFIO_AP_PRIVATE_H_ */


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
