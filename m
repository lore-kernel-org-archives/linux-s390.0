Return-Path: <linux-kernel-owner+w=401wt.eu-S1755149AbYJAJDN@vger.kernel.org>
Message-Id: <20081001084128.501589142@de.ibm.com>
References: <20081001083317.782967473@de.ibm.com>
Date: Wed, 01 Oct 2008 10:33:30 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 13/21] qdio enhanced SIGA (iqdio) support.
Content-Disposition: inline; filename=112-qdio-enhanced-siga.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Klaus-Dieter Wacker <kdwacker@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Klaus-Dieter Wacker <kdwacker@de.ibm.com>

Add support for z10 HiperSockets multiwrite SBALs on output
queues. This is used on LPAR with EDDP enabled devices.

Signed-off-by: Klaus-Dieter Wacker <kdwacker@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/qdio.h |    8 +++++++-
 drivers/s390/cio/qdio.h      |    3 +++
 drivers/s390/cio/qdio_main.c |   24 +++++++++++++++++++-----
 3 files changed, 29 insertions(+), 6 deletions(-)

Index: quilt-2.6/arch/s390/include/asm/qdio.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/qdio.h
+++ quilt-2.6/arch/s390/include/asm/qdio.h
@@ -299,7 +299,13 @@ struct qdio_ssqd_desc {
 	u8 mbccnt;
 	u16 qdioac2;
 	u64 sch_token;
-	u64:64;
+	u8 mro;
+	u8 mri;
+	u8:8;
+	u8 sbalic;
+	u16:16;
+	u8:8;
+	u8 mmwc;
 } __attribute__ ((packed));
 
 /* params are: ccw_device, qdio_error, queue_number,
Index: quilt-2.6/drivers/s390/cio/qdio.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio.h
+++ quilt-2.6/drivers/s390/cio/qdio.h
@@ -203,6 +203,9 @@ struct qdio_output_q {
 	/* PCIs are enabled for the queue */
 	int pci_out_enabled;
 
+	/* IQDIO: output multiple buffers (enhanced SIGA) */
+	int use_enh_siga;
+
 	/* timer to check for more outbound work */
 	struct timer_list timer;
 };
Index: quilt-2.6/drivers/s390/cio/qdio_main.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio_main.c
+++ quilt-2.6/drivers/s390/cio/qdio_main.c
@@ -316,6 +316,9 @@ static inline int qdio_do_siga_output(st
 	unsigned int fc = 0;
 	unsigned long schid;
 
+	if (q->u.out.use_enh_siga) {
+		fc = 3;
+	}
 	if (!is_qebsm(q))
 		schid = *((u32 *)&q->irq_ptr->schid);
 	else {
@@ -1449,6 +1452,8 @@ int qdio_establish(struct qdio_initializ
 	}
 
 	qdio_setup_ssqd_info(irq_ptr);
+	sprintf(dbf_text, "qDmmwc%2x", irq_ptr->ssqd_desc.mmwc);
+	QDIO_DBF_TEXT2(0, setup, dbf_text);
 	sprintf(dbf_text, "qib ac%2x", irq_ptr->qib.ac);
 	QDIO_DBF_TEXT2(0, setup, dbf_text);
 
@@ -1621,12 +1626,21 @@ static void handle_outbound(struct qdio_
 		if (multicast_outbound(q))
 			qdio_kick_outbound_q(q);
 		else
-			/*
-			 * One siga-w per buffer required for unicast
-			 * HiperSockets.
-			 */
-			while (count--)
+			if ((q->irq_ptr->ssqd_desc.mmwc > 1) &&
+			    (count > 1) &&
+			    (count <= q->irq_ptr->ssqd_desc.mmwc)) {
+				/* exploit enhanced SIGA */
+				q->u.out.use_enh_siga = 1;
 				qdio_kick_outbound_q(q);
+			} else {
+				/*
+				* One siga-w per buffer required for unicast
+				* HiperSockets.
+				*/
+				q->u.out.use_enh_siga = 0;
+				while (count--)
+					qdio_kick_outbound_q(q);
+			}
 		goto out;
 	}
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
