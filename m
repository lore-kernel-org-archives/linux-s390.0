Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97BB5616D0;
	Tue, 22 Sep 2026 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790091642; cv=none; b=OlBEX8kPtWwOR6SPRpiI9cnFre8O41bE37zyrybDV5hUzHKAaiPmsrmunh683SRA6Y3g+DmC3k2CxUQFBO/HLDszx7igOyxfBs1aUAbIcU/ZFSoTf677vUU648ijli3BOpCvct5bI5L2XE5aeG4Q6qGebfD3zm8yzMHHQDrRcZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790091642; c=relaxed/simple;
	bh=BT0JleXFpz569SGOSbz6OPKRm+jGpeOzNmZQorlaS2g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bMxlxgB7rqqOZy654dlFQh1+Un5ozm65BITzHt7bBRcwlcHqug21+vPcOXFNMLHFQSz7w1J90lPSRzKhYEoxkp/tQeCAw5p7INTJmEOR51/eBjjX5/oJWlY4w0xuYmhHTqVFo4pV/Vgnz7wTJWTBKtkK9n0toUmvqG+fTaO458A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZHcHi4a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZHcHi4a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7997D1F000FF;
	Tue, 22 Sep 2026 15:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790091639;
	bh=DP0C33MD1sJk9gftfUN3DqNmrRTthZUOvUUdUm9+5vQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WZHcHi4aiZSJ/M5W5aVd3nsf68Y2qn1YytH1o3kF+QwTpnnUSKUMdkRkaSqWb95I8
	 pVA/RUXbudTN0j1vay7KKoaS/Y4r7gKaYf3SU69gSZO5GR2/phftjMPVoPE+ZljVeD
	 Y2tFmPnTEWsWdvikTKT1eZvexav5cB8etQPBOoIMu9D0ur29/eeKbsD0psm+UDxjdw
	 +av3SZ7/zMwznmHmrOcBJgimUeaMeJcK7voccyd3s2shSVJQe8+nCk75sE+Vcd4itz
	 Xvr3FBre3YY7eVzznahb9RZESKfgNCEsn2O+Kdu6szVC4aB0L1LSOptQtqD3wUUY80
	 nKww3boW8E5xw==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 22 Sep 2026 16:35:42 +0100
Subject: [PATCH v4 11/12] mm: make userland page table freeing RCU-safe
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-rcu-pagetable-freeing-v4-11-fe1ad1f1e303@kernel.org>
References: <20260922-rcu-pagetable-freeing-v4-0-fe1ad1f1e303@kernel.org>
In-Reply-To: <20260922-rcu-pagetable-freeing-v4-0-fe1ad1f1e303@kernel.org>
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
 Stafford Horne <shorne@gmail.com>, Rich Felker <dalias@libc.org>, 
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
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
 Randy Dunlap <rdunlap@infradead.org>
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
 Qi Zheng <qi.zheng@linux.dev>, linux-doc@vger.kernel.org, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=20537; i=ljs@kernel.org;
 h=from:subject:message-id; bh=BT0JleXFpz569SGOSbz6OPKRm+jGpeOzNmZQorlaS2g=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLI2Lcj51H7BvPYGf1VPoXqQtZ7o5Fmxsrls3YYTOjIcE
 6ffube0o5SFQYyLQVZMkeX5F/H9QSJh8zov+LvBzGFlAhnCwMUpABNZ0czwP7D0f0mU2rv7d+o9
 txyXn28R+qFUskvhuPz81+/cxXmfeDP84ZTJeBHh8XANV1v36RW7917QO7zz0iHnK66y5W/uz/7
 6kQ8A
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Now every architecture has been converted to support
CONFIG_MMU_GATHER_RCU_TABLE_FREE, this configuration option no longer makes
any sense to keep around.

Therefore remove it, and remove all the dead code that existed for
!CONFIG_MMU_GATHER_RCU_TABLE_FREE architectures previously.

Additionally, CONFIG_MMU_GATHER_TABLE_FREE is no longer necessary, as all
architectures instead use CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE when a custom
__tlb_remove_table() is required, so remove this too.

A number of architectures only enabled CONFIG_MMU_GATHER_RCU_TABLE_FREE if
CONFIG_MMU was set, however the mmu_gather logic only actually does
something meaningful if CONFIG_MMU is set (mmu_gather.c is only compiled in
this case, for instance).

