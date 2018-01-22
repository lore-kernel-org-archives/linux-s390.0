From: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC/PATCH v2 03/22] s390/mm: add gmap PMD invalidation
 notification
Date: Mon, 22 Jan 2018 13:12:14 +0100
Message-ID: <4bfa494f-167b-d0a6-0875-e62b1f5139a4@redhat.com>
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1513169613-13509-4-git-send-email-frankja@linux.vnet.ibm.com>
 <5a4805ea-7b97-60ca-a4a6-e456fe7475c6@redhat.com>
 <e67d12fb-706a-fb01-adc3-cb02a2db8604@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <e67d12fb-706a-fb01-adc3-cb02a2db8604@linux.vnet.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 22.01.2018 13:09, Janosch Frank wrote:
> On 22.01.2018 12:56, David Hildenbrand wrote:
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
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
>>> ---
>>>  arch/s390/include/asm/gmap.h    |  3 ++
>>>  arch/s390/include/asm/pgtable.h |  7 +++-
>>>  arch/s390/mm/gmap.c             | 92 ++++++++++++++++++++++++++++++++++++-----
>>>  arch/s390/mm/pgtable.c          |  4 ++
>>>  4 files changed, 94 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
>>> index c1bc563..21bb658 100644
>>> --- a/arch/s390/include/asm/gmap.h
>>> +++ b/arch/s390/include/asm/gmap.h
>>> @@ -13,6 +13,9 @@
>>>  #define GMAP_NOTIFY_SHADOW	0x2
>>>  #define GMAP_NOTIFY_MPROT	0x1
>>>  
>>> +/* Status bits in the gmap segment entry. */
>>> +#define _SEGMENT_ENTRY_GMAP_IN		0x0001	/* invalidation notify bit */
>>> +
>>
>> _SEGMENT_ENTRY_READ -> 0x0001
>>
>> Is it even okay to reuse that bit?
>>
> 
> It's in the GMAP segment entry, not in the process' segment entry.
> That's why we throw away all software bits from the process entry when
> linking into the gmap table.
> 

Ah right, we only share page tables but not complete segments. Thanks.

-- 

Thanks,

David / dhildenb
