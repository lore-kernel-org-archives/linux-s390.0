From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [RFC 05/19] s390/zcrypt: base implementation of AP matrix
 device driver
Date: Mon, 16 Oct 2017 10:59:24 +0200
Message-ID: <20171016105924.0662b311@mschwideX1>
References: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1507916344-3896-6-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507916344-3896-6-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, 13 Oct 2017 13:38:50 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> diff --git a/drivers/s390/crypto/Makefile b/drivers/s390/crypto/Makefile
> index 87646ca..1983afa 100644
> --- a/drivers/s390/crypto/Makefile
> +++ b/drivers/s390/crypto/Makefile
> @@ -13,4 +13,8 @@ obj-$(CONFIG_ZCRYPT) += zcrypt_pcixcc.o zcrypt_cex2a.o zcrypt_cex4.o
> 
>  # pkey kernel module
>  pkey-objs := pkey_api.o
> -obj-$(CONFIG_PKEY) += pkey.o
> \ No newline at end of file
> +obj-$(CONFIG_PKEY) += pkey.o
> +
> +# adjunct processor matrix
> +vfio_ap_matrix-objs := vfio_ap_matrix_drv.o
> +obj-$(CONFIG_VFIO_AP_MATRIX) += vfio_ap_matrix.o

With the fix to patch #3 the newline quirk will be gone.

> diff --git a/drivers/s390/crypto/ap_matrix_bus.c b/drivers/s390/crypto/ap_matrix_bus.c
> index 4eb1e3c..66bfa54 100644
> --- a/drivers/s390/crypto/ap_matrix_bus.c
> +++ b/drivers/s390/crypto/ap_matrix_bus.c
> @@ -75,10 +75,18 @@ static int ap_matrix_dev_create(void)
>  	return 0;
>  }
> 
> +struct ap_matrix *ap_matrix_get_device(void)
> +{
> +	return matrix;
> +}
> +EXPORT_SYMBOL(ap_matrix_get_device);
> +
>  int __init ap_matrix_init(void)
>  {
>  	int ret;
> 
> +	matrix = NULL;
> +
>  	ap_matrix_root_device = root_device_register(AP_MATRIX_BUS_NAME);
>  	ret = PTR_RET(ap_matrix_root_device);
>  	if (ret)

The global variable "matrix" is already NULL at the time ap_matrix_init is
called. No need to set it again. And I would appreciate if the global
variable would be named "ap_matrix".

> diff --git a/drivers/s390/crypto/ap_matrix_bus.h b/drivers/s390/crypto/ap_matrix_bus.h
> index 225db4f..c2aff23 100644
> --- a/drivers/s390/crypto/ap_matrix_bus.h
> +++ b/drivers/s390/crypto/ap_matrix_bus.h
> @@ -16,6 +16,6 @@ struct ap_matrix {
>  	struct device device;
>  };
> 
> -int ap_matrix_init(void);
> +struct ap_matrix *ap_matrix_get_device(void);
> 
>  #endif /* _AP_MATRIX_BUS_H_ */
> diff --git a/drivers/s390/crypto/vfio_ap_matrix_drv.c b/drivers/s390/crypto/vfio_ap_matrix_drv.c
> new file mode 100644
> index 0000000..760ed56
> --- /dev/null
> +++ b/drivers/s390/crypto/vfio_ap_matrix_drv.c
> @@ -0,0 +1,102 @@
> +/*
> + * VFIO based AP Matrix device driver
> + *
> + * Copyright IBM Corp. 2017
> + *
> + * Author(s): Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/slab.h>
> +
> +#include "ap_bus.h"
> +#include "ap_matrix_bus.h"
> +#include "vfio_ap_matrix_private.h"
> +
> +#define VFIO_AP_MATRIX_DRV_NAME "vfio_ap_queue"
> +
> +MODULE_AUTHOR("IBM Corporation");
> +MODULE_DESCRIPTION("AP Matrix device driver, Copyright IBM Corp. 2017");
> +MODULE_LICENSE("GPL v2");
> +
> +static struct ap_device_id ap_queue_ids[] = {
> +	{ .dev_type = AP_DEVICE_TYPE_CEX4,
> +	  .match_flags = AP_DEVICE_ID_MATCH_QUEUE_TYPE },
> +	{ .dev_type = AP_DEVICE_TYPE_CEX5,
> +	  .match_flags = AP_DEVICE_ID_MATCH_QUEUE_TYPE },
> +	{ .dev_type = AP_DEVICE_TYPE_CEX6,
> +	  .match_flags = AP_DEVICE_ID_MATCH_QUEUE_TYPE },
> +	{ /* end of list */ },
> +};
> +
> +MODULE_DEVICE_TABLE(ap_matrix, ap_queue_ids);
> +
> +static struct ap_matrix_driver {
> +	struct ap_driver ap_drv;
> +	struct ap_matrix *ap_matrix;
> +} vfio_ap_matrix_drv;
> +
> +static int ap_matrix_queue_dev_probe(struct ap_device *apdev)
> +{
> +	struct vfio_ap_queue *vapq;
> +	struct ap_queue *apq = to_ap_queue(&apdev->device);
> +	struct ap_matrix *ap_matrix = vfio_ap_matrix_drv.ap_matrix;
> +
> +	vapq = kzalloc(sizeof(*vapq), GFP_KERNEL);
> +	if (!vapq)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(&vapq->list);
> +	vapq->queue = apq;
> +	spin_lock_bh(&ap_matrix->qlock);
> +	list_add_tail(&vapq->list, &ap_matrix->queues);
> +	spin_unlock_bh(&ap_matrix->qlock);
> +
> +	return 0;
> +}
> +
> +static void ap_matrix_queue_dev_remove(struct ap_device *apdev)
> +{
> +	struct vfio_ap_queue *vapq;
> +	struct ap_queue *apq = to_ap_queue(&apdev->device);
> +	struct ap_matrix *ap_matrix = vfio_ap_matrix_drv.ap_matrix;
> +
> +	vapq = find_vapq(ap_matrix, apq->qid);
> +
> +	if (vapq) {
> +		spin_lock_bh(&ap_matrix->qlock);
> +		list_del_init(&vapq->list);
> +		spin_unlock_bh(&ap_matrix->qlock);
> +		kfree(vapq);
> +	}
> +}

