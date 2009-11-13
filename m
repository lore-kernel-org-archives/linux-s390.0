Return-Path: <linux-kernel-owner+w=401wt.eu-S1756045AbZKMPPw@vger.kernel.org>
Message-Id: <20091113150913.785968948@de.ibm.com>
Date: Fri, 13 Nov 2009 16:08:49 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 25/52] [PATCH] sclp: improve servicability setting
References: <20091113150824.351347652@de.ibm.com>
Content-Disposition: inline; filename=124-sclp-dump-indicator.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Set dump indicator on read-scp-info command to get meaningful dumps.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/sclp_cmd.c |    1 +
 1 file changed, 1 insertion(+)

Index: quilt-2.6/drivers/s390/char/sclp_cmd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp_cmd.c	2009-11-13 15:48:33.000000000 +0100
+++ quilt-2.6/drivers/s390/char/sclp_cmd.c	2009-11-13 16:08:17.000000000 +0100
@@ -84,6 +84,7 @@
 		do {
 			memset(sccb, 0, sizeof(*sccb));
 			sccb->header.length = sizeof(*sccb);
+			sccb->header.function_code = 0x80;
 			sccb->header.control_mask[2] = 0x80;
 			rc = sclp_cmd_sync_early(commands[i], sccb);
 		} while (rc == -EBUSY);
