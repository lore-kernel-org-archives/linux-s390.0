Return-Path: <linux-kernel-owner+w=401wt.eu-S1755039AbYGaMk4@vger.kernel.org>
Message-Id: <20080731123932.621722615@de.ibm.com>
References: <20080731123004.868574766@de.ibm.com>
Date: Thu, 31 Jul 2008 14:30:06 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 2/6] stp: fix section mismatch warning.
Content-Disposition: inline; filename=101-stp-section.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Fix these two (false positive) warnings by adding an __init annoation:

WARNING: vmlinux.o(.text+0x7e6a): Section mismatch in reference from the function stp_reset() to the function .init.text:__alloc_bootmem()
The function stp_reset() references
the function __init __alloc_bootmem().
This is often because stp_reset lacks a __init
annotation or the annotation of __alloc_bootmem is wrong.

WARNING: vmlinux.o(.text+0x7ece): Section mismatch in reference from the function stp_reset() to the function .init.text:free_bootmem()
The function stp_reset() references
the function __init free_bootmem().
This is often because stp_reset lacks a __init
annotation or the annotation of free_bootmem is wrong.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/time.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: quilt-2.6/arch/s390/kernel/time.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/time.c
+++ quilt-2.6/arch/s390/kernel/time.c
@@ -1348,7 +1348,7 @@ early_param("stp", early_parse_stp);
 /*
  * Reset STP attachment.
  */
-static void stp_reset(void)
+static void __init stp_reset(void)
 {
 	int rc;
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
