Return-Path: <linux-kernel-owner+w=401wt.eu-S1762234AbXHVMeP@vger.kernel.org>
Message-Id: <20070822123642.514416081@de.ibm.com>
References: <20070822123603.501231302@de.ibm.com>
Date: Wed, 22 Aug 2007 14:36:06 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 03/10] qdio: fix EQBS handling on CCQ96
Content-Disposition: inline; filename=003-qdio-eqbs.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: "Klaus D. Wacker" <kdwacker@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Klaus D. Wacker <kdwacker@de.ibm.com>

QDIO returned from EQBS instruction in any case after return code
CCQ=96 was issued regardless whether buffer states for at least one
buffer were extracted or not.
This caused FCP devices to hang when running under z/VM and having
QIOASSASIST=ON and having high I/O rates.
In order to fix this qdio return code processing of EQBS instruction
after CCQ=96 is changed that buffers are returned and if no buffers
where extracted the instruction is repeated at once.

Signed-off-by: Klaus D. Wacker <kdwacker@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 drivers/s390/cio/qdio.c |    2 ++
 1 file changed, 2 insertions(+)

Index: quilt-2.6/drivers/s390/cio/qdio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio.c
+++ quilt-2.6/drivers/s390/cio/qdio.c
@@ -195,6 +195,8 @@ qdio_do_eqbs(struct qdio_q *q, unsigned 
 again:
 	ccq = do_eqbs(irq->sch_token, state, q_no, start, cnt);
 	rc = qdio_check_ccq(q, ccq);
+	if ((ccq == 96) && (tmp_cnt != *cnt))
+		rc = 0;
 	if (rc == 1) {
 		QDIO_DBF_TEXT5(1,trace,"eqAGAIN");
 		goto again;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
