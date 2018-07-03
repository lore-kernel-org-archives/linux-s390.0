From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v6 21/21] s390: doc: detailed specifications for AP
 virtualization
Date: Tue, 3 Jul 2018 11:25:16 -0400
Message-ID: <99a7ea9a-ef42-2f1a-a0c4-b6aa864d4152@linux.ibm.com>
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1530306683-7270-22-git-send-email-akrowiak@linux.vnet.ibm.com>
 <49b11ac2-2230-ad74-1583-c6a57f8b31e3@linux.ibm.com>
 <6a330cae-2fe2-54df-edce-c3360117cf3c@linux.ibm.com>
 <13998e79-9bae-5c55-b83d-85e6db8d3b99@linux.ibm.com>
 <20180703135205.2ebb107f.cohuck@redhat.com>
 <18532145-abeb-1251-926e-edbc6fa0bcb0@linux.ibm.com>
 <20180703152557.08d10223.cohuck@redhat.com>
 <99aabca1-76ba-1a9e-256d-0e234a3ac28f@linux.ibm.com>
 <20180703163027.538d3d12.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180703163027.538d3d12.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 07/03/2018 10:30 AM, Cornelia Huck wrote:
> On Tue, 3 Jul 2018 15:58:37 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
>
>> On 07/03/2018 03:25 PM, Cornelia Huck wrote:
>>> On Tue, 3 Jul 2018 14:20:11 +0200
>>> Halil Pasic <pasic@linux.ibm.com> wrote:
>>>    
>>>> On 07/03/2018 01:52 PM, Cornelia Huck wrote:
>>>>> On Tue, 3 Jul 2018 11:22:10 +0200
>>>>> Halil Pasic <pasic@linux.ibm.com> wrote:
>>>>>       
>>>> [..]
>>>>>> Let me try to invoke the DASD analogy. If one for some reason wants to detach
>>>>>> a DASD the procedure to follow seems to be (see
>>>>>> https://www.ibm.com/support/knowledgecenter/en/linuxonibm/com.ibm.linux.z.lgdd/lgdd_t_dasd_online.html)
>>>>>> the following:
>>>>>> 1) Unmount.
>>>>>> 2) Offline possibly using safe_offline.
>>>>>> 3) Detach.
>>>>>>
>>>>>> Detaching a disk that is currently doing I/O asks for trouble, so the admin is encouraged
>>>>>> to make sure there is no pending I/O.
>>>>> I don't think we can use dasd (block devices) as a good analogy for
>>>>> every kind of device (for starters, consider network devices).
>>>>>       
>>>> I did not use it for every kind of device. I used it for AP. I'm
>>>> under the impression you find the analogy inappropriate. If, could
>>>> you please explain why?
>>> I don't think block devices (which are designed to be more or less
>>> permanently accessed, e.g. by mounting a file system) have the same
>>> semantics as ap devices (which exist as a backend for crypto requests).
>>> Not everything that makes sense for a block device makes sense for
>>> other devices as well, and I don't think it makes sense here.
>>>    
>> I'm still confused. If it's about frequency of access (as hinted
>> by block devices accessed more or less permanently) I'm not sure
>> there is a substantial difference. I guess there are scenarios where
>> the AP domain is used very seldom (e.g. protected keys --> most of
>> the crypto ops done by CPACF but AP unwraps at the beginning), but
>> there are such scenarios for block too.
>>
>> If it's about (persistent) state, I guess it again depends on the
>> scenario and on the type of the card. But I may be wrong.
> So, let's turn this around: Why do you think that dasd (and not qeth or
> whatever) is a good model for ap device unbinding? Because I really
> fail to get it... maybe the ap driver maintainers can chime in.
>
>>>>   
>>>>>> In case of AP you can interpret my 'in use' as the queue is not empty. In my understanding
>>>>>> unbind is supposed to be hard (I used the word radical). That's why I compared it to pulling
>>>>>> a cable. So that's why I ask is there stuff the admin is supposed to do before doing the
>>>>>> unbind.
>>>>> Are you asking for a kind of 'quiescing' operation? I would hope that
>>>>> the crypto drivers already can deal with that via flushing the queue,
>>>>> not allowing new requests, or whatever. This is not the block device
>>>>> case.
>>>>>       
>>>> The current implementation of vfio-ap which is a crypto driver too certainly
>>>> can not deal 'with that'. Whether the rest of the drivers can, I don't
>>>> know. Maybe Tony can tell.
>>> If the current implementation of vfio-ap cannot deal with it (by
>>> cleaning up, blocking, etc.), it needs at the very least be documented
>>> so that it can be implemented later. I do not know what the SIE will or
>>> won't do to assist here (e.g., if you're removing it from some masks,
>>> the device will already be inaccessible to the guest). But the part you
>>> were referring to was talking about the existing host driver anyway,
>>> wasn't it?
>>>    
>> I was thinking about both directions. Re-classifying a device form
>> pass-through to normal should also be possible. But the document only
>> talks about one direction.
> Presumably because it (rightfully) focuses on setting up vfio-ap?

This is a true statement. The doc is not intended to be a comprehensive
administration guide, it is intended to be more of a design spec. The
goal here is to show the relationship between the objects involved in
AP queue pass-through.

>
>> I'm not familiar with the existing host drivers. If we can say 'Hey,
>> unbind is perfectly safe at any time: no per-cautions need to be considered!'
>> I'm very happy with that. Although I would find it a bit surprising.
>>
>> I just wanted to make sure this is not something we forget.
>>
>>>> I'm aware of the fact that AP adapters are not block devices. But
>>>> as stated above I don't understand what is the big difference regarding
>>>> the unbind operation.
>>>>   
>>>>> Anyway, this is an administrative issue. If you don't have a clear
>>>>> concept which devices are for host usage and which for guest usage, you
>>>>> already have problems.
>>>> I'm trying to understand the whole solution. I agree, this is an administrative
>>>> issue. But the document is trying to address such administrative issues.
>>> I'd assume "know which devices are for the host and which devices are
>>> for the guests" to be a given, no?
>>>    
>> My other email scratches this topic. AFAIK we don't have a solution for
>> that yet. Nor we have a good understanding of how and to what extent
>> is statically given what is given. E.g. if one wants to re-partition my AP
>> resources (and at some point one will have to at least do the initial
>> re-partitioning) do I need a reboot for the changes to take effect? Or
>> is this 'known' variable during the uptime of an OS.
> I think that is really out of scope for this file, which I'd expect to
> explain how vfio-ap basically works and which incantations I need to
> give crypto devices to a guest. It should NOT focus on administrative
> tasks; this should either be delegated to the likes of libvirt or
> documented in a "how to use crypto cards with kvm" kind of technical
> writeup. If there's a limitation (e.g. you can't easily unbind again),
> write a line here.

On this we can agree.

>
