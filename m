Return-Path: <linux-kernel-owner+w=401wt.eu-S1757197AbZKMPRq@vger.kernel.org>
Message-Id: <20091113150911.224496056@de.ibm.com>
Date: Fri, 13 Nov 2009 16:08:35 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 11/52] [PATCH] dasd: remove dead code 
References: <20091113150824.351347652@de.ibm.com>
Content-Disposition: inline; filename=110-dasd-dead-code.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

the todclk.h header file is dead code. Remove it.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/todclk.h     |   23 -----------------------
 drivers/s390/block/dasd.c          |    1 -
 drivers/s390/block/dasd_3990_erp.c |    1 -
 drivers/s390/block/dasd_diag.c     |    1 -
 drivers/s390/block/dasd_eckd.c     |    1 -
 drivers/s390/block/dasd_fba.c      |    1 -
 6 files changed, 28 deletions(-)

Index: quilt-2.6/arch/s390/include/asm/todclk.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/todclk.h	2009-11-13 15:48:32.000000000 +0100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,23 +0,0 @@
-/*
- * File...........: linux/include/asm/todclk.h
- * Author(s)......: Holger Smolinski <Holger.Smolinski@de.ibm.com>
- * Bugreports.to..: <Linux390@de.ibm.com>
- * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
- *
- * History of changes (starts July 2000)
- */
-
-#ifndef __ASM_TODCLK_H
-#define __ASM_TODCLK_H
-
-#ifdef __KERNEL__
-
-#define TOD_uSEC (0x1000ULL)
-#define TOD_mSEC (1000 * TOD_uSEC)
-#define TOD_SEC (1000 * TOD_mSEC)
-#define TOD_MIN (60 * TOD_SEC)
-#define TOD_HOUR (60 * TOD_MIN)
-
-#endif
-
-#endif
Index: quilt-2.6/drivers/s390/block/dasd_3990_erp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_3990_erp.c	2009-11-13 15:48:33.000000000 +0100
+++ quilt-2.6/drivers/s390/block/dasd_3990_erp.c	2009-11-13 16:08:14.000000000 +0100
@@ -12,7 +12,6 @@
 #include <linux/timer.h>
 #include <linux/slab.h>
 #include <asm/idals.h>
-#include <asm/todclk.h>
 
 #define PRINTK_HEADER "dasd_erp(3990): "
 
Index: quilt-2.6/drivers/s390/block/dasd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd.c	2009-11-13 15:48:33.000000000 +0100
+++ quilt-2.6/drivers/s390/block/dasd.c	2009-11-13 16:08:14.000000000 +0100
@@ -24,7 +24,6 @@
 #include <asm/ccwdev.h>
 #include <asm/ebcdic.h>
 #include <asm/idals.h>
-#include <asm/todclk.h>
 #include <asm/itcw.h>
 
 /* This is ugly... */
Index: quilt-2.6/drivers/s390/block/dasd_diag.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_diag.c	2009-11-13 16:08:13.000000000 +0100
+++ quilt-2.6/drivers/s390/block/dasd_diag.c	2009-11-13 16:08:14.000000000 +0100
@@ -24,7 +24,6 @@
 #include <asm/ebcdic.h>
 #include <asm/io.h>
 #include <asm/s390_ext.h>
-#include <asm/todclk.h>
 #include <asm/vtoc.h>
 #include <asm/diag.h>
 
Index: quilt-2.6/drivers/s390/block/dasd_eckd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_eckd.c	2009-11-13 15:48:33.000000000 +0100
+++ quilt-2.6/drivers/s390/block/dasd_eckd.c	2009-11-13 16:08:14.000000000 +0100
@@ -24,7 +24,6 @@
 #include <asm/idals.h>
 #include <asm/ebcdic.h>
 #include <asm/io.h>
-#include <asm/todclk.h>
 #include <asm/uaccess.h>
 #include <asm/cio.h>
 #include <asm/ccwdev.h>
Index: quilt-2.6/drivers/s390/block/dasd_fba.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_fba.c	2009-11-13 15:48:33.000000000 +0100
+++ quilt-2.6/drivers/s390/block/dasd_fba.c	2009-11-13 16:08:14.000000000 +0100
@@ -20,7 +20,6 @@
 #include <asm/idals.h>
 #include <asm/ebcdic.h>
 #include <asm/io.h>
-#include <asm/todclk.h>
 #include <asm/ccwdev.h>
 
 #include "dasd_int.h"
