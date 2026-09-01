Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F23C31A55B;
	Tue,  1 Sep 2026 11:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788260789; cv=none; b=N2S/QnA2kCdSZtmnhSw486XvJgkraV4URWVIkl/6jJLXpyqT2joeFhdSqGj6S/MOF6+OI5hRmbD1D0zLsEnifrofo/eQRCk8rC4O9RiCvA/HT/Yum1CKdR5MXgqCp1PpJhsV/gc6hxQ7PXrW0VND7ptqO/r59RcIbVcjcXWIrnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788260789; c=relaxed/simple;
	bh=pmFGalV7u20s+FwKIjahThGo/bP2PelMktCxEOFxTVg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OdaI54HM6AHcEzqwRfNZXuCMIDPXYBwZuoob1NdjrO2jmMlCheTJ/3ZWnD7/mHPGEqqr+dfJRBLwQ8ojDY42/nD2biuoHQCW5tZVK+Etj0GfM6kWdtSkMrq9XOllsFWagouUUixpeltwB05Jdowyfrl74i6pQQ4CV9dsi+aG3rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGF50wlp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGF50wlp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672D31F00A3D;
	Tue,  1 Sep 2026 11:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788260788;
	bh=TUQ/bqWjoWegxWt3AQb93fUpQ2PrCnmOoUsz1IYEEAE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GGF50wlpx5daBNc1SscpLRoU6tPHwKSR+bV8BmmnowzFMrNC7trXHUsfj3E29ekmP
	 L994BAJdClVd9Yr3sw10ofz2hcYCefpn83H5DYofkntVOSN+eCftj5m4xWN3/2E2D/
	 RFukLQfk+qbv3V89PdpuaKKmQP74DUXJDElrDgI1Dr4MmMgC9t6XspOEhIOgtQX01M
	 wqfpQbMB1i3sYccAi4FcWcGcNPqf/WvHnQU2Xsyz3ahXaqNeamxd9OXRjYTbFrxc7S
	 /vIhMXRqAYVq0FTclNXFmznsm97gJHIBWu1Lt/sABxm5WcMKOwI4+HiU5LGFpA5f/L
	 7AiAMNGXxwKMQ==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 01 Sep 2026 12:01:25 +0100
Subject: [PATCH 05/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for arc,
 microblaze, xtensa
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-rcu-pagetable-freeing-v1-5-5456a81c8212@kernel.org>
References: <20260901-rcu-pagetable-freeing-v1-0-5456a81c8212@kernel.org>
In-Reply-To: <20260901-rcu-pagetable-freeing-v1-0-5456a81c8212@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4476; i=ljs@kernel.org;
 h=from:subject:message-id; bh=pmFGalV7u20s+FwKIjahThGo/bP2PelMktCxEOFxTVg=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLKmbfSIvHmucsrngzpFV6ri1iXfOvHwlaZthq+1b/Z7h
 b/boqS4OkpZGMS4GGTFFFmefxHfHyQSNq/zgr8bzBxWJpAhDFycAnCROQx/pdWZM5/4V7cefbv6
 30bLDceeu9TYfHEtfr1/o9qro+8EbzP8FfadW57HeKAhZnUIw8e+uFk5CVr6H1ZPr3eZnWD9uVm
 SCQA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Each of these architectures directly free page tables without routing these
changes through tlb_remove_ptdesc().

The use of tlb_remove_ptdesc() is required for
CONFIG_MMU_GATHER_RCU_TABLE_FREE to correctly free page tables under RCU,
so simply update these architectures to use these functions.

Since none of the architectures share page tables or do anything unusual,
nothing complicated is required here.

Therefore this is simply a mechanical change - convert __pud_free_tlb(),
__pmd_free_tlb() and __pte_free_tlb() to use tlb_remove_ptdesc() as
required.

At the point this is in place, all mmu_gather page table freeing is
performed under RCU, and thus MMU_GATHER_RCU_TABLE_FREE is selected for
each architecture.

This forms part of an overall effort to switch every architecture to this
mode.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 arch/arc/Kconfig                      | 1 +
 arch/arc/include/asm/pgalloc.h        | 6 +++---
 arch/microblaze/Kconfig               | 1 +
 arch/microblaze/include/asm/pgalloc.h | 2 +-
 arch/xtensa/Kconfig                   | 1 +
 arch/xtensa/include/asm/tlb.h         | 2 +-
 6 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 2ed7186c81c5..7a7542b61823 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -47,6 +47,7 @@ config ARC
 	select HAVE_SYSCALL_TRACEPOINTS
 	select IRQ_DOMAIN
 	select LOCK_MM_AND_FIND_VMA
+	select MMU_GATHER_RCU_TABLE_FREE
 	select MODULES_USE_ELF_RELA
 	select OF
 	select OF_EARLY_FLATTREE
diff --git a/arch/arc/include/asm/pgalloc.h b/arch/arc/include/asm/pgalloc.h
index dfae070fe8d5..9b6c37f92e97 100644
--- a/arch/arc/include/asm/pgalloc.h
+++ b/arch/arc/include/asm/pgalloc.h
@@ -72,7 +72,7 @@ static inline void p4d_populate(struct mm_struct *mm, p4d_t *p4dp, pud_t *pudp)
 	set_p4d(p4dp, __p4d((unsigned long)pudp));
 }
 
