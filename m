Return-Path: <linux-kernel-owner+w=401wt.eu-S1763409AbXGJJdk@vger.kernel.org>
Message-Id: <20070710093124.689069269@de.ibm.com>
References: <20070710092935.896013926@de.ibm.com>
Date: Tue, 10 Jul 2007 11:29:51 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 16/16] vmlogrdr function annotation.
Content-Disposition: inline; filename=016-vmlogrdr-initexit.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Stefan Weinhuber <wein@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

Use __init and __exit for vmlogrdr. Both functions are only referenced
by the module_init exit macros, so this change should be fine.

Acked-by: Stefan Weinhuber <wein@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/vmlogrdr.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: quilt-2.6/drivers/s390/char/vmlogrdr.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/vmlogrdr.c
+++ quilt-2.6/drivers/s390/char/vmlogrdr.c
@@ -835,7 +835,7 @@ static void vmlogrdr_cleanup(void)
 }
 
 
-static int vmlogrdr_init(void)
+static int __init vmlogrdr_init(void)
 {
 	int rc;
 	int i;
@@ -885,7 +885,7 @@ cleanup:
 }
 
 
-static void vmlogrdr_exit(void)
+static void __exit vmlogrdr_exit(void)
 {
 	vmlogrdr_cleanup();
 	printk (KERN_INFO "vmlogrdr: driver unloaded\n");

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
