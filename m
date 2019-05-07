Return-Path: <SRS0=f00L=TH=kvack.org=owner-linux-mm@kernel.org>
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 0/8] mm/memory_hotplug: Factor out memory block device handling
Date: Tue,  7 May 2019 20:37:56 +0200
Message-Id: <20190507183804.5512-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, akpm@linux-foundation.org, Dan Williams <dan.j.williams@intel.com>, David Hildenbrand <david@redhat.com>, Alex Deucher <alexander.deucher@amd.com>, Andrew Banman <andrew.banman@hpe.com>, Andy Lutomirski <luto@kernel.org>, Arun KS <arunks@codeaurora.org>, Baoquan He <bhe@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Borislav Petkov <bp@alien8.de>, Christophe Leroy <christophe.leroy@c-s.fr>, Chris Wilson <chris@chris-wilson.co.uk>, Dave Hansen <dave.hansen@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, Fenghua Yu <fenghua.yu@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Logan Gunthorpe <logang@deltatee.com>, Mark Brown <broonie@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Mathieu Malaterre <malat@debian.org>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, "mike.travis@hpe.com" <mike.travis@hpe.com>, Nicholas Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.com>, Oscar Salvador <osalvador@suse.de>, Paul Mackerras <paulus@samba.org>, Pavel Tatashin <pasha.tatashin@soleen.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Peter Zijlstra <peterz@infradead.org>, Qian Cai <cai@lca.pw>, "Rafael J. Wysocki" <rafael@kernel.org>, Rich Felker <dalias@libc.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>, Vasily Gorbik <gor@linux.ibm.com>, Wei Yang <richard.weiyang@gmail.com>, Wei Yang <richardw.yang@linux.intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>
List-ID: <linux-s390.vger.kernel.org>

We only want memory block devices for memory to be onlined/offlined
(add/remove from the buddy). This is required so user space can
online/offline memory and kdump gets notified about newly onlined memory.

Only such memory has the requirement of having to span whole memory blocks.
Let's factor out creation/removal of memory block devices. This helps
to further cleanup arch_add_memory/arch_remove_memory() and to make
implementation of new features easier. E.g. supplying a driver for
memory block devices becomes way easier (so user space is able to
distinguish different types of added memory to properly online it).

Patch 1 makes sure the memory block size granularity is always respected.
Patch 2 implements arch_remove_memory() on s390x. Patch 3 prepares
arch_remove_memory() to be also called without CONFIG_MEMORY_HOTREMOVE.
Patch 4,5 and 6 factor out creation/removal of memory block devices.
Patch 7 gets rid of some unlikely errors that could have happened, not
removing links between memory block devices and nodes, previously brought
up by Oscar.

Did a quick sanity test with DIMM plug/unplug, making sure all devices
and sysfs links properly get added/removed. Compile tested on s390x and
x86-64.

Based on git://git.cmpxchg.org/linux-mmots.git

Next refactoring on my list will be making sure that remove_memory()
will never deal with zones / access "struct pages". Any kind of zone
handling will have to be done when offlining system memory / before
removing device memory. I am thinking about remove_pfn_range_from_zone()",
du undo everything "move_pfn_range_to_zone()" did.

v1 -> v2:
- s390x/mm: Implement arch_remove_memory()
-- remove mapping after "__remove_pages"


David Hildenbrand (8):
  mm/memory_hotplug: Simplify and fix check_hotplug_memory_range()
  s390x/mm: Implement arch_remove_memory()
  mm/memory_hotplug: arch_remove_memory() and __remove_pages() with
    CONFIG_MEMORY_HOTPLUG
  mm/memory_hotplug: Create memory block devices after arch_add_memory()
  mm/memory_hotplug: Drop MHP_MEMBLOCK_API
  mm/memory_hotplug: Remove memory block devices before
    arch_remove_memory()
  mm/memory_hotplug: Make unregister_memory_block_under_nodes() never
    fail
  mm/memory_hotplug: Remove "zone" parameter from
    sparse_remove_one_section

 arch/ia64/mm/init.c            |   2 -
 arch/powerpc/mm/mem.c          |   2 -
 arch/s390/mm/init.c            |  15 +++--
 arch/sh/mm/init.c              |   2 -
 arch/x86/mm/init_32.c          |   2 -
 arch/x86/mm/init_64.c          |   2 -
 drivers/base/memory.c          | 109 +++++++++++++++++++--------------
 drivers/base/node.c            |  27 +++-----
 include/linux/memory.h         |   6 +-
 include/linux/memory_hotplug.h |  12 +---
 include/linux/node.h           |   7 +--
 mm/memory_hotplug.c            |  44 ++++++-------
 mm/sparse.c                    |  10 +--
 13 files changed, 104 insertions(+), 136 deletions(-)

-- 
2.20.1
