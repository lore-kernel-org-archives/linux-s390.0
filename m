Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795691676;
	b=Yd7Xkz0p528VK1Mngo4K63vXOOyxCAHqKXn8FxzR6aVfc3AJEp08Wd8QWHWuaes2etvk
	 jajB5nmWjSyKRb7t5Qym4YisqXpHQfd19K5S3FNvY0NnymCHEhfbt4txHsE4eFvylF6yu
	 gCRzdjkqIzlfr30jHyZhbdsIflCwhIWQos6Kv+HKJ2IYWWP1KVRyd4xF9Oa4YxIZ4koGY
	 +fr9iMd8pb2xMJKxcVcFrkPBKqcu0OIisYkDZgGvPFGDwMAxr1+DVPbCHAcpszSk6lBPU
	 TM8czeEAdbBNlEazXgmbBlvNwxurZOtpaVl1ciDkm6PtdInxfRTpHGjeijpb8GiO/PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691676;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=6YKQUHqJDRHR3OCTfVDPkStj7CDLwSpBT3OSStLmyG8=;
	b=bMMg3iH2sVil9bEFTZGDDKIBAr2Oa9oqcTs5UNC6oQJINP+zVb80BEX++bmj0hq0vc0r
	 Qz7Z8U617rQk5Vz5/z9n/fkTztsn+yzgYlEQlsneWlnPpfUZzlHSAipLNd2qzgtyE5M/A
	 ZHp/FXoN9KM6XMrqGXeKm+BPYTLF1rGbKsUhvGPrOY4GZmIbqiucoLzhIXMrAWeJ+58sT
	 GECbl3cwkrfIkPQary1PTqMeRWkstH0APKKnKxmtkvTHoIF4rsonYwH5pyRjsHDJuc0xM
	 wGl1DJK6oTapGf6kpzqYepyH7CNzzlHTQiMc5Kdj0AzEE2yyhruTdJO6XHCMoAFsVBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RIzKI4va;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7FC606A31E;
	Thu, 26 Nov 2026 11:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RIzKI4va
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C461F000C0;
	Thu, 26 Nov 2026 11:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691675;
	bh=6YKQUHqJDRHR3OCTfVDPkStj7CDLwSpBT3OSStLmyG8=;
	h=From:Subject:Date:To:Cc;
	b=RIzKI4va+frBwlc3L5up4od5Tzz5+IjApWpqzPqE+xv9jFM5mM90LbTn7IGHybUdo
	 frm/EMLI2JqkB+cS25k4UmXZXWB07H+XNcKtUR7frpUMZxWrCYR3DGOa/X/MpLq+jh
	 PV0BS7E4dViEIpcL/qFS4PVk9Q6KK0gywkDhG+VaVhoAjRq2WN1fBw0VQozFJ0FoOZ
	 MvP+SOIq31uptC2jpA+gEOEia4UowVG5kosrZuTrhHijOhq3bltvBXoa7seeeP5CwO
	 ZYXkZLAKrsjA5mYJZEYMzX21yAE9XTWjfZ/GYlVgWG9dZei7XsFofG/i2PQ80MNyan
	 d4HLkIP2adjlg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH RFC v2 00/54] arch, mm: create a generic
 set_memory/change_page_attr core
Date: Thu, 26 Nov 2026 13:14:13 +0200
Message-Id: <20261126-generic-set-memory-v0-1-v2-0-723f1e33c3d8@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WQzU7DMBCEX6XymS3+i+3khITEA3BFPdjOpjGQB
 OzUKqr67jhphZAQcNzRfrOzcyIJY8BEms2JRMwhhWksA7/ZEN/bcY8Q2jITTrmimjPY41gIDwl
 nGHCY4gdkCgyoqqS2lDpukRT6LWIXjqvzE3l8uCe7i5gO7hn9vHgua84mBBft6PtF+ul+m+lWw
 bK2rPchzUVc42a2ev+bLJdwwD3rvOKCKifuXjCO+Lqd4p7szpdYEd8P5fn5Gvjr91LF4l8zBX1
 whbNzaQi0osIZha42rMmcfK/rgjDGOKwNwNEooJ5VTtnWc8abkvxPIIbkMwiURhvTVabDX2/oK
 5JETcHwWopaFErb65G1Xz8NQ5ibjUXnNNdSaiWpoJK2leFeMalN25lOWu262reitHL+BOlh9HM
 aAgAA
