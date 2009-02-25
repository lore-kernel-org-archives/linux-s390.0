Return-Path: <linux-kernel-owner+w=401wt.eu-S1764203AbZBYPWI@vger.kernel.org>
Message-Id: <20090225150833.276341700@de.ibm.com>
References: <20090225150622.529143164@de.ibm.com>
Date: Wed, 25 Feb 2009 16:06:44 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch/s390 22/46] convert bitmap definitions to C
Content-Disposition: inline; filename=121-bitmap-to-C.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/bitops.h |    2 -
 arch/s390/kernel/bitmap.S      |   56 -----------------------------------------
 arch/s390/kernel/bitmap.c      |   49 +++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 57 deletions(-)

Index: quilt-2.6/arch/s390/include/asm/bitops.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/bitops.h
+++ quilt-2.6/arch/s390/include/asm/bitops.h
@@ -57,7 +57,7 @@
  * with operation of the form "set_bit(bitnr, flags)".
  */
 
-/* bitmap tables from arch/S390/kernel/bitmap.S */
+/* bitmap tables from arch/s390/kernel/bitmap.c */
 extern const char _oi_bitmap[];
 extern const char _ni_bitmap[];
 extern const char _zb_findmap[];
Index: quilt-2.6/arch/s390/kernel/bitmap.c
===================================================================
--- /dev/null
+++ quilt-2.6/arch/s390/kernel/bitmap.c
@@ -0,0 +1,49 @@
+/*
+ *    Bitmaps for set_bit, clear_bit, test_and_set_bit, ...
+ *    See include/asm/{bitops.h|posix_types.h} for details
+ *
+ *    Copyright IBM Corp. 1999,2009
+ *    Author(s): Martin Schwidefsky <schwidefsky@de.ibm.com>,
+ */
+
+#include <linux/bitops.h>
+
+const char _oi_bitmap[] = { 0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80 };
+
+const char _ni_bitmap[] = { 0xfe, 0xfd, 0xfb, 0xf7, 0xef, 0xdf, 0xbf, 0x7f };
+
+const char _zb_findmap[] = {
+	0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,4,
+	0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,5,
+	0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,4,
+	0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,6,
+	0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,4,
+	0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,5,
+	0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,4,
+	0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,7,
+	0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,4,
+	0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,5,
+	0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,4,
+	0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,6,
+	0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,4,
+	0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,5,
+	0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,4,
+	0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,8 };
+
+const char _sb_findmap[] = {
+	8,0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,
+	4,0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,
+	5,0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,
+	4,0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,
+	6,0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,
+	4,0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,
+	5,0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,
+	4,0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,
+	7,0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,
+	4,0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,
+	5,0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,
+	4,0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,
+	6,0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,
+	4,0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,
+	5,0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,
+	4,0,1,0,2,0,1,0,3,0,1,0,2,0,1,0 };
Index: quilt-2.6/arch/s390/kernel/bitmap.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/bitmap.S
+++ /dev/null
@@ -1,56 +0,0 @@
-/*
- *  arch/s390/kernel/bitmap.S
- *    Bitmaps for set_bit, clear_bit, test_and_set_bit, ...
- *    See include/asm-s390/{bitops.h|posix_types.h} for details
- *
- *  S390 version
- *    Copyright (C) 1999 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com),
- */
-
-         .globl _oi_bitmap
-_oi_bitmap:
-         .byte  0x01,0x02,0x04,0x08,0x10,0x20,0x40,0x80
-
-         .globl _ni_bitmap
-_ni_bitmap:
-         .byte  0xFE,0xFD,0xFB,0xF7,0xEF,0xDF,0xBF,0x7F
-
-         .globl _zb_findmap
-_zb_findmap:
-         .byte  0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,4
-         .byte  0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,5
-         .byte  0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,4 
-         .byte  0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,6
-         .byte  0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,4
-         .byte  0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,5
-         .byte  0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,4
-         .byte  0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,7
-         .byte  0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,4
-         .byte  0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,5
-         .byte  0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,4
-         .byte  0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,6
-         .byte  0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,4
-         .byte  0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,5
-         .byte  0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,4
-         .byte  0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,8
-
-         .globl _sb_findmap
-_sb_findmap:
-         .byte  8,0,1,0,2,0,1,0,3,0,1,0,2,0,1,0
-         .byte  4,0,1,0,2,0,1,0,3,0,1,0,2,0,1,0
-         .byte  5,0,1,0,2,0,1,0,3,0,1,0,2,0,1,0
-         .byte  4,0,1,0,2,0,1,0,3,0,1,0,2,0,1,0
-         .byte  6,0,1,0,2,0,1,0,3,0,1,0,2,0,1,0
-         .byte  4,0,1,0,2,0,1,0,3,0,1,0,2,0,1,0
-         .byte  5,0,1,0,2,0,1,0,3,0,1,0,2,0,1,0
-         .byte  4,0,1,0,2,0,1,0,3,0,1,0,2,0,1,0
-         .byte  7,0,1,0,2,0,1,0,3,0,1,0,2,0,1,0
-         .byte  4,0,1,0,2,0,1,0,3,0,1,0,2,0,1,0
-         .byte  5,0,1,0,2,0,1,0,3,0,1,0,2,0,1,0
-         .byte  4,0,1,0,2,0,1,0,3,0,1,0,2,0,1,0
-         .byte  6,0,1,0,2,0,1,0,3,0,1,0,2,0,1,0
-         .byte  4,0,1,0,2,0,1,0,3,0,1,0,2,0,1,0
-         .byte  5,0,1,0,2,0,1,0,3,0,1,0,2,0,1,0
-         .byte  4,0,1,0,2,0,1,0,3,0,1,0,2,0,1,0
-

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
