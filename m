Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34139 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729209AbgGHGus (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Jul 2020 02:50:48 -0400
Subject: Re: [PATCH v1 0/9] s390: implement and optimize vmemmap_free()
From: David Hildenbrand <david@redhat.com>
References: <20200703133917.39045-1-david@redhat.com>
 <20200707120849.GB12303@osiris>
 <f4a87c47-4987-e3f8-8c06-ff6dd60f6a39@redhat.com>
Message-ID: <51813747-a2d6-03a4-fe61-b8d62dbca05b@redhat.com>
Date: Wed, 8 Jul 2020 08:50:39 +0200
MIME-Version: 1.0
In-Reply-To: <f4a87c47-4987-e3f8-8c06-ff6dd60f6a39@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-mm@kvack.org, Christian Borntraeger <borntraeger@de.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

On 07.07.20 14:13, David Hildenbrand wrote:
> On 07.07.20 14:08, Heiko Carstens wrote:
>> On Fri, Jul 03, 2020 at 03:39:08PM +0200, David Hildenbrand wrote:
>>> This series is based on the latest s390/features branch [1]. It implements
>>> vmemmap_free(), consolidating it with vmem_add_range(), and optimizes it by
>>> - Freeing empty page tables (now also done for idendity mapping).
>>> - Handling cases where the vmemmap of a section does not fill huge pages
>>>   completely.
>>>
>>> vmemmap_free() is currently never used, unless adiing standby memory fails
>>> (unlikely). This is relevant for virtio-mem, which adds/removes memory
>>> in memory block/section granularity (always removes memory in the same
>>> granularity it added it).
>>>
>>> I gave this a proper test with my virtio-mem prototype (which I will share
>>> once the basic QEMU implementation is upstream), both with 56 byte memmap
>>> per page and 64 byte memmap per page, with and without huge page support.
>>> In both cases, removing memory (routed through arch_remove_memory()) will
>>> result in
>>> - all populated vmemmap pages to get removed/freed
>>> - all applicable page tables for the vmemmap getting removed/freed
>>> - all applicable page tables for the idendity mapping getting removed/freed
>>> Unfortunately, I don't have access to bigger and z/VM (esp. dcss)
>>> environments.
>>>
>>> This is the basis for real memory hotunplug support for s390x and should
>>> complete my journey to s390x vmem/vmemmap code for now :)
>>>
>>> What needs double-checking is tlb flushing. AFAIKS, as there are no valid
>>> accesses, doing a single range flush at the end is sufficient, both when
>>> removing vmemmap pages and the idendity mapping.
>>>
>>> Along, some minor cleanups.
>>
>> Hmm.. I really would like to see if there would be only a single page
>> table walker left in vmem.c, which handles both adding and removing
>> things.
>> Now we end up with two different page table walk implementations
>> within the same file. However not sure if it is worth the effort to
>> unify them though.
> 
> I tried to unify vmemmap_populate() and vmem_add_range() already and
> didn't like the end result ... so, unifying these along with the removal
> part won't be any better - most probably. Open for suggestions :)
> 
> (at least arm64 and x86-64 handle it similarly)
> 

I'll play with something like

static void modify_pagetable(unsigned long start, unsigned long end,
			     bool direct, bool add)

and see how it turns out.

-- 
Thanks,

David / dhildenb
