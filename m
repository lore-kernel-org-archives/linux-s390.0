From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v4 6/7] s390: ap: Cleanup on removing the AP device
Date: Wed, 27 Feb 2019 10:58:22 +0100
Message-ID: <97bd632b-87a6-fa23-d4db-7ccdec877831@linux.ibm.com>
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
 <1550849400-27152-7-git-send-email-pmorel@linux.ibm.com>
 <3f15bd09-8a90-ed8a-e15a-0f3bac1a3528@linux.ibm.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3f15bd09-8a90-ed8a-e15a-0f3bac1a3528@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 26/02/2019 19:27, Tony Krowiak wrote:
> On 2/22/19 10:29 AM, Pierre Morel wrote:
>> When the device is remove, we must make sure to
>> clear the interruption and reset the AP device.
>>
>> We also need to clear the CRYCB of the guest.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_drv.c     | 35 
>> +++++++++++++++++++++++++++++++++++
>>   drivers/s390/crypto/vfio_ap_ops.c     |  3 ++-
>>   drivers/s390/crypto/vfio_ap_private.h |  3 +++
>>   3 files changed, 40 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c 
>> b/drivers/s390/crypto/vfio_ap_drv.c
>> index eca0ffc..e5d91ff 100644
>> --- a/drivers/s390/crypto/vfio_ap_drv.c
>> +++ b/drivers/s390/crypto/vfio_ap_drv.c
>> @@ -5,6 +5,7 @@
>>    * Copyright IBM Corp. 2018
>>    *
>>    * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
>> + *          Pierre Morel <pmorel@linux.ibm.com>
>>    */
>>   #include <linux/module.h>
>> @@ -12,6 +13,8 @@
>>   #include <linux/slab.h>
>>   #include <linux/string.h>
>>   #include <asm/facility.h>
>> +#include <linux/bitops.h>
>> +#include <linux/kvm_host.h>
>>   #include "vfio_ap_private.h"
>>   #define VFIO_AP_ROOT_NAME "vfio_ap"
>> @@ -61,6 +64,33 @@ static int vfio_ap_queue_dev_probe(struct ap_device 
>> *apdev)
>>   }
>>   /**
>> + * vfio_ap_update_crycb
>> + * @q: A pointer to the queue being removed
>> + *
>> + * We clear the APID of the queue, making this queue unusable for the 
>> guest.
>> + * After this function we can reset the queue without to fear a race 
>> with
>> + * the guest to access the queue again.
>> + * We do not fear race with the host as we still get the device.
>> + */
>> +static void vfio_ap_update_crycb(struct vfio_ap_queue *q)
>> +{
>> +    struct ap_matrix_mdev *matrix_mdev = q->matrix_mdev;
>> +
>> +    if (!matrix_mdev)
>> +        return;
>> +
>> +    clear_bit_inv(AP_QID_CARD(q->apqn), matrix_mdev->matrix.apm);
>> +
>> +    if (!matrix_mdev->kvm)
>> +        return;
>> +
>> +    kvm_arch_crypto_set_masks(matrix_mdev->kvm,
>> +                  matrix_mdev->matrix.apm,
>> +                  matrix_mdev->matrix.aqm,
>> +                  matrix_mdev->matrix.adm);
>> +}
>> +
>> +/**
>>    * vfio_ap_queue_dev_remove:
>>    *
>>    * Free the associated vfio_ap_queue structure
>> @@ -70,6 +100,11 @@ static void vfio_ap_queue_dev_remove(struct 
>> ap_device *apdev)
>>       struct vfio_ap_queue *q;
>>       q = dev_get_drvdata(&apdev->device);
>> +    if (!q)
>> +        return;
>> +
>> +    vfio_ap_update_crycb(q);
>> +    vfio_ap_mdev_reset_queue(q);
> 
> The reset is unnecessary because once the card is removed from the
> CRYCB, the ZAPQ may fail with because the queue may not exist anymore.

The code here is run inside the host. So the queue is still available 
for ZAPQ.


> Besides, once the card is removed from the guest's CRYCB, the bus
> running in the guest will do a reset.

I already answered this:
- The AP bus reset the queue before calling the driver probe
- which means that the guest can still access the queue after the reset 
done by the bus.
- we need to first clear the CRYCB to remove the queue from the guest 
before we reset the queue.


Regards,
Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
