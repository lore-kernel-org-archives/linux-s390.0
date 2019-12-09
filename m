Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:56026 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfLITOE (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 9 Dec 2019 14:14:04 -0500
From: Logan Gunthorpe <logang@deltatee.com>
Date: Mon,  9 Dec 2019 12:13:40 -0700
Message-Id: <20191209191346.5197-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [PATCH 0/6] Allow setting caching mode in arch_add_memory() for P2PDMA
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>, Dan Williams <dan.j.williams@intel.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Logan Gunthorpe <logang@deltatee.com>

Hi,

Currently, the page tables created using memremap_pages() are always
created with the PAGE_KERNEL cacheing mode. However, the P2PDMA code
is creating pages for PCI BAR memory which should never be accessed
through the cache and instead use either WC or UC. This still works in
most cases, on x86, because the MTRR registers typically override the
caching settings in the page tables for all of the IO memory to be
UC-. However, this tends not to work so well on other arches or
some rare x86 machines that have firmware which does not setup the
MTRR registers in this way.

Instead of this, this series proposes a change to arch_add_memory()
to take the pgprot required by the mapping which allows us to
explicitly set pagetable entries for P2PDMA memory to WC.

This changes is pretty routine for most of the arches: x86_64, s390, arm64
and powerpc simply need to thread the pgprot through to where the page tables
are setup. x86_32 unfortunately sets up the page tables at boot so
must use _set_memory_prot() to change their caching mode. ia64 and sh
don't appear to have an easy way to change the page tables so, for now
at least, we just return -EINVAL on such mappings and thus they will
not support P2PDMA memory until the work for this is done.

Thanks,

Logan

--

Logan Gunthorpe (6):
  x86/mm: Thread pgprot_t through init_memory_mapping()
  x86/mm: Introduce _set_memory_prot()
  powerpc/mm: Thread pgprot_t through create_section_mapping()
  s390/mm: Thread pgprot_t through vmem_add_mapping()
  mm, memory_hotplug: Provide argument for the pgprot_t in
    arch_add_memory()
  mm/memremap: Set caching mode for PCI P2PDMA memory to WC

 arch/arm64/mm/mmu.c                        |  4 +--
 arch/ia64/mm/init.c                        |  5 +++-
 arch/powerpc/include/asm/book3s/64/hash.h  |  3 +-
 arch/powerpc/include/asm/book3s/64/radix.h |  3 +-
 arch/powerpc/include/asm/sparsemem.h       |  3 +-
 arch/powerpc/mm/book3s64/hash_utils.c      |  5 ++--
 arch/powerpc/mm/book3s64/pgtable.c         |  7 +++--
 arch/powerpc/mm/book3s64/radix_pgtable.c   | 18 +++++++-----
 arch/powerpc/mm/mem.c                      |  7 +++--
 arch/s390/include/asm/pgtable.h            |  3 +-
 arch/s390/mm/extmem.c                      |  3 +-
 arch/s390/mm/init.c                        |  4 +--
 arch/s390/mm/vmem.c                        | 10 +++----
 arch/sh/mm/init.c                          |  5 +++-
 arch/x86/include/asm/page_types.h          |  3 --
 arch/x86/include/asm/pgtable.h             |  3 ++
 arch/x86/include/asm/set_memory.h          |  1 +
 arch/x86/kernel/amd_gart_64.c              |  3 +-
 arch/x86/mm/init.c                         |  9 +++---
 arch/x86/mm/init_32.c                      | 10 +++++--
 arch/x86/mm/init_64.c                      | 34 ++++++++++++----------
 arch/x86/mm/mm_internal.h                  |  3 +-
 arch/x86/mm/pageattr.c                     |  7 +++++
 arch/x86/platform/efi/efi_64.c             |  3 +-
 include/linux/memory_hotplug.h             |  2 +-
 mm/memory_hotplug.c                        |  2 +-
 mm/memremap.c                              |  5 +++-
 27 files changed, 104 insertions(+), 61 deletions(-)

--
2.20.1
