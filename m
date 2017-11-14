From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: Re: [RFC 05/19] s390/zcrypt: base implementation of AP matrix device
 driver
Date: Tue, 14 Nov 2017 11:37:05 -0500
Message-ID: <06ddee4e-e1b8-ba17-5e3e-241e4dcf7cd0@linux.vnet.ibm.com>
References: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1507916344-3896-6-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20171114134040.3fcd6efd.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171114134040.3fcd6efd.cohuck@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 11/14/2017 07:40 AM, Cornelia Huck wrote:
> On Fri, 13 Oct 2017 13:38:50 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> Introduces a new AP matrix device driver. This device driver
>> will ultimately perform the following functions:
>>
>> * Register with the AP bus to let it know that the matrix
>>    driver can control AP queue devices. This will allow
>>    an administrator to unbind an AP queue device from its
>>    device driver and bind it to the matrix device driver.
>>    This is how AP queue devices will be reserved for use
>>    by guest machines.
>>
>> * Register the matrix device created by the AP matrix bus
>>    with the VFIO mediated device framework. This will create
>>    the sysfs entries needed to create mediated matrix devices.
>>    Each mediated matrix device can be configured with a matrix
>>    of adapters, usage domains and control domains that can be
>>    accessed by a guest machine.
>>
>> * Process requests via ioctl calls defined for the mediated
>>    matrix device. The guest can access the ioctl calls via
>>    the mediated device's file descriptor to:
>>
>>      * Grant access to the adapters, usage domains and
>>        control domains configured for the mediated matrix
>>        device.
>>
>> This device driver
>> is built on the VFIO mediated device framework. The VFIO mediated
>> device framework allows a mediated device to be dedicated exclusively
>> to a single guest VM.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> ---
>>   MAINTAINERS                                  |    2 +
>>   arch/s390/Kconfig                            |   13 +++
>>   arch/s390/configs/default_defconfig          |    1 +
>>   arch/s390/configs/gcov_defconfig             |    1 +
>>   arch/s390/configs/performance_defconfig      |    1 +
>>   arch/s390/defconfig                          |    1 +
>>   drivers/s390/crypto/Makefile                 |    6 +-
>>   drivers/s390/crypto/ap_matrix_bus.c          |    8 ++
>>   drivers/s390/crypto/ap_matrix_bus.h          |    2 +-
>>   drivers/s390/crypto/vfio_ap_matrix_drv.c     |  102 ++++++++++++++++++++++++++
>>   drivers/s390/crypto/vfio_ap_matrix_private.h |   47 ++++++++++++
>>   11 files changed, 182 insertions(+), 2 deletions(-)
>>   create mode 100644 drivers/s390/crypto/vfio_ap_matrix_drv.c
>>   create mode 100644 drivers/s390/crypto/vfio_ap_matrix_private.h
>>
>> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
>> index 48af970..411c19a 100644
>> --- a/arch/s390/Kconfig
>> +++ b/arch/s390/Kconfig
>> @@ -722,6 +722,19 @@ config VFIO_CCW
>>   	  To compile this driver as a module, choose M here: the
>>   	  module will be called vfio_ccw.
>>   
>> +config VFIO_AP_MATRIX
>> +	def_tristate m
>> +	prompt "Support for Adjunct Processor Matrix device interface"
>> +	depends on ZCRYPT
>> +	select VFIO
>> +	select MDEV
>> +	select VFIO_MDEV
>> +	select VFIO_MDEV_DEVICE
>> +	select IOMMU_API
> I think the more common pattern is to depend on the VFIO configs
> instead of selecting them.
It's ironic because I originally changed from using 'depends on' and 
changed it based on review comments made
on our internal mailing list. I'll go with 'depends on'.
>
>> +	help
>> +		driver grants access to Adjunct Processor (AP) devices
>> +		via the VFIO mediated device interface.
>> +
>>   endmenu
>>   
>>   menu "Dump support"
>> diff --git a/drivers/s390/crypto/Makefile b/drivers/s390/crypto/Makefile
>> index 87646ca..1983afa 100644
>> --- a/drivers/s390/crypto/Makefile
>> +++ b/drivers/s390/crypto/Makefile
>> @@ -13,4 +13,8 @@ obj-$(CONFIG_ZCRYPT) += zcrypt_pcixcc.o zcrypt_cex2a.o zcrypt_cex4.o
>>   
>>   # pkey kernel module
>>   pkey-objs := pkey_api.o
>> -obj-$(CONFIG_PKEY) += pkey.o
>> \ No newline at end of file
>> +obj-$(CONFIG_PKEY) += pkey.o
> Another change of that line.
Will fix this
>
>> +
>> +# adjunct processor matrix
>> +vfio_ap_matrix-objs := vfio_ap_matrix_drv.o
>> +obj-$(CONFIG_VFIO_AP_MATRIX) += vfio_ap_matrix.o
>> diff --git a/drivers/s390/crypto/ap_matrix_bus.c b/drivers/s390/crypto/ap_matrix_bus.c
>> index 4eb1e3c..66bfa54 100644
>> --- a/drivers/s390/crypto/ap_matrix_bus.c
>> +++ b/drivers/s390/crypto/ap_matrix_bus.c
>> @@ -75,10 +75,18 @@ static int ap_matrix_dev_create(void)
>>   	return 0;
>>   }
>>   
>> +struct ap_matrix *ap_matrix_get_device(void)
>> +{
>> +	return matrix;
> See the comments I had for the previous patch. In particular, I think
> it is better to retrieve a pointer to the matrix device via driver core
> methods.
I got some objections to creating a new bus and since there will only ever
be a single AP matrix device, I decided there really wasn't a need for an
AP matrix bus and got rid of it. I opted instead to create the matrix 
device
in the init function of the vfio_ap_matrix driver. Rather than passing 
around a
pointer, I put the following in vfio_ap_matrix_private.h:

     struct ap_matrix {
         struct device device;
         spinlock_t qlock;
         struct list_head queues;
     };

     extern struct ap_matrix ap_matrix;

... and declared the ap_matrix in  the driver (vfio_ap_matrix_drv.c) 
file as:

     struct ap_matrix ap_matrix;

Does this seem like a reasonable approach?


>
>> +}
>> +EXPORT_SYMBOL(ap_matrix_get_device);
>> +
>>   int __init ap_matrix_init(void)
>>   {
>>   	int ret;
>>   
>> +	matrix = NULL;
>> +
>>   	ap_matrix_root_device = root_device_register(AP_MATRIX_BUS_NAME);
>>   	ret = PTR_RET(ap_matrix_root_device);
>>   	if (ret)
>> diff --git a/drivers/s390/crypto/ap_matrix_bus.h b/drivers/s390/crypto/ap_matrix_bus.h
>> index 225db4f..c2aff23 100644
>> --- a/drivers/s390/crypto/ap_matrix_bus.h
>> +++ b/drivers/s390/crypto/ap_matrix_bus.h
>> @@ -16,6 +16,6 @@ struct ap_matrix {
>>   	struct device device;
>>   };
>>   
>> -int ap_matrix_init(void);
> So, was that not needed before?
Forgot to remove it when I refactored a previous patch in which was 
introduced.
>
>> +struct ap_matrix *ap_matrix_get_device(void);
>>   
>>   #endif /* _AP_MATRIX_BUS_H_ */
>> diff --git a/drivers/s390/crypto/vfio_ap_matrix_drv.c b/drivers/s390/crypto/vfio_ap_matrix_drv.c
>> new file mode 100644
>> index 0000000..760ed56
>> --- /dev/null
>> +++ b/drivers/s390/crypto/vfio_ap_matrix_drv.c
>> @@ -0,0 +1,102 @@
>> +/*
>> + * VFIO based AP Matrix device driver
>> + *
>> + * Copyright IBM Corp. 2017
>> + *
>> + * Author(s): Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/slab.h>
>> +
>> +#include "ap_bus.h"
>> +#include "ap_matrix_bus.h"
>> +#include "vfio_ap_matrix_private.h"
>> +
>> +#define VFIO_AP_MATRIX_DRV_NAME "vfio_ap_queue"
>> +
>> +MODULE_AUTHOR("IBM Corporation");
>> +MODULE_DESCRIPTION("AP Matrix device driver, Copyright IBM Corp. 2017");
>> +MODULE_LICENSE("GPL v2");
>> +
>> +static struct ap_device_id ap_queue_ids[] = {
>> +	{ .dev_type = AP_DEVICE_TYPE_CEX4,
>> +	  .match_flags = AP_DEVICE_ID_MATCH_QUEUE_TYPE },
>> +	{ .dev_type = AP_DEVICE_TYPE_CEX5,
>> +	  .match_flags = AP_DEVICE_ID_MATCH_QUEUE_TYPE },
>> +	{ .dev_type = AP_DEVICE_TYPE_CEX6,
>> +	  .match_flags = AP_DEVICE_ID_MATCH_QUEUE_TYPE },
> So, you explicitly don't match to all devices, but only to the newer
> ones? This needs an explaining comment.
Okay
>
>> +	{ /* end of list */ },
>> +};
>> +
>> +MODULE_DEVICE_TABLE(ap_matrix, ap_queue_ids);
>> +
>> +static struct ap_matrix_driver {
>> +	struct ap_driver ap_drv;
>> +	struct ap_matrix *ap_matrix;
> Do you actually need that pointer to the matrix device? One usage is to
> pass it as an parameter to the mdev registration in the next patch. As
> you only support one matrix device, would it be better to move getting
> that device into the mdev code?
>
> For the other usage, move getting it into find_vapq()?
See my comments above regarding getting rid of the AP matrix bus.
>
>> +} vfio_ap_matrix_drv;
>> +
>> +static int ap_matrix_queue_dev_probe(struct ap_device *apdev)
>> +{
>> +	struct vfio_ap_queue *vapq;
>> +	struct ap_queue *apq = to_ap_queue(&apdev->device);
>> +	struct ap_matrix *ap_matrix = vfio_ap_matrix_drv.ap_matrix;
>> +
>> +	vapq = kzalloc(sizeof(*vapq), GFP_KERNEL);
>> +	if (!vapq)
>> +		return -ENOMEM;
>> +
>> +	INIT_LIST_HEAD(&vapq->list);
>> +	vapq->queue = apq;
>> +	spin_lock_bh(&ap_matrix->qlock);
>> +	list_add_tail(&vapq->list, &ap_matrix->queues);
>> +	spin_unlock_bh(&ap_matrix->qlock);
>> +
>> +	return 0;
>> +}
>> +
>> +static void ap_matrix_queue_dev_remove(struct ap_device *apdev)
>> +{
>> +	struct vfio_ap_queue *vapq;
>> +	struct ap_queue *apq = to_ap_queue(&apdev->device);
>> +	struct ap_matrix *ap_matrix = vfio_ap_matrix_drv.ap_matrix;
>> +
>> +	vapq = find_vapq(ap_matrix, apq->qid);
>> +
>> +	if (vapq) {
>> +		spin_lock_bh(&ap_matrix->qlock);
>> +		list_del_init(&vapq->list);
>> +		spin_unlock_bh(&ap_matrix->qlock);
>> +		kfree(vapq);
>> +	}
>> +}
>> +
>> +int __init ap_matrix_init(void)
>> +{
>> +
>> +	int ret;
>> +
>> +	vfio_ap_matrix_drv.ap_matrix = ap_matrix_get_device();
>> +	if (!vfio_ap_matrix_drv.ap_matrix)
>> +		return -ENODEV;
>> +
>> +	vfio_ap_matrix_drv.ap_drv.probe = ap_matrix_queue_dev_probe;
>> +	vfio_ap_matrix_drv.ap_drv.remove = ap_matrix_queue_dev_remove;
>> +	vfio_ap_matrix_drv.ap_drv.ids = ap_queue_ids;
> Can you use an static initializer for that?
This is how its done for the AP bus drivers, for example; see zcrypt_cex4.c.
>
>> +
>> +	ret = ap_driver_register(&vfio_ap_matrix_drv.ap_drv,
>> +				 THIS_MODULE, VFIO_AP_MATRIX_DRV_NAME);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return ret;
>> +}
>> +
>> +void __exit ap_matrix_exit(void)
>> +{
>> +	ap_driver_unregister(&vfio_ap_matrix_drv.ap_drv);
>> +}
>> +
>> +module_init(ap_matrix_init);
>> +module_exit(ap_matrix_exit);
>> diff --git a/drivers/s390/crypto/vfio_ap_matrix_private.h b/drivers/s390/crypto/vfio_ap_matrix_private.h
>> new file mode 100644
>> index 0000000..11c5e02
>> --- /dev/null
>> +++ b/drivers/s390/crypto/vfio_ap_matrix_private.h
>> @@ -0,0 +1,47 @@
>> +/*
>> + * Private data and functions for adjunct processor VFIO matrix driver.
>> + *
>> + * Copyright IBM Corp. 2016
>> + * Author(s): Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> + */
>> +
>> +#ifndef _VFIO_AP_PRIVATE_H_
>> +#define _VFIO_AP_PRIVATE_H_
>> +
>> +#include <linux/types.h>
>> +
>> +#include "ap_bus.h"
>> +#include "ap_matrix_bus.h"
>> +
>> +#define VFIO_AP_MATRIX_MODULE_NAME "vfio_ap_matrix"
>> +
>> +struct vfio_ap_queue {
>> +	struct ap_queue *queue;
>> +	struct list_head list;
>> +};
>> +
>> +static inline struct vfio_ap_queue *to_vapq(struct ap_device *ap_dev)
>> +{
>> +	struct ap_queue *ap_queue = to_ap_queue(&ap_dev->device);
>> +	struct vfio_ap_queue *vapq;
>> +
>> +	vapq = container_of(&ap_queue, struct vfio_ap_queue, queue);
> Why not just return container_of(...); ?
Will change it.
>
>> +
>> +	return vapq;
>> +}
>> +
>> +static inline struct vfio_ap_queue *find_vapq(struct ap_matrix *ap_matrix,
>> +					      ap_qid_t qid)
>> +{
>> +	struct vfio_ap_queue *vapq;
>> +
>> +	if (!list_empty(&ap_matrix->queues)) {
>> +		list_for_each_entry(vapq, &ap_matrix->queues, list)
>> +			if (vapq->queue->qid == qid)
>> +				return vapq;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +#endif /* _VFIO_AP_PRIVATE_H_ */
