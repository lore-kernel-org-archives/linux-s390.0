Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A277F31A55B;
	Tue,  1 Sep 2026 11:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788260713; cv=none; b=K7zv/w7EQBoBLu1zMhAo1s6sCTQDSTG8wOPe8nb6aus3v9oQ4RVwsMWAQSxudnbuoJnC3PGKGaBiQ91vdmZqhUkVDX5hZQpPTc2Q4XI2LRlMWZu7dQorPrgetJUgyfAsQDac4HMA4CCplWQL/29/jlpO4F7OQoYoCVbLQmlchwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788260713; c=relaxed/simple;
	bh=nOobssw3s2ybzz17WgTPwcFF0UlLF/ay3MomYWqGLy4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GHPvCWvShmHMdx1EWwn6nzvJsPH2nDvbDr3wPVGKF8BdmsPs5mXyZsDeejJqQcfJrlij2AWtCIYbYQghyeo7b+/7EXrj4Fb+Ttyq95Qes01Lpu6HeKdA4kezTOEoX/mIKJ05o4/v9oVzBipgSj801ApQ2OL7EBuMZRmH/nJMQ/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aocYUNqM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aocYUNqM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188E71F000E9;
	Tue,  1 Sep 2026 11:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788260711;
	bh=gRmiVdG7zWf/GvbotLfM+46aH1AfJWGnO1OGWRPxU9E=;
	h=From:Subject:Date:To:Cc;
	b=aocYUNqMRbNIbR6s7Rg9UHR1UN1/ebvPynn8GpuDG2QdVDakyem/wqr3PXG73lTrw
	 LRwJV+WxkKceCXprisvIxR3VWfUEANDIb29r9bo9cxnwu1RT88h7/r2oNGO6i4DLfA
	 /1H00YbDEOwscD5LsRcrichbczg0w+PRJI3ol5M4Acd/RMmHVJ82SDlNk7qRSKQ6fv
	 yZgIP4l8yq1hjJzoNIjNVErJih9+CIYXFkubFhrXJBYOwhfyQUHWcWiVYCHurHrUdp
	 5I376A6qXa8usdLRXcRLGYqkpNqZlPMrocSBYL9TMfz13c76O+Hpawt3iY9CtV9EP1
	 gw7MT7SmcXBiA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: [PATCH 00/12] mm: make userland page table freeing RCU-safe
Date: Tue, 01 Sep 2026 12:01:20 +0100
Message-Id: <20260901-rcu-pagetable-freeing-v1-0-5456a81c8212@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAICwlmoC/yXMQQqDMBBG4avIrDsQY5HQq0gXSfobR0qUiZaCe
 Pem7fJbvHdQgQoK3ZqDFC8psuSK9tJQnHxOYHlUkzW2N65rWePOq0/YfHiCRwUkJ3bX0Ae4zsA
 aqu2qGOX9+w73v8seZsTtO6Pz/AAWVW4teQAAAA==
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7724; i=ljs@kernel.org;
 h=from:subject:message-id; bh=nOobssw3s2ybzz17WgTPwcFF0UlLF/ay3MomYWqGLy4=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLKmbXRPzZlRe2dXWOSN5VOqw0LTPl0Mv/7n0cOKu9vTL
 j4St330uqOUhUGMi0FWTJHl+Rfx/UEiYfM6L/i7wcxhZQIZwsDFKQATOfiUkWFF16YP/Tyvz6vt
 NXmiVXQwt/+G8BbtXWvMJyYvqkt1jd7ByLDI/qRK5V1pmT/yjf2L/kXdcliok3bDpfT2pNb26wH
 9TxkB
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
 arch/sparc/mm/srmmu.c                    |  26 ++++++-
 arch/um/Kconfig                          |   1 -
 arch/x86/Kconfig                         |   1 -
 arch/xtensa/include/asm/tlb.h            |   2 +-
 include/asm-generic/tlb.h                |  66 +++--------------
 mm/Kconfig                               |   2 +-
 mm/gup.c                                 |   5 +-
 mm/huge_memory.c                         |   2 +-
 mm/mmu_gather.c                          |  30 ++------
 mm/pgtable-generic.c                     |  18 ++++-
 35 files changed, 194 insertions(+), 188 deletions(-)
---
base-commit: 88297631d4d42f6004cb39c0ba3da7d2d10a616f
change-id: 20260831-rcu-pagetable-freeing-84b6be830e20

Cheers,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

