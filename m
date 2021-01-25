Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:41414 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbhAYC7b (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sun, 24 Jan 2021 21:59:31 -0500
From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH V4 0/4] mm/memory_hotplug: Pre-validate the address range with platform
Date: Mon, 25 Jan 2021 08:28:48 +0530
Message-Id: <1611543532-18698-1-git-send-email-anshuman.khandual@arm.com>
List-ID: <linux-s390.vger.kernel.org>
To: linux-mm@kvack.org, akpm@linux-foundation.org, hca@linux.ibm.com, catalin.marinas@arm.com
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, Oscar Salvador <osalvador@suse.de>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>, David Hildenbrand <david@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

This series adds a mechanism allowing platforms to weigh in and prevalidate
incoming address range before proceeding further with the memory hotplug.
This helps prevent potential platform errors for the given address range,
down the hotplug call chain, which inevitably fails the hotplug itself.

This mechanism was suggested by David Hildenbrand during another discussion
with respect to a memory hotplug fix on arm64 platform.

https://lore.kernel.org/linux-arm-kernel/1600332402-30123-1-git-send-email-anshuman.khandual@arm.com/

This mechanism focuses on the addressibility aspect and not [sub] section
alignment aspect. Hence check_hotplug_memory_range() and check_pfn_span()
have been left unchanged. Wondering if all these can still be unified in
an expanded memhp_range_allowed() check, that can be called from multiple
memory hot add and remove paths.

This series applies on v5.11-rc5 and has been tested on arm64. But only
build tested on s390.

Changes in V4:

- Moved arch_get_mappable_range() earlier in vmem_add_mapping() on s390
- Moved mhp_range_allowed() back in pagemap_range() as in V2 series
- Changed max_phys as (1ULL << MAX_PHYSMEM_BITS) - 1 in mhp_get_pluggable_range()
- Renamed all memhp instances into mhp
- Dropped the RFC tag from the last patch

Changes in V3:

https://lore.kernel.org/linux-mm/1610975582-12646-1-git-send-email-anshuman.khandual@arm.com/

- Updated the commit message in [PATCH 1/3]
- Replaced 1 with 'true' and 0 with 'false' in memhp_range_allowed()
- Updated memhp_range.end as VMEM_MAX_PHYS - 1 and updated vmem_add_mapping() on s390
- Changed memhp_range_allowed() behaviour in __add_pages()
- Updated __add_pages() to return E2BIG when memhp_range_allowed() fails for non-linear mapping based requests

Changes in V2:

https://lore.kernel.org/linux-mm/1608218912-28932-1-git-send-email-anshuman.khandual@arm.com/

- Changed s390 version per Heiko and updated the commit message
- Called memhp_range_allowed() only for arch_add_memory() in pagemap_range()
- Exported the symbol memhp_get_pluggable_range() 

Changes in V1:

https://lore.kernel.org/linux-mm/1607400978-31595-1-git-send-email-anshuman.khandual@arm.com/

- Fixed build problems with (MEMORY_HOTPLUG & !MEMORY_HOTREMOVE)
- Added missing prototype for arch_get_mappable_range()
- Added VM_BUG_ON() check for memhp_range_allowed() in arch_add_memory() per David

Changes in RFC V2:

https://lore.kernel.org/linux-mm/1606706992-26656-1-git-send-email-anshuman.khandual@arm.com/

Incorporated all review feedbacks from David.

- Added additional range check in __segment_load() on s390 which was lost
- Changed is_private init in pagemap_range()
- Moved the framework into mm/memory_hotplug.c
- Made arch_get_addressable_range() a __weak function
- Renamed arch_get_addressable_range() as arch_get_mappable_range()
- Callback arch_get_mappable_range() only handles range requiring linear mapping
- Merged multiple memhp_range_allowed() checks in register_memory_resource()
- Replaced WARN() with pr_warn() in memhp_range_allowed()
- Replaced error return code ERANGE with E2BIG

Changes in RFC V1:

https://lore.kernel.org/linux-mm/1606098529-7907-1-git-send-email-anshuman.khandual@arm.com/

Cc: Oscar Salvador <osalvador@suse.de>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-s390@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (3):
  mm/memory_hotplug: Prevalidate the address range being added with platform
  arm64/mm: Define arch_get_mappable_range()
  s390/mm: Define arch_get_mappable_range()

David Hildenbrand (1):
  virtio-mem: check against mhp_get_pluggable_range() which memory we can hotplug

 arch/arm64/mm/mmu.c            | 15 +++----
 arch/s390/mm/init.c            |  1 +
 arch/s390/mm/vmem.c            | 14 +++++-
 drivers/virtio/virtio_mem.c    | 40 +++++++++++------
 include/linux/memory_hotplug.h | 10 +++++
 mm/memory_hotplug.c            | 78 +++++++++++++++++++++++++---------
 mm/memremap.c                  |  6 ++-
 7 files changed, 122 insertions(+), 42 deletions(-)

-- 
2.20.1
