From: Eric Farman <farman@linux.ibm.com>
Date: Tue, 26 Feb 2019 18:42:07 +0000
Subject: Re: [PATCH 1/2] s390/cio: Fix vfio-ccw handling of recursive TICs
Message-Id: <a876e299-1119-b1ab-bdb7-671b8c7f426c@linux.ibm.com>
In-Reply-To: <20190226193821.12bb526b@oc2783563651>
References: <20190226193821.12bb526b@oc2783563651>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 02/26/2019 12:26 PM, Cornelia Huck wrote:
> On Mon, 25 Feb 2019 21:43:31 -0500
> Eric Farman <farman@linux.ibm.com> wrote:
> 
>> On 02/25/2019 12:56 PM, Halil Pasic wrote:
>>> On Fri, 22 Feb 2019 19:39:40 +0100
>>> Eric Farman <farman@linux.ibm.com> wrote:
> 
>>>> @@ -392,7 +419,15 @@ static int ccwchain_calc_length(u64 iova, struct channel_program *cp)
>>>>    			return -EOPNOTSUPP;
>>>>    		}
>>>>    
>>>> -		if (!ccw_is_chain(ccw))
>>>> +		/*
>>>> +		 * We want to keep counting if the current CCW has the
>>>> +		 * command-chaining flag enabled, or if it is a TIC CCW
>>>> +		 * that loops back into the current chain.  The latter
>>>> +		 * is used for device orientation, where the CCW PRIOR to
>>>> +		 * the TIC can either jump to the TIC or a CCW immediately
>>>> +		 * after the TIC, depending on the results of its operation.
>>>> +		 */
>>>> +		if (!ccw_is_chain(ccw) && !is_tic_within_range(ccw, iova, cnt))
>>>
>>> AFAIU this is a heuristic. I would prefer this being a heuristics
>>> pointed out clearly, along with the explanation of what happens if the
>>> heuristics fails.
>> I don't agree that this as a heuristic and I don't see the value of
>> including "what happens" when that answer comes from decades worth of
>> books of various classifications.  Furthermore, I don't see anything in
>> POPS (SA22-7832-11 pp. 15-60 and 15-76/77) that implies we're excluding
>> something.
>>
>> Perhaps I misunderstand you.  Could you please explain your continued
>> concern about Status Modifier, because the above academic statement
>> combined with your earlier comment that "all the theoretically possible
>> cases where we could skip over a ccw that would terminate a chain (tic
>> or not chaining) if there was no status modifier" does not help me
>> understand the "heuristic" problem you have here.
>>
>> A theoretically possible combination of CCWs is nice in, well, theory.
>> But the examples I discussed with you offline are more likely to result
>> in a Command Reject due to an invalid sequence (or other more painful
>> errors) than a useful channel program for a device to operate upon.
>> Hardly a heuristic.
>>
>>>
>>> Your comment is suggesting that the case we care about is TIC pointing
>>> to the CCW that immediately precedes it. The code however considers the
>>> whole current chain.
>>
>> In practical usage, a backwards TIC of just one CCW is common.  But I'm
>> not aware of anything architecturally that prevents us from jumping
>> farther up the chain via a TIC if we wanted, which is why I looked at
>> the entire range.  If we did go back farther, we would still be most
>> interested in the CCW prior to the TIC because of the possible SM jump.
> 
> FWIW, I consider the comment to be fine as-is, and I'd prefer not to
> over-complicate the description here.
> 
> I'm going to queue this and send a pull request, unless someone points
> out something obviously wrong to me.
> 

Thanks, Connie.
