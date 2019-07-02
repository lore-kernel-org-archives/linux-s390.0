Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46234 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726046AbfGBQs1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 2 Jul 2019 12:48:27 -0400
Subject: Re: [RFC v1 2/4] vfio-ccw: No need to call cp_free on an error in
 cp_init
References: <cover.1561997809.git.alifm@linux.ibm.com>
 <5f1b69cd3a52e367f9f5014a3613768c8634408c.1561997809.git.alifm@linux.ibm.com>
 <20190702104257.102f32d3.cohuck@redhat.com>
 <66d92fe7-6395-46a6-b9bc-b76cbe7fb48e@linux.ibm.com>
 <4f7e52bd-6b22-90b0-ab7b-f9c5c3ccac3f@linux.ibm.com>
From: Farhan Ali <alifm@linux.ibm.com>
Message-ID: <9bc36261-194c-635e-b0b8-a4b71b031c2f@linux.ibm.com>
Date: Tue, 2 Jul 2019 12:48:02 -0400
MIME-Version: 1.0
In-Reply-To: <4f7e52bd-6b22-90b0-ab7b-f9c5c3ccac3f@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: pasic@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org



On 07/02/2019 12:15 PM, Eric Farman wrote:
> 
> 
> On 7/2/19 9:58 AM, Farhan Ali wrote:
>>
>>
>> On 07/02/2019 04:42 AM, Cornelia Huck wrote:
>>> On Mon,  1 Jul 2019 12:23:44 -0400
>>> Farhan Ali <alifm@linux.ibm.com> wrote:
>>>
>>>> We don't set cp->initialized to true so calling cp_free
>>>> will just return and not do anything.
>>>>
>>>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>>>> ---
>>>>    drivers/s390/cio/vfio_ccw_cp.c | 2 --
>>>>    1 file changed, 2 deletions(-)
>>>>
>>>> diff --git a/drivers/s390/cio/vfio_ccw_cp.c
>>>> b/drivers/s390/cio/vfio_ccw_cp.c
>>>> index 5ac4c1e..cab1be9 100644
>>>> --- a/drivers/s390/cio/vfio_ccw_cp.c
>>>> +++ b/drivers/s390/cio/vfio_ccw_cp.c
>>>> @@ -647,8 +647,6 @@ int cp_init(struct channel_program *cp, struct
>>>> device *mdev, union orb *orb)
>>>>          /* Build a ccwchain for the first CCW segment */
>>>>        ret = ccwchain_handle_ccw(orb->cmd.cpa, cp);
>>>> -    if (ret)
>>>> -        cp_free(cp);
>>>
>>> Makes sense; hopefully ccwchain_handle_ccw() cleans up correctly on
>>> error :) (I think it does)
>>>
>>
>> I have checked that it does as well, but wouldn't hurt if someone else
>> also glances over once again :)
> 
> Oh noes.  What happens once we start encountering TICs?  If we do:
> 
> ccwchain_handle_ccw()	(OK)
> ccwchain_loop_tic()	(OK)
> ccwchain_handle_ccw()	(FAIL)
> 
> The first _handle_ccw() will have added a ccwchain to the cp list, which
> doesn't appear to get cleaned up now.  That used to be done in cp_init()
> until I squashed cp_free and cp_unpin_free.  :(

Yup, you are right we are not freeing the chain correctly. Will fix it 
in v2.
> 
>>
>>> Maybe add a comment
>>>
>>> /* ccwchain_handle_ccw() already cleans up on error */
>>>
>>> so we don't stumble over this in the future?
>>
>> Sure.
>>
>>>
>>> (Also, does this want a Fixes: tag?)
>>
>> This might warrant a fixes tag as well.
>>>
>>>>          if (!ret)
>>>>            cp->initialized = true;
>>>
>>>
> 
