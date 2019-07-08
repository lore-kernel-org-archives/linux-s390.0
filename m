Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34588 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729708AbfGHNet (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 8 Jul 2019 09:34:49 -0400
Subject: Re: [RFC v1 1/4] vfio-ccw: Set orb.cmd.c64 before calling
 ccwchain_handle_ccw
References: <cover.1561997809.git.alifm@linux.ibm.com>
 <050943a6f5a427317ea64100bc2b4ec6394a4411.1561997809.git.alifm@linux.ibm.com>
 <20190702102606.2e9cfed3.cohuck@redhat.com>
 <de9ae025-a96a-11ab-2ba9-8252d8b070e0@linux.ibm.com>
 <62c3b191-3fae-011d-505d-59e8412229d0@linux.ibm.com>
 <20190703113004.217ca43e.cohuck@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Message-ID: <cea0abe3-3840-16cb-29bc-4409ee5b5fa4@linux.ibm.com>
Date: Mon, 8 Jul 2019 09:34:29 -0400
MIME-Version: 1.0
In-Reply-To: <20190703113004.217ca43e.cohuck@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>
Cc: pasic@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org



On 07/03/2019 05:30 AM, Cornelia Huck wrote:
> On Tue, 2 Jul 2019 11:11:47 -0400
> Eric Farman <farman@linux.ibm.com> wrote:
> 
>> On 7/2/19 9:56 AM, Farhan Ali wrote:
>>>
>>>
>>> On 07/02/2019 04:26 AM, Cornelia Huck wrote:
>>>> On Mon,  1 Jul 2019 12:23:43 -0400
>>>> Farhan Ali <alifm@linux.ibm.com> wrote:
>>>>   
>>>>> Because ccwchain_handle_ccw calls ccwchain_calc_length and
>>>>> as per the comment we should set orb.cmd.c64 before calling
>>>>> ccwchanin_calc_length.
>>>>>
>>>>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>>>>> ---
>>>>>    drivers/s390/cio/vfio_ccw_cp.c | 10 +++++-----
>>>>>    1 file changed, 5 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/drivers/s390/cio/vfio_ccw_cp.c
>>>>> b/drivers/s390/cio/vfio_ccw_cp.c
>>>>> index d6a8dff..5ac4c1e 100644
>>>>> --- a/drivers/s390/cio/vfio_ccw_cp.c
>>>>> +++ b/drivers/s390/cio/vfio_ccw_cp.c
>>>>> @@ -640,16 +640,16 @@ int cp_init(struct channel_program *cp, struct
>>>>> device *mdev, union orb *orb)
>>>>>        memcpy(&cp->orb, orb, sizeof(*orb));
>>>>>        cp->mdev = mdev;
>>>>>    -    /* Build a ccwchain for the first CCW segment */
>>>>> -    ret = ccwchain_handle_ccw(orb->cmd.cpa, cp);
>>>>> -    if (ret)
>>>>> -        cp_free(cp);
>>>>> -
>>>>>        /* It is safe to force: if not set but idals used
>>>>>         * ccwchain_calc_length returns an error.
>>>>>         */
>>>>>        cp->orb.cmd.c64 = 1;
>>>>>    +    /* Build a ccwchain for the first CCW segment */
>>>>> +    ret = ccwchain_handle_ccw(orb->cmd.cpa, cp);
>>>>> +    if (ret)
>>>>> +        cp_free(cp);
>>>>> +
>>>>>        if (!ret)
>>>>>            cp->initialized = true;
>>>>>      
>>>>
>>>> Hm... has this ever been correct, or did this break only with the
>>>> recent refactorings?
>>>>
>>>> (IOW, what should Fixes: point to?)
>>
>> Yeah, that looks like it should blame my refactoring.
>>
>>>>
>>>>   
>>>
>>> I think it was correct before some of the new refactoring we did. But we
>>> do need to set before calling ccwchain_calc_length, because the function
>>> does have a check for orb.cmd.64. I will see which exact commit did it.
>>
>> I get why that check exists, but does anyone know why it's buried in
>> ccwchain_calc_length()?  Is it simply because ccwchain_calc_length()
>> assumes to be working on Format-1 CCWs?  I don't think that routine
>> cares if it's an IDA or not, an it'd be nice if we could put a check for
>> the supported IDA formats somewhere up front.
> 
> The more I stare at this code, the more confused I get :(

That makes 2 of us :(

> 
> Apparently we want to allow the guest to specify an orb without cmd.c64
> set, as this is fine as long as the channel program does not use idals.
> However, we _do_ want to reject it if cmd.c64 is not set, but idals are
> used; so we actually _don't_ want to force this before the processing.
> We just want the flag in the orb to be set when we do the ssch.
> 
> So it seems that the comment does not really talk about what
> ccwchain_calc_length _will_ do, but what it _generally_ does (and, in
> this case, already would have done.)
> 
> If my understanding is correct, maybe we should reword the comment
> instead? i.e. s/returns/would have returned/
> 
> 
I think you are right. But then should we move this to ccw_fetch_direct? 
It might be easier to understand the code, since that's where we are 
converting guest ccws to host idals?

Thanks
Farhan
