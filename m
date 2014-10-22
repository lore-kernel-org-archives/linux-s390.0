From: Frank Blaschka <blaschka@linux.vnet.ibm.com>
Subject: [PATCH 4/6] qeth: s390 ethernet device driver dependency
Date: Wed, 22 Oct 2014 12:18:05 +0200
Message-ID: <1413973087-18740-5-git-send-email-blaschka@linux.vnet.ibm.com>
References: <1413973087-18740-1-git-send-email-blaschka@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1413973087-18740-1-git-send-email-blaschka@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Thomas Richter <tmricht@linux.vnet.ibm.com>, Frank Blaschka <blaschka@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Richter <tmricht@linux.vnet.ibm.com>

Compile the s390 10GB ethernet device driver only when
ETHERNET has been defined in the kernel configuration file.
Right now the qeth device driver is always built regardless
of which network connectivity is active.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Signed-off-by: Frank Blaschka <blaschka@linux.vnet.ibm.com>
---
 drivers/s390/net/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/Kconfig b/drivers/s390/net/Kconfig
index 8b3f559..f1b5111 100644
--- a/drivers/s390/net/Kconfig
+++ b/drivers/s390/net/Kconfig
@@ -71,7 +71,7 @@ config CLAW
 config QETH
 	def_tristate y
 	prompt "Gigabit Ethernet device support"
-	depends on CCW && NETDEVICES && IP_MULTICAST && QDIO
+	depends on CCW && NETDEVICES && IP_MULTICAST && QDIO && ETHERNET
 	help
 	  This driver supports the IBM System z OSA Express adapters
 	  in QDIO mode (all media types), HiperSockets interfaces and z/VM
-- 
1.8.5.5
