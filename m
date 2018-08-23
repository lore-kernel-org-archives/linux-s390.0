From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v9 12/22] s390: vfio-ap: sysfs interfaces to configure
 control domains
Date: Thu, 23 Aug 2018 11:26:01 +0200
Message-ID: <ae3c635b-5ddd-4382-d676-09cf1a685f06@linux.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1534196899-16987-13-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180820162317.08bd7d23.cohuck@redhat.com>
 <660de00a-c403-28c1-4df4-82a973ab3ad5@linux.ibm.com>
 <20180821172548.57a6c758.cohuck@redhat.com>
 <82a391ee-85b1-cdc7-0f9b-d37fd8ba8e47@linux.ibm.com>
 <a43ef10f-aa91-cb4c-a8aa-cd3ce9cfebf2@linux.ibm.com>
 <20180822114250.59a250aa.cohuck@redhat.com>
 <8bc5f207-f913-825c-f9fc-0a2c7fd280aa@linux.ibm.com>
 <e36abc22-9daf-e0f4-c6b3-7adbb28db4c3@de.ibm.com>
 <f84dbcc0-f627-be02-9933-3baa953adc09@linux.ibm.com>
 <219b352b-d5a2-189c-e205-82e7f9ae3d64@de.ibm.com>
 <dbb74c9c-93ab-ed05-fad4-ea2aa5f2b71e@linux.ibm.com>
 <9ef5fcb9-02e0-88e3-007c-eedb14e6db80@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9ef5fcb9-02e0-88e3-007c-eedb14e6db80@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, pmorel@linux.ibm.com, Cornelia Huck <cohuck@redhat.com>
Cc: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>



On 08/22/2018 09:16 PM, Tony Krowiak wrote:
> On 08/22/2018 01:11 PM, Halil Pasic wrote:
>>
>>
>> On 08/22/2018 05:48 PM, Christian Borntraeger wrote:
>>> On 08/22/2018 05:34 PM, Pierre Morel wrote:
>>>> On 22/08/2018 17:11, Christian Borntraeger wrote:
>>>>>
>>>>>
>>>>> On 08/22/2018 01:03 PM, Pierre Morel wrote:
>>>>>>> That's interesting.
>>>>>>>
>>>>>>>> IMHO this quote is quite a half-full half-empty cup one:
>>>>>>>> * it mandates the set of usage domains is a subset of the set
>>>>>>>> of the control domains, but
>>>>>>>> * it speaks of independent controls, namely about the 'usage domain index'
>>>>>>>> and the 'control domain index list' and makes the enforcement of the rule
>>>>>>>> a job of the administrator (instead of codifying it in the controls).
>>>>>>> I'm wondering if a configuration with a usage domain that is not also a
>>>>>>> control domain is rejected outright? Anybody tried that? :)
>>>>>>
>>>>>> Yes, and no it is not.
>>>>>> We can use a queue (usage domain) to a AP card for SHA-512 or RSA without
>>>>>> having to define the queue as a control domain.
>>>>>
>>>>> Huh? My HMC allows to add a domain as
>>>>> - control only domain
>>>>> - control and usage domain.
>>>>>
>>>>> But I am not able to configure a usage-only domain for my LPAR. That seems to match
>>>>> the current code, no?
>>>>>
>>>>
>>>> Yes, it may not be configurable by the HMC but if we start a guest with no control domain it is not a problem to access the hardware through the usage domain.
>>>>
>>>> I tested this a long time ago, but tested again today to be sure on my LPAR.
>>>>
>>>> AFAIU adding a control only domain and a control and usage domain
>>>> allows say:
>>>> control and usage domain 1
>>>> control only domain 2
>>>>
>>>> Allow to send a message to domain 2 using queue 1
>>>>
>>>> Allow also to send a domain modifying message to domain 1 using queue 1
>>>>
>>>> control domain are domain which are controlled
>>>
>>> So you have changed the code to not automatically make a usage domain a
>>> control domain in the bitfield (and you could still use it as a usage
>>> domain). Correct?
>>
>> I tested basically the same yesterday, with the same results.
>>
>>> I think this is probably expected. the "usage implies control" seems to
>>> be a convention implemented by HMC (lpar) and z/VM but millicode offers
>>> the bits to have usage-only domains. As LPAR and z/VM will always enable
>>> any usage-domain to also be a control domain we should do the same.
>>
>> I'm fine either way, but slightly prefer higher level management software
>> and not the kernel accommodating this convention.
>>
>> Please consider a quote from Harald's mail in another sub-thread
>>
>>
>> """
>> ... about control domains
>>
>> Talked with the s390 firmware guys. The convention that the control domain
>> mask is a superset of the usage domain mask is only true for 1st level guests.
>>
>> It is absolutely valid to run a kvm guest with restricted control domain
>> mask bitmap in the CRYCB. It is valid to have an empty control domain mask
>> and the guest should be able to run crypto CPRBs on the usage domain(s) without
>> any problems. However, nobody has tried this.
>> """
>>
>> I'm yet to get an explanation why was this convention established in the first
>> place. And I can not figure it out myself. For me a setup where I know that
>> the domains used by some guest can not be modified by the same guest makes
>> perfect sense. If I try to think in analogies, I kind of compare modification
>> (that is control domain) with write access, and usage (that is usage domain)
>> with read access to, let's say a regular file. For me, all options (rw, r, and w)
>> do make sense, and if I had to pick the one that makes the least sense I would
>> pick write only. The convention is in these terms making read-only illegal. But
>> should 'usage only domains' ever get identified as something somebody wants to do
>> we can just add an attribute for that. So I'm fine either way.
> 
> One of the things I suggested in a private conversation with Christian earlier
> today was to provide an additional rw sysfs attribute - a boolean - that indicates
> whether all usage domains should also be control domains. The default could be
> true. This would allow one to configure guests with usage-only domains as well
> as satisfy the convention.
> 

I prefer keeping the attributes as they are and adding a new let's say
(un)assign_usage_domain if the need arises over this boolean attribute
that changes how (un)assign_domain works.

Halil
