From: Pierre Morel <pmorel@linux.ibm.com>
Date: Wed, 31 Oct 2018 12:40:47 +0000
Subject: Re: [PATCH 00/10] KVM: s390: make use of the GIB
Message-Id: <8e4fd7d4-f6d9-909d-538d-180f36236247@linux.ibm.com>
In-Reply-To: <1137077f-91ed-5699-1726-63627dc741d0@de.ibm.com>
References: <1137077f-91ed-5699-1726-63627dc741d0@de.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 31/10/2018 13:36, Christian Borntraeger wrote:
> 
> 
> On 10/31/2018 01:29 PM, Cornelia Huck wrote:
>> On Wed, 31 Oct 2018 13:11:10 +0100
>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>
>>> On 10/31/2018 11:09 AM, David Hildenbrand wrote:
>>>> On 25.10.18 14:37, Michael Mueller wrote:
>>>>> The Guest Information Area (GIB) and its mechanics is part of
>>>>> the AIV facility. It provides hardware support to process
>>>>> Adapter Interruptions (AI) for pagable storage mode guests.
>>>>>
>>>>> Whenever a guest cannot process an AI because none of its
>>>>> vcpus is running in SIE context, a GIB alert interruption is
>>>>> sent to and handled by the host program to dispatch a vcpu of
>>>>> the respective guest.
>>>>>
>>>>> Eventually, the AI is handled by the guest.
>>>>
>>>>
>>>> This does not apply to vSIE, right?
>>>
>>> We do not provide GISA, GIB and friends to the guest (e.g. we do not have
>>> the scp bits set). So right now we do not have anything to do for vsie.
>>>
>>
>> Any plans to do so in the future?
> 
> Since GISA is just a performance optimization I am not sure if we really want
> to go down the path to also provide that for nested guests. Right now it this
> is just a speedup that the guest1 can use to improve the speed of guest2. If
> guest3 is a bit slower that should be fine for now.
> 
> Pierre can you post your patches that make use of the GIB in vfio-ap so that
> everybody can see the full picture?
> 

OK, I do.

-- 
Pierre Morel
Linux/KVM/QEMU in B�blingen - Germany
