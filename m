Return-Path: <linux-kernel-owner+w=401wt.eu-S1756509AbYK0Klt@vger.kernel.org>
Message-Id: <20081127103135.348578690@de.ibm.com>
References: <20081127103020.528516828@de.ibm.com>
Date: Thu, 27 Nov 2008 11:30:47 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 27/60] remove warnings with functions ending in BUG
Content-Disposition: inline; filename=126-bug-warning.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Functions which end in a BUG() statement and skip the return statement
cause compile warnings on s390, e.g.:

mm/bootmem.c: In function 'mark_bootmem':
mm/bootmem.c:321: warning: control reaches end of non-void function

To avoid the warning add an endless loop to the BUG() macro.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/bug.h |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Index: quilt-2.6/arch/s390/include/asm/bug.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/bug.h
+++ quilt-2.6/arch/s390/include/asm/bug.h
@@ -47,7 +47,10 @@
 
 #endif /* CONFIG_DEBUG_BUGVERBOSE */
 
-#define BUG()	__EMIT_BUG(0)
+#define BUG() do {					\
+	__EMIT_BUG(0);					\
+	for (;;);					\
+} while (0)
 
 #define WARN_ON(x) ({					\
 	int __ret_warn_on = !!(x);			\

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
