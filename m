Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19746 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727657AbgJGUKT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Oct 2020 16:10:19 -0400
Subject: Re: [PATCH 08/10] s390/dasd: Display FC Endpoint Security information
 via sysfs
References: <20201002193940.24012-1-sth@linux.ibm.com>
 <20201002193940.24012-9-sth@linux.ibm.com>
 <20201006122632.098149ba.cohuck@redhat.com>
 <d88b8230-993e-d63d-394a-efcaf60f813d@linux.ibm.com>
 <20201007114928.6a088a7d.cohuck@redhat.com>
 <243fe10e-ce80-57de-a92c-3a6457cde40a@linux.ibm.com>
 <20201007184011.6dece07f.cohuck@redhat.com>
From: =?UTF-8?Q?Jan_H=c3=b6ppner?= <hoeppner@linux.ibm.com>
Message-ID: <702cf75e-5193-92d3-79a7-182ac86df16e@linux.ibm.com>
Date: Wed, 7 Oct 2020 22:10:11 +0200
MIME-Version: 1.0
In-Reply-To: <20201007184011.6dece07f.cohuck@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Stefan Haberland <sth@linux.ibm.com>, axboe@kernel.dk, linux-block@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com

On 10/7/20 6:40 PM, Cornelia Huck wrote:
> On Wed, 7 Oct 2020 16:33:37 +0200
> Jan Höppner <hoeppner@linux.ibm.com> wrote:
> 
>>>>>> +static inline void dasd_path_release(struct kobject *kobj)
>>>>>> +{
>>>>>> +/* Memory for the dasd_path kobject is freed when dasd_free_device() is called */
>>>>>> +}
>>>>>> +    
>>>>>
>>>>> As already said, I don't think that's a correct way to implement this.
>>>>>     
>>>>
>>>> As you correctly pointed out, our release function doesn't do anything.
>>>> This is because our path data is a (static) part of our device.
>>>> This data is critical to keep our devices operational.
>>>> We can't simply rely on allocated memory if systems are under stress.   
>>>
>>> Yes, avoiding freeing and reallocating memory certainly makes sense.
>>>   
>>>>
>>>> Having this data dynamically allocated involves a lot of rework of our
>>>> path handling as well. There are a few things that are subject to improvement
>>>> and evaluating whether our dasd_path structures can be dynamic is one of
>>>> these things. However, even then, the above concern persists and I
>>>> highly doubt that dynamic dasd_paths objects are doable for us at this
>>>> moment.
>>>>
>>>> I do understand the concerns, however, we release the memory for dasd_path
>>>> structures eventually when dasd_free_device() is called. Until that point,
>>>> the data has to be kept alive. The rest is taking care of by the kobject
>>>> library.  
>>>
>>> Yes, there doesn't seem to be any memory leakage.
>>>   
>>>> In our path handling we also make sure that we can always verify/validate
>>>> paths information even if a system is under high memory pressure. Another
>>>> reason why it would contradictory for dasd_path objects to be dynamic.
>>>>
>>>> I hope this explains the reasoning behind the release function.  
>>>
>>> I understand where you're coming from.
>>>
>>> However, "static" kobjects (in the sense of "we may re-register the
>>> same kobject") are still problematic. Is there any way to simply
>>> "disappear" path objects that are not valid at the moment, or mark them
>>> as not valid?  
>>
>> You could use kobject_del(), but it is rather intended to be used for
>> a two-stage removal of the kobject.
>>
>>>
>>> Also, the simple act of registering/unregistering a kobject already
>>> creates stress from its sysfs interactions... it seems you should try
>>> to avoid that as well?
>>>   
>>
>> We don't re-register kobjects over and over again. The kobjects are
>> infact initialized and created only _once_. This is done either during
>> device initialization (after dasd_eckd_read_conf() in
>> dasd_eckd_check_characteristics()) or when a path is newly added
>> (in the path event handler).
>> The kobject will stay until the memory for the whole device is being
>> freed. This is also the reason why the kobject can stay initialized and
>> we track ourselves whether we did the initialization/creation already
>> (which we check e.g. when a path is removed and added again).
>> So, instead of the release function freeing the kobject data,
>> it is done by our dasd_free_device() (same thing, different function IMHO).
>>
>> I think the concerns would be more worrisome if we'd remove/add
>> the kobjects every time. And then I agree, we'd run into trouble.
>>
> 
> The thing that tripped me is
> 
> +void dasd_path_remove_kobj(struct dasd_device *device, int chp)
> +{
> +	if (device->path[chp].in_sysfs) {
> +		kobject_put(&device->path[chp].kobj);
> +		device->path[chp].in_sysfs = false;
> +	}
> +}
> 
> As an exported function, it is not clear where this may be called from.
> Given your explanation above (and some more code reading on my side),
> the code looks ok in its current incarnation (but non-idiomatic).
> 
> Is there a way to check that indeed nobody re-adds a previously removed
> path object due to a (future) programming error? And maybe add a
> comment that you must never re-register a path? "The path is gone,
> let's remove the object" looks quite tempting.
> 

A comment is the minimum I can think of at the moment and
I'll prepare a fixup patch or a new version of this patch that adds
a proper comment for this function.
Other ways to protect the usage must be investigated. 
I have to discuss with Stefan what the best approach would be as the patchset
is supposed to be ready for upstream integration.

I'd prefer a fixup patch that we could send with at least one more fixup patch
that we have in the pipe already. Let's see. I hope that's fine with you
(and Jens obviously) so far.

regards,
Jan
