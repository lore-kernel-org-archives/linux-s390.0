Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH V3 0/3] mm/memory_hotplug: Pre-validate the address range
 with platform
References: <1610975582-12646-1-git-send-email-anshuman.khandual@arm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <d57036a1-de12-2d32-be65-daaa3dc5b772@redhat.com>
Date: Tue, 19 Jan 2021 14:33:03 +0100
MIME-Version: 1.0
In-Reply-To: <1610975582-12646-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org, akpm@linux-foundation.org, hca@linux.ibm.com, catalin.marinas@arm.com
Cc: Oscar Salvador <osalvador@suse.de>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On 18.01.21 14:12, Anshuman Khandual wrote:
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
> This series applies on v5.11-rc4 and has been tested on arm64. But only
> build tested on s390.
> 
> Changes in V3
> 
> - Updated the commit message in [PATCH 1/3]
> - Replaced 1 with 'true' and 0 with 'false' in memhp_range_allowed()
> - Updated memhp_range.end as VMEM_MAX_PHYS - 1 and updated vmem_add_mapping() on s390
> - Changed memhp_range_allowed() behaviour in __add_pages()
> - Updated __add_pages() to return E2BIG when memhp_range_allowed() fails for non-linear mapping based requests

Minor thing, we should make up our mind if we want to call stuff
internally "memhp_" or "mhp". I prefer the latter, because it is shorter.


-- 
Thanks,

David / dhildenb
