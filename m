Return-Path: <SRS0=PCIz=SS=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [PATCH 1/7] s390: zcrypt: driver callback to indicate resource in
 use
References: <1555016604-2008-1-git-send-email-akrowiak@linux.ibm.com>
 <1555016604-2008-2-git-send-email-akrowiak@linux.ibm.com>
 <c575e772-59e2-9fed-5ade-24701d4f2b49@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Tue, 16 Apr 2019 09:11:19 -0400
MIME-Version: 1.0
In-Reply-To: <c575e772-59e2-9fed-5ade-24701d4f2b49@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <8ee6f624-b698-bf83-2ae0-e292ad2512fc@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pmorel@linux.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com
List-ID: <linux-s390.vger.kernel.org>

On 4/16/19 3:52 AM, Pierre Morel wrote:
> On 11/04/2019 23:03, Tony Krowiak wrote:
>> Introduces a new driver callback to prevent a root user from unbinding
>> an AP queue from its device driver if the queue is in use. This prevents
>> a root user from inadvertently taking a queue away from a guest and
>> giving it to the host, or vice versa. The callback will be invoked
>> whenever a change to the AP bus's apmask or aqmask sysfs interfaces may
>> result in one or more AP queues being removed from its driver. If the
>> callback responds in the affirmative for any driver queried, the change
>> to the apmask or aqmask will be rejected with a device in use error.
>>
>> For this patch, only non-default drivers will be queried. Currently,
>> there is only one non-default driver, the vfio_ap device driver. The
>> vfio_ap device driver manages AP queues passed through to one or more
>> guests and we don't want to unexpectedly take AP resources away from
>> guests which are most likely independently administered.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/ap_bus.c | 138 
>> +++++++++++++++++++++++++++++++++++++++++--
>>   drivers/s390/crypto/ap_bus.h |   3 +
>>   2 files changed, 135 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
>> index 1546389d71db..66a5a9d9fae6 100644
>> --- a/drivers/s390/crypto/ap_bus.c
>> +++ b/drivers/s390/crypto/ap_bus.c
>> @@ -35,6 +35,7 @@
>>   #include <linux/mod_devicetable.h>
>>   #include <linux/debugfs.h>
>>   #include <linux/ctype.h>
>> +#include <linux/module.h>
>>   #include "ap_bus.h"
>>   #include "ap_debug.h"
>> @@ -980,9 +981,11 @@ int ap_parse_mask_str(const char *str,
>>       newmap = kmalloc(size, GFP_KERNEL);
>>       if (!newmap)
>>           return -ENOMEM;
>> -    if (mutex_lock_interruptible(lock)) {
>> -        kfree(newmap);
>> -        return -ERESTARTSYS;
>> +    if (lock) {
>> +        if (mutex_lock_interruptible(lock)) {
>> +            kfree(newmap);
>> +            return -ERESTARTSYS;
>> +        }
>>       }
>>       if (*str == '+' || *str == '-') {
>> @@ -994,7 +997,10 @@ int ap_parse_mask_str(const char *str,
>>       }
>>       if (rc == 0)
>>           memcpy(bitmap, newmap, size);
>> -    mutex_unlock(lock);
>> +
>> +    if (lock)
>> +        mutex_unlock(lock);
>> +
>>       kfree(newmap);
>>       return rc;
>>   }
>> @@ -1181,12 +1187,72 @@ static ssize_t apmask_show(struct bus_type 
>> *bus, char *buf)
>>       return rc;
>>   }
>> +static int __verify_card_reservations(struct device_driver *drv, void 
>> *data)
>> +{
>> +    int rc = 0;
>> +    struct ap_driver *ap_drv = to_ap_drv(drv);
>> +    unsigned long *newapm = (unsigned long *)data;
>> +
>> +    /*
>> +     * If the reserved bits do not identify cards reserved for use by 
>> the
>> +     * non-default driver, there is no need to verify the driver is 
>> using
>> +     * the queues.
>> +     */
>> +    if (ap_drv->flags & AP_DRIVER_FLAG_DEFAULT)
>> +        return 0;
> 
> I prefer you suppress this asymmetry with the assumption that the 
> "default driver" will not register a "in_use" callback.

Based on comments by Connie, I plan on removing this patch from the
next version.

> 
> 
>> +
>> +    /* Pin the driver's module code */
>> +    if (!try_module_get(drv->owner))
>> +        return 0;
>> +
>> +    if (ap_drv->in_use)
>> +        if (ap_drv->in_use(newapm, ap_perms.aqm))
>> +            rc = -EADDRINUSE;
>> +
>> +    module_put(drv->owner);
>> +
>> +    return rc;
>> +}
>> +
> 
