Return-Path: <linux-kernel-owner+w=401wt.eu-S1752535AbXGQMVH@vger.kernel.org>
Message-Id: <20070717122239.461337642@de.ibm.com>
References: <20070717121747.591687140@de.ibm.com>
Date: Tue, 17 Jul 2007 14:17:50 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 3/8] qdio: output queue stall on FCP and network devices
Content-Disposition: inline; filename=002-qdio-stall.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Frank Pavlic <fpavlic@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Frank Pavlic <fpavlic@de.ibm.com>

When running QIOASSIST enabled qdio devices in a z/VM environment
the output queue for such devices stall in heavy workload situations.
When SQBS and EQBS instructions returns CCQ=96 qdio does not reissue
the instruction again with the register settings done by millicode
but processed the returned qdio buffer. This is wrong. qdio has to
reissue the instruction once again on CCQ=96, as we already do it
for CCQ=97.

Signed-off-by: Frank Pavlic <fpavlic@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/qdio.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: quilt-2.6/drivers/s390/cio/qdio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio.c
+++ quilt-2.6/drivers/s390/cio/qdio.c
@@ -166,9 +166,9 @@ qdio_check_ccq(struct qdio_q *q, unsigne
 {
 	char dbf_text[15];
 
-	if (ccq == 0 || ccq == 32 || ccq == 96)
+	if (ccq == 0 || ccq == 32)
 		return 0;
-	if (ccq == 97)
+	if (ccq == 96 || ccq == 97)
 		return 1;
 	/*notify devices immediately*/
 	sprintf(dbf_text,"%d", ccq);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
