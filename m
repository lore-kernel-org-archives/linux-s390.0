Return-Path: <linux-kernel-owner+w=401wt.eu-S1760185AbYBSOre@vger.kernel.org>
Message-Id: <20080219144504.185987495@de.ibm.com>
References: <20080219144047.587547541@de.ibm.com>
Date: Tue, 19 Feb 2008 15:40:53 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 06/13] find bit corner case.
Content-Disposition: inline; filename=006-bitops.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Fix [ext2_]find_first_[zero_]bit for the corner case of an all clear
or all set bit field by always handling that last word of the bit field
with __ffz_word/__ffs_word.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-s390/bitops.h |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

Index: quilt-2.6/include/asm-s390/bitops.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/bitops.h
+++ quilt-2.6/include/asm-s390/bitops.h
@@ -456,16 +456,18 @@ static inline unsigned long __ffz_word_l
 
 	asm volatile(
 #ifndef __s390x__
-		"	ahi	%1,31\n"
-		"	srl	%1,5\n"
+		"	ahi	%1,-1\n"
+		"	sra	%1,5\n"
+		"	jz	1f\n"
 		"0:	c	%2,0(%0,%3)\n"
 		"	jne	1f\n"
 		"	la	%0,4(%0)\n"
 		"	brct	%1,0b\n"
 		"1:\n"
 #else
-		"	aghi	%1,63\n"
-		"	srlg	%1,%1,6\n"
+		"	aghi	%1,-1\n"
+		"	srag	%1,%1,6\n"
+		"	jz	1f\n"
 		"0:	cg	%2,0(%0,%3)\n"
 		"	jne	1f\n"
 		"	la	%0,8(%0)\n"
@@ -491,16 +493,18 @@ static inline unsigned long __ffs_word_l
 
 	asm volatile(
 #ifndef __s390x__
-		"	ahi	%1,31\n"
-		"	srl	%1,5\n"
+		"	ahi	%1,-1\n"
+		"	sra	%1,5\n"
+		"	jz	1f\n"
 		"0:	c	%2,0(%0,%3)\n"
 		"	jne	1f\n"
 		"	la	%0,4(%0)\n"
 		"	brct	%1,0b\n"
 		"1:\n"
 #else
-		"	aghi	%1,63\n"
-		"	srlg	%1,%1,6\n"
+		"	aghi	%1,-1\n"
+		"	srag	%1,%1,6\n"
+		"	jz	1f\n"
 		"0:	cg	%2,0(%0,%3)\n"
 		"	jne	1f\n"
 		"	la	%0,8(%0)\n"

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
