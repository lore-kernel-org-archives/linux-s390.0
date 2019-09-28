Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58230 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbfI1JHA (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 28 Sep 2019 05:07:00 -0400
Subject: Re: [PATCH] mm/page_alloc: fix a crash in free_pages_prepare()
References: <1569613623-16820-1-git-send-email-cai@lca.pw>
 <20190927140222.6f7d0a41b9e734053ee911b9@linux-foundation.org>
 <1569619686.5576.242.camel@lca.pw>
 <20190927145945.846a3f3405d3af066827d3f5@linux-foundation.org>
 <CAKgT0UfZBNmn1aZdvRT6Yvki3LBi_Nr5hjkYeSnpA7S8kY58-Q@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <5ee9164f-71c5-4082-a80d-8fbc5dc50750@redhat.com>
Date: Sat, 28 Sep 2019 11:06:56 +0200
MIME-Version: 1.0
In-Reply-To: <CAKgT0UfZBNmn1aZdvRT6Yvki3LBi_Nr5hjkYeSnpA7S8kY58-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Qian Cai <cai@lca.pw>, Heiko Carstens <heiko.carstens@de.ibm.com>, gor@linux.ibm.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>

On 28.09.19 00:17, Alexander Duyck wrote:
> On Fri, Sep 27, 2019 at 2:59 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>>
>> On Fri, 27 Sep 2019 17:28:06 -0400 Qian Cai <cai@lca.pw> wrote:
>>
>>>>
>>>> So I think you've moved the arch_free_page() to be after the final
>>>> thing which can access page contents, yes?  If so, we should have a
>>>> comment in free_pages_prepare() to attmept to prevent this problem from
>>>> reoccurring as the code evolves?
>>>
>>> Right, something like this above arch_free_page() there?
>>>
>>> /*
>>>  * It needs to be just above kernel_map_pages(), as s390 could mark those
>>>  * pages unused and then trigger a fault when accessing.
>>>  */
>>
>> I did this.
>>
>> --- a/mm/page_alloc.c~mm-page_alloc-fix-a-crash-in-free_pages_prepare-fix
>> +++ a/mm/page_alloc.c
>> @@ -1179,7 +1179,13 @@ static __always_inline bool free_pages_p
>>                 kernel_init_free_pages(page, 1 << order);
>>
>>         kernel_poison_pages(page, 1 << order, 0);
>> +       /*
>> +        * arch_free_page() can make the page's contents inaccessible.  s390
>> +        * does this.  So nothing which can access the page's contents should
>> +        * happen after this.
>> +        */
>>         arch_free_page(page, order);
>> +
>>         if (debug_pagealloc_enabled())
>>                 kernel_map_pages(page, 1 << order, 0);
>>
> 
> So the question I would have is what is the state of the page after it
> has been marked unused and then pulled back in? I'm assuming it will
> be all 0s.

I think this comment relates to the s390x implementation, so I'll try to
explain that. After arch_free_page() the page might have been zapped in
the hypervisor, but that might happen deferred. The guest ends up
triggering the ESSA instruction in arch_free_page(). That instruction
sets some extended-page-table-related ("pgste") bits in the hypervisor
tables for the guest ("gmap") and fills a buffer with these entries. The
page is marked _PGSTE_GPS_USAGE_UNUSED.

Once the buffer is full, the ESSA instruction intercepts to the
hypervisor, where the hypervisor can go over all recorded entries and
zap them *in case* the extended-page-table-related bits still indicate
that the page is unused by the guest (_PGSTE_GPS_USAGE_UNUSED) or is
marked to be logically zero (_PGSTE_GPS_ZERO). Zapping a page only
happens if it's a pte_swap(pte) entry and effectively triggers a
ptep_zap_unused() -> ptep_zap_swap_entry() -> free_swap_and_cache(). So
I think it will be backed with the zero page when pulled back in.

arch_alloc_page() will similarly trigger the ESSA instruction but only
set the extended-page-table-related bits, so the entry is no longer
_PGSTE_GPS_USAGE_UNUSED. This is basically to make sure a page won't get
zapped in the hypervisor while it is already getting used by the guest
again.

The implementation on the KVM side resides in
arch/s390/kvm/priv.c:handle_essa() but more importantly in
arch/s390/kvm/priv.c:__do_essa() ("pure interpretation path skipping
hardware interpretation completely").

Now, one interesting thing resides in
arch/s390/kvm/priv.c:pgste_perform_essa():
	/* If we are discarding a page, set it to logical zero */
	if (res)
		pgstev |= _PGSTE_GPS_ZERO;

So whenever we do an arch_free_page() in the guest, the page will
immediately also be set in the hypervisor to _PGSTE_GPS_ZERO. However, I
think setting the page logically to zero is just an "extended HW state"
and will not actually result in the page reading zeroes before we
actually zap it. I might be wrong and I only see one place where
_PGSTE_GPS_ZERO actually gets cleared again, especially when setting a
page stable (which looks bogus but as the documentation is confidential
I have no idea what's happening there).

Long story short: I think there is *no guarantee* that
a) After arch_free_page(), the page is actually zeroed-out
b) After arch_free_page() the page has been zapped in the hypervisor or
   will get zapped.
c) After arch_alloc_page(), the page was actually zeroed-out.

I might be wrong, depending on how _PGSTE_GPS_ZERO is actually used.

However, *if* the page was zapped in the hypervisor
(free_swap_and_cache()), I think it will get populated using the zero-page.

Also, please not that s390x requires an arch_alloc_page() after an
arch_free_page(). You cannot simply go ahead and reuse the page after
arch_alloc_page().

> 
> I know with the work I am still doing on marking pages as unused this
> ends up being an additional item that we will need to pay attention
> to, however in our case we will just be initializing the page as zero
> if we end up evicting it from the guest.

Please note that if you are using MADV_FREE instead of MADV_DONTNEED in
the hypervisor, you might end up with the same guarantees that s390x'
implementation gives you. Could be, that the page was not zapped/zeroed
out on the next access. Depends on if the hypervisor was feeling like
zapping entries marked using MADV_FREE.

-- 

Thanks,

David / dhildenb
