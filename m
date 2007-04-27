Return-Path: <linux-kernel-owner+w=401wt.eu-S1755932AbXD0OLw@vger.kernel.org>
Message-Id: <20070427140518.176245414@de.ibm.com>
References: <20070427140503.087958775@de.ibm.com>
Date: Fri, 27 Apr 2007 16:05:30 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 27/38] ctc: kmalloc->kzalloc/casting cleanups.
Content-Disposition: inline; filename=130-ctc-kmalloc.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: "Ahmed S. Darwish" <darwish.07@gmail.com>, Frank Pavlic <fpavlic@de.ibm.com>, Ursula Braun <braunu@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: "Ahmed S. Darwish" <darwish.07@gmail.com>

A patch for the CTC / ESCON network driver.  Switch from kmalloc to kzalloc
when appropriate, remove some unnecessary kmalloc casts too.  Since I have no
s390 machine, I didn't compile it but I examined it carefully.

Signed-off-by: "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc: Frank Pavlic <fpavlic@de.ibm.com>
Cc: Ursula Braun <braunu@de.ibm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/net/ctcmain.c |   23 +++++++++--------------
 1 files changed, 9 insertions(+), 14 deletions(-)

Index: quilt-2.6/drivers/s390/net/ctcmain.c
===================================================================
--- quilt-2.6.orig/drivers/s390/net/ctcmain.c	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/drivers/s390/net/ctcmain.c	2007-04-27 16:04:59.000000000 +0200
@@ -1638,21 +1638,19 @@
 	struct channel *ch;
 
 	DBF_TEXT(trace, 2, __FUNCTION__);
-	if ((ch =
-	     (struct channel *) kmalloc(sizeof (struct channel),
-					GFP_KERNEL)) == NULL) {
+	ch = kzalloc(sizeof(struct channel), GFP_KERNEL);
+	if (!ch) {
 		ctc_pr_warn("ctc: Out of memory in add_channel\n");
 		return -1;
 	}
-	memset(ch, 0, sizeof (struct channel));
-	if ((ch->ccw = kmalloc(8*sizeof(struct ccw1),
-					       GFP_KERNEL | GFP_DMA)) == NULL) {
+	/* assure all flags and counters are reset */
+	ch->ccw = kzalloc(8 * sizeof(struct ccw1), GFP_KERNEL | GFP_DMA);
+	if (!ch->ccw) {
 		kfree(ch);
 		ctc_pr_warn("ctc: Out of memory in add_channel\n");
 		return -1;
 	}
 
-	memset(ch->ccw, 0, 8*sizeof(struct ccw1));	// assure all flags and counters are reset
 
 	/**
 	 * "static" ccws are used in the following way:
@@ -1692,15 +1690,14 @@
 		return -1;
 	}
 	fsm_newstate(ch->fsm, CH_STATE_IDLE);
-	if ((ch->irb = kmalloc(sizeof (struct irb),
-					      GFP_KERNEL)) == NULL) {
+	ch->irb = kzalloc(sizeof(struct irb), GFP_KERNEL);
+	if (!ch->irb) {
 		ctc_pr_warn("ctc: Out of memory in add_channel\n");
 		kfree_fsm(ch->fsm);
 		kfree(ch->ccw);
 		kfree(ch);
 		return -1;
 	}
-	memset(ch->irb, 0, sizeof (struct irb));
 	while (*c && less_than((*c)->id, ch->id))
 		c = &(*c)->next;
 	if (*c && (!strncmp((*c)->id, ch->id, CTC_ID_SIZE))) {
@@ -2745,14 +2742,13 @@
 	if (!get_device(&cgdev->dev))
 		return -ENODEV;
 
-	priv = kmalloc(sizeof (struct ctc_priv), GFP_KERNEL);
+	priv = kzalloc(sizeof(struct ctc_priv), GFP_KERNEL);
 	if (!priv) {
 		ctc_pr_err("%s: Out of memory\n", __func__);
 		put_device(&cgdev->dev);
 		return -ENOMEM;
 	}
 
-	memset(priv, 0, sizeof (struct ctc_priv));
 	rc = ctc_add_files(&cgdev->dev);
 	if (rc) {
 		kfree(priv);
@@ -2793,10 +2789,9 @@
 	DBF_TEXT(setup, 3, __FUNCTION__);
 
 	if (alloc_device) {
-		dev = kmalloc(sizeof (struct net_device), GFP_KERNEL);
+		dev = kzalloc(sizeof(struct net_device), GFP_KERNEL);
 		if (!dev)
 			return NULL;
-		memset(dev, 0, sizeof (struct net_device));
 	}
 
 	dev->priv = privptr;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