As a result, there's no need to gate any of this logic on CONFIG_MMU
explicitly.

CONFIG_PT_RECLAIM however does have a strict dependency on CONFIG_MMU, so
make this dependency explicit.

Additionally, correct comments to remove references to non-RCU page table
gathering and make it clear that this is not 'semi-RCU', nor has it been
since commit 1fb3d8c20bfa ("mm/mmu_gather: replace IPI with
synchronize_rcu() when batch allocation fails").

With this change in place the kernel policy is now that userspace page
tables are freed after an RCU grace period, and thus it is now safe to
unconditionally perform page table walks under RCU, safe in the knowledge
that page tables will not be freed underneath the walker.

This is all that is guaranteed, however, so naturally it is still incumbent
upon page table walkers to ensure that the page table entries are as
expected.

Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 arch/Kconfig                    |  8 -----
 arch/alpha/Kconfig              |  1 -
 arch/arc/Kconfig                |  1 -
 arch/arm/Kconfig                |  1 -
 arch/arm64/Kconfig              |  1 -
 arch/csky/Kconfig               |  1 -
 arch/hexagon/Kconfig            |  1 -
 arch/loongarch/Kconfig          |  1 -
 arch/m68k/Kconfig               |  1 -
 arch/microblaze/Kconfig         |  1 -
 arch/mips/Kconfig               |  1 -
 arch/nios2/Kconfig              |  1 -
 arch/openrisc/Kconfig           |  1 -
 arch/parisc/Kconfig             |  1 -
 arch/powerpc/Kconfig            |  1 -
 arch/riscv/Kconfig              |  1 -
 arch/s390/Kconfig               |  1 -
 arch/sh/Kconfig                 |  1 -
 arch/sparc/Kconfig              |  2 --
 arch/sparc/include/asm/tlb_64.h |  2 --
 arch/um/Kconfig                 |  1 -
 arch/x86/Kconfig                |  1 -
 arch/xtensa/Kconfig             |  1 -
 include/asm-generic/tlb.h       | 66 ++++++-----------------------------------
 mm/Kconfig                      |  2 +-
 mm/gup.c                        |  5 ++--
 mm/mmu_gather.c                 | 30 ++++---------------
 27 files changed, 18 insertions(+), 117 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 45c657772362..6f7516916797 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -526,13 +526,6 @@ config HAVE_ARCH_JUMP_LABEL
 config HAVE_ARCH_JUMP_LABEL_RELATIVE
 	bool
 
-config MMU_GATHER_TABLE_FREE
-	bool
-
-config MMU_GATHER_RCU_TABLE_FREE
-	bool
-	select MMU_GATHER_TABLE_FREE
-
 config MMU_GATHER_PAGE_SIZE
 	bool
 
@@ -548,7 +541,6 @@ config MMU_GATHER_MERGE_VMAS
 
 config MMU_GATHER_NO_GATHER
 	bool
-	depends on MMU_GATHER_TABLE_FREE
 
 config ARCH_WANT_IRQS_OFF_ACTIVATE_MM
 	bool
diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index e53ef2d88463..9063c7bda4e4 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -42,7 +42,6 @@ config ALPHA
 	select ARCH_STACKWALK
 	select CPU_NO_EFFICIENT_FFS if !ALPHA_EV67
 	select MMU_GATHER_NO_RANGE
-	select MMU_GATHER_RCU_TABLE_FREE
 	select SPARSEMEM_EXTREME if SPARSEMEM
 	select ZONE_DMA
 	select TRACE_IRQFLAGS_SUPPORT
diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 7a7542b61823..2ed7186c81c5 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -47,7 +47,6 @@ config ARC
 	select HAVE_SYSCALL_TRACEPOINTS
 	select IRQ_DOMAIN
 	select LOCK_MM_AND_FIND_VMA
-	select MMU_GATHER_RCU_TABLE_FREE
 	select MODULES_USE_ELF_RELA
 	select OF
 	select OF_EARLY_FLATTREE
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 72b9afc6ae10..0cc289a7184a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -134,7 +134,6 @@ config ARM
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
-	select MMU_GATHER_RCU_TABLE_FREE if MMU
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RSEQ
 	select HAVE_RUST if CPU_LITTLE_ENDIAN && CPU_32v7 && !KASAN
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 2bbeded33da0..b6c2dd8b2612 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -221,7 +221,6 @@ config ARM64
 	select HAVE_RELIABLE_STACKTRACE
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
 	select HAVE_FUNCTION_ARG_ACCESS_API
-	select MMU_GATHER_RCU_TABLE_FREE
 	select HAVE_RSEQ
 	select HAVE_RUST if RUSTC_SUPPORTS_ARM64
 	select HAVE_STACKPROTECTOR
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 80f89ef1d962..4331313a42ff 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -96,7 +96,6 @@ config CSKY
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
 	select LOCK_MM_AND_FIND_VMA
-	select MMU_GATHER_RCU_TABLE_FREE
 	select MAY_HAVE_SPARSE_IRQ
 	select MODULES_USE_ELF_RELA if MODULES
 	select OF
diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index d9b3fb86556b..b48491140013 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -23,7 +23,6 @@ config HEXAGON
 	# select HAVE_CLK
 	select GENERIC_ATOMIC64
 	select HAVE_PERF_EVENTS
-	select MMU_GATHER_RCU_TABLE_FREE
 	# GENERIC_ALLOCATOR is used by dma_alloc_coherent()
 	select GENERIC_ALLOCATOR
 	select GENERIC_IRQ_PROBE
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 9c5def706222..d1b23da40737 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -188,7 +188,6 @@ config LOONGARCH
 	select IRQ_LOONGARCH_CPU
 	select LOCK_MM_AND_FIND_VMA
 	select MMU_GATHER_MERGE_VMAS if MMU
-	select MMU_GATHER_RCU_TABLE_FREE
 	select MODULES_USE_ELF_RELA if MODULES
 	select NEED_PER_CPU_EMBED_FIRST_CHUNK
 	select NEED_PER_CPU_PAGE_FIRST_CHUNK
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index fa5d39549da9..eb84c3af92c0 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -37,7 +37,6 @@ config M68K
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_UID16
 	select MMU_GATHER_NO_RANGE if MMU
-	select MMU_GATHER_RCU_TABLE_FREE if MMU
 	select MODULES_USE_ELF_REL
 	select MODULES_USE_ELF_RELA
 	select NO_DMA if !MMU && !COLDFIRE
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index af7e821e96c1..484ebb3baedf 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -41,7 +41,6 @@ config MICROBLAZE
 	select PCI_SYSCALL if PCI
 	select CPU_NO_EFFICIENT_FFS
 	select MMU_GATHER_NO_RANGE
-	select MMU_GATHER_RCU_TABLE_FREE
 	select SPARSE_IRQ
 	select ZONE_DMA
 	select TRACE_IRQFLAGS_SUPPORT
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e2eb9627bd14..f0c43d118ca0 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -97,7 +97,6 @@ config MIPS
 	select IRQ_FORCED_THREADING
 	select ISA if EISA
 	select LOCK_MM_AND_FIND_VMA
-	select MMU_GATHER_RCU_TABLE_FREE
 	select MODULES_USE_ELF_REL if MODULES
 	select MODULES_USE_ELF_RELA if MODULES && 64BIT
 	select PERF_USE_VMALLOC
diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index b0ccfc3b7a7e..9c0e6eaeb005 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -19,7 +19,6 @@ config NIOS2
 	select HAVE_PAGE_SIZE_4KB
 	select IRQ_DOMAIN
 	select LOCK_MM_AND_FIND_VMA
-	select MMU_GATHER_RCU_TABLE_FREE
 	select MODULES_USE_ELF_RELA
 	select OF
 	select OF_EARLY_FLATTREE
diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index d90b24dd3bce..5eb995c13074 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -35,7 +35,6 @@ config OPENRISC
 	select GENERIC_ATOMIC64
 	select GENERIC_CLOCKEVENTS_BROADCAST
 	select GENERIC_SMP_IDLE_THREAD
-	select MMU_GATHER_RCU_TABLE_FREE
 	select MODULES_USE_ELF_RELA
 	select HAVE_DEBUG_STACKOVERFLOW
 	select OR1K_PIC
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index d3afac2f0d9b..77f67028ad89 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -80,7 +80,6 @@ config PARISC
 	select GENERIC_CLOCKEVENTS
 	select CPU_NO_EFFICIENT_FFS
 	select THREAD_INFO_IN_TASK
-	select MMU_GATHER_RCU_TABLE_FREE
 	select NEED_DMA_MAP_STATE
 	select NEED_SG_DMA_LENGTH
 	select HAVE_ARCH_KGDB
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2580e27e4328..0767cfcbaa42 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -307,7 +307,6 @@ config PPC
 	select KASAN_VMALLOC			if KASAN && EXECMEM
 	select LOCK_MM_AND_FIND_VMA
 	select MMU_GATHER_PAGE_SIZE
-	select MMU_GATHER_RCU_TABLE_FREE
 	select HAVE_ARCH_TLB_REMOVE_TABLE
 	select MMU_GATHER_MERGE_VMAS
 	select MMU_LAZY_TLB_SHOOTDOWN		if PPC_BOOK3S_64
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 3529ed1861ce..7741a4287498 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -208,7 +208,6 @@ config RISCV
 	select IRQ_FORCED_THREADING
 	select KASAN_VMALLOC if KASAN
 	select LOCK_MM_AND_FIND_VMA
-	select MMU_GATHER_RCU_TABLE_FREE if MMU
 	select MODULES_USE_ELF_RELA if MODULES
 	select OF
 	select OF_EARLY_FLATTREE
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index b88b85042136..a34376c05f6e 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -267,7 +267,6 @@ config S390
 	select LOCK_MM_AND_FIND_VMA
 	select MMU_GATHER_MERGE_VMAS
 	select MMU_GATHER_NO_GATHER
-	select MMU_GATHER_RCU_TABLE_FREE
 	select MODULES_USE_ELF_RELA
 	select NEED_DMA_MAP_STATE	if PCI
 	select NEED_PER_CPU_EMBED_FIRST_CHUNK
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 75236bef6f16..fe859def918c 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -62,7 +62,6 @@ config SUPERH
 	select HAVE_SYSCALL_TRACEPOINTS
 	select IRQ_FORCED_THREADING
 	select LOCK_MM_AND_FIND_VMA
-	select MMU_GATHER_RCU_TABLE_FREE if MMU
 	select MODULES_USE_ELF_RELA
 	select NEED_SG_DMA_LENGTH
 	select NO_DMA if !MMU && !DMA_COHERENT
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 79c09d6ee466..742ffff8c37f 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -64,7 +64,6 @@ config SPARC32
 	select HAVE_UID16
 	select HAVE_PAGE_SIZE_4KB
 	select LOCK_MM_AND_FIND_VMA
-	select MMU_GATHER_RCU_TABLE_FREE
 	select HAVE_ARCH_TLB_REMOVE_TABLE
 	select OLD_SIGACTION
 	select ZONE_DMA
@@ -77,7 +76,6 @@ config SPARC64
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_KRETPROBES
 	select HAVE_KPROBES
-	select MMU_GATHER_RCU_TABLE_FREE
 	select HAVE_ARCH_TLB_REMOVE_TABLE
 	select MMU_GATHER_MERGE_VMAS
 	select MMU_GATHER_NO_FLUSH_CACHE
diff --git a/arch/sparc/include/asm/tlb_64.h b/arch/sparc/include/asm/tlb_64.h
index 3037187482db..f5f9631685d5 100644
--- a/arch/sparc/include/asm/tlb_64.h
+++ b/arch/sparc/include/asm/tlb_64.h
@@ -29,9 +29,7 @@ void flush_tlb_pending(void);
  * and therefore we don't need a TLBI when freeing page-table pages.
  */
 
-#ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
 #define tlb_needs_table_invalidate()	(false)
-#endif
 
 #include <asm-generic/tlb.h>
 
diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index d9541d13d9eb..94b8ff70f578 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -44,7 +44,6 @@ config UML
 	select HAVE_SYSCALL_TRACEPOINTS
 	select THREAD_INFO_IN_TASK
 	select SPARSE_IRQ
-	select MMU_GATHER_RCU_TABLE_FREE
 
 config MMU
 	bool
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a8c3b3d31a27..6e5e462ec059 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -283,7 +283,6 @@ config X86
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select ASYNC_KERNEL_PGTABLE_FREE	if IOMMU_SVA
-	select MMU_GATHER_RCU_TABLE_FREE
 	select MMU_GATHER_MERGE_VMAS
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
 	select HAVE_REGS_AND_STACK_ACCESS_API
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 33c4caee30e2..f2f9cd9cde50 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -55,7 +55,6 @@ config XTENSA
 	select HAVE_VIRT_CPU_ACCOUNTING_GEN
 	select IRQ_DOMAIN
 	select LOCK_MM_AND_FIND_VMA
-	select MMU_GATHER_RCU_TABLE_FREE if MMU
 	select MODULES_USE_ELF_RELA
 	select PERF_USE_VMALLOC
 	select TRACE_IRQFLAGS_SUPPORT
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index bdcc2778ac64..9d827076db19 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -67,11 +67,8 @@
  *  - tlb_remove_table()
  *
  *    tlb_remove_table() is the basic primitive to free page-table directories
- *    (__p*_free_tlb()).  In it's most primitive form it is an alias for
- *    tlb_remove_page() below, for when page directories are pages and have no
- *    additional constraints.
- *
- *    See also MMU_GATHER_TABLE_FREE and MMU_GATHER_RCU_TABLE_FREE.
+ *    (__p*_free_tlb()).  Page directories are freed after an RCU grace
+ *    period - see the comment in mm/mmu_gather.c.
  *
  *  - tlb_remove_page() / tlb_remove_page_size()
  *  - __tlb_remove_folio_pages() / __tlb_remove_page_size()
@@ -151,24 +148,15 @@
  *  This might be useful if your architecture has size specific TLB
  *  invalidation instructions.
  *
- *  MMU_GATHER_TABLE_FREE
- *
- *  This provides tlb_remove_table(), to be used instead of tlb_remove_page()
- *  for page directores (__p*_free_tlb()).
- *
- *  Useful if your architecture has non-page page directories.
+ *  Page directories (__p*_free_tlb()) are always freed via tlb_remove_table(),
+ *  after an RCU grace period (see mm/mmu_gather.c).
  *
- *  When used, an architecture is expected to provide __tlb_remove_table() or
- *  use the generic __tlb_remove_table(), which does the actual freeing of these
- *  pages.
+ *  This serialises against software page-table walkers, including architectures
+ *  which do not use IPIs for remote TLB invalidates.
  *
- *  MMU_GATHER_RCU_TABLE_FREE
- *
- *  Like MMU_GATHER_TABLE_FREE, and adds semi-RCU semantics to the free (see
- *  comment below).
- *
- *  Useful if your architecture doesn't use IPIs for remote TLB invalidates
- *  and therefore doesn't naturally serialize with software page-table walkers.
+ *  An architecture is expected to provide __tlb_remove_table() (see
+ *  HAVE_ARCH_TLB_REMOVE_TABLE) or use the generic __tlb_remove_table(), which
+ *  does the actual freeing of these pages.
  *
  *  MMU_GATHER_NO_FLUSH_CACHE
  *
@@ -200,12 +188,8 @@
  *  various ptep_get_and_clear() functions.
  */
 
-#ifdef CONFIG_MMU_GATHER_TABLE_FREE
-
 struct mmu_table_batch {
-#ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
 	struct rcu_head		rcu;
-#endif
 	unsigned int		nr;
 	void			*tables[];
 };
@@ -224,23 +208,6 @@ static inline void __tlb_remove_table(void *table)
 
 extern void tlb_remove_table(struct mmu_gather *tlb, void *table);
 
-#else /* !CONFIG_MMU_GATHER_TABLE_FREE */
-
-static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page);
-/*
- * Without MMU_GATHER_TABLE_FREE the architecture is assumed to have page based
- * page directories and we can use the normal page batching to free them.
- */
-static inline void tlb_remove_table(struct mmu_gather *tlb, void *table)
-{
-	struct ptdesc *ptdesc = (struct ptdesc *)table;
-
-	pagetable_dtor(ptdesc);
-	tlb_remove_page(tlb, ptdesc_page(ptdesc));
-}
-#endif /* CONFIG_MMU_GATHER_TABLE_FREE */
-
-#ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
 /*
  * This allows an architecture that does not use the linux page-tables for
  * hardware to skip the TLBI when freeing page tables.
@@ -253,19 +220,6 @@ void tlb_remove_table_sync_one(void);
 
 void tlb_remove_table_sync_rcu(void);
 
-#else
-
-#ifdef tlb_needs_table_invalidate
-#error tlb_needs_table_invalidate() requires MMU_GATHER_RCU_TABLE_FREE
-#endif
-
-static inline void tlb_remove_table_sync_one(void) { }
-
-static inline void tlb_remove_table_sync_rcu(void) { }
-
-#endif /* CONFIG_MMU_GATHER_RCU_TABLE_FREE */
-
-
 #ifndef CONFIG_MMU_GATHER_NO_GATHER
 /*
  * If we can't allocate a page to make a big batch of page pointers
@@ -325,9 +279,7 @@ static inline void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct
 struct mmu_gather {
 	struct mm_struct	*mm;
 
-#ifdef CONFIG_MMU_GATHER_TABLE_FREE
 	struct mmu_table_batch	*batch;
-#endif
 
 	unsigned long		start;
 	unsigned long		end;
diff --git a/mm/Kconfig b/mm/Kconfig
index c1ddf59c0d71..bc7befafb47b 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1465,7 +1465,7 @@ config HAVE_ARCH_TLB_REMOVE_TABLE
 
 config PT_RECLAIM
 	def_bool y
-	depends on MMU_GATHER_RCU_TABLE_FREE && !HAVE_ARCH_TLB_REMOVE_TABLE
+	depends on MMU && !HAVE_ARCH_TLB_REMOVE_TABLE
 	help
 	  Try to reclaim empty user page table pages in paths other than munmap
 	  and exit_mmap path.
diff --git a/mm/gup.c b/mm/gup.c
index eb898ea1ee22..63b435ec605c 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2700,8 +2700,9 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
  * Before activating this code, please be aware that the following assumptions
  * are currently made:
  *
- *  *) Either MMU_GATHER_RCU_TABLE_FREE is enabled, and tlb_remove_table() is used to
- *  free pages containing page tables or TLB flushing requires IPI broadcast.
+ *  *) tlb_remove_table() is used to free pages containing page tables, with
+ *  the free deferred until an RCU grace period has elapsed (see
+ *  mm/mmu_gather.c).
  *
  *  *) ptes can be read atomically by the architecture.
  *
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 3985d856de7f..2a72a9686773 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -218,8 +218,6 @@ bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page, int page_
 
 #endif /* MMU_GATHER_NO_GATHER */
 
