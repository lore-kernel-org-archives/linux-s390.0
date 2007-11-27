Return-Path: <linux-kernel-owner+w=401wt.eu-S1759476AbXK0Q3z@vger.kernel.org>
Message-Id: <20071127162919.848871022@de.ibm.com>
References: <20071127162210.262064983@de.ibm.com>
Date: Tue, 27 Nov 2007 17:22:12 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 2/4] cio: add missing reprobe loop end statement
Content-Disposition: inline; filename=002-cio-reprobe.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

Add loop end statement to prevent looping over empty subchannel sets.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/css.c |    1 +
 1 file changed, 1 insertion(+)

Index: quilt-2.6/drivers/s390/cio/css.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.c
+++ quilt-2.6/drivers/s390/cio/css.c
@@ -451,6 +451,7 @@ static int reprobe_subchannel(struct sub
 		break;
 	case -ENXIO:
 	case -ENOMEM:
+	case -EIO:
 		/* These should abort looping */
 		break;
 	default:

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
