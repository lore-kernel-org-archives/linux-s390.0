Return-Path: <linux-kernel-owner+w=401wt.eu-S1757044AbXJDLeY@vger.kernel.org>
Message-Id: <20071004112830.875676045@de.ibm.com>
References: <20071004112706.574737175@de.ibm.com>
Date: Thu, 04 Oct 2007 13:27:29 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 23/34] Get rid of ARCH_KMALLOC_MINALIGN.
Content-Disposition: inline; filename=023-arch-align.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

slab cache debugging code has been changed so that we always get a
minimum alignment of the alignment of a 64-integer. Since this is
8 on s390/s390x there is no need of ARCH_KMALLOC_MINALIGN anymore.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-s390/cache.h |    2 --
 1 file changed, 2 deletions(-)

Index: quilt-2.6/include/asm-s390/cache.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/cache.h
+++ quilt-2.6/include/asm-s390/cache.h
@@ -14,8 +14,6 @@
 #define L1_CACHE_BYTES     256
 #define L1_CACHE_SHIFT     8
 
-#define ARCH_KMALLOC_MINALIGN	8
-
 #define __read_mostly __attribute__((__section__(".data.read_mostly")))
 
 #endif

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
