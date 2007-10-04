Return-Path: <linux-kernel-owner+w=401wt.eu-S1761585AbXJDLje@vger.kernel.org>
Message-Id: <20071004112831.765609656@de.ibm.com>
References: <20071004112706.574737175@de.ibm.com>
Date: Thu, 04 Oct 2007 13:27:32 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 26/34] qdio: change QDIO performance_stats error message priority
Content-Disposition: inline; filename=026-qdio-message.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ursula Braun <braunu@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <braunu@de.ibm.com>

Signed-off-by: Ursula Braun <braunu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 drivers/s390/cio/qdio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: quilt-2.6/drivers/s390/cio/qdio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio.c
+++ quilt-2.6/drivers/s390/cio/qdio.c
@@ -3727,7 +3727,7 @@ qdio_performance_stats_store(struct bus_
 #endif /* CONFIG_64BIT */
 		}
 	} else {
-		QDIO_PRINT_WARN("QDIO performance_stats: write 0 or 1 to this file!\n");
+		QDIO_PRINT_ERR("QDIO performance_stats: write 0 or 1 to this file!\n");
 		return -EINVAL;
 	}
 	return count;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
