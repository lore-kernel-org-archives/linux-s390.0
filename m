From: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC/PATCH 02/22] s390/mm: Abstract gmap notify bit setting
Date: Wed, 15 Nov 2017 10:30:27 +0100
Message-ID: <c17a05fd-9eee-93b9-8e9f-15e3d927e9f5@redhat.com>
References: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1510007400-42493-3-git-send-email-frankja@linux.vnet.ibm.com>
 <5939dc68-f6e8-54a0-a6d1-b9655de273a5@redhat.com>
 <84dc4936-6fe2-0636-3757-ae0e87a8938f@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <84dc4936-6fe2-0636-3757-ae0e87a8938f@linux.vnet.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 13.11.2017 16:57, Janosch Frank wrote:
> On 10.11.2017 13:57, David Hildenbrand wrote:
>> On 06.11.2017 23:29, Janosch Frank wrote:
>>> Currently we use the software PGSTE bits PGSTE_IN_BIT and PGSTE_VSIE_BIT
>>> to notify before an invalidation occurs on a prefix page or a VSIE page
>>> respectively. Both bits only work for a PGSTE, which only exists for
>>> page tables.
>>>
>>> For huge page support we also need such bits for segments (pmds) so
>>> let's introduce abstract GMAP_ENTRY_* bits that will be realized into
>>> the respective bits when gmap DAT table entries are protected.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
>>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> [...]
>>> @@ -8,6 +8,10 @@
>>>  #ifndef _ASM_S390_GMAP_H
>>>  #define _ASM_S390_GMAP_H
>>>  
>>> +/* Generic bits for GMAP notification on DAT table entry changes. */
>>> +#define GMAP_ENTRY_VSIE	0x2
>>> +#define GMAP_ENTRY_IN	0x1
>>
>> Can we rename
>> GMAP_ENTRY_VSIE -> GMAP_ENTRY_SHADOW_IN
>>
>> and also
>>
>> PGSTE_VSIE_BIT -> PGSTE_SHADOW_IN_BIT
> 
> I'd like to keep the PGSTE bit names, the PGSTE bits are nicely
> formatted and consistent in pgtable.h. The segment bit names are even
> worse because of their length:
> 
> _SEGMENT_ENTRY_GMAP_VSIE
> 
> and if we'd use your naming it gets even longer:
> 
> _SEGMENT_ENTRY_GMAP_SHADOW_IN_BIT
> 
> 
> I'll try to come up with something consistent and good sounding, but it
> certainly isn't a #1 priority and I might fail to do so :)
> 
>>
>> as they are used for managing shadow page table invalidation.
>>
>> Also, a better fitting name for ENTRY would be nice :)
>> (GMAP_NOTIFY_...)
> 
> Yes, the ENTRY part came from the _SEGMENT_ENTRY_* constants, whose
> names you might also dislike.
> 
> So I think I'll use:
> GMAP_NOTIFY_PREFIX(_BIT)

s/PREFIX/MPROTECT/ ?

Because that's the GMAP interface being used.

> GMAP_NOTIFY_SHADOW(_BIT)
> 
> 


-- 

Thanks,

David / dhildenb
