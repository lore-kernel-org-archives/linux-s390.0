Return-Path: <linux-kernel-owner+w=401wt.eu-S1755936AbXD0OJB@vger.kernel.org>
Message-Id: <20070427140520.859093636@de.ibm.com>
References: <20070427140503.087958775@de.ibm.com>
Date: Fri, 27 Apr 2007 16:05:41 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 38/38] SPIN_LOCK_UNLOCKED cleanup in drivers/s390
Content-Disposition: inline; filename=141-spinlock.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Milind Arun Choudhary <milindchoudhary@gmail.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Milind Arun Choudhary <milindchoudhary@gmail.com>

SPIN_LOCK_UNLOCKED cleanup,use __SPIN_LOCK_UNLOCKED instead.

Signed-off-by: Milind Arun Choudhary <milindchoudhary@gmail.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/vmlogrdr.c |    6 +++---
 drivers/s390/cio/cmf.c       |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

Index: quilt-2.6/drivers/s390/char/vmlogrdr.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/vmlogrdr.c	2007-04-27 16:04:59.000000000 +0200
+++ quilt-2.6/drivers/s390/char/vmlogrdr.c	2007-04-27 16:05:02.000000000 +0200
@@ -125,7 +125,7 @@
 	  .recording_name = "EREP",
 	  .minor_num      = 0,
 	  .buffer_free    = 1,
-	  .priv_lock      = SPIN_LOCK_UNLOCKED,
+	  .priv_lock	  = __SPIN_LOCK_UNLOCKED(sys_ser[0].priv_lock),
 	  .autorecording  = 1,
 	  .autopurge      = 1,
 	},
@@ -134,7 +134,7 @@
 	  .recording_name = "ACCOUNT",
 	  .minor_num      = 1,
 	  .buffer_free    = 1,
-	  .priv_lock      = SPIN_LOCK_UNLOCKED,
+	  .priv_lock	  = __SPIN_LOCK_UNLOCKED(sys_ser[1].priv_lock),
 	  .autorecording  = 1,
 	  .autopurge      = 1,
 	},
@@ -143,7 +143,7 @@
 	  .recording_name = "SYMPTOM",
 	  .minor_num      = 2,
 	  .buffer_free    = 1,
-	  .priv_lock      = SPIN_LOCK_UNLOCKED,
+	  .priv_lock	  = __SPIN_LOCK_UNLOCKED(sys_ser[2].priv_lock),
 	  .autorecording  = 1,
 	  .autopurge      = 1,
 	}
Index: quilt-2.6/drivers/s390/cio/cmf.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cmf.c	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/drivers/s390/cio/cmf.c	2007-04-27 16:05:02.000000000 +0200
@@ -476,7 +476,7 @@
 };
 
 static struct cmb_area cmb_area = {
-	.lock = SPIN_LOCK_UNLOCKED,
+	.lock = __SPIN_LOCK_UNLOCKED(cmb_area.lock),
 	.list = LIST_HEAD_INIT(cmb_area.list),
 	.num_channels  = 1024,
 };

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
