Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] s390/mm: s/specifiation/specification/, s/an specification/a specification/
Date: Thu, 21 May 2015 14:00:47 +0200
Message-Id: <1432209647-20668-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Jiri Kosina <trivial@kernel.org>
Cc: linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-ID: <linux-s390.vger.kernel.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/s390/include/asm/pgtable.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index fc642399b489d896..9a04717f5d0cf40f 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1565,9 +1565,9 @@ static inline int has_transparent_hugepage(void)
 /*
  * 64 bit swap entry format:
  * A page-table entry has some bits we have to treat in a special way.
- * Bits 52 and bit 55 have to be zero, otherwise an specification
+ * Bits 52 and bit 55 have to be zero, otherwise a specification
  * exception will occur instead of a page translation exception. The
- * specifiation exception has the bad habit not to store necessary
+ * specification exception has the bad habit not to store necessary
  * information in the lowcore.
  * Bits 54 and 63 are used to indicate the page type.
  * A swap pte is indicated by bit pattern (pte & 0x201) == 0x200
-- 
1.9.1
