From: frank.blaschka@de.ibm.com
Subject: [patch 1/3] [PATCH] net: wiznet add missing HAS_IOMEM dependency
Date: Wed, 25 Jul 2012 10:34:27 +0200
Message-ID: <20120725083446.107634782@de.ibm.com>
References: <20120725083426.704834478@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline; filename=600-wiznet-kconfig.diff
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The "WIZnet devices" config option should depend on HAS_IOMEM as
all wiznet drivers require it as well.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
---
 drivers/net/ethernet/wiznet/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/wiznet/Kconfig b/drivers/net/ethernet/wiznet/Kconfig
index cb18043..b4d2816 100644
--- a/drivers/net/ethernet/wiznet/Kconfig
+++ b/drivers/net/ethernet/wiznet/Kconfig
@@ -4,6 +4,7 @@
 
 config NET_VENDOR_WIZNET
 	bool "WIZnet devices"
+	depends on HAS_IOMEM
 	default y
 	---help---
 	  If you have a network (Ethernet) card belonging to this class, say Y
-- 
1.7.11.3
