Return-Path: <linux-kernel-owner+w=401wt.eu-S1758417AbZFDQWG@vger.kernel.org>
Message-Id: <20090604161904.066653742@de.ibm.com>
References: <20090604161847.513682672@de.ibm.com>
Date: Thu, 04 Jun 2009 18:19:06 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 19/38] pm: claw driver power management callbacks
Content-Disposition: inline; filename=pm_claw.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Frank Blaschka <frank.blaschka@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Frank Blaschka <frank.blaschka@de.ibm.com>

Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 drivers/s390/net/claw.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/s390/net/claw.c
===================================================================
--- linux-2.6.orig/drivers/s390/net/claw.c
+++ linux-2.6/drivers/s390/net/claw.c
@@ -3,12 +3,12 @@
  *    ESCON CLAW network driver
  *
  *  Linux for zSeries version
- *    Copyright (C) 2002,2005 IBM Corporation
+ *    Copyright IBM Corp. 2002, 2009
  *  Author(s) Original code written by:
- *              Kazuo Iimura (iimura@jp.ibm.com)
+ *              Kazuo Iimura <iimura@jp.ibm.com>
  *   	      Rewritten by
- *              Andy Richter (richtera@us.ibm.com)
- *              Marc Price (mwprice@us.ibm.com)
+ *              Andy Richter <richtera@us.ibm.com>
+ *              Marc Price <mwprice@us.ibm.com>
  *
  *    sysfs parms:
  *   group x.x.rrrr,x.x.wwww
@@ -253,6 +253,11 @@ static void claw_free_wrt_buf(struct net
 /* Functions for unpack reads   */
 static void unpack_read(struct net_device *dev);
 
+static int claw_pm_prepare(struct ccwgroup_device *gdev)
+{
+	return -EPERM;
+}
+
 /* ccwgroup table  */
 
 static struct ccwgroup_driver claw_group_driver = {
@@ -264,6 +269,7 @@ static struct ccwgroup_driver claw_group
         .remove      = claw_remove_device,
         .set_online  = claw_new_device,
         .set_offline = claw_shutdown_device,
+	.prepare     = claw_pm_prepare,
 };
 
 /*

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
