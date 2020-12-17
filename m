Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33512 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726548AbgLQRdD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 17 Dec 2020 12:33:03 -0500
Subject: Re: [PATCH V2 0/3] mm/hotplug: Pre-validate the address range with
 platform
References: <1608218912-28932-1-git-send-email-anshuman.khandual@arm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <5eba82eb-d807-087c-41ba-b79ea8510317@redhat.com>
Date: Thu, 17 Dec 2020 18:31:24 +0100
MIME-Version: 1.0
In-Reply-To: <1608218912-28932-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org, akpm@linux-foundation.org, hca@linux.ibm.com, catalin.marinas@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>

On 17.12.20 16:28, Anshuman Khandual wrote:
> This series adds a mechanism allowing platforms to weigh in and prevalidate
> incoming address range before proceeding further with the memory hotplug.
> This helps prevent potential platform errors for the given address range,
> down the hotplug call chain, which inevitably fails the hotplug itself.
> 
> This mechanism was suggested by David Hildenbrand during another discussion
> with respect to a memory hotplug fix on arm64 platform.
> 
> https://lore.kernel.org/linux-arm-kernel/1600332402-30123-1-git-send-email-anshuman.khandual@arm.com/
> 
> This mechanism focuses on the addressibility aspect and not [sub] section
> alignment aspect. Hence check_hotplug_memory_range() and check_pfn_span()
> have been left unchanged. Wondering if all these can still be unified in
> an expanded memhp_range_allowed() check, that can be called from multiple
> memory hot add and remove paths.
> 
> This series applies on v5.10 and has been tested on arm64. But only
> build tested on s390.
> 
> Changes in V2:
> 
> - Changed s390 version per Heiko and updated the commit message
> - Called memhp_range_allowed() only for arch_add_memory() in pagemap_range()
> - Exported the symbol memhp_get_pluggable_range() 
> 
> Changes in V1:
> 
> https://lore.kernel.org/linux-mm/1607400978-31595-1-git-send-email-anshuman.khandual@arm.com/
> 
> - Fixed build problems with (MEMORY_HOTPLUG & !MEMORY_HOTREMOVE)
> - Added missing prototype for arch_get_mappable_range()
> - Added VM_BUG_ON() check for memhp_range_allowed() in arch_add_memory() per David
> 
> Changes in RFC V2:
> 
> https://lore.kernel.org/linux-mm/1606706992-26656-1-git-send-email-anshuman.khandual@arm.com/
> 
> Incorporated all review feedbacks from David.
> 
> - Added additional range check in __segment_load() on s390 which was lost
> - Changed is_private init in pagemap_range()
> - Moved the framework into mm/memory_hotplug.c
> - Made arch_get_addressable_range() a __weak function
> - Renamed arch_get_addressable_range() as arch_get_mappable_range()
> - Callback arch_get_mappable_range() only handles range requiring linear mapping
> - Merged multiple memhp_range_allowed() checks in register_memory_resource()
> - Replaced WARN() with pr_warn() in memhp_range_allowed()
> - Replaced error return code ERANGE with E2BIG
> 
> Changes in RFC V1:
> 
> https://lore.kernel.org/linux-mm/1606098529-7907-1-git-send-email-anshuman.khandual@arm.com/
> 
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> 
> Anshuman Khandual (3):
>   mm/hotplug: Prevalidate the address range being added with platform
>   arm64/mm: Define arch_get_mappable_range()
>   s390/mm: Define arch_get_mappable_range()

Thanks, I'm planning on reviewing + sending a virtio-mem patch to use
memhp_get_mappable_range() in the new year. I assume we also have
restrictions when it comes to x86-64, will have a look.


-- 
Thanks,

David / dhildenb
