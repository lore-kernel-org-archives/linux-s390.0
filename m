Return-Path: <linux-kernel-owner+w=401wt.eu-S1758027AbYBIMEc@vger.kernel.org>
Message-Id: <20080209120305.733009610@de.ibm.com>
References: <20080209120157.885371603@de.ibm.com>
Date: Sat, 09 Feb 2008 13:02:00 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 03/11] Fix __ffs_word_loop/__ffz_word_loop inlnie assembly.
Content-Disposition: inline; filename=003-bitops-fix.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

The black art of inline assemblies.. The new __ffs_word_loop/
__ffz_word_loop inline assemblies need an early clobber for the
two input/output variables.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-s390/bitops.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: quilt-2.6/include/asm-s390/bitops.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/bitops.h
+++ quilt-2.6/include/asm-s390/bitops.h
@@ -472,7 +472,7 @@ static inline unsigned long __ffz_word_l
 		"	brct	%1,0b\n"
 		"1:\n"
 #endif
-		: "+a" (bytes), "+d" (size)
+		: "+&a" (bytes), "+&d" (size)
 		: "d" (-1UL), "a" (addr), "m" (*(addrtype *) addr)
 		: "cc" );
 	return bytes;
@@ -507,7 +507,7 @@ static inline unsigned long __ffs_word_l
 		"	brct	%1,0b\n"
 		"1:\n"
 #endif
-		: "+a" (bytes), "+a" (size)
+		: "+&a" (bytes), "+&a" (size)
 		: "d" (0UL), "a" (addr), "m" (*(addrtype *) addr)
 		: "cc" );
 	return bytes;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