X-Change-ID: 20260721-generic-set-memory-v0-1-06547a00b2ae
To: linux-mm@kvack.org
Cc: =?utf-8?q?Adrian_Barna=C5=9B?= <abarnas@google.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Borislav Petkov <bp@alien8.de>, Brendan Jackman <brendan.jackman@linux.dev>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 David Hildenbrand <david@kernel.org>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Ingo Molnar <mingo@kernel.org>, Kevin Brodsky <kevin.brodsky@arm.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, Michal Hocko <mhocko@suse.com>, 
 Mike Rapoport <rppt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Paul Walmsley <pjw@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Russell King <linux@armlinux.org.uk>, 
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, x86@kernel.org
X-Mailer: b4 0.16.1-dev

= tl;dr =

This is heavily reworked v2 of

https://lore.kernel.org/all/20260721-generic-set-memory-v0-1-v1-0-2c1fc62306b3@kernel.org

I decided to convert all architectures that implement set_memory_*() in one
series so that it will be clear that the consolidation does not have
conceptual gaps.

While the series is large, a bulk of it is a refactoring of x86's CPA, and
then several commits that create the generic code and a few commits per
converted architecture.

= Motivation =

Currently there are 7 independent implementations for set_memory and
set_direct_map APIs.

With increasing demand for kernel page table manipulations, for example
"Direct Map Removal Support for guest_memfd" [1] and "mm: ASI direct map
management" [2], it makes sense to have a generic core for kernel page
table manipulation in mm/ with helpers in the architecture specific code.

A fix to a UAF bug [3] earlier this year had to touch set memory
functionality in subtly different way in different architectures rather
than to fix the core logic in a single place.

x86's implementation is the most versatile and most battle tested and as
such it is the best base for the generic implementation: it preserves large
mappings when it can, it splits when it must, it handles the direct map
alias, it serializes against itself and it sanity checks the result. The
others are catching up one bug at a time ;-)

With the generic CPA core in place it would be possible to:

- make sure protection updates follow all-or-nothing principle: today a
  request that fails half way leaves the pages it already processed changed
  and a caller has no real way to recover from it
- add an "atomic" mode to CPA so that it could handle debug_pagealloc and
  KFENCE the same way on all architectures
- enable collapse of large mappings on arm64 with BBML3 and on s390 and let
  them use EXECMEM_ROX_CACHE
- enable collapse of the direct map sometime in the future

= Changes =

This series converts all the architectures that implement set_memory APIs
to use a generic core based on x86 implementation so that all of them have
the same behaviour.

The core walks the page tables, serializes the requests, decides how large
mappings are handled, and makes direct map counters in /proc/meminfo and
/proc/vmstat and CPA statistics in debugfs available to all architectures.

The architectures take care of the page table format, of what they can
split, of definitions of alias mappings and of the TLB flushes.

The changelogs of the conversion patches list what changes for every
architecture.

I left out Documentation/mm/kernel-page-tables.rst update for now. Will
post it with non-RFC version.

= Patches =

Patches 1-2 are riscv fixes for handling of p4d leaves and Svnapot.

Patches 3-5 align command line parsing in s390 decompressor with the kernel
to make sure both kernel and decompressor see the same parameter values,
particularly for debug_pagealloc.

Patches 6-17 are x86 fixes and cleanups.

Patches 18-28 reorganize x86 CPA implementation to make it friendlier for
generalization and separate the generic part of CPA from the x86 specifics.

Patch 29 pulls CPA core to mm/pageattr.c and declares the architecture
hooks in include/linux/pageattr.h.

Patches 30-32, 38, 43, 44 and 48 add bits that the architectures converted
after them need.

Then there are the conversion patches:
- 33-36 for LoongArch
- 37 for ARM
- 39 for powerpc
- 40-42 for riscv
- 45-47 for s390
- 49-52 for arm64

And in the end, patch 53 enables the generic core with ARCH_HAS_SET_MEMORY
and patch 54 adds kernel-doc for the API and the hooks.

= Testing =

The patches are build tested on all architectures with various relevant
configuration options turned on and off.

arm64 and riscv boot in QEMU and pass module load and unload loops, BPF JIT
loads, memfd_secret() and writes to tmpfs, which on arm64 trigger CPA with
debug_pagealloc.

x86 is tested in KVM with the CPA self test, module load and unload loops
and BPF JIT loads.

All three were tested with and without debug_pagealloc, and arm64 with
rodata=on as well.

The tests ran with a concurrent loop reading the kernel page tables dump in
debugfs to rule out races with ptdump.

I also verified that there is no measurable performance difference on x86.

= Prerequisites =

While working on this series I found a few more issues, though much less
pressing than UAF :)

The fixes for x86 [4], riscv [5] and s390 [6] are posted separately.

This series is on top of v7.4-rc3 with the posted fixes applied and with
hibernation series [7] from mm-nonmm-unstable that is waiting for the next
merge window in Andrew's tree.

b4 will conflict on the hibernation series, it's easier to get this RFC
from git:

https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=generic-set-memory/rfc-v2

= Merging =

As Dave suggested [8], I'd like this to go through mm with acks from the
architectures.

