From: Halil Pasic <pasic@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/4] vfio: ccw: fix cleanup if cp_prefetch fails
Date: Thu, 22 Mar 2018 11:10:26 +0100
Message-ID: <04a22205-bac4-652d-d5a1-c05d7ee5bfde@linux.vnet.ibm.com>
References: <20180321020822.86255-1-bjsdjshi@linux.vnet.ibm.com>
 <20180321020822.86255-2-bjsdjshi@linux.vnet.ibm.com>
 <682d8b1c-5aca-7015-043b-a3f1446bf378@linux.vnet.ibm.com>
 <20180322022248.GB12194@bjsdjshi@linux.vnet.ibm.com>
 <54fd02cd-bd0b-889b-c40f-f9a32aa25d77@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54fd02cd-bd0b-889b-c40f-f9a32aa25d77@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, cohuck@redhat.com, borntraeger@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>



On 03/22/2018 10:37 AM, Pierre Morel wrote:
> On 22/03/2018 03:22, Dong Jia Shi wrote:
>> * Halil Pasic <pasic@linux.vnet.ibm.com> [2018-03-21 13:49:54 +0100]:
>>
>>>
>>> On 03/21/2018 03:08 AM, Dong Jia Shi wrote:
>>>> From: Halil Pasic <pasic@linux.vnet.ibm.com>
>>>>
>>>> If the translation of a channel program fails, we may end up attempting
>>>> to clean up (free, unpin) stuff that never got translated (and allocated,
>>>> pinned) in the first place.
>>>>
>>>> By adjusting the lengths of the chains accordingly (so the element that
>>>> failed, and all subsequent elements are excluded) cleanup activities
>>>> based on false assumptions can be avoided.
>>>>
>>>> Let's make sure cp_free works properly after cp_prefetch returns with an
>>>> error by setting ch_len to 0 for the ccw chains those are not prefetched.
>>> This sentence used to be:
>>>
>>> Let's make sure cp_free works properly after cp_prefetch returns with an
>>> error.
>>>
>>> @Dong Jia
>>> I find the 'by setting ch_len to 0 for the ccw chains those are not prefetched'
>>> you added for clarification (I guess) somewhat problematic.
>>> The chain in which the translation failure occurred
>>> +    chain->ch_len = idx;
>> I made a mistake. When rewording the message, I missed this part...
>> Sorry for the problem!

np

>>
>>> is shortened so that only the translated elements (ccws) are going to
>>> get cleaned up (on a per element basis) by cp_free. This may or may
>>> not be the first ccw. Subsequent chains are shortened to 0 as there
>>> no translation took place.
>>>
>>> So as a result of this change only properly translated ccws are going
>>> to get (re)visited by cp_free as only those may have resources bound
>>> to them which need to be released.
>>>
>>> I'm not against improving the commit message. But this ain't
>>> an improvement to me.
>> You are right. How about:
>> Let's make sure cp_free works properly after cp_prefetch returns with an
>> error by setting ch_len of a ccw chain to the number of the translated
>> ccws on that chain.

Works with me.

> 
> By the way, since you will propose a new version,
> you have a long description of the cp_prefetch function in the code.
> I think you should modify it according to the changes and describe how and
> why the ch_len field of each chain is used and changed by this function.
> 
> Something like:
> 
> "
> For each chain composing the channel program:
> On entry ch_len hold the count of CCW to be translated.
> On exit ch_len is adjusted to the count of successfully translated CCW.
> 
> This allows cp_free to find in ch_len the count of CCW to free in a chain.
> "

Sounds good to me.

Halil
