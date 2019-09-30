Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18968 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729677AbfI3G14 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 30 Sep 2019 02:27:56 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8U6M5Vu063119
        for <linux-s390@vger.kernel.org>; Mon, 30 Sep 2019 02:27:53 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vbak5kgcu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 30 Sep 2019 02:27:45 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 30 Sep 2019 07:27:43 +0100
Subject: Re: [PATCH] mm/page_alloc: fix a crash in free_pages_prepare()
References: <1569613623-16820-1-git-send-email-cai@lca.pw>
 <20190927140222.6f7d0a41b9e734053ee911b9@linux-foundation.org>
 <1569619686.5576.242.camel@lca.pw>
 <20190927145945.846a3f3405d3af066827d3f5@linux-foundation.org>
 <CAKgT0UfZBNmn1aZdvRT6Yvki3LBi_Nr5hjkYeSnpA7S8kY58-Q@mail.gmail.com>
 <5ee9164f-71c5-4082-a80d-8fbc5dc50750@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 30 Sep 2019 08:27:39 +0200
MIME-Version: 1.0
In-Reply-To: <5ee9164f-71c5-4082-a80d-8fbc5dc50750@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <364ff782-b9d0-5228-0392-ecb61b786dce@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Qian Cai <cai@lca.pw>, Heiko Carstens <heiko.carstens@de.ibm.com>, gor@linux.ibm.com, linux-s390@vger.kernel.org, linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>



On 28.09.19 11:06, David Hildenbrand wrote:
> On 28.09.19 00:17, Alexander Duyck wrote:
>> On Fri, Sep 27, 2019 at 2:59 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>>>
>>> On Fri, 27 Sep 2019 17:28:06 -0400 Qian Cai <cai@lca.pw> wrote:
>>>
>>>>>
>>>>> So I think you've moved the arch_free_page() to be after the final
>>>>> thing which can access page contents, yes?  If so, we should have a
>>>>> comment in free_pages_prepare() to attmept to prevent this problem from
>>>>> reoccurring as the code evolves?
>>>>
>>>> Right, something like this above arch_free_page() there?
>>>>
>>>> /*
>>>>  * It needs to be just above kernel_map_pages(), as s390 could mark those
>>>>  * pages unused and then trigger a fault when accessing.
>>>>  */
>>>
>>> I did this.
>>>
>>> --- a/mm/page_alloc.c~mm-page_alloc-fix-a-crash-in-free_pages_prepare-fix
>>> +++ a/mm/page_alloc.c
>>> @@ -1179,7 +1179,13 @@ static __always_inline bool free_pages_p
>>>                 kernel_init_free_pages(page, 1 << order);
>>>
>>>         kernel_poison_pages(page, 1 << order, 0);
>>> +       /*
>>> +        * arch_free_page() can make the page's contents inaccessible.  s390
>>> +        * does this.  So nothing which can access the page's contents should
>>> +        * happen after this.
>>> +        */
>>>         arch_free_page(page, order);
>>> +
>>>         if (debug_pagealloc_enabled())
>>>                 kernel_map_pages(page, 1 << order, 0);
>>>
>>
>> So the question I would have is what is the state of the page after it
>> has been marked unused and then pulled back in? I'm assuming it will
>> be all 0s.
> 
> I think this comment relates to the s390x implementation, so I'll try to
> explain that. After arch_free_page() the page might have been zapped in
> the hypervisor, but that might happen deferred. The guest ends up
> triggering the ESSA instruction in arch_free_page(). That instruction
> sets some extended-page-table-related ("pgste") bits in the hypervisor
> tables for the guest ("gmap") and fills a buffer with these entries. The
> page is marked _PGSTE_GPS_USAGE_UNUSED.

Yes. And that also means that architecturally it can be 0 or it can contain
the old content depending on whether the host has paged that page out or not
and how many pages have been marked unused.
I am also sure that the implementation of z/VM and KVM do differ in that regard.
For example KVM does not make use of the logical zero state but z/VM does.

In essence you can consider this like a ballooner that takes away the page lazily.


For a writeup of the details see 
https://www.kernel.org/doc/ols/2006/ols2006v2-pages-321-336.pdf
(This also contains additional states that were never merged upstream)