= References =

[1] https://lore.kernel.org/all/20260410151746.61150-1-kalyazin@amazon.com
[2] https://lore.kernel.org/all/20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com/
[3] https://lore.kernel.org/all/20260723-series-vmap-race-fix-v6-0-8cc77dcc0018@kernel.org
[4] https://lore.kernel.org/all/20261112-fixes-x86-v1-0-791adb8d6670@kernel.org
[5] https://lore.kernel.org/all/20261117-fixes-riscv-v2-0-5edc9bdc54fd@kernel.org
[6] https://lore.kernel.org/all/20261117-fixes-s390-v1-1-2d9d04ca0072@kernel.org
[7] https://lore.kernel.org/all/20260926-hibernation-v2-0-235f69f3ab2a@kernel.org
[8] https://lore.kernel.org/all/fa75382e-878a-4064-a9b1-43bd2c9dedce@intel.com

---
v2 changes:
* revamp the series :)

v1: https://patch.msgid.link/20260721-generic-set-memory-v0-1-v1-0-2c1fc62306b3@kernel.org

---
Mike Rapoport (Microsoft) (54):
      riscv: do not use P4D entries for the linear mapping
      riscv: test for Svnapot in pte_napot()
      s390/boot: parse boolean parameters like the kernel
      s390/boot: stop parsing the command line at "--"
      s390/boot: treat dashes and underscores alike in parameter names
      x86/mm/pat: don't count kernel image splits as direct map splits
      x86/mm/pat: drop KERN_WARNING from the WARN() in __cpa_process_fault()
      x86/mm/pat: fail a split at an unexpected level with -EINVAL
      x86/mm/pat: separate CPA request flags from internal state
      x86/mm/pat: stop using CPA for debug_pagealloc
      x86/mm/pat: drop the init_mm read lock from change_page_attr_set_clr()
      x86/mm/pat: introduce change_page_attr_pages()
      x86/mm/pat: make the direct map counters atomic
      x86/mm/pat: take pgd_lock only around the pgd_list walks
      x86/mm/pat: look up the effective NX/RW bits in verify_rwx()
      x86/mm/pat: look up a large page again only after dropping cpa_lock
      x86/mm/pat: drop the check of existing mappings against static protections
      x86/mm/pat: consolidate encoding of page table entries
      x86/mm/pat: use enum pgtable_level in CPA
      x86/mm/pat: index the CPA statistics by page table level
      x86/mm/pat: introduce struct cpa_leaf
      x86/mm/pat: consolidate calculation of the new protection
      x86/mm/pat: allocate the page tables for a split by level
      x86/mm/pat: detect unchanged mappings by comparing protections
      x86/mm/pat: add cpa_is_direct_map()
      x86/mm/pat: implement set_memory_*() with a table of operations
      x86/mm/pat: prepare the direct map counters for the generic code
      x86/mm/pat: separate the generic part of CPA from the x86 hooks
      x86/mm/pat, mm: pull CPA core to mm/
      mm/pageattr: introduce arch_cpa_can_split()
      mm/pageattr: introduce cpa_flush_tlb_kernel_range()
      asm-generic: add an empty pageattr.h
      LoongArch: use pfn_is_nosave() to exclude firmware ranges from hibernation
      LoongArch: stop pretending LoongArch supports set_direct_map APIs
      LoongArch: drop the huge page handling from set_memory()
      LoongArch: use the generic CPA core
      ARM: mm: use the generic CPA core
      mm/pageattr: let a leaf cover a contiguous block of entries
      powerpc: use the generic CPA core
      riscv: replace set_memory_rw_nx() with set_memory_nx() and set_memory_rw()
      riscv: use the generic CPA core
      riscv: count the mappings of the linear map
      mm/pageattr: let an architecture allocate the page tables for a split
      mm/pageattr: derive direct map counter updates from the level sizes
      s390/boot: map the identity map with 4K pages for debug_pagealloc
      s390: remove set_memory_rwnx()
      s390: use the generic CPA core
      mm/pageattr: let an architecture bracket the set_memory() entry points
      arm64: mm: allocate page tables in the callers of split_p{mu}d()
      arm64: use the generic CPA core
      arm64: let the generic CPA core split large mappings
      arm64: count the mappings of the linear map
      arch, mm: enable the generic CPA core with ARCH_HAS_SET_MEMORY
      mm/pageattr: document CPA core and the architecture hooks

 arch/arm/include/asm/set_memory.h       |    6 +-
 arch/arm/mm/pageattr.c                  |   96 ++-
 arch/arm64/include/asm/mmu.h            |    3 -
 arch/arm64/include/asm/pageattr.h       |   23 +
 arch/arm64/include/asm/set_memory.h     |    2 -
 arch/arm64/mm/init.c                    |    3 -
 arch/arm64/mm/mmu.c                     |  310 +++-----
 arch/arm64/mm/pageattr.c                |  390 +++++-----
 arch/loongarch/Kconfig                  |    1 -
 arch/loongarch/include/asm/set_memory.h |   12 +-
 arch/loongarch/mm/pageattr.c            |  215 +-----
 arch/loongarch/power/hibernate.c        |    6 +-
 arch/powerpc/include/asm/set_memory.h   |   46 +-
 arch/powerpc/mm/pageattr.c              |  160 ++--
 arch/riscv/include/asm/pageattr.h       |   17 +
 arch/riscv/include/asm/pgtable.h        |   10 +-
 arch/riscv/include/asm/set_memory.h     |   10 +-
 arch/riscv/kernel/setup.c               |    6 +-
 arch/riscv/mm/init.c                    |   24 +-
 arch/riscv/mm/pageattr.c                |  459 ++++--------
 arch/s390/boot/boot.h                   |    1 +
 arch/s390/boot/ipl_parm.c               |   64 +-
 arch/s390/boot/string.c                 |    9 +
 arch/s390/boot/vmem.c                   |    3 +-
 arch/s390/include/asm/pageattr.h        |   21 +
 arch/s390/include/asm/set_memory.h      |   56 +-
 arch/s390/mm/dump_pagetables.c          |    2 -
 arch/s390/mm/init.c                     |   15 +
 arch/s390/mm/pageattr.c                 |  496 ++++++-------
 arch/s390/mm/vmem.c                     |   12 +-
 arch/x86/Kconfig                        |    8 -
 arch/x86/include/asm/pageattr.h         |   33 +
 arch/x86/include/asm/pgtable_types.h    |    6 -
 arch/x86/include/asm/set_memory.h       |    5 -
 arch/x86/mm/init_32.c                   |    5 +-
 arch/x86/mm/init_64.c                   |   15 +-
 arch/x86/mm/pat/set_memory.c            | 1220 +++++++++----------------------
 include/asm-generic/Kbuild              |    1 +
 include/asm-generic/pageattr.h          |    5 +
 include/asm-generic/set_memory.h        |   11 +
 include/linux/pageattr.h                |  459 ++++++++++++
 include/linux/pgtable.h                 |   26 +
 include/linux/vm_event_item.h           |    2 +-
 mm/Kconfig                              |    3 +
 mm/Kconfig.debug                        |    8 +
 mm/Makefile                             |    1 +
 mm/pageattr.c                           |  684 +++++++++++++++++
 mm/vmstat.c                             |    2 +-
 48 files changed, 2614 insertions(+), 2358 deletions(-)
