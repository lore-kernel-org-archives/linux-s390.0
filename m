From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v4 6/7] s390: ap: Cleanup on removing the AP device
Date: Tue, 12 Mar 2019 17:53:55 -0400
Message-ID: <cf148acb-1a07-ffa3-f728-0f6b02aa914d@linux.ibm.com>
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
 <1550849400-27152-7-git-send-email-pmorel@linux.ibm.com>
 <3956ad4c-55c9-e42c-4ab2-00ddae05b317@linux.ibm.com>
 <94904df0-42b6-51f8-6440-68722ef5419d@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <94904df0-42b6-51f8-6440-68722ef5419d@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pmorel@linux.ibm.com, borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 3/11/19 4:31 AM, Pierre Morel wrote:
> On 08/03/2019 23:43, Tony Krowiak wrote:
>> On 2/22/19 10:29 AM, Pierre Morel wrote:
>>> When the device is remove, we must make sure to
>>> clear the interruption and reset the AP device.
>>>
>>> We also need to clear the CRYCB of the guest.
>>>
>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>> ---
>>>   drivers/s390/crypto/vfio_ap_drv.c     | 35 
>>> +++++++++++++++++++++++++++++++++++
>>>   drivers/s390/crypto/vfio_ap_ops.c     |  3 ++-
>>>   drivers/s390/crypto/vfio_ap_private.h |  3 +++
>>>   3 files changed, 40 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c 
>>> b/drivers/s390/crypto/vfio_ap_drv.c
>>> index eca0ffc..e5d91ff 100644
>>> --- a/drivers/s390/crypto/vfio_ap_drv.c
>>> +++ b/drivers/s390/crypto/vfio_ap_drv.c
>>> @@ -5,6 +5,7 @@
>>>    * Copyright IBM Corp. 2018
>>>    *
>>>    * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
>>> + *          Pierre Morel <pmorel@linux.ibm.com>
>>>    */
>>>   #include <linux/module.h>
>>> @@ -12,6 +13,8 @@
>>>   #include <linux/slab.h>
>>>   #include <linux/string.h>
>>>   #include <asm/facility.h>
>>> +#include <linux/bitops.h>
>>> +#include <linux/kvm_host.h>
>>>   #include "vfio_ap_private.h"
>>>   #define VFIO_AP_ROOT_NAME "vfio_ap"
>>> @@ -61,6 +64,33 @@ static int vfio_ap_queue_dev_probe(struct 
>>> ap_device *apdev)
>>>   }
>>>   /**
>>> + * vfio_ap_update_crycb
>>> + * @q: A pointer to the queue being removed
>>> + *
>>> + * We clear the APID of the queue, making this queue unusable for 
>>> the guest.
>>> + * After this function we can reset the queue without to fear a race 
>>> with
>>> + * the guest to access the queue again.
>>> + * We do not fear race with the host as we still get the device.
>>> + */
>>> +static void vfio_ap_update_crycb(struct vfio_ap_queue *q)
>>> +{
>>> +    struct ap_matrix_mdev *matrix_mdev = q->matrix_mdev;
>>> +
>>> +    if (!matrix_mdev)
>>> +        return;
>>> +

You should probably check whether the APID has been cleared before
proceeding. Take the case where an AP with multiple queues is removed
from the configuration via the SE or SCLP. The AP bus is going to invoke
the vfio_ap_queue_dev_remove() function for each of the queues. The APID
will get cleared on the first remove, so it is not only unnecessary to
clear it on subsequent removes, it is kind of nasty to keep resetting
the masks in the guest's CRYCB (below) each time the remove callback is
invoked.

>>> +    clear_bit_inv(AP_QID_CARD(q->apqn), matrix_mdev->matrix.apm);
>>> +
>>> +    if (!matrix_mdev->kvm)
>>> +        return;
>>> +
>>> +    kvm_arch_crypto_set_masks(matrix_mdev->kvm,
>>> +                  matrix_mdev->matrix.apm,
>>> +                  matrix_mdev->matrix.aqm,
>>> +                  matrix_mdev->matrix.adm);
>>> +}
>>> +
>>> +/**
>>>    * vfio_ap_queue_dev_remove:
>>>    *
>>>    * Free the associated vfio_ap_queue structure
>>> @@ -70,6 +100,11 @@ static void vfio_ap_queue_dev_remove(struct 
>>> ap_device *apdev)
>>>       struct vfio_ap_queue *q;
>>>       q = dev_get_drvdata(&apdev->device);
>>> +    if (!q)
>>> +        return;
>>> +
>>> +    vfio_ap_update_crycb(q);
>>> +    vfio_ap_mdev_reset_queue(q);
>>
>> Since the bit corresponding to the APID is cleared in the
>> vfio_ap_update_crycb() above, shouldn't all queues on that
>> card also be reset?
> 
> I do not think so.
> The remove function will be called in a loop for all queues by the bus.
> No need to clear all queues.
> 
> 
>>
>>>       list_del(&q->list);
>>>       kfree(q);
>>>   }
>>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c 
>>> b/drivers/s390/crypto/vfio_ap_ops.c
>>> index 0196065..5b9bb33 100644
>>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>>> @@ -59,6 +59,7 @@ int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
>>>               if (retry <= 0)
>>>                   pr_warn("%s: queue 0x%04x not empty\n",
>>>                       __func__, q->apqn);
>>> +            vfio_ap_free_irq(q);
>>
>> Shouldn't this be done for the response codes that terminate this loop
>> such as those caught by the default case?
> 
> I do not think so, the error code is returned and the caller may want to 
> reset the queue again.
> I think that doing the free inside the call to reset is not right.
> I will investigate in this direction.
> 
> Regards,
> Pierre
> 
