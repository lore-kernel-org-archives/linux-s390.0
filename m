Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41976 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728386AbgDPOgN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 16 Apr 2020 10:36:13 -0400
Subject: Re: [PATCH v7 03/15] s390/zcrypt: driver callback to indicate
 resource in use
References: <20200407192015.19887-1-akrowiak@linux.ibm.com>
 <20200407192015.19887-4-akrowiak@linux.ibm.com>
 <20200414140838.54f777b8.cohuck@redhat.com>
 <0f193571-1ff6-08f3-d02d-b4f40d2930c8@linux.ibm.com>
 <20200416120544.053b38d8.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <78116a88-7571-1ac9-40e1-6c1081c81467@linux.ibm.com>
Date: Thu, 16 Apr 2020 10:35:48 -0400
MIME-Version: 1.0
In-Reply-To: <20200416120544.053b38d8.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, jjherne@linux.ibm.com, fiuczy@linux.ibm.com



On 4/16/20 6:05 AM, Cornelia Huck wrote:
> On Wed, 15 Apr 2020 13:10:18 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>> On 4/14/20 8:08 AM, Cornelia Huck wrote:
>>> On Tue,  7 Apr 2020 15:20:03 -0400
>>> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>>>> @@ -995,9 +996,11 @@ int ap_parse_mask_str(const char *str,
>>>>    	newmap = kmalloc(size, GFP_KERNEL);
>>>>    	if (!newmap)
>>>>    		return -ENOMEM;
>>>> -	if (mutex_lock_interruptible(lock)) {
>>>> -		kfree(newmap);
>>>> -		return -ERESTARTSYS;
>>>> +	if (lock) {
>>>> +		if (mutex_lock_interruptible(lock)) {
>>>> +			kfree(newmap);
>>>> +			return -ERESTARTSYS;
>>>> +		}
>>> This whole function is a bit odd. It seems all masks we want to
>>> manipulate are always guarded by the ap_perms_mutex, and the need for
>>> allowing lock == NULL comes from wanting to call this function with the
>>> ap_perms_mutex already held.
>>>
>>> That would argue for a locked/unlocked version of this function... but
>>> looking at it, why do we lock the way we do? The one thing this
>>> function (prior to this patch) does outside of the holding of the mutex
>>> is the allocation and freeing of newmap. But with this patch, we do the
>>> allocation and freeing of newmap while holding the mutex. Something
>>> seems a bit weird here.
>> Note that the ap_parse_mask function copies the newmap
>> to the bitmap passed in as a parameter to the function.
>> Prior to the introduction of this patch, the calling functions - i.e.,
>> apmask_store(), aqmask_store() and ap_perms_init() - passed
>> in the actual bitmap (i.e., ap_perms.apm or ap_perms aqm),
>> so the ap_perms were changed directly by this function.
>>
>> With this patch, the apmask_store() and aqmask_store()
>> functions now pass in a copy of those bitmaps. This is so
>> we can verify that any APQNs being removed are not
>> in use by the vfio_ap device driver before committing the
>> change to ap_perms. Consequently, it is now necessary
>> to take the lock for the until the changes are committed.
> Yes, but every caller actually takes the mutex before calling this
> function already :)

That is not a true statement, the ap_perms_init() function
does not take the mutex prior to calling this function. Keep in
mind, the ap_parse_mask function is not static and is exported,
I was precluded from removing the lock parameter from the function
definition.

>
>> Having explained that, you make a valid argument that
>> this calls for a locked/unlocked version of this function, so
>> I will modify this patch to that effect.
> Ok.
>
> The other thing I found weird is that the function does
> alloc newmap -> grab mutex -> do manipulation -> release mutex -> free newmap
> while the new callers do
> (mutex already held) -> alloc newmap
>
> so why grab/release the mutex the way the function does now? IOW, why
> not have an unlocked __ap_parse_mask_string() and do

In my last comment above, I agreed to create an unlocked version
of this function. Your example below is similar to what I
implemented after responding to your comment yesterday.

>
> int ap_parse_mask_string(...)
> {
> 	int rc;
>
> 	if (mutex_lock_interruptible(&ap_perms_mutex))
> 		return -ERESTARTSYS;
> 	rc = __ap_parse_mask_string(...);
>          mutex_unlock(&ap_perms_mutex);
> 	return rc;
> }
