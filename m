From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v6 21/21] s390: doc: detailed specifications for AP
 virtualization
Date: Tue, 3 Jul 2018 11:17:24 -0400
Message-ID: <a48a3086-07ff-5519-9820-8067c4e29f44@linux.ibm.com>
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1530306683-7270-22-git-send-email-akrowiak@linux.vnet.ibm.com>
 <49b11ac2-2230-ad74-1583-c6a57f8b31e3@linux.ibm.com>
 <6a330cae-2fe2-54df-edce-c3360117cf3c@linux.ibm.com>
 <13998e79-9bae-5c55-b83d-85e6db8d3b99@linux.ibm.com>
 <20180703135205.2ebb107f.cohuck@redhat.com>
 <18532145-abeb-1251-926e-edbc6fa0bcb0@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <18532145-abeb-1251-926e-edbc6fa0bcb0@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 07/03/2018 08:20 AM, Halil Pasic wrote:
>
>
> On 07/03/2018 01:52 PM, Cornelia Huck wrote:
>> On Tue, 3 Jul 2018 11:22:10 +0200
>> Halil Pasic <pasic@linux.ibm.com> wrote:
>>
> [..]
>>>
>>> Let me try to invoke the DASD analogy. If one for some reason wants 
>>> to detach
>>> a DASD the procedure to follow seems to be (see
>>> https://www.ibm.com/support/knowledgecenter/en/linuxonibm/com.ibm.linux.z.lgdd/lgdd_t_dasd_online.html) 
>>>
>>> the following:
>>> 1) Unmount.
>>> 2) Offline possibly using safe_offline.
>>> 3) Detach.
>>>
>>> Detaching a disk that is currently doing I/O asks for trouble, so 
>>> the admin is encouraged
>>> to make sure there is no pending I/O.
>>
>> I don't think we can use dasd (block devices) as a good analogy for
>> every kind of device (for starters, consider network devices).
>>
>
> I did not use it for every kind of device. I used it for AP. I'm
> under the impression you find the analogy inappropriate. If, could
> you please explain why?
>
>>> In case of AP you can interpret my 'in use' as the queue is not 
>>> empty. In my understanding
>>> unbind is supposed to be hard (I used the word radical). That's why 
>>> I compared it to pulling
>>> a cable. So that's why I ask is there stuff the admin is supposed to 
>>> do before doing the
>>> unbind.
>>
>> Are you asking for a kind of 'quiescing' operation? I would hope that
>> the crypto drivers already can deal with that via flushing the queue,
>> not allowing new requests, or whatever. This is not the block device
>> case.
>>
>
> The current implementation of vfio-ap which is a crypto driver too 
> certainly
> can not deal 'with that'. Whether the rest of the drivers can, I don't
> know. Maybe Tony can tell.

As stated in the cover letter, unbinding a queue from the vfio-ap device
driver is akin to a hot unplug. Hot plug/unplug is one of the goals of
the next patch series.

>
>
> I'm aware of the fact that AP adapters are not block devices. But
> as stated above I don't understand what is the big difference regarding
> the unbind operation.
>
>> Anyway, this is an administrative issue. If you don't have a clear
>> concept which devices are for host usage and which for guest usage, you
>> already have problems.
>
> I'm trying to understand the whole solution. I agree, this is an 
> administrative
> issue. But the document is trying to address such administrative issues.

This section of the document is intended to describe how to provision AP 
queues
for dedicated guest usage and to show the relationship between the 
various objects
involved. While it does administrative actions, it is not intended to be an
administrator's guide.


>
>>
>> Speaking of administrative issues, is there libvirt support for vfio-ap
>> under development? It would be helpful to validate the approach.
>
> I full-heartedly agree. I guess Tony will have to answer this one too.
>
> Regards,
> Halil
