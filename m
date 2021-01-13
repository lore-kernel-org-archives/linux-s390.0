Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:58490 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbhAMFEg (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Jan 2021 00:04:36 -0500
Subject: Re: [PATCH V2 1/3] mm/hotplug: Prevalidate the address range being
 added with platform
References: <1608218912-28932-1-git-send-email-anshuman.khandual@arm.com>
 <1608218912-28932-2-git-send-email-anshuman.khandual@arm.com>
 <10e733fa-4568-d38f-9b95-2ccc5dc627b8@redhat.com>
 <20210111134303.GA3031@linux> <e2b53f0a-482d-2045-6162-6de2510c9690@arm.com>
 <556a8a62-7bb2-d16b-67ea-57c87c1a6aa7@redhat.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <041d9344-b07c-c6f9-c41a-01057470c350@arm.com>
Date: Wed, 13 Jan 2021 10:34:04 +0530
MIME-Version: 1.0
In-Reply-To: <556a8a62-7bb2-d16b-67ea-57c87c1a6aa7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.de>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hca@linux.ibm.com, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>



On 1/12/21 3:39 PM, David Hildenbrand wrote:
> On 12.01.21 04:51, Anshuman Khandual wrote:
>>
>>
>> On 1/11/21 7:13 PM, Oscar Salvador wrote:
>>> On Mon, Jan 11, 2021 at 11:51:47AM +0100, David Hildenbrand wrote:
>>>> AFAIKs, all memhp_get_pluggable_range() users pass "1".
>>>>
>>>> What about the "add_pages()-only" path?
>>>
>>> I guess you refer to memremap_pages(), right?
>>
>> Right, via pagemap_range().
>>
>>> If so, moving the added memhp_range_allowed() check above the if-else might do
>>> the trick
>>>
>> We had that code in the earlier version. But dropped it, as we did
>> not want to add any new checks in the generic code. Can add it back
>> if that is preferred.
> 
> I remember discussing replacing the check in __add_pages() instead. But

The proposed change for __add_pages() now seems misleading. Instead of
VM_BUG_ON(), memhp_range_allowed() should be checked directly for a non
linear mapping i.e with 'false' argument and return prematurely in case
that check fails.

s/VM_BUG_ON(!memhp_range_allowed(.., 1)/!memhp_range_allowed(.., 0)/

 /*
  * Reasonably generic function for adding memory.  It is
  * expected that archs that support memory hotplug will
@@ -317,10 +304,7 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
 	if (WARN_ON_ONCE(!params->pgprot.pgprot))
 		return -EINVAL;
 
-	err = check_hotplug_memory_addressable(pfn, nr_pages);
-	if (err)
-		return err;
-
+	VM_BUG_ON(!memhp_range_allowed(PFN_PHYS(pfn), nr_pages * PAGE_SIZE, 1));
 	if (altmap) {
 		/*
 		 * Validate altmap is within bounds of the total request
@@ -1181,6 +1165,61 @@ int add_memory_driver_managed(int nid, u64 start, u64 size,


> I don't really care where the check ends up being. As discussed, at some
> point, we should provide versions of add_pages() and arch_add_pages()
> that don't immediately end in arch-code.

Sure. But for now, AFAICS the above replacement should be sufficient.
