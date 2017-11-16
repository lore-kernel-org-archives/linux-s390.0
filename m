From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: Re: [RFC 06/19] s390/zcrypt: register matrix device with VFIO
 mediated device framework
Date: Thu, 16 Nov 2017 10:37:15 -0500
Message-ID: <9504121b-c296-ba2d-c7d7-d95fa904b533@linux.vnet.ibm.com>
References: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1507916344-3896-7-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20171114141421.584811d9.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171114141421.584811d9.cohuck@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 11/14/2017 08:14 AM, Cornelia Huck wrote:
> On Fri, 13 Oct 2017 13:38:51 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> Registers the matrix device created by the AP matrix bus with
>> the VFIO mediated device framework. Registering the matrix
>> device will create the sysfs structures needed to create
>> mediated matrix devices that can be configured with a matrix
>> of adapters, usage domains and control domains for a guest
>> machine.
>>
>> Registering the matrix device with the VFIO mediated device
>> framework will create the following sysfs structures:
>>
>> /sys/devices/ap_matrix
>> ... [matrix]
>> ...... [mdev_supported_types]
>> ......... [ap_matrix-passthrough]
>> ............ available_instances
>> ............ create
>> ............ device_api
>> ............ [devices]
>> ............ name
>>
>> To create a mediated device for the AP matrix device, write a UUID
>> to the create file:
>>
>>      uuidgen > create
>>
>> A symbolic link to the mediated device's directory will be created in the
>> devices subdirectory named after the generated $uuid:
>>
>> /sys/devices/ap_matrix
>> ... [matrix]
>> ...... [mdev_supported_types]
>> ......... [ap_matrix-passthrough]
>> ............ [devices]
>> ............... [$uuid]
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> ---
>>   MAINTAINERS                                  |    1 +
>>   drivers/s390/crypto/Makefile                 |    2 +-
>>   drivers/s390/crypto/ap_matrix_bus.c          |    1 +
>>   drivers/s390/crypto/ap_matrix_bus.h          |    4 +
>>   drivers/s390/crypto/vfio_ap_matrix_drv.c     |    5 +
>>   drivers/s390/crypto/vfio_ap_matrix_ops.c     |  172 ++++++++++++++++++++++++++
>>   drivers/s390/crypto/vfio_ap_matrix_private.h |    3 +
>>   include/uapi/linux/vfio.h                    |    1 +
>>   8 files changed, 188 insertions(+), 1 deletions(-)
>>   create mode 100644 drivers/s390/crypto/vfio_ap_matrix_ops.c
>>
>> diff --git a/drivers/s390/crypto/ap_matrix_bus.c b/drivers/s390/crypto/ap_matrix_bus.c
>> index 66bfa54..418c23b 100644
>> --- a/drivers/s390/crypto/ap_matrix_bus.c
>> +++ b/drivers/s390/crypto/ap_matrix_bus.c
>> @@ -61,6 +61,7 @@ static int ap_matrix_dev_create(void)
>>   	matrix->device.bus = &ap_matrix_bus_type;
>>   	matrix->device.parent = ap_matrix_root_device;
>>   	matrix->device.release = ap_matrix_dev_release;
>> +	INIT_LIST_HEAD(&matrix->queues);
> Don't you also need to init the spin lock?
Yes, but note that I am getting rid of the AP matrix bus - as we 
discussed earlier - so
this code will be moved to the AP matrix driver.
>
>>   
>>   	ret = device_register(&matrix->device);
>>   	if (ret) {
>> diff --git a/drivers/s390/crypto/ap_matrix_bus.h b/drivers/s390/crypto/ap_matrix_bus.h
>> index c2aff23..3eccc36 100644
>> --- a/drivers/s390/crypto/ap_matrix_bus.h
>> +++ b/drivers/s390/crypto/ap_matrix_bus.h
>> @@ -12,8 +12,12 @@
>>   
>>   #include <linux/device.h>
>>   
>> +#include "ap_bus.h"
> Why do you need this include now? (IOW, does that need to go into
> another patch?)
It is not needed here, but as discussed earlier, the AP matrix bus is
going away.
>
>> +
>>   struct ap_matrix {
>>   	struct device device;
>> +	spinlock_t qlock;
>> +	struct list_head queues;
>>   };
>>   
>>   struct ap_matrix *ap_matrix_get_device(void);
>> diff --git a/drivers/s390/crypto/vfio_ap_matrix_ops.c b/drivers/s390/crypto/vfio_ap_matrix_ops.c
>> new file mode 100644
>> index 0000000..7d01f18
>> --- /dev/null
>> +++ b/drivers/s390/crypto/vfio_ap_matrix_ops.c
>> @@ -0,0 +1,172 @@
>> +/*
>> + * Adjunct processor matrix VFIO device driver callbacks.
>> + *
>> + * Copyright IBM Corp. 2017
>> + * Author(s): Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> + *
>> + */
>> +#include <asm/ap-config.h>
>> +#include <linux/string.h>
>> +#include <linux/vfio.h>
>> +#include <linux/mdev.h>
>> +#include <linux/device.h>
>> +#include <linux/list.h>
>> +#include <linux/ctype.h>
>> +
>> +#include "vfio_ap_matrix_private.h"
>> +
>> +#define AP_MATRIX_MDEV_TYPE_HWVIRT "passthrough"
>> +#define AP_MATRIX_MDEV_NAME_HWVIRT "AP Matrix Passthrough Device"
>> +
>> +#define AP_MATRIX_MAX_AVAILABLE_INSTANCES	255
>> +
>> +struct ap_matrix_mdev {
>> +	struct mdev_device *mdev;
>> +	struct list_head node;
>> +};
>> +
>> +struct ap_matrix	*matrix;
>> +struct mutex		mdev_devices_lock;
>> +struct list_head	mdev_devices;
>> +int			available_instances;
> Having this as a global variable feels wrong. I see that vfio-ccw keeps
> things like this in driver data attached to its parent. Can you do
> something like that as well?
I am moving all of these variables into struct ap_matrix. The matrix device
will be stored as driver data for the device so it will be retrievable by
the mdev functions. This will eliminate the need for these globals and
also omit the need to store a reference to the matrix device in
multiple places.

>
>> +
>> +static struct ap_matrix_mdev *ap_matrix_mdev_find_by_uuid(uuid_le uuid)
>> +{
>> +	struct ap_matrix_mdev *matrix_mdev;
>> +
>> +	list_for_each_entry(matrix_mdev, &mdev_devices, node) {
>> +		if (uuid_le_cmp(mdev_uuid(matrix_mdev->mdev), uuid) == 0)
>> +			return matrix_mdev;
>> +	}
>> +
>> +	return NULL;
>> +}
> (...)
>
>> +int ap_matrix_mdev_register(struct ap_matrix *ap_matrix)
>> +{
>> +	int ret;
>> +	struct device *dev = &ap_matrix->device;
>> +
>> +	ret = mdev_register_device(dev, &vfio_ap_matrix_ops);
>> +	if (ret)
>> +		return ret;
>> +
>> +	matrix = ap_matrix;
> I'd just grab the (one) matrix device here...
I am changing this so the matrix device will be stored as
driver data with the device:

     dev_set_drvdata(dev)
>
>> +	mutex_init(&mdev_devices_lock);
>> +	INIT_LIST_HEAD(&mdev_devices);
>> +	available_instances = AP_MATRIX_MAX_AVAILABLE_INSTANCES;
>> +
>> +	return 0;
>> +}
>> +
>> +void ap_matrix_mdev_unregister(struct ap_matrix *ap_matrix)
>> +{
>> +	struct device *dev;
>> +
>> +	if (ap_matrix == matrix) {
> ...and lose this extra if.
It is going bye bye.
>
>> +		dev = &matrix->device;
>> +		available_instances--;
>> +		mdev_unregister_device(dev);
>> +	}
>> +}
