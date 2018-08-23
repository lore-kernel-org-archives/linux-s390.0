From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v9 12/22] s390: vfio-ap: sysfs interfaces to configure
 control domains
Date: Thu, 23 Aug 2018 12:41:11 +0200
Message-ID: <56ce7a29-c7ce-1bad-c26b-945b2d8dae4b@linux.ibm.com>
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
 <ae3c635b-5ddd-4382-d676-09cf1a685f06@linux.ibm.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ae3c635b-5ddd-4382-d676-09cf1a685f06@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 23/08/2018 11:26, Halil Pasic wrote:
> 
> 
> On 08/22/2018 09:16 PM, Tony Krowiak wrote:
>> On 08/22/2018 01:11 PM, Halil Pasic wrote:
>>>
>>>
>>> On 08/22/2018 05:48 PM, Christian Borntraeger wrote:
>>>> On 08/22/2018 05:34 PM, Pierre Morel wrote:
>>>>> On 22/08/2018 17:11, Christian Borntraeger wrote:
>>>>>>
>>>>>>
>>>>>> On 08/22/2018 01:03 PM, Pierre Morel wrote:
>>>>>>>> That's interesting.
>>>>>>>>
...
>>>>
>>>> So you have changed the code to not automatically make a usage domain a
>>>> control domain in the bitfield (and you could still use it as a usage
>>>> domain). Correct?

Yes.

>>>
>>> I tested basically the same yesterday, with the same results.
>>>
>>>> I think this is probably expected. the "usage implies control" seems to
>>>> be a convention implemented by HMC (lpar) and z/VM but millicode offers
>>>> the bits to have usage-only domains. As LPAR and z/VM will always 
>>>> enable
>>>> any usage-domain to also be a control domain we should do the same.

I think it is the reasonable thing to do.

>>>
>>> I'm fine either way, but slightly prefer higher level management 
>>> software
>>> and not the kernel accommodating this convention.

Please, we do not need this in a first version just make it easy
stick with what HMC does.

>>> with read access to, let's say a regular file. For me, all options 
>>> (rw, r, and w)
>>> do make sense, and if I had to pick the one that makes the least 
>>> sense I would
>>> pick write only. The convention is in these terms making read-only 
>>> illegal. But
>>> should 'usage only domains' ever get identified as something somebody 
>>> wants to do
>>> we can just add an attribute for that. So I'm fine either way.

We do not need to introduce new features now.

regards,
Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
