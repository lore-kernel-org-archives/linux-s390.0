Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CDA45629A;
	Fri, 11 Sep 2026 19:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789155496; cv=none; b=Kw70TBWNv9jSXfHgGuRAGY5o6+S7ixHxTVfNfNYPio9KFCXZxF3lxclXu/IsX3V38Cx44fmEBRYu9UC2ji8m4ItBLb41VMJGOl/EhdUWvRSsjdggSnG6/DqvKVIPRRSw6xIJBeTSH7Pyi6nnaoh5vUeLcY7fEc4QtpdeBrTy3JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789155496; c=relaxed/simple;
	bh=RrPlKuSegKczbWHtvSwqv948LdW8VcCW3xiwS2H9cjE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IqK+qVxGG+gayOU+K7t9iWzcWgoyiCC4xouu+EUapUglqnWWLLRRHe4nlFCZLTAp3nfTLy8+6FYWO8TA+7aT8odK3oOcuWiBskcXY1g/05IE4EfbCK/75pYuOMNQrb8NwHoFVUQxCiqPh9PJMRVUeru5Ej7+0BQ2/GvTgBSbif8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QMj0IEmZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMj0IEmZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04931F000FF;
	Fri, 11 Sep 2026 19:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789155479;
	bh=hf37vYyW20dEN/lTmhv9TGUfmK0JZbnALvXs9gFdpBw=;
	h=From:Subject:Date:To:Cc;
	b=QMj0IEmZBrk/GKZIX9T/5F97jvb2O2L3q/ovTsXYfnZD8Kw/Q4X2c/SRae5A1roMB
	 28QBr7EzVgZ+FMH+N0105ht5veE+OmSQcB+etn1rvALVTOjYICRsC4wfdvbMKkGmXk
	 IDDsJFMcnzupqWm/s46BVVqKm5NUrjfVX+FlcdHwCGemk/f/9ktInqmxM7GH3q1pBO
	 4Y6a15+wknntdtHfMGhulc3/6cw7Y0PmAQfyPVrkiYWHIU4ksi5tpPVXEdNb8uAQT5
	 bSlXL/WAnt7QsoOSjBOFnWqFI8TVUT91h/EcwR6DumY/+ZsRIWVbdSdjLLA8eyFmua
	 N34D69zmfbleQ==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: [PATCH v3 00/12] mm: make userland page table freeing RCU-safe
Date: Fri, 11 Sep 2026 20:36:47 +0100
Message-Id: <20260911-rcu-pagetable-freeing-v3-0-7b8c86103821@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WN0Q6CIBhGX8VxHQ1QibrqPVoXQL9IOXSgrOZ89
 0Bv6sLLs33fOTMK4C0EdClm5CHaYHuXoDwUSLfSGcD2kRgxwjgRJcVeT3iQBkapOsCNB7DOYFE
 prkCUBBhB6Tt4aOx79d7uG4dJPUGPWZYXrQ1j7z9rONK82xpnsteIFBNcVzWXgmrBKLu+wDvoj
 r03KEci+9WIPQ1LGtpwongF4iTgT7Msyxf4nPnyFAEAAA==
X-Change-ID: 20260831-rcu-pagetable-freeing-84b6be830e20
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Brian Cain <bcain@kernel.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Dinh Nguyen <dinguyen@kernel.org>, 
 Simon Schuster <schuster.simon@siemens-energy.com>, 
 Jonas Bonn <jonas@southpole.se>, 
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, 
 Stafford Horne <shorne@gmail.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Russell King <linux@armlinux.org.uk>, Vineet Gupta <vgupta@kernel.org>, 
 Michal Simek <monstr@monstr.eu>, Chris Zankel <chris@zankel.net>, 
 Max Filippov <jcmvbkbc@gmail.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Mark Rutland <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Arnd Bergmann <arnd@arndb.de>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
 linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-snps-arc@lists.infradead.org, 
 linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-alpha@vger.kernel.org, loongarch@lists.linux.dev, 
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 linux-um@lists.infradead.org, Hugh Dickins <hughd@google.com>, 
 Qi Zheng <qi.zheng@linux.dev>, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8719; i=ljs@kernel.org;
 h=from:subject:message-id; bh=RrPlKuSegKczbWHtvSwqv948LdW8VcCW3xiwS2H9cjE=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLKWRDS6HNB+eMojqSzYMqTy97EfC96GXVurd+BWnXFOs
 YFurChrRykLgxgXg6yYIsvzL+L7g0TC5nVe8HeDmcPKBDKEgYtTACZy04yR4eXy/5OeRddUTr4e
 UzjHYfv9Tb8tVs4SvW79e7nZ7wJxDTeGf+ozOy+pmWdGsn85oKkiuH+J1yU/27uT2AqkFj5b+Zg
 tkhUA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

