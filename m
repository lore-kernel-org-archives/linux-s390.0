From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v5 05/13] s390: vfio-ap: register matrix device with
 VFIO mdev framework
Date: Wed, 16 May 2018 12:42:40 +0200
Message-ID: <20180516124240.42dcd426.cohuck@redhat.com>
References: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1525705912-12815-6-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525705912-12815-6-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Mon,  7 May 2018 11:11:44 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

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
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> ---
>  MAINTAINERS                           |    1 +
>  drivers/s390/crypto/Makefile          |    2 +-
>  drivers/s390/crypto/vfio_ap_drv.c     |    9 +++
>  drivers/s390/crypto/vfio_ap_ops.c     |  106 +++++++++++++++++++++++++++++++++
>  drivers/s390/crypto/vfio_ap_private.h |   17 +++++
>  5 files changed, 134 insertions(+), 1 deletions(-)
>  create mode 100644 drivers/s390/crypto/vfio_ap_ops.c


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

Should be '2018' (also in some other files in this series; please
double check.)

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

Shouldn't the code check whether available_instances is actually > 0?

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
> +	struct ap_matrix *ap_matrix;
> +
> +	ap_matrix = to_ap_matrix(dev);

Move this with the declaration?

> +
> +	return sprintf(buf, "%d\n", ap_matrix->available_instances);
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
> +	mdev_unregister_device(&ap_matrix->device);
> +}
> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index cf23675..afd8dbc 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -10,14 +10,31 @@
>  #define _VFIO_AP_PRIVATE_H_
>  
>  #include <linux/types.h>
> +#include <linux/device.h>
> +#include <linux/mdev.h>
>  
>  #include "ap_bus.h"
>  
>  #define VFIO_AP_MODULE_NAME "vfio_ap"
>  #define VFIO_AP_DRV_NAME "vfio_ap"
> +/**
> + * There must be one mediated matrix device per guest. If every APQN is assigned

One, or at most one? Or one for every guest using ap devices?

> + * to a guest, then the maximum number of guests with a unique APQN assigned
> + * would be 255 adapters x 255 domains = 72351 guests.
> + */
> +#define AP_MATRIX_MAX_AVAILABLE_INSTANCES 72351
>  
>  struct ap_matrix {
>  	struct device device;
> +	int available_instances;
>  };
>  
> +static inline struct ap_matrix *to_ap_matrix(struct device *dev)
> +{
> +	return container_of(dev, struct ap_matrix, device);
> +}
> +
> +extern int vfio_ap_mdev_register(struct ap_matrix *ap_matrix);
> +extern void vfio_ap_mdev_unregister(struct ap_matrix *ap_matrix);
> +
>  #endif /* _VFIO_AP_PRIVATE_H_ */
