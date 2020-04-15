Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v7 03/15] s390/zcrypt: driver callback to indicate
 resource in use
References: <20200407192015.19887-1-akrowiak@linux.ibm.com>
 <20200407192015.19887-4-akrowiak@linux.ibm.com>
 <20200414140838.54f777b8.cohuck@redhat.com>
Message-ID: <0f193571-1ff6-08f3-d02d-b4f40d2930c8@linux.ibm.com>
Date: Wed, 15 Apr 2020 13:10:18 -0400
MIME-Version: 1.0
In-Reply-To: <20200414140838.54f777b8.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, jjherne@linux.ibm.com, fiuczy@linux.ibm.com



On 4/14/20 8:08 AM, Cornelia Huck wrote:
> On Tue,  7 Apr 2020 15:20:03 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>> Introduces a new driver callback to prevent a root user from unbinding
>> an AP queue from its device driver if the queue is in use. The intent of
>> this callback is to provide a driver with the means to prevent a root user
>> from inadvertently taking a queue away from a guest and giving it to the
>> host while the guest is still using it. The callback will
>> be invoked whenever a change to the AP bus's sysfs apmask or aqmask
>> attributes would result in one or more AP queues being removed from its
>> driver. If the callback responds in the affirmative for any driver
>> queried, the change to the apmask or aqmask will be rejected with a device
>> in use error.
>>
>> For this patch, only non-default drivers will be queried. Currently,
>> there is only one non-default driver, the vfio_ap device driver. The
>> vfio_ap device driver manages AP queues passed through to one or more
>> guests and we don't want to unexpectedly take AP resources away from
>> guests which are most likely independently administered.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/ap_bus.c | 144 +++++++++++++++++++++++++++++++++--
>>   drivers/s390/crypto/ap_bus.h |   4 +
>>   2 files changed, 142 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
>> index 5256e3ce84e5..af15c095e76a 100644
>> --- a/drivers/s390/crypto/ap_bus.c
>> +++ b/drivers/s390/crypto/ap_bus.c
>> @@ -35,6 +35,7 @@
>>   #include <linux/mod_devicetable.h>
>>   #include <linux/debugfs.h>
>>   #include <linux/ctype.h>
>> +#include <linux/module.h>
>>   
>>   #include "ap_bus.h"
>>   #include "ap_debug.h"
>> @@ -995,9 +996,11 @@ int ap_parse_mask_str(const char *str,
>>   	newmap = kmalloc(size, GFP_KERNEL);
>>   	if (!newmap)
>>   		return -ENOMEM;
>> -	if (mutex_lock_interruptible(lock)) {
>> -		kfree(newmap);
>> -		return -ERESTARTSYS;
>> +	if (lock) {
>> +		if (mutex_lock_interruptible(lock)) {
>> +			kfree(newmap);
>> +			return -ERESTARTSYS;
>> +		}
> This whole function is a bit odd. It seems all masks we want to
> manipulate are always guarded by the ap_perms_mutex, and the need for
> allowing lock == NULL comes from wanting to call this function with the
> ap_perms_mutex already held.
>
> That would argue for a locked/unlocked version of this function... but
> looking at it, why do we lock the way we do? The one thing this
> function (prior to this patch) does outside of the holding of the mutex
> is the allocation and freeing of newmap. But with this patch, we do the
> allocation and freeing of newmap while holding the mutex. Something
> seems a bit weird here.

Note that the ap_parse_mask function copies the newmap
to the bitmap passed in as a parameter to the function.
Prior to the introduction of this patch, the calling functions - i.e.,
apmask_store(), aqmask_store() and ap_perms_init() - passed
in the actual bitmap (i.e., ap_perms.apm or ap_perms aqm),
so the ap_perms were changed directly by this function.

With this patch, the apmask_store() and aqmask_store()
functions now pass in a copy of those bitmaps. This is so
we can verify that any APQNs being removed are not
in use by the vfio_ap device driver before committing the
change to ap_perms. Consequently, it is now necessary
to take the lock for the until the changes are committed.

Having explained that, you make a valid argument that
this calls for a locked/unlocked version of this function, so
I will modify this patch to that effect.

>
>>   	}
>>   
>>   	if (*str == '+' || *str == '-') {
