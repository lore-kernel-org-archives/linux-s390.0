Return-Path: <linux-kernel-owner+w=401wt.eu-S1755335AbYJORs4@vger.kernel.org>
Message-Id: <20081015174413.548630842@de.ibm.com>
References: <20081015174215.337001494@de.ibm.com>
Date: Wed, 15 Oct 2008 19:42:16 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 1/5] qdio: prevent double qdio shutdown in case of I/O errors
Content-Disposition: inline; filename=001-qdio-shutdown.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Glauber <jang@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jan Glauber <jang@linux.vnet.ibm.com>

In case of I/O errors on a qdio subchannel qdio_shutdown may be 
called twice by the qdio driver and by zfcp. Remove the 
superfluous shutdown from qdio and let the upper layer driver
handle the error condition.

Signed-off-by: Jan Glauber <jang@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/qdio_main.c |    1 -
 1 file changed, 1 deletion(-)

Index: quilt-2.6/drivers/s390/cio/qdio_main.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio_main.c
+++ quilt-2.6/drivers/s390/cio/qdio_main.c
@@ -1083,7 +1083,6 @@ void qdio_int_handler(struct ccw_device 
 		case -EIO:
 			sprintf(dbf_text, "ierr%4x", irq_ptr->schid.sch_no);
 			QDIO_DBF_TEXT2(1, setup, dbf_text);
-			qdio_int_error(cdev);
 			return;
 		case -ETIMEDOUT:
 			sprintf(dbf_text, "qtoh%4x", irq_ptr->schid.sch_no);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