-#define __pud_free_tlb(tlb, pmd, addr)  pud_free((tlb)->mm, pmd)
+#define __pud_free_tlb(tlb, pmd, addr)  tlb_remove_ptdesc((tlb), virt_to_ptdesc(pmd))
 
 #endif
 
@@ -83,10 +83,10 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pudp, pmd_t *pmdp)
 	set_pud(pudp, __pud((unsigned long)pmdp));
 }
 
-#define __pmd_free_tlb(tlb, pmd, addr)  pmd_free((tlb)->mm, pmd)
+#define __pmd_free_tlb(tlb, pmd, addr)  tlb_remove_ptdesc((tlb), virt_to_ptdesc(pmd))
 
 #endif
 
-#define __pte_free_tlb(tlb, pte, addr)  pte_free((tlb)->mm, pte)
+#define __pte_free_tlb(tlb, pte, addr)  tlb_remove_ptdesc((tlb), page_ptdesc(pte))
 
 #endif /* _ASM_ARC_PGALLOC_H */
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 484ebb3baedf..af7e821e96c1 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -41,6 +41,7 @@ config MICROBLAZE
 	select PCI_SYSCALL if PCI
 	select CPU_NO_EFFICIENT_FFS
 	select MMU_GATHER_NO_RANGE
+	select MMU_GATHER_RCU_TABLE_FREE
 	select SPARSE_IRQ
 	select ZONE_DMA
 	select TRACE_IRQFLAGS_SUPPORT
diff --git a/arch/microblaze/include/asm/pgalloc.h b/arch/microblaze/include/asm/pgalloc.h
index 084a8a0dc239..ffee6a009219 100644
--- a/arch/microblaze/include/asm/pgalloc.h
+++ b/arch/microblaze/include/asm/pgalloc.h
@@ -25,7 +25,7 @@ extern void __bad_pte(pmd_t *pmd);
 
 extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm);
 
-#define __pte_free_tlb(tlb, pte, addr)	pte_free((tlb)->mm, (pte))
+#define __pte_free_tlb(tlb, pte, addr)	tlb_remove_ptdesc((tlb), page_ptdesc(pte))
 
 #define pmd_populate(mm, pmd, pte) \
 			(pmd_val(*(pmd)) = (unsigned long)page_address(pte))
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index f2f9cd9cde50..33c4caee30e2 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -55,6 +55,7 @@ config XTENSA
 	select HAVE_VIRT_CPU_ACCOUNTING_GEN
 	select IRQ_DOMAIN
 	select LOCK_MM_AND_FIND_VMA
+	select MMU_GATHER_RCU_TABLE_FREE if MMU
 	select MODULES_USE_ELF_RELA
 	select PERF_USE_VMALLOC
 	select TRACE_IRQFLAGS_SUPPORT
diff --git a/arch/xtensa/include/asm/tlb.h b/arch/xtensa/include/asm/tlb.h
index 8c3ceb427018..6fb7b78154f6 100644
--- a/arch/xtensa/include/asm/tlb.h
+++ b/arch/xtensa/include/asm/tlb.h
@@ -16,7 +16,7 @@
 
 #include <asm-generic/tlb.h>
 
-#define __pte_free_tlb(tlb, pte, address)	pte_free((tlb)->mm, pte)
+#define __pte_free_tlb(tlb, pte, address)	tlb_remove_ptdesc((tlb), page_ptdesc(pte))
 
 void check_tlb_sanity(void);
 

-- 
2.55.0

