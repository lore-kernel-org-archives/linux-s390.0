From: Farhan Ali <alifm@linux.ibm.com>
Date: Fri, 22 Feb 2019 17:02:18 +0000
Subject: Re: [PULL 1/1] vfio-ccw: Don't assume there are more ccws after a TIC
Message-Id: <4c5be18d-5e01-4b4d-64ef-59d149272dd8@linux.ibm.com>
In-Reply-To: <7bca96ab-ad5f-519b-792d-ebcd9124e31c@linux.ibm.com>
References: <7bca96ab-ad5f-519b-792d-ebcd9124e31c@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 02/22/2019 09:56 AM, Eric Farman wrote:
> 
> 
> On 02/22/2019 03:27 AM, Cornelia Huck wrote:
>> On Thu, 21 Feb 2019 20:09:16 +0100
>> Halil Pasic <pasic@linux.ibm.com> wrote:
>>
>>> On Thu, 21 Feb 2019 12:10:32 -0500
>>> Eric Farman <farman@linux.ibm.com> wrote:
>>
>>>> Well, taking the TIC-boundary logic from tic_target_chain_exists() and
>>>> stuffing it into ccwchain_calc_length() seems to do the trick for 
>>>> seeing
>>>> if we're sending a TIC back into our current chain, and makes the dasd
>>>> boot work again (the following is built on top of this patch, and is
>>>> surely whitespace damaged):
>>>>
>>>> diff --git a/drivers/s390/cio/vfio_ccw_cp.c 
>>>> b/drivers/s390/cio/vfio_ccw_cp.c
>>>> index ba08fe137c2e..a4abe7519b7e 100644
>>>> --- a/drivers/s390/cio/vfio_ccw_cp.c
>>>> +++ b/drivers/s390/cio/vfio_ccw_cp.c
>>>> @@ -362,6 +362,7 @@ static int ccwchain_calc_length(u64 iova, struct
>>>> channel_program *cp)
>>>> �� {
>>>> ��������� struct ccw1 *ccw, *p;
>>>> ��������� int cnt;
>>>> +������ u64 tail;
>>>>
>>>> ��������� /*
>>>> ���������� * Copy current chain from guest to host kernel.
>>>> @@ -392,7 +393,9 @@ static int ccwchain_calc_length(u64 iova, struct
>>>> channel_program *cp)
>>>> ������������������������� return -EOPNOTSUPP;
>>>> ����������������� }
>>>>
>>>> -�������������� if (!ccw_is_chain(ccw))
>>>> +�������������� tail = iova + (cnt - 1) * sizeof(struct ccw1);
>>>> +
>>>> +�������������� if (!(ccw_is_chain(ccw) || (ccw_is_tic(ccw) && iova <=
>>>> ccw->cda && ccw->cda <= tail)))
>>>
>>> After De Morgan this looks like
>>>
>>>
>>> !ccw_is_chain(ccw)) && !(ccw_is_tic(ccw) && tic_points_in_this_chain())
>>>
>>> which only differs form the state without the Farhan fix by not carrying
>>> on for tic's that point outside of this chain.
>>>
>>> Would certainly catch the problem you discovered.
>>>
>>> Of course there is no guarantee that this covers all the theoretically
>>> possible cases where we could skip over a ccw that would terminate a 
>>> chain
>>> (tic or not chaining) if there was no status modifier. If you like I can
>>> construct an example where this heuristic fails (at least I think so).
>>>
>>> If this is the direction we are going to take I think "vfio-ccw: Don't
>>> assume there are more ccws after a TIC" should be superseded by this. 
>>> And
>>> we need a comment that explains the second part of the expression.
>>
>> As that patch is already queued, I think we should do that change with
>> 'fixes' on top.
>>
>> There are probably more corner cases that we're missing, but this fixes
>> a problem that can be hit today (well, with some posted patches...), so
>> I'd go ahead and queue it and go through the code and maybe fix/rework
>> on top.
> 
> Sounds good.� I will get that posted so we can look it over with fresh 
> eyes.
> 

Just catching up with my email backlog. This fix will solve the DASD ipl 
issue and should supersede my patch.


>>
>> Did any of you do any stress testing of that change yet?
>>
> 
> I've been running fio since yesterday after my last email (and 
> subsequent lunch), and haven't seen any further errors.� It's still 
> running today, and knock on wood it'll keep going nicely.
> 
> It just occurred to me that I was trying to run a different set of tests 
> when I bumped into this.� I think they are a different set of disks, so 
> I should go back and try that while fio runs.
> 
>  �- Eric
> 

I will try to test this patch as well.

Thanks
Farhan
