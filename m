Return-Path: <linux-kernel-owner+w=401wt.eu-S1754615AbYJAI60@vger.kernel.org>
Message-Id: <20081001084127.769319562@de.ibm.com>
References: <20081001083317.782967473@de.ibm.com>
Date: Wed, 01 Oct 2008 10:33:27 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 10/21] bus_id ->dev_name() conversions in qdio
Content-Disposition: inline; filename=109-cio-busid5.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Use dev_name() in the new qdio driver.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 drivers/s390/cio/qdio_debug.c |    2 +-
 drivers/s390/cio/qdio_main.c  |    2 +-
 drivers/s390/cio/qdio_setup.c |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

Index: quilt-2.6/drivers/s390/cio/qdio_debug.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio_debug.c
+++ quilt-2.6/drivers/s390/cio/qdio_debug.c
@@ -155,7 +155,7 @@ static int qstat_seq_open(struct inode *
 static void get_queue_name(struct qdio_q *q, struct ccw_device *cdev, char *name)
 {
 	memset(name, 0, sizeof(name));
-	sprintf(name, "%s", cdev->dev.bus_id);
+	sprintf(name, "%s", dev_name(&cdev->dev));
 	if (q->is_input_q)
 		sprintf(name + strlen(name), "_input");
 	else
Index: quilt-2.6/drivers/s390/cio/qdio_main.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio_main.c
+++ quilt-2.6/drivers/s390/cio/qdio_main.c
@@ -962,7 +962,7 @@ static void qdio_handle_activate_check(s
 	char dbf_text[15];
 
 	QDIO_DBF_TEXT2(1, trace, "ick2");
-	sprintf(dbf_text, "%s", cdev->dev.bus_id);
+	sprintf(dbf_text, "%s", dev_name(&cdev->dev));
 	QDIO_DBF_TEXT2(1, trace, dbf_text);
 	QDIO_DBF_HEX2(0, trace, &intparm, sizeof(int));
 	QDIO_DBF_HEX2(0, trace, &dstat, sizeof(int));
Index: quilt-2.6/drivers/s390/cio/qdio_setup.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio_setup.c
+++ quilt-2.6/drivers/s390/cio/qdio_setup.c
@@ -447,7 +447,7 @@ void qdio_print_subchannel_info(struct q
 {
 	char s[80];
 
-	sprintf(s, "%s sc:%x ", cdev->dev.bus_id, irq_ptr->schid.sch_no);
+	sprintf(s, "%s sc:%x ", dev_name(&cdev->dev), irq_ptr->schid.sch_no);
 
 	switch (irq_ptr->qib.qfmt) {
 	case QDIO_QETH_QFMT:
@@ -477,7 +477,7 @@ void qdio_print_subchannel_info(struct q
 	printk(KERN_INFO "qdio: %s", s);
 
 	memset(s, 0, sizeof(s));
-	sprintf(s, "%s SIGA required: ", cdev->dev.bus_id);
+	sprintf(s, "%s SIGA required: ", dev_name(&cdev->dev));
 	if (irq_ptr->siga_flag.input)
 		sprintf(s + strlen(s), "Read ");
 	if (irq_ptr->siga_flag.output)

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
