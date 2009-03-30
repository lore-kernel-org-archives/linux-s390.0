Return-Path: <linux-kernel-owner+w=401wt.eu-S1756980AbZC3Jaf@vger.kernel.org>
Date: Mon, 30 Mar 2009 11:30:15 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH] ETHOC: fix build breakage on s390
Message-ID: <20090330113015.21576898@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: Thierry Reding <thierry.reding@avionic-design.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Let driver depend on HAS_IOMEM to avoid build breakage on s390:

  CC      drivers/net/ethoc.o
drivers/net/ethoc.c: In function 'ethoc_read':
drivers/net/ethoc.c:221: error: implicit declaration of function 'ioread32'
drivers/net/ethoc.c: In function 'ethoc_write':
drivers/net/ethoc.c:226: error: implicit declaration of function 'iowrite32'
drivers/net/ethoc.c: In function 'ethoc_rx':
drivers/net/ethoc.c:405: error: implicit declaration of function 'memcpy_fromio'
drivers/net/ethoc.c: In function 'ethoc_start_xmit':
drivers/net/ethoc.c:828: error: implicit declaration of function 'memcpy_toio'

Cc: Thierry Reding <thierry.reding@avionic-design.de>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 drivers/net/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/net/Kconfig
===================================================================
--- linux-2.6.orig/drivers/net/Kconfig
+++ linux-2.6/drivers/net/Kconfig
@@ -974,7 +974,7 @@ config ENC28J60_WRITEVERIFY
 
 config ETHOC
 	tristate "OpenCores 10/100 Mbps Ethernet MAC support"
-	depends on NET_ETHERNET
+	depends on NET_ETHERNET && HAS_IOMEM
 	select MII
 	select PHYLIB
 	help
