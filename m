Return-Path: <linux-kernel-owner+w=401wt.eu-S937020AbXLTPna@vger.kernel.org>
Message-Id: <20071220152106.252234639@de.ibm.com>
References: <20071220151925.405881218@de.ibm.com>
Date: Thu, 20 Dec 2007 16:19:40 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 15/47] qdio: set QDIO_ACTIVATE_TIMEOUT to 5s
Content-Disposition: inline; filename=114-qdio-timeout.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ursula Braun <braunu@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <braunu@de.ibm.com>

Current definition of QDIO_ACTIVATE_TIMEOUT results in value 0.
Thus it may cause endless wait in function qdio_activate().

Signed-off-by: Ursula Braun <braunu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/qdio.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: quilt-2.6/drivers/s390/cio/qdio.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio.h
+++ quilt-2.6/drivers/s390/cio/qdio.h
@@ -57,7 +57,7 @@
 					    of the queue to 0 */
 
 #define QDIO_ESTABLISH_TIMEOUT (1*HZ)
-#define QDIO_ACTIVATE_TIMEOUT ((5*HZ)>>10)
+#define QDIO_ACTIVATE_TIMEOUT (5*HZ)
 #define QDIO_CLEANUP_CLEAR_TIMEOUT (20*HZ)
 #define QDIO_CLEANUP_HALT_TIMEOUT (10*HZ)
 #define QDIO_FORCE_CHECK_TIMEOUT (10*HZ)

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