-#ifdef CONFIG_MMU_GATHER_TABLE_FREE
-
 static void __tlb_remove_table_free(struct mmu_table_batch *batch)
 {
 	int i;
@@ -230,10 +228,8 @@ static void __tlb_remove_table_free(struct mmu_table_batch *batch)
 	free_page((unsigned long)batch);
 }
 
-#ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
-
 /*
- * Semi RCU freeing of the page directories.
+ * RCU freeing of the page directories.
  *
  * This is needed by some architectures to implement software pagetable walkers.
  *
@@ -259,13 +255,13 @@ static void __tlb_remove_table_free(struct mmu_table_batch *batch)
  * means.
  *
  * What we do is batch the freed directory pages (tables) and RCU free them.
- * We use the sched RCU variant, as that guarantees that IRQ/preempt disabling
- * holds off grace periods.
+ * Disabling IRQs or preemption holds off RCU grace periods, so this protects
+ * both rcu_read_lock() and IRQ-disabling walkers.
  *
  * However, in order to batch these pages we need to allocate storage, this
  * allocation is deep inside the MM code and can thus easily fail on memory
- * pressure. To guarantee progress we fall back to single table freeing, see
- * the implementation of tlb_remove_table_one().
+ * pressure. To guarantee progress we fall back to single table freeing, which
+ * is also RCU-deferred - see the implementation of tlb_remove_table_one().
  *
  */
 
@@ -315,15 +311,6 @@ void tlb_remove_table_sync_rcu(void)
 	synchronize_rcu();
 }
 
-#else /* !CONFIG_MMU_GATHER_RCU_TABLE_FREE */
-
-static void tlb_remove_table_free(struct mmu_table_batch *batch)
-{
-	__tlb_remove_table_free(batch);
-}
-
-#endif /* CONFIG_MMU_GATHER_RCU_TABLE_FREE */
-
 /*
  * If we want tlb_remove_table() to imply TLB invalidates.
  */
@@ -403,13 +390,6 @@ static inline void tlb_table_init(struct mmu_gather *tlb)
 	tlb->batch = NULL;
 }
 
-#else /* !CONFIG_MMU_GATHER_TABLE_FREE */
-
-static inline void tlb_table_flush(struct mmu_gather *tlb) { }
-static inline void tlb_table_init(struct mmu_gather *tlb) { }
-
-#endif /* CONFIG_MMU_GATHER_TABLE_FREE */
-
 static void tlb_flush_mmu_free(struct mmu_gather *tlb)
 {
 	tlb_table_flush(tlb);

-- 
2.55.0