I would opt for a quick exit if find_vapq can not find the device.
The un-indent the actual remove code.

> +
> +int __init ap_matrix_init(void)
> +{
> +
> +	int ret;
> +
> +	vfio_ap_matrix_drv.ap_matrix = ap_matrix_get_device();
> +	if (!vfio_ap_matrix_drv.ap_matrix)
> +		return -ENODEV;
> +
> +	vfio_ap_matrix_drv.ap_drv.probe = ap_matrix_queue_dev_probe;
> +	vfio_ap_matrix_drv.ap_drv.remove = ap_matrix_queue_dev_remove;
> +	vfio_ap_matrix_drv.ap_drv.ids = ap_queue_ids;
> +
> +	ret = ap_driver_register(&vfio_ap_matrix_drv.ap_drv,
> +				 THIS_MODULE, VFIO_AP_MATRIX_DRV_NAME);
> +	if (ret)
> +		return ret;
> +
> +	return ret;
> +}
> +
> +void __exit ap_matrix_exit(void)
> +{
> +	ap_driver_unregister(&vfio_ap_matrix_drv.ap_drv);
> +}
> +
> +module_init(ap_matrix_init);
> +module_exit(ap_matrix_exit);
> diff --git a/drivers/s390/crypto/vfio_ap_matrix_private.h b/drivers/s390/crypto/vfio_ap_matrix_private.h
> new file mode 100644
> index 0000000..11c5e02
> --- /dev/null
> +++ b/drivers/s390/crypto/vfio_ap_matrix_private.h
> @@ -0,0 +1,47 @@
> +/*
> + * Private data and functions for adjunct processor VFIO matrix driver.
> + *
> + * Copyright IBM Corp. 2016
> + * Author(s): Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> + */
> +
> +#ifndef _VFIO_AP_PRIVATE_H_
> +#define _VFIO_AP_PRIVATE_H_
> +
> +#include <linux/types.h>
> +
> +#include "ap_bus.h"
> +#include "ap_matrix_bus.h"
> +
> +#define VFIO_AP_MATRIX_MODULE_NAME "vfio_ap_matrix"
> +
> +struct vfio_ap_queue {
> +	struct ap_queue *queue;
> +	struct list_head list;
> +};
> +
> +static inline struct vfio_ap_queue *to_vapq(struct ap_device *ap_dev)
> +{
> +	struct ap_queue *ap_queue = to_ap_queue(&ap_dev->device);
> +	struct vfio_ap_queue *vapq;
> +
> +	vapq = container_of(&ap_queue, struct vfio_ap_queue, queue);
> +
> +	return vapq;
> +}

This can be shortened a bit

	return container_of(&ap_queue, struct vfio_ap_queue, queue);

> +
> +static inline struct vfio_ap_queue *find_vapq(struct ap_matrix *ap_matrix,
> +					      ap_qid_t qid)
> +{
> +	struct vfio_ap_queue *vapq;
> +
> +	if (!list_empty(&ap_matrix->queues)) {
> +		list_for_each_entry(vapq, &ap_matrix->queues, list)
> +			if (vapq->queue->qid == qid)
> +				return vapq;
> +	}
> +
> +	return NULL;
> +}
> +
> +#endif /* _VFIO_AP_PRIVATE_H_ */


-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
