From: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC/PATCH v2 03/22] s390/mm: add gmap PMD invalidation
 notification
Date: Mon, 22 Jan 2018 14:29:34 +0100
Message-ID: <d0f856de-8e82-1afa-f62d-fbb33b715db7@redhat.com>
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1513169613-13509-4-git-send-email-frankja@linux.vnet.ibm.com>
 <edb33737-5f1d-b74e-6dbf-f5174b790fee@redhat.com>
 <c154cb64-59be-34fe-44e0-7ee19c6b5440@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <c154cb64-59be-34fe-44e0-7ee19c6b5440@linux.vnet.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 22.01.2018 14:13, Janosch Frank wrote:
> On 22.01.2018 12:46, David Hildenbrand wrote:
>> On 13.12.2017 13:53, Janosch Frank wrote:
>>> For later migration of huge pages we want to write-protect guest
>>> PMDs. While doing this, we have to make absolutely sure, that the
>>> guest's lowcore is always accessible when the VCPU is running. With
>>> PTEs, this is solved by marking the PGSTEs of the lowcore pages with
>>> the invalidation notification bit and kicking the guest out of the SIE
>>> via a notifier function if we need to invalidate such a page.
>>>
>>> With PMDs we do not have PGSTEs or some other bits we could use in the
>>> host PMD. Instead we pick one of the free bits in the gmap PMD. Every
>>> time a host pmd will be invalidated, we will check if the respective
>>> gmap PMD has the bit set and in that case fire up the notifier.
>>>
>>> In the first step we only support setting the invalidation bit, but we
>>> do not support restricting access of guest pmds. It will follow
>>> shortly.
>>
>> I am wondering if we could avoid having invalidation bits on PMDs
>> completely by always splitting up a PMD huge page into PTEs.
>>
>> I assume this would make the code easier - as we need split up of PMDs
>> either way when protecting for the shadow gmap.
>>
>> This would imply that also our notification handler only has to be
>> called for 4k pages, which also makes that part easier.
> 
> Except for 1MB shadowed segments which still need an invalidation handler.

But that doesn't go via gmap_protect_range() / gmap_call_notifier() if I
am not mistaking.


-- 

Thanks,

David / dhildenb
