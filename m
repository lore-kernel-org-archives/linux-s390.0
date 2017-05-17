Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH] s390: use generic fb.h
Date: Wed, 17 May 2017 10:34:49 +0200
Message-Id: <20170517083449.1994-1-tklauser@distanz.ch>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The arch uses a verbatim copy of the asm-generic version and does not
add any own implemntations to the header, so use asm-generic/fb.h
instead of duplicating code.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 arch/s390/include/asm/Kbuild |  1 +
 arch/s390/include/asm/fb.h   | 12 ------------
 2 files changed, 1 insertion(+), 12 deletions(-)
 delete mode 100644 arch/s390/include/asm/fb.h

diff --git a/arch/s390/include/asm/Kbuild b/arch/s390/include/asm/Kbuild
index 45092b12f54f..953315cc37c4 100644
--- a/arch/s390/include/asm/Kbuild
+++ b/arch/s390/include/asm/Kbuild
@@ -5,6 +5,7 @@ generic-y += dma-contiguous.h
 generic-y += div64.h
 generic-y += emergency-restart.h
 generic-y += export.h
+generic-y += fb.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
 generic-y += kmap_types.h
diff --git a/arch/s390/include/asm/fb.h b/arch/s390/include/asm/fb.h
deleted file mode 100644
index c7df38030992..000000000000
--- a/arch/s390/include/asm/fb.h
+++ /dev/null
@@ -1,12 +0,0 @@
-#ifndef _ASM_FB_H_
-#define _ASM_FB_H_
-#include <linux/fb.h>
-
-#define fb_pgprotect(...) do {} while (0)
-
-static inline int fb_is_primary_device(struct fb_info *info)
-{
-	return 0;
-}
-
-#endif /* _ASM_FB_H_ */
-- 
2.13.0