---
base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
change-id: 20260721-generic-set-memory-v0-1-06547a00b2ae
prerequisite-change-id: 20260916-hibernation-7603b86eb981:v2
prerequisite-patch-id: b1bb2d4e1a2f542e3e8d0741a30a780722a350b0
prerequisite-patch-id: da4fcef1a9df5f657cadfccf591d6bbb45a197f4
prerequisite-patch-id: 6eab635bf8bd5b2ad0b40464fc7f595d7929769a
prerequisite-patch-id: 74ad7bb09568c6b155058869cddbca01f37ee377
prerequisite-patch-id: 319fe0988123448585901a69c901cd6381744ae7
prerequisite-change-id: 20261112-fixes-x86-0c15b6adc212:v1
prerequisite-patch-id: 00540235ba71e3d6f77190958aed21af53e3231e
prerequisite-patch-id: 4c8347b413897acfb979f48814bd0a98887881cb
prerequisite-patch-id: 3432c685702db763dc8ace31c0ba56e9e357c97d
prerequisite-patch-id: 0b22ccc8b6b84cf68d83eb4322196cc51b22310e
prerequisite-patch-id: 0e2e3eb56ec4e967db60bc464e42cdcb4a132571
prerequisite-patch-id: f35d21bc18f51b0ca3fc3c80f3fb8901ce207f98
prerequisite-patch-id: b1825b2c583747b97cfee853f231ff91fbbb1e64
prerequisite-patch-id: c972a0aef660b2fc348ad08acfd290406b565932
prerequisite-patch-id: 95489ac4f31f34a8b874ca96c6145c6613f9b612
prerequisite-change-id: 20261112-fixes-riscv-3e48788f58fe:v2
prerequisite-patch-id: 99056c0e4f9faa899a17b9cdc913796f60d848d5
prerequisite-patch-id: cc95791ee9f36ddcf041d6c0dd9ddd655ed38718
prerequisite-change-id: 20261117-fixes-s390-82943938787a:v1
prerequisite-patch-id: f93f6904a8052e1e5e504e055e886363846b7881

--
Sincerely yours,
Mike.

