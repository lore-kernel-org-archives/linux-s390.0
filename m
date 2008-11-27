Return-Path: <linux-kernel-owner+w=401wt.eu-S1757098AbYK0KyL@vger.kernel.org>
Message-Id: <20081127103134.797553323@de.ibm.com>
References: <20081127103020.528516828@de.ibm.com>
Date: Thu, 27 Nov 2008 11:30:45 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 25/60] cio: get rid of compile warning
Content-Disposition: inline; filename=124-cio-warning.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Move cio_tpi() to the rest of the CONFIG_CCW_CONSOLE functions to
get rid of this one:

drivers/s390/cio/cio.c:115: warning: 'cio_tpi' defined but not used

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/cio.c |   75 ++++++++++++++++++++++++-------------------------
 1 file changed, 37 insertions(+), 38 deletions(-)

Index: quilt-2.6/drivers/s390/cio/cio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.c
+++ quilt-2.6/drivers/s390/cio/cio.c
@@ -104,44 +104,6 @@ cio_get_options (struct subchannel *sch)
        return flags;
 }
 
-/*
- * Use tpi to get a pending interrupt, call the interrupt handler and
- * return a pointer to the subchannel structure.
- */
-static int
-cio_tpi(void)
-{
-	struct tpi_info *tpi_info;
-	struct subchannel *sch;
-	struct irb *irb;
-	int irq_context;
-
-	tpi_info = (struct tpi_info *) __LC_SUBCHANNEL_ID;
-	if (tpi (NULL) != 1)
-		return 0;
-	irb = (struct irb *) __LC_IRB;
-	/* Store interrupt response block to lowcore. */
-	if (tsch (tpi_info->schid, irb) != 0)
-		/* Not status pending or not operational. */
-		return 1;
-	sch = (struct subchannel *)(unsigned long)tpi_info->intparm;
-	if (!sch)
-		return 1;
-	irq_context = in_interrupt();
-	if (!irq_context)
-		local_bh_disable();
-	irq_enter ();
-	spin_lock(sch->lock);
-	memcpy(&sch->schib.scsw, &irb->scsw, sizeof(union scsw));
-	if (sch->driver && sch->driver->irq)
-		sch->driver->irq(sch);
-	spin_unlock(sch->lock);
-	irq_exit ();
-	if (!irq_context)
-		_local_bh_enable();
-	return 1;
-}
-
 static int
 cio_start_handle_notoper(struct subchannel *sch, __u8 lpm)
 {
@@ -687,6 +649,43 @@ static char console_sch_name[10] = "0.x.
 static struct io_subchannel_private console_priv;
 static int console_subchannel_in_use;
 
+/*
+ * Use tpi to get a pending interrupt, call the interrupt handler and
+ * return a pointer to the subchannel structure.
+ */
+static int cio_tpi(void)
+{
+	struct tpi_info *tpi_info;
+	struct subchannel *sch;
+	struct irb *irb;
+	int irq_context;
+
+	tpi_info = (struct tpi_info *) __LC_SUBCHANNEL_ID;
+	if (tpi(NULL) != 1)
+		return 0;
+	irb = (struct irb *) __LC_IRB;
+	/* Store interrupt response block to lowcore. */
+	if (tsch(tpi_info->schid, irb) != 0)
+		/* Not status pending or not operational. */
+		return 1;
+	sch = (struct subchannel *)(unsigned long)tpi_info->intparm;
+	if (!sch)
+		return 1;
+	irq_context = in_interrupt();
+	if (!irq_context)
+		local_bh_disable();
+	irq_enter();
+	spin_lock(sch->lock);
+	memcpy(&sch->schib.scsw, &irb->scsw, sizeof(union scsw));
+	if (sch->driver && sch->driver->irq)
+		sch->driver->irq(sch);
+	spin_unlock(sch->lock);
+	irq_exit();
+	if (!irq_context)
+		_local_bh_enable();
+	return 1;
+}
+
 void *cio_get_console_priv(void)
 {
 	return &console_priv;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
