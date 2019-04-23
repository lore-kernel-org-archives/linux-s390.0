Return-Path: <linux-arch-owner@vger.kernel.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v3 08/10] powerpc/mm/radix: mark __radix__flush_tlb_range_psize() as __always_inline
Date: Tue, 23 Apr 2019 12:21:04 +0900
Message-ID: <20190423032106.11960-9-yamada.masahiro@socionext.com>
In-Reply-To: <20190423032106.11960-1-yamada.masahiro@socionext.com>
References: <20190423032106.11960-1-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190423032104.5Hk2dwl9CmwHqVOIFT-pJPPhbuiDWt96Ufq_oICx3Yk@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Christophe Leroy <christophe.leroy@c-s.fr>, Mathieu Malaterre <malat@debian.org>, Masahiro Yamada <yamada.masahiro@socionext.com>
List-ID: <linux-s390.vger.kernel.org>

This prepares to move CONFIG_OPTIMIZE_INLINING from x86 to a common
place. We need to eliminate potential issues beforehand.

If it is enabled for powerpc, the following error is reported:

arch/powerpc/mm/tlb-radix.c: In function '__radix__flush_tlb_range_psize':
arch/powerpc/mm/tlb-radix.c:104:2: error: asm operand 3 probably doesn't match constraints [-Werror]
  asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
  ^~~
arch/powerpc/mm/tlb-radix.c:104:2: error: impossible constraint in 'asm'

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3: None
Changes in v2:
  - split into a separate patch

 arch/powerpc/mm/tlb-radix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 6a23b9ebd2a1..a2b2848f0ae3 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -928,7 +928,7 @@ void radix__tlb_flush(struct mmu_gather *tlb)
 	tlb->need_flush_all = 0;
 }
 
-static inline void __radix__flush_tlb_range_psize(struct mm_struct *mm,
+static __always_inline void __radix__flush_tlb_range_psize(struct mm_struct *mm,
 				unsigned long start, unsigned long end,
 				int psize, bool also_pwc)
 {
-- 
2.17.1
