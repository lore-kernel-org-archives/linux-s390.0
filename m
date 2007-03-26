Return-Path: <linux-kernel-owner+w=401wt.eu-S932835AbXCZV23@vger.kernel.org>
Message-Id: <20070326212635.859350894@de.ibm.com>
References: <20070326212459.711271424@de.ibm.com>
Date: Mon, 26 Mar 2007 23:25:01 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [patch 2/8] Get rid of console setup functions.
Content-Disposition: inline; filename=110-console-setup.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

We get this:

Section mismatch: reference to .init.text:con3270_consetup from .data
		  between 'con3270' (at offset 0x45c8) and 'con3270_fn'
Section mismatch: reference to .init.text:con3215_consetup from .data
		  between 'con3215' (at offset 0x4678) and
		  'raw3215_ccw_driver'

Since there is no difference between a non present console setup
function and one that returns only 0 remove them.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 drivers/s390/char/con3215.c |    7 -------
 drivers/s390/char/con3270.c |    7 -------
 2 files changed, 14 deletions(-)

Index: linux-2.6/drivers/s390/char/con3215.c
===================================================================
--- linux-2.6.orig/drivers/s390/char/con3215.c
+++ linux-2.6/drivers/s390/char/con3215.c
@@ -813,12 +813,6 @@ con3215_unblank(void)
 	spin_unlock_irqrestore(get_ccwdev_lock(raw->cdev), flags);
 }
 
-static int __init 
-con3215_consetup(struct console *co, char *options)
-{
-	return 0;
-}
-
 /*
  *  The console structure for the 3215 console
  */
@@ -827,7 +821,6 @@ static struct console con3215 = {
 	.write	 = con3215_write,
 	.device	 = con3215_device,
 	.unblank = con3215_unblank,
-	.setup	 = con3215_consetup,
 	.flags	 = CON_PRINTBUFFER,
 };
 
Index: linux-2.6/drivers/s390/char/con3270.c
===================================================================
--- linux-2.6.orig/drivers/s390/char/con3270.c
+++ linux-2.6/drivers/s390/char/con3270.c
@@ -555,12 +555,6 @@ con3270_unblank(void)
 	spin_unlock_irqrestore(&cp->view.lock, flags);
 }
 
-static int __init 
-con3270_consetup(struct console *co, char *options)
-{
-	return 0;
-}
-
 /*
  *  The console structure for the 3270 console
  */
@@ -569,7 +563,6 @@ static struct console con3270 = {
 	.write	 = con3270_write,
 	.device	 = con3270_device,
 	.unblank = con3270_unblank,
-	.setup	 = con3270_consetup,
 	.flags	 = CON_PRINTBUFFER,
 };
 

-- 
