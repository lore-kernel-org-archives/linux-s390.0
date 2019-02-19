From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v3 8/9] s390: ap: Cleanup on removing the AP device
Date: Tue, 19 Feb 2019 20:29:56 +0100
Message-ID: <2b6a07ac-b999-b7d0-81de-273abfcb7c00@linux.ibm.com>
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
 <1550152269-6317-9-git-send-email-pmorel@linux.ibm.com>
 <f60b520b-7342-da0d-48cb-5a16190b7f40@linux.ibm.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f60b520b-7342-da0d-48cb-5a16190b7f40@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 16/02/2019 00:29, Tony Krowiak wrote:
> On 2/14/19 8:51 AM, Pierre Morel wrote:
>> When the device is remove, we must make sure to
>> clear the interruption and reset the AP device.
>>
>> We also need to clear the CRYCB of the guest.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_drv.c     | 92 
>> +++++++++++++++++++++++++++++++++++
>>   drivers/s390/crypto/vfio_ap_ops.c     |  2 +-
>>   drivers/s390/crypto/vfio_ap_private.h |  2 +
>>   3 files changed, 95 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c 
>> b/drivers/s390/crypto/vfio_ap_drv.c
>> index 03153e6..50428be 100644
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
>> @@ -64,6 +67,88 @@ static int vfio_ap_queue_dev_probe(struct ap_device 
>> *apdev)
>>       return 0;
>>   }
>> +/*
>> + * vfio_ap_drain_queue
>> + * @q: the queue to drain
>> + *
>> + * This function waits until the queue is empty.
>> + */
>> +static void vfio_ap_drain_queue(struct vfio_ap_queue *q)
>> +{
>> +    struct ap_queue_status status;
>> +    int retry = 20;
>> +
>> +    status = ap_tapq(q->apqn, NULL);
>> +    while (!status.queue_empty && retry--)  {
>> +        msleep(200);
>> +        status = ap_tapq(q->apqn, NULL);
>> +    }
>> +    if (retry <= 0) {
>> +        pr_warn("%s: queue not empty after zapq on apqn 0x%04x\n",
>> +            __func__, q->apqn);
>> +    }
>> +}
>> +
>> +/*
>> + * vfio_ap_zapq
>> + * @q: The queue to zerro
>> + *
>> + * It is best effort, no return value is done, however on success
>> + * we will drain the queue before getting the queue back to the
>> + * AP bus.
>> + */
>> +static void vfio_ap_zapq(struct vfio_ap_queue *q)
>> +{
>> +    struct ap_queue_status status;
>> +    int retry = 20;
>> +
>> +    do {
>> +        status = ap_zapq(q->apqn);
>> +        switch (status.response_code) {
>> +        case AP_RESPONSE_RESET_IN_PROGRESS:
>> +        case AP_RESPONSE_BUSY:
>> +            msleep(20);
>> +            break;
>> +        default:
>> +            pr_warn("%s: zapq error %02x on apqn 0x%04x\n",
>> +                __func__, status.response_code, q->apqn);
>> +            return;
>> +        case AP_RESPONSE_NORMAL:
>> +            vfio_ap_drain_queue(q);
> 
> I don't think this is necessary. The zeroize is performed on
> each AP-queue entry in an AP queue. My understanding is that when a
> reset or zeroize is pending, any AP instructions subsequently issued
> are rejected with condition-code 3 indicating an AP queue reset is in
> progress. It is also my understanding that once the AP commands 
> currently executing in a given AP queue entry complete, the queue
> entry will be zeroized. So it seems to me that there is no need to
> "drain" the queue, it will have already been done by the zeroize.

My understanding from the specifications is that after a RAPQ or a ZAPQ
we should wait for the queue to be really empty.

> 
> If you agree we don't need to "drain" the queue, then I'd rather just
> make the zapq function in the vfio_ap_ops.c non-static and make it
> available to the driver. There is no sense in duplicating this code. In
> fact, even if you keep the draining function, you still don't need to
> duplicate a zaapq instruction here, you can just call the vfio_ap_ops.c
> version and then drain the queue on AP_RESPONSE_NORMAL.

OK I will see how to optimize this.



>> +        return;
>> +
>> +    vfio_ap_update_crycb(q);
>> +    vfio_ap_zapq(q);
>> +
>> +    vfio_ap_free_irq(q);
> 
> If you make the zapq function in vfio_ap_ops.c available to the driver
> rather than duplicating it in this file, you won't need this call
> to vfio_ap_free_irq because it is done as part of the zapq in
> vfio_ap_ops.c.

Another solution.
OK I will look at this.

Thanks,
Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
