Return-Path: <linux-kernel-owner+w=401wt.eu-S1759521AbXEJPD1@vger.kernel.org>
Subject: [PATCH] Kconfig: SCSI_ESP_CORE depends on HAS_DMA
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
Content-Type: text/plain
Date: Thu, 10 May 2007 17:03:42 +0200
Message-Id: <1178809422.29611.6.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/scsi/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/scsi/Kconfig linux-2.6-patched/drivers/scsi/Kconfig
--- linux-2.6/drivers/scsi/Kconfig	2007-05-10 15:17:27.000000000 +0200
+++ linux-2.6-patched/drivers/scsi/Kconfig	2007-05-10 15:18:12.000000000 +0200
@@ -1755,7 +1755,7 @@ config SUN3X_ESP
 
 config SCSI_ESP_CORE
 	tristate "ESP Scsi Driver Core"
-	depends on SCSI
+	depends on SCSI && HAS_DMA
 	select SCSI_SPI_ATTRS
 
 config SCSI_SUNESP
