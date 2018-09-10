From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v9 09/22] s390: vfio-ap: register matrix device with VFIO
 mdev framework
Date: Mon, 10 Sep 2018 23:58:29 +0200
Message-ID: <8f40992c-5dbe-92a2-2b9d-d29bd3647567@linux.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1534196899-16987-10-git-send-email-akrowiak@linux.vnet.ibm.com>
 <af1cd7a8-446c-ddf6-cf17-886dd259da3d@linux.ibm.com>
 <a89e99e9-5670-bc2e-8e08-a5f6edaaaf9c@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a89e99e9-5670-bc2e-8e08-a5f6edaaaf9c@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, pmorel@linux.ibm.com, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>



On 09/10/2018 03:38 PM, Tony Krowiak wrote:
> On 09/06/2018 04:49 AM, Pierre Morel wrote:
>> On 13/08/2018 23:48, Tony Krowiak wrote:
>>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>>
>>> Registers the matrix device created by the VFIO AP device
>>> driver with the VFIO mediated device framework.
>>> Registering the matrix device will create the sysfs
>>> structures needed to create mediated matrix devices
>>> each of which will be used to configure the AP matrix
>>> for a guest and connect it to the VFIO AP device driver.
>>>
>>> Registering the matrix device with the VFIO mediated device
>>> framework will create the following sysfs structures:
>>>
>>> /sys/devices/vfio_ap/matrix/
>>> ...... [mdev_supported_types]
>>> ......... [vfio_ap-passthrough]
>>> ............ create
>>>
>>> To create a mediated device for the AP matrix device, write a UUID
>>> to the create file:
>>>
>>>     uuidgen > create
>>>
>>> A symbolic link to the mediated device's directory will be created in the
>>> devices subdirectory named after the generated $uuid:
>>>
>>> /sys/devices/vfio_ap/matrix/
>>> ...... [mdev_supported_types]
>>> ......... [vfio_ap-passthrough]
>>> ............ [devices]
>>> ............... [$uuid]
>>>
>>> A symbolic link to the mediated device will also be created
>>> in the vfio_ap matrix's directory:
>>>
>>> /sys/devices/vfio_ap/matrix/[$uuid]
>>>
>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
>>> Tested-by: Michael Mueller <mimu@linux.ibm.com>
>>> Tested-by: Farhan Ali <alifm@linux.ibm.com>
>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> ---
>>>   MAINTAINERS                           |    1 +
>>>   drivers/s390/crypto/Makefile          |    2 +-
>>>   drivers/s390/crypto/vfio_ap_drv.c     |   23 ++++++
>>>   drivers/s390/crypto/vfio_ap_ops.c     |  124 +++++++++++++++++++++++++++++++++
>>>   drivers/s390/crypto/vfio_ap_private.h |   45 ++++++++++++
>>>   include/uapi/linux/vfio.h             |    1 +
>>>   6 files changed, 195 insertions(+), 1 deletions(-)
>>>   create mode 100644 drivers/s390/crypto/vfio_ap_ops.c
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index e84c559..f60dd56 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -12427,6 +12427,7 @@ W: http://www.ibm.com/developerworks/linux/linux390/
>>>   S:    Supported
>>>   F:    drivers/s390/crypto/vfio_ap_drv.c
>>>   F:    drivers/s390/crypto/vfio_ap_private.h
>>> +F:    drivers/s390/crypto/vfio_ap_ops.c
>>>
>>>   S390 ZFCP DRIVER
>>>   M:    Steffen Maier <maier@linux.ibm.com>
>>> diff --git a/drivers/s390/crypto/Makefile b/drivers/s390/crypto/Makefile
>>> index 48e466e..8d36b05 100644
>>> --- a/drivers/s390/crypto/Makefile
>>> +++ b/drivers/s390/crypto/Makefile
>>> @@ -17,5 +17,5 @@ pkey-objs := pkey_api.o
>>>   obj-$(CONFIG_PKEY) += pkey.o
>>>
>>>   # adjunct processor matrix
>>> -vfio_ap-objs := vfio_ap_drv.o
>>> +vfio_ap-objs := vfio_ap_drv.o vfio_ap_ops.o
>>>   obj-$(CONFIG_VFIO_AP) += vfio_ap.o
>>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
>>> index 5069580..fa04c5a 100644
>>> --- a/drivers/s390/crypto/vfio_ap_drv.c
>>> +++ b/drivers/s390/crypto/vfio_ap_drv.c
>>> @@ -11,6 +11,7 @@
>>>   #include <linux/mod_devicetable.h>
>>>   #include <linux/slab.h>
>>>   #include <linux/string.h>
>>> +#include <asm/zcrypt.h>
>>>   #include "vfio_ap_private.h"
>>>
>>>   #define VFIO_AP_ROOT_NAME "vfio_ap"
>>> @@ -65,6 +66,19 @@ static int vfio_ap_matrix_dev_init(void)
>>>           return ret;
>>>       }
>>>
>>> +    mutex_init(&matrix_dev.lock);
>>> +    INIT_LIST_HEAD(&matrix_dev.mdev_list);
>>> +
>>> +    /* Test if PQAP(QCI) instruction is available */
>>> +    if (test_facility(12)) {
>>> +        ret = ap_qci(&matrix_dev.info);
>>> +        if (ret) {
>>> +            root_device_unregister(root_device);
>>> +            return ret;
>>> +        }
>>> +    }
>>> +
>>> +    atomic_set(&matrix_dev.available_instances, MAX_ZDEV_ENTRIES_EXT);
>>>       matrix_dev.device.type = &vfio_ap_dev_type;
>>>       dev_set_name(&matrix_dev.device, "%s", VFIO_AP_DEV_NAME);
>>>       matrix_dev.device.type = &vfio_ap_dev_type;
>>> @@ -105,11 +119,20 @@ int __init vfio_ap_init(void)
>>>           return ret;
>>>       }
>>>
>>> +    ret = vfio_ap_mdev_register();
>>> +    if (ret) {
>>> +        ap_driver_unregister(&vfio_ap_drv);
>>> +        vfio_ap_matrix_dev_destroy();
>>> +
>>> +        return ret;
>>> +    }
>>> +
>>>       return 0;
>>>   }
>>>
>>>   void __exit vfio_ap_exit(void)
>>>   {
>>> +    vfio_ap_mdev_unregister();
>>>       ap_driver_unregister(&vfio_ap_drv);
>>>       vfio_ap_matrix_dev_destroy();
>>>   }
>>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>>> new file mode 100644
>>> index 0000000..8018c2d
>>> --- /dev/null
>>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>>> @@ -0,0 +1,124 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/*
>>> + * Adjunct processor matrix VFIO device driver callbacks.
>>> + *
>>> + * Copyright IBM Corp. 2018
>>> + *
>>> + * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
>>> + *          Halil Pasic <pasic@linux.ibm.com>
>>> + *          Pierre Morel <pmorel@linux.ibm.com>
>>> + */
>>> +#include <linux/string.h>
>>> +#include <linux/vfio.h>
>>> +#include <linux/device.h>
>>> +#include <linux/list.h>
>>> +#include <linux/ctype.h>
>>> +
>>> +#include "vfio_ap_private.h"
>>> +
>>> +#define VFIO_AP_MDEV_TYPE_HWVIRT "passthrough"
>>> +#define VFIO_AP_MDEV_NAME_HWVIRT "VFIO AP Passthrough Device"
>>> +
>>> +static void vfio_ap_matrix_init(struct ap_config_info *info,
>>> +                struct ap_matrix *matrix)
>>> +{
>>> +    matrix->apm_max = info->apxa ? info->Na : 63;
>>> +    matrix->aqm_max = info->apxa ? info->Nd : 15;
>>> +    matrix->adm_max = info->apxa ? info->Nd : 15;
>>> +}
>>> +
>>> +static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
>>> +{
>>> +    struct ap_matrix_mdev *matrix_mdev;
>>> +
>>> +    matrix_mdev = kzalloc(sizeof(*matrix_mdev), GFP_KERNEL);
>>> +    if (!matrix_mdev)
>>> +        return -ENOMEM;
>>> +
>>> +    matrix_mdev->name = dev_name(mdev_dev(mdev));
>>> +    vfio_ap_matrix_init(&matrix_dev.info, &matrix_mdev->matrix);
>>> +    mdev_set_drvdata(mdev, matrix_mdev);
>>> +
>>> +    if (atomic_dec_if_positive(&matrix_dev.available_instances) < 0) {
>>> +        kfree(matrix_mdev);
>>> +        return -EPERM;
>>> +    }
>>> +
>>> +    mutex_lock(&matrix_dev.lock);
>>> +    list_add(&matrix_mdev->list, &matrix_dev.mdev_list);
>>> +    mutex_unlock(&matrix_dev.lock);
>>> +
>> Hi Tony,
>>
>> You need to initialize the matrix_mdev->list before
>> using it.
> 
> Why? Initialization only sets its prev and next pointers to point to itself. The
> list_add immediately sets those pointers to insert it into the matrix_dev.mdev_list,
> so what would be the purose?
> 

I think the source of the confusion is that matrix_mdev->list a new element to be
added to the matrix_dev.mdev_list and not a sentinel node of some list (which in
a sense stands for the list as a whole).

Regards,
Halil