The majority of architectures in the kernel defer page table freeing until
an RCU grace period has elapsed, this series converts all remaining
architectures to do so too and eliminates CONFIG_MMU_GATHER_RCU_TABLE_FREE
altogether.

This is important because it enables safe lockless page table walking under
RCU alone.

Doing so allows for reduced lock contention, avoids lock ordering concerns
and enables fast, efficient and correct page table walking as a result.

Additionally it removes a bunch of code and architecture-specific behaviour
which is always a beneficial thing to do.

There has been much recent work on this:

* In 2023 Hugh Dickins RCU-deferred khugepaged page table retraction in
  commit 13cf577e6b66 ("mm/pgtable: add pte_free_defer() for pgtable as
  page").

* Qi Zheng has done most of the work that made this possible starting with
  the critical commit 718b13861d22 ("x86: mm: free page table pages by RCU
  instead of semi RCU").

* Qi then went on to convert a large number of architectures in commit
  e3ecf7c7d082 ("mm: pgtable: convert some architectures to use
  tlb_remove_ptdesc()"), commit 44b079583f7d ("alpha: mm: enable
  MMU_GATHER_RCU_TABLE_FREE") and the series to which it belongs.

* Qi then introduced the important CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE
  option in commit 086498aed3f6 ("mm: convert __HAVE_ARCH_TLB_REMOVE_TABLE
  to CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE config").

* Finally, and critically, Lance Yang then converted the batch allocation
  fallback case to be RCU-safe in commit 1fb3d8c20bfa ("mm/mmu_gather:
  replace IPI with synchronize_rcu() when batch allocation fails").

The work I do here is only possible due to the work Hugh, Qi, Lance and
others have done previously.

An initial task this series addresses is to zap deposited page tables after
an RCU grace period. Not doing so is currently safe, but for page table
walkers relying on RCU alone, it would not be.

The changes are largely mechanical - the majority of arches already have
the machinery required to support CONFIG_MMU_GATHER_RCU_TABLE_FREE and
simply needed configuration changes or small implementation changes to
switch over.

However some arches required extra attention - sh-X2, m68k-motorola and
sparc32.

sh-X2 allocates PMDs from the slab allocator and PTEs as normal. Therefore
CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE is set to customise page table freeing
and the LSB is used to encode which page table level is used, with
__tlb_remove_table() doing the right thing depending on this.

This pattern is repeated for m68k-motorola and sparc32 to account for
different page table levels. In each case, the page tables are aligned such
that sufficient bits are available in each case for encoding this
information.

m68k-motorola required the biggest change - since RCU page table freeing
uses call_rcu(), this means page table freeing can arise from softirq
context.

This was fixed with an IRQ-safe spin lock used in both get_pointer_table()
and free_pointer_table().

As part of this change, the logic for allocation of a new pointer table was
separated out into add_pointer_table() to make the locking more obviously
correct.

Finally, sparc32 was similar to m68k-motorola in that locking was required,
however this was already implemented via a spinlock, and only had to be
updated to be IRQ-safe.

Additionally, the nocache pool's bit_map lock was updated to be IRQ-safe
for softirq frees.

Separately, the PTE path can't take mm->page_table_lock from softirq (no mm
there), which is fine because the page reference count transitions are
atomic and fully ordered.

The series finally removes CONFIG_MMU_GATHER_RCU_TABLE_FREE and all related
configurations and code that supported !CONFIG_MMU_GATHER_RCU_TABLE_FREE.

As a result, page table walks can now be performed safely under RCU without
any risk of page tables being freed underneath a walker.

However, this is the only guarantee that this work provides - page table
walkers must still ensure that page table entries are as expected
throughout.

All changes have been build tested. As most of the conversions are simply
utilising existing mechanics that are known to work, this suffices for most
cases.

However those arches where significant changes have been made -
m68k-motorola, sparc32 and sh-X2 - have been tested further.

For each of these a boot test and stress test has been performed - fork 400
children, each mmap()'ing 2 MiB and touching every page then partially
munmap()'ing then exiting to trigger as much page table freeing as
possible.

All were found to be working correctly.

Note that sparc32 LEON SMP is not emulated, Andreas - do you have a means
of testing this?

v3:
* Added Kiryl's tag to series (thanks! :)
* Corrected commit message, comment indentation in 11/12 as per Kiryl.
* Corrected 12/12 documentation as per Kiryl.

v2:
* Updated commit message to reflect CONFIG_MMU dependency for xtensa as per
  Suren.
* Updated 12/12 to correctly describe the new contract re: readers/writes
  as per Kiryl. Also fixed up typos there as per Kiryl, Suren and slightly
  reworded for clarity, and updated commit message to reflect.
* Updated 11/12 to reflect the fact the change is for userland only as per
  Kiryl, also added a note about write locks similarly to 12/12.
* Fixed bug as reported by sashiko for the sparc32 change (10/12) - the
  refcounts are insufficient on their own, so replace the page_table_lock
  altogether with an IRQ-safe spinlock.
https://lore.kernel.org/r/20260908-rcu-pagetable-freeing-v2-0-1f60b64e878e@kernel.org

v1:
https://patch.msgid.link/20260901-rcu-pagetable-freeing-v1-0-5456a81c8212@kernel.org

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
Lorenzo Stoakes (ARM) (12):
      mm/huge_memory: zap deposited page tables after an RCU grace period
      mm: enable MMU_GATHER_RCU_TABLE_FREE for most 2-level architectures
      mm: enable MMU_GATHER_RCU_TABLE_FREE for MMU riscv
      mm: enable MMU_GATHER_RCU_TABLE_FREE for MMU arm
      mm: enable MMU_GATHER_RCU_TABLE_FREE for arc, microblaze, xtensa
      mm: enable MMU_GATHER_RCU_TABLE_FREE for sparc64
      mm: enable MMU_GATHER_RCU_TABLE_FREE for m68k-coldfire
      mm: enable MMU_GATHER_RCU_TABLE_FREE for sh-X2
      mm: enable MMU_GATHER_RCU_TABLE_FREE for m68k-motorola
      mm: enable MMU_GATHER_RCU_TABLE_FREE for sparc32
      mm: make userland page table freeing RCU-safe
      mm: change the contract for free_pgtables(), update docs

 Documentation/mm/process_addrs.rst       |   6 ++
 arch/Kconfig                             |   8 --
 arch/alpha/Kconfig                       |   1 -
 arch/arc/include/asm/pgalloc.h           |   6 +-
 arch/arm/Kconfig                         |   1 -
 arch/arm64/Kconfig                       |   1 -
 arch/loongarch/Kconfig                   |   1 -
 arch/m68k/Kconfig                        |   1 +
 arch/m68k/include/asm/mcf_pgalloc.h      |   5 +-
 arch/m68k/include/asm/motorola_pgalloc.h |   9 ++-
 arch/m68k/mm/motorola.c                  | 121 ++++++++++++++++++++-----------
 arch/microblaze/include/asm/pgalloc.h    |   2 +-
 arch/mips/Kconfig                        |   1 -
 arch/parisc/Kconfig                      |   1 -
 arch/powerpc/Kconfig                     |   1 -
 arch/riscv/Kconfig                       |   1 -
 arch/s390/Kconfig                        |   1 -
 arch/sh/Kconfig                          |   1 +
 arch/sh/include/asm/pgalloc.h            |   6 +-
 arch/sh/mm/pgtable.c                     |  20 +++++
 arch/sparc/Kconfig                       |   4 +-
 arch/sparc/include/asm/pgalloc_32.h      |   7 +-
 arch/sparc/include/asm/pgalloc_64.h      |   8 --
 arch/sparc/include/asm/tlb_64.h          |   2 -
 arch/sparc/lib/bitext.c                  |  14 ++--
 arch/sparc/mm/srmmu.c                    |  32 ++++++--
 arch/um/Kconfig                          |   1 -
 arch/x86/Kconfig                         |   1 -
 arch/xtensa/include/asm/tlb.h            |   2 +-
 include/asm-generic/tlb.h                |  66 +++--------------
 mm/Kconfig                               |   2 +-
 mm/gup.c                                 |   5 +-
 mm/huge_memory.c                         |   2 +-
 mm/mmu_gather.c                          |  30 ++------
 mm/pgtable-generic.c                     |  15 +++-
 35 files changed, 194 insertions(+), 191 deletions(-)
---
base-commit: 88297631d4d42f6004cb39c0ba3da7d2d10a616f
change-id: 20260831-rcu-pagetable-freeing-84b6be830e20

Best regards,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

