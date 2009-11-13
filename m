Return-Path: <linux-kernel-owner+w=401wt.eu-S1756947AbZKMPQC@vger.kernel.org>
Message-Id: <20091113150912.928971346@de.ibm.com>
Date: Fri, 13 Nov 2009 16:08:45 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 21/52] [PATCH] dasd: enable prefix independent of pav support
References: <20091113150824.351347652@de.ibm.com>
Content-Disposition: inline; filename=120-dasd-enable-prefix.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Weinhuber <wein@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Stefan Weinhuber <wein@de.ibm.com>

The DASD device driver needs to explicitly enable the prefix command
on the storage server, before it can be used. Originally we enabled
this command along with others only if we wanted to support PAV.
However, today we require this command for other features like
High Performance FICON as well, so we need to always enable prefix.

Signed-off-by: Stefan Weinhuber <wein@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd_eckd.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: quilt-2.6/drivers/s390/block/dasd_eckd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_eckd.c	2009-11-13 16:08:14.000000000 +0100
+++ quilt-2.6/drivers/s390/block/dasd_eckd.c	2009-11-13 16:08:16.000000000 +0100
@@ -1011,9 +1011,9 @@
 	}
 	psf_ssc_data = (struct dasd_psf_ssc_data *)cqr->data;
 	psf_ssc_data->order = PSF_ORDER_SSC;
-	psf_ssc_data->suborder = 0x40;
+	psf_ssc_data->suborder = 0xc0;
 	if (enable_pav) {
-		psf_ssc_data->suborder |= 0x88;
+		psf_ssc_data->suborder |= 0x08;
 		psf_ssc_data->reserved[0] = 0x88;
 	}
 	ccw = cqr->cpaddr;
