From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 05/14] s390: vfio-ap: base implementation of VFIO AP
 device driver
Date: Tue, 3 Apr 2018 09:02:24 -0400
Message-ID: <fa399df2-de08-2700-9cb5-6a7248a62896@linux.vnet.ibm.com>
References: <1521051954-25715-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1521051954-25715-6-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180403125737.15cb55fb.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180403125737.15cb55fb.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, akrowiak@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 04/03/2018 06:57 AM, Cornelia Huck wrote:
> On Wed, 14 Mar 2018 14:25:45 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> Introduces a new AP device driver. This device driver
>> is built on the VFIO mediated device framework. The framework
>> provides sysfs interfaces that facilitate passthrough
>> access by guests to devices installed on the linux host.
>>
>> The VFIO AP device driver will serve two purposes:
>>
>> 1. Provide the interfaces to reserve AP devices for exclusive
>>     use by KVM guests. This is accomplished by unbinding the
>>     devices to be reserved for guest usage from the default AP
>>     device driver and binding them to the VFIO AP device driver.
>>
>> 2. Implements the functions, callbacks and sysfs attribute
>>     interfaces required to create one or more VFIO mediated
>>     devices each of which will be used to configure the AP
>>     matrix for a guest and serve as a file descriptor
>>     for facilitating communication between QEMU and the
>>     VFIO AP device driver.
>>
>> When the VFIO AP device driver is initialized:
>>
>> * It registers with the AP bus for control of type 10 (CEX4
>>    and newer) AP queue devices. The probe and remove callbacks
>>    will be provided to support the binding/unbinding of
>>    AP queue devices to/from the VFIO AP device driver.
>>
>> * Creates a /sys/devices/vfio-ap/matrix device to hold
>>    the APQNs of the AP devices bound to the VFIO
>>    AP device driver and serves as the parent of the
>>    mediated devices created for each guest.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> ---
>>   MAINTAINERS                           |    2 +
>>   arch/s390/Kconfig                     |   11 +++
>>   drivers/s390/crypto/Makefile          |    4 +
>>   drivers/s390/crypto/vfio_ap_drv.c     |  135 +++++++++++++++++++++++++++++++++
>>   drivers/s390/crypto/vfio_ap_private.h |   22 ++++++
>>   include/uapi/linux/vfio.h             |    2 +
>>   6 files changed, 176 insertions(+), 0 deletions(-)
>>   create mode 100644 drivers/s390/crypto/vfio_ap_drv.c
>>   create mode 100644 drivers/s390/crypto/vfio_ap_private.h
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
>> new file mode 100644
>> index 0000000..459e595
>> --- /dev/null
>> +++ b/drivers/s390/crypto/vfio_ap_drv.c
>> @@ -0,0 +1,135 @@
>> +/*
>> + * VFIO based AP device driver
>> + *
>> + * Copyright IBM Corp. 2017
> Update to 2018?
Okay, will do.
>
>> + *
>> + * Author(s): Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/slab.h>
>> +
>> +#include "vfio_ap_private.h"
>> +
>> +#define VFIO_AP_ROOT_NAME "vfio_ap"
>> +#define VFIO_AP_DEV_TYPE_NAME "ap_matrix"
>> +#define VFIO_AP_DEV_NAME "matrix"
>> +
>> +MODULE_AUTHOR("IBM Corporation");
>> +MODULE_DESCRIPTION("VFIO AP device driver, Copyright IBM Corp. 2017");
>> +MODULE_LICENSE("GPL v2");
>> +
>> +static struct device *vfio_ap_root_device;
>> +
>> +static struct ap_driver vfio_ap_drv;
>> +
>> +static struct ap_matrix *ap_matrix;
>> +
>> +static struct device_type vfio_ap_dev_type = {
>> +	.name = VFIO_AP_DEV_TYPE_NAME,
>> +};
>> +
>> +/* Only type 10 adapters (CEX4 and later) are supported
>> + * by the AP matrix device driver
>> + */
>> +static struct ap_device_id ap_queue_ids[] = {
>> +	{ .dev_type = AP_DEVICE_TYPE_CEX4,
>> +	  .match_flags = AP_DEVICE_ID_MATCH_QUEUE_TYPE },
>> +	{ .dev_type = AP_DEVICE_TYPE_CEX5,
>> +	  .match_flags = AP_DEVICE_ID_MATCH_QUEUE_TYPE },
>> +	{ .dev_type = AP_DEVICE_TYPE_CEX6,
>> +	  .match_flags = AP_DEVICE_ID_MATCH_QUEUE_TYPE },
>> +	{ /* end of sibling */ },
>> +};
>> +
>> +MODULE_DEVICE_TABLE(vfio_ap, ap_queue_ids);
>> +
>> +static int vfio_ap_queue_dev_probe(struct ap_device *apdev)
>> +{
>> +	return 0;
>> +}
>> +
>> +static void vfio_ap_matrix_dev_release(struct device *dev)
>> +{
>> +	struct ap_matrix *ap_matrix = dev_get_drvdata(dev);
>> +
>> +	kfree(ap_matrix);
>> +}
>> +
>> +static int vfio_ap_matrix_dev_create(void)
>> +{
>> +	int ret;
>> +
>> +	vfio_ap_root_device = root_device_register(VFIO_AP_ROOT_NAME);
>> +
>> +	ret = IS_ERR(vfio_ap_root_device);
>> +	if (ret) {
> Minor nit: I'd contract that to
>
> if (IS_ERR(vfio_ap_root_device)) {
>
> (you're writing ret in any case)
Okay, will do.
>
>> +		ret = PTR_ERR(vfio_ap_root_device);
>> +		goto done;
>> +	}
>> +
>> +	ap_matrix = kzalloc(sizeof(*ap_matrix), GFP_KERNEL);
>> +	if (!ap_matrix) {
>> +		ret = -ENOMEM;
>> +		goto matrix_alloc_err;
>> +	}
>> +
>> +	ap_matrix->device.type = &vfio_ap_dev_type;
>> +	dev_set_name(&ap_matrix->device, "%s", VFIO_AP_DEV_NAME);
>> +	ap_matrix->device.parent = vfio_ap_root_device;
>> +	ap_matrix->device.release = vfio_ap_matrix_dev_release;
>> +	ap_matrix->device.driver = &vfio_ap_drv.driver;
>> +
>> +	ret = device_register(&ap_matrix->device);
>> +	if (ret)
>> +		goto matrix_reg_err;
>> +
>> +	goto done;
>> +
>> +matrix_reg_err:
>> +	put_device(&ap_matrix->device);
>> +	kfree(ap_matrix);
> The kfree() is wrong: If you called device_register for the embedded
> struct device, this needs to be handled via the ->release callback
> exclusively (IOW, the put_device() is enough and the kfree needs to go).
Ah yes, I see that. I will fix it.
>
>> +
>> +matrix_alloc_err:
>> +	root_device_unregister(vfio_ap_root_device);
>> +
>> +done:
>> +	return ret;
>> +}
