Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20100224084449.452911663@de.ibm.com>
Date: Wed, 24 Feb 2010 09:44:42 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 12/32] [PATCH] qdio: optimize cache line usage of struct qdio_irq
References: <20100224084430.193562869@de.ibm.com>
Content-Disposition: inline; filename=111-qdio-optimize-cache-lines.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Glauber <jang@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jan Glauber <jang@linux.vnet.ibm.com>

Remove a memset hack that relied on the internal layout of the
qdio_irq struct and move the per device statistics data into an own
cache line to avoid cache line bashing between the inbound and the
outbound queue tasklets. Also reduce the number of allocated queues
from 32 to 4 which is the current maximum. That saves a cache line
in struct qdio_irq.

Signed-off-by: Jan Glauber <jang@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/qdio.h  |    3 ++-
 drivers/s390/cio/qdio.h       |    9 +++------
 drivers/s390/cio/qdio_setup.c |   10 +++++++++-
 3 files changed, 14 insertions(+), 8 deletions(-)

Index: quilt-2.6/arch/s390/include/asm/qdio.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/qdio.h	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/include/asm/qdio.h	2010-02-24 09:44:25.000000000 +0100
@@ -13,7 +13,8 @@
 #include <asm/cio.h>
 #include <asm/ccwdev.h>
 
-#define QDIO_MAX_QUEUES_PER_IRQ		32
+/* only use 4 queues to save some cachelines */
+#define QDIO_MAX_QUEUES_PER_IRQ		4
 #define QDIO_MAX_BUFFERS_PER_Q		128
 #define QDIO_MAX_BUFFERS_MASK		(QDIO_MAX_BUFFERS_PER_Q - 1)
 #define QDIO_MAX_ELEMENTS_PER_BUFFER	16
Index: quilt-2.6/drivers/s390/cio/qdio.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio.h	2010-02-24 09:44:25.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/qdio.h	2010-02-24 09:44:25.000000000 +0100
@@ -208,7 +208,7 @@
 	unsigned int eqbs_partial;
 	unsigned int sqbs;
 	unsigned int sqbs_partial;
-};
+} ____cacheline_aligned;
 
 struct qdio_queue_perf_stat {
 	/*
@@ -329,12 +329,8 @@
 	struct qdio_ssqd_desc ssqd_desc;
 	void (*orig_handler) (struct ccw_device *, unsigned long, struct irb *);
 
-	struct qdio_dev_perf_stat perf_stat;
 	int perf_stat_enabled;
-	/*
-	 * Warning: Leave these members together at the end so they won't be
-	 * cleared in qdio_setup_irq.
-	 */
+
 	struct qdr *qdr;
 	unsigned long chsc_page;
 
@@ -343,6 +339,7 @@
 
 	debug_info_t *debug_area;
 	struct mutex setup_mutex;
+	struct qdio_dev_perf_stat perf_stat;
 };
 
 /* helper functions */
Index: quilt-2.6/drivers/s390/cio/qdio_setup.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio_setup.c	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/qdio_setup.c	2010-02-24 09:44:25.000000000 +0100
@@ -382,7 +382,15 @@
 	struct qdio_irq *irq_ptr = init_data->cdev->private->qdio_data;
 	int rc;
 
-	memset(irq_ptr, 0, ((char *)&irq_ptr->qdr) - ((char *)irq_ptr));
+	memset(&irq_ptr->qib, 0, sizeof(irq_ptr->qib));
+	memset(&irq_ptr->siga_flag, 0, sizeof(irq_ptr->siga_flag));
+	memset(&irq_ptr->ccw, 0, sizeof(irq_ptr->ccw));
+	memset(&irq_ptr->ssqd_desc, 0, sizeof(irq_ptr->ssqd_desc));
+	memset(&irq_ptr->perf_stat, 0, sizeof(irq_ptr->perf_stat));
+
+	irq_ptr->debugfs_dev = irq_ptr->debugfs_perf = NULL;
+	irq_ptr->sch_token = irq_ptr->state = irq_ptr->perf_stat_enabled = 0;
+
 	/* wipes qib.ac, required by ar7063 */
 	memset(irq_ptr->qdr, 0, sizeof(struct qdr));
 
