From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 05/13] s390: vfio-ap: register matrix device with VFIO
 mdev framework
Date: Tue, 15 May 2018 11:16:45 -0400
Message-ID: <afd54b28-e61c-a81e-41a3-6142d7277400@linux.vnet.ibm.com>
References: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1525705912-12815-6-git-send-email-akrowiak@linux.vnet.ibm.com>
 <5471b194-d7ca-c9c6-132e-fa9539fe44f0@linux.ibm.com>
 <4688078d-3e13-5201-582f-52576b25defa@linux.vnet.ibm.com>
 <1f9117bd-ed14-bde4-fdbd-cb3733c8c633@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1f9117bd-ed14-bde4-fdbd-cb3733c8c633@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pmorel@linux.ibm.com, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 05/15/2018 10:17 AM, Pierre Morel wrote:
> On 14/05/2018 21:42, Tony Krowiak wrote:
>> On 05/11/2018 01:18 PM, Halil Pasic wrote:
>>>
>>>
>>> On 05/07/2018 05:11 PM, Tony Krowiak wrote:
>>>> Registers the matrix device created by the VFIO AP device
>>>> driver with the VFIO mediated device framework.
>>>> Registering the matrix device will create the sysfs
>>>> structures needed to create mediated matrix devices
>>>> each of which will be used to configure the AP matrix
>>>> for a guest and connect it to the VFIO AP device driver.
>>>>
>>> [..]
>>>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c 
>>>> b/drivers/s390/crypto/vfio_ap_ops.c
>>>> new file mode 100644
>>>> index 0000000..d7d36fb
>>>> --- /dev/null
>>>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>>>> @@ -0,0 +1,106 @@
>>>> +// SPDX-License-Identifier: GPL-2.0+
>>>> +/*
>>>> + * Adjunct processor matrix VFIO device driver callbacks.
>>>> + *
>>>> + * Copyright IBM Corp. 2017
>>>> + * Author(s): Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>>>> + *
>>>> + */
>>>> +#include <linux/string.h>
>>>> +#include <linux/vfio.h>
>>>> +#include <linux/device.h>
>>>> +#include <linux/list.h>
>>>> +#include <linux/ctype.h>
>>>> +
>>>> +#include "vfio_ap_private.h"
>>>> +
>>>> +#define VFOP_AP_MDEV_TYPE_HWVIRT "passthrough"
>>>> +#define VFIO_AP_MDEV_NAME_HWVIRT "VFIO AP Passthrough Device"
>>>> +
>>>> +static int vfio_ap_mdev_create(struct kobject *kobj, struct 
>>>> mdev_device *mdev)
>>>> +{
>>>> +    struct ap_matrix *ap_matrix = 
>>>> to_ap_matrix(mdev_parent_dev(mdev));
>>>> +
>>>> +    ap_matrix->available_instances--;
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int vfio_ap_mdev_remove(struct mdev_device *mdev)
>>>> +{
>>>> +    struct ap_matrix *ap_matrix = 
>>>> to_ap_matrix(mdev_parent_dev(mdev));
>>>> +
>>>> +    ap_matrix->available_instances++;
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>
>>> The above functions seem to be called with the lock of this 
>>> auto-generated
>>> mdev parent device held. That's why we don't have to care about 
>>> synchronization
>>> ourselves, right?
>>
>> I would assume as much. The comments for the 'struct mdev_parent_ops' in
>> include/linux/mdev.h do not mention anything about synchronization, 
>> nor did I
>> see any locking or synchronization in the vfio_ccw implementation 
>> after which
>> I modeled my code, so frankly it is something I did not consider.
>>
>>>
>>>
>>> A small comment in the code could be helpful for mdev non-experts. 
>>> Hell, I would
>>> even consider documenting it for all mdev -- took me some time to 
>>> figure out.
>>
>> You may want to bring this up with the VFIO mdev maintainers, but I'd 
>> be happy to
>> include a comment in the functions in question if you think it 
>> important.
>>
>>>
>>>
>>> [..]
>>>
>>>
>>>> +int vfio_ap_mdev_register(struct ap_matrix *ap_matrix)
>>>> +{
>>>> +    int ret;
>>>> +
>>>> +    ret = mdev_register_device(&ap_matrix->device, 
>>>> &vfio_ap_matrix_ops);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    ap_matrix->available_instances = 
>>>> AP_MATRIX_MAX_AVAILABLE_INSTANCES;
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +void vfio_ap_mdev_unregister(struct ap_matrix *ap_matrix)
>>>> +{
>>>> +    ap_matrix->available_instances--;
>>>
>>> What is this for? I don't understand.
>>
>> To control the number of mediated devices one can create for the 
>> matrix device.
>> Once the max is reached, the mdev framework will not allow creation 
>> of another
>> mediated device until one is removed. This counter keeps track of the 
>> number
>> of instances that can be created. This is documented with the mediated
>> framework. You may want to take a look at:
>>
>> Documentation/vfio-mediated-device.txt
>> Documentation/vfio.txt
>> Documentation/virtual/kvm/devices/vfio.txt
>
> This is what you do in create/remove.
> But here in unregister I agree with Halil, it does not seem to be usefull.

If that is in fact what Halil was asking, then I misinterpreted his 
question; I
thought he was asking what the available_instances was used for. You are
correct, this does not belong here although it makes little difference given
this is called only when the driver, which creates the matrix device, is 
unloaded.
It is necessary in the register function to initialize its value, but I'll
remove it from here.

>
>
>>
>>>
>>>
>>> Regards,
>>> Halil
>>>
>>>> + mdev_unregister_device(&ap_matrix->device);
>>>> +}
>>
>>
>
