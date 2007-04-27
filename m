Return-Path: <linux-kernel-owner+w=401wt.eu-S1755926AbXD0OMg@vger.kernel.org>
Message-Id: <20070427140518.672178916@de.ibm.com>
References: <20070427140503.087958775@de.ibm.com>
Date: Fri, 27 Apr 2007 16:05:32 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 29/38] vmlogrdr: stop IUCV connection in vmlogrdr_release.
Content-Disposition: inline; filename=132-vmlogrdr-iucv.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ursula Braun <braunu@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <braunu@de.ibm.com>

Reopen of /dev/account failed. The IUCV path has to be terminated
in vmlogrdr_release.

Signed-off-by: Ursula Braun <braunu@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/vmlogrdr.c |    3 +++
 1 files changed, 3 insertions(+)

Index: quilt-2.6/drivers/s390/char/vmlogrdr.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/vmlogrdr.c	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/drivers/s390/char/vmlogrdr.c	2007-04-27 16:04:59.000000000 +0200
@@ -385,6 +385,9 @@
 
 	struct vmlogrdr_priv_t * logptr = filp->private_data;
 
+	iucv_path_sever(logptr->path, NULL);
+	kfree(logptr->path);
+	logptr->path = NULL;
 	if (logptr->autorecording) {
 		ret = vmlogrdr_recording(logptr,0,logptr->autopurge);
 		if (ret)

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
