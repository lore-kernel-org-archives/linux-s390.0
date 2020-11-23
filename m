Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:51952 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgKWC3O (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sun, 22 Nov 2020 21:29:14 -0500
From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [RFC 0/3] mm/hotplug: Pre-validate the address range with platform
Date: Mon, 23 Nov 2020 07:58:46 +0530
Message-Id: <1606098529-7907-1-git-send-email-anshuman.khandual@arm.com>
List-ID: <linux-s390.vger.kernel.org>
To: linux-mm@kvack.org, akpm@linux-foundation.org, david@redhat.com
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

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

This series applies on v5.10-rc5 and has been slightly tested on arm64.
But looking for some early feedback here.

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
  mm/hotplug: Pre-validate the address range with platform
  arm64/mm: Define arch_get_addressable_range()
  s390/mm: Define arch_get_addressable_range()

 arch/arm64/include/asm/memory.h |  3 ++
 arch/arm64/mm/mmu.c             | 19 ++++++------
 arch/s390/include/asm/mmu.h     |  2 ++
 arch/s390/mm/vmem.c             | 16 ++++++++---
 include/linux/memory_hotplug.h  | 51 +++++++++++++++++++++++++++++++++
 mm/memory_hotplug.c             | 29 ++++++-------------
 mm/memremap.c                   |  9 +++++-
 7 files changed, 96 insertions(+), 33 deletions(-)

-- 
2.20.1
