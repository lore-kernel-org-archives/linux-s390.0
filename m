Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FE54EBAC5;
	Fri, 25 Sep 2026 20:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790367065; cv=none; b=N62yty9pkPvp4Lu6dl86c9qV5B4+iOA/3/i/7ca79HKtcUv8QNhirJdybeHlryLPL5tvg6dVfOG+j6+lWYyY7JfyCGfjVFUrzObbSZ4kozCOXMTOp6p4xP1bALcdmRDkbljempJuZa1nEVKjZ8u/EeN13cfvrdpwYcY5sVrgV4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790367065; c=relaxed/simple;
	bh=cFPK9Qp3GkYDJY1+z/OkYpoXzS5f6cyg/j7ISm4Bfmw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QU/y+OnHZDWLpp42pfB6dIUyDunQvtGVOI+pVtOr2ud2YhnBnJpz2OBn0g5PHXj5iqUBzT81e62bUHX3mKZbin7ahIdBdqfI1ox2Y5DG4nX+cATDP8kP7/hy3NSCaf9M4bwtOTokxgvvnSdavabnDiIV1n2C28URV67PHRfhUK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRWuOpzM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRWuOpzM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9701F00898;
	Fri, 25 Sep 2026 20:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790367048;
	bh=VNDoSlNHzmr2TcajqqRMg1JSSBHZiW10Z/420v+HtkY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=eRWuOpzMfrsAwJkjQJrXE2PR8EaQ7vuZpM3gPXtLJG/rsLYdB6W5v8O2y873kD1RA
	 0dcxN9M23DXC2JBiB1EQ2vnuZFiksaaoiuVqE9I1fLk0lqqo4F7uGetAxqdprWuO8Q
	 /yE+KFZ2W7ywydjYVlN2l7JDtwqt60DgYuMuBo5+AR+8TTxE74Fj2C+sBslk9sfjm4
	 vT6CFNhM7OQ5iwATrjTl7Hu0qr94RhzZ3XUENMoIfrg3RH2t/44CZT7HqGdFBoE/Ux
	 oCYlxmueoLG4zu+nkmcsa5LabyYHx+hTL+Y3rBIT8+5ei87HCEF3Q+viHffmEsMGsS
	 wZIPCXy5iS+Iw==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Fri, 25 Sep 2026 21:09:37 +0100
Subject: [PATCH v5 02/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for most
 2-level architectures
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-rcu-pagetable-freeing-v5-2-31e91065fea4@kernel.org>
References: <20260925-rcu-pagetable-freeing-v5-0-31e91065fea4@kernel.org>
In-Reply-To: <20260925-rcu-pagetable-freeing-v5-0-31e91065fea4@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3661; i=ljs@kernel.org;
 h=from:subject:message-id; bh=cFPK9Qp3GkYDJY1+z/OkYpoXzS5f6cyg/j7ISm4Bfmw=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLK2XWWbz37XeqtiitCpJtGCFfYP8+/XT9n2f6fqnV0Gf
 dVpWznqOkpZGMS4GGTFFFmefxHfHyQSNq/zgr8bzBxWJpAhDFycAjCRcD5GhpdHvvHtyuaOfXb9
 koA45yq226uMS/cwL6utsnApv1j+8gsjw6bzjUwXcs5mTJi1n7l0x5/Zydejp/3mOhj/rcl+He/
 7Y5wA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Commit e3ecf7c7d082 ("mm: pgtable: convert some architectures to use
tlb_remove_ptdesc()") updated a number of architectures from using
pagetable_dtor() + tlb_remove_page_ptdesc() to using tlb_remove_ptdesc() in
__pte_free_tlb().

This is meaningful as tlb_remove_ptdesc() allows for RCU page table
freeing if CONFIG_MMU_GATHER_RCU_TABLE_FREE is specified.

The csky, hexagon, nios2, openrisc, sh (except X2) and m68k-sun3
architectures all have 2 levels of page tables, so the only page tables
ever freed by mmu_gather are PTEs, so this update suffices to ensure that
every page table freed by the mmu_gather mechanism is freed under RCU.

Therefore, update all of these architectures to select
CONFIG_MMU_GATHER_RCU_TABLE_FREE.

This forms part of an overall effort to switch every architecture to this
mode.

Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 arch/csky/Kconfig     | 1 +
 arch/hexagon/Kconfig  | 1 +
 arch/m68k/Kconfig     | 1 +
 arch/nios2/Kconfig    | 1 +
 arch/openrisc/Kconfig | 1 +
 arch/sh/Kconfig       | 1 +
 6 files changed, 6 insertions(+)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 4331313a42ff..80f89ef1d962 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -96,6 +96,7 @@ config CSKY
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
 	select LOCK_MM_AND_FIND_VMA
+	select MMU_GATHER_RCU_TABLE_FREE
 	select MAY_HAVE_SPARSE_IRQ
 	select MODULES_USE_ELF_RELA if MODULES
 	select OF
diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index b48491140013..d9b3fb86556b 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -23,6 +23,7 @@ config HEXAGON
 	# select HAVE_CLK
 	select GENERIC_ATOMIC64
 	select HAVE_PERF_EVENTS
+	select MMU_GATHER_RCU_TABLE_FREE
 	# GENERIC_ALLOCATOR is used by dma_alloc_coherent()
 	select GENERIC_ALLOCATOR
 	select GENERIC_IRQ_PROBE
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 11835eb59d94..e29610fd1240 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -36,6 +36,7 @@ config M68K
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_UID16
 	select MMU_GATHER_NO_RANGE if MMU
+	select MMU_GATHER_RCU_TABLE_FREE if MMU && SUN3
 	select MODULES_USE_ELF_REL
 	select MODULES_USE_ELF_RELA
 	select NO_DMA if !MMU && !COLDFIRE
diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index 9c0e6eaeb005..b0ccfc3b7a7e 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -19,6 +19,7 @@ config NIOS2
 	select HAVE_PAGE_SIZE_4KB
 	select IRQ_DOMAIN
 	select LOCK_MM_AND_FIND_VMA
+	select MMU_GATHER_RCU_TABLE_FREE
 	select MODULES_USE_ELF_RELA
 	select OF
 	select OF_EARLY_FLATTREE
diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 5eb995c13074..d90b24dd3bce 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -35,6 +35,7 @@ config OPENRISC
 	select GENERIC_ATOMIC64
 	select GENERIC_CLOCKEVENTS_BROADCAST
 	select GENERIC_SMP_IDLE_THREAD
+	select MMU_GATHER_RCU_TABLE_FREE
 	select MODULES_USE_ELF_RELA
 	select HAVE_DEBUG_STACKOVERFLOW
 	select OR1K_PIC
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index d60f1d5a94c0..204f64912f0e 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -61,6 +61,7 @@ config SUPERH
 	select HAVE_SYSCALL_TRACEPOINTS
 	select IRQ_FORCED_THREADING
 	select LOCK_MM_AND_FIND_VMA
+	select MMU_GATHER_RCU_TABLE_FREE if MMU && !X2TLB
 	select MODULES_USE_ELF_RELA
 	select NEED_SG_DMA_LENGTH
 	select NO_DMA if !MMU && !DMA_COHERENT

-- 
2.55.0

