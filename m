From: frank.blaschka@de.ibm.com
Subject: [patch 4/6] [PATCH] qeth: Update Kconfig wording
Date: Mon, 21 Jan 2013 13:30:21 +0100
Message-ID: <20130121123037.534460661@de.ibm.com>
References: <20130121123017.240686588@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline; filename=603-qeth-kconfig-help.diff
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Stefan Raspl <raspl@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Stefan Raspl <raspl@linux.vnet.ibm.com>

Refer to virtual NICs instead of GuestLANs.

Signed-off-by: Stefan Raspl <raspl@linux.vnet.ibm.com>
Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
---
 drivers/s390/net/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/s390/net/Kconfig
+++ b/drivers/s390/net/Kconfig
@@ -74,8 +74,8 @@ config QETH
 	depends on CCW && NETDEVICES && IP_MULTICAST && QDIO
 	help
 	  This driver supports the IBM System z OSA Express adapters
-	  in QDIO mode (all media types), HiperSockets interfaces and VM GuestLAN
-	  interfaces in QDIO and HIPER mode.
+	  in QDIO mode (all media types), HiperSockets interfaces and z/VM
+	  virtual NICs for Guest LAN and VSWITCH.
 	
 	  For details please refer to the documentation provided by IBM at
 	  <http://www.ibm.com/developerworks/linux/linux390>
