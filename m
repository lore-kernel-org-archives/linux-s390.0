Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61244 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730677AbgEEQ0L (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 May 2020 12:26:11 -0400
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 11/11] s390/qeth: clean up Kconfig help text
Date: Tue,  5 May 2020 18:25:59 +0200
Message-Id: <20200505162559.14138-12-jwi@linux.ibm.com>
In-Reply-To: <20200505162559.14138-1-jwi@linux.ibm.com>
References: <20200505162559.14138-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Remove a stale doc link. While at it also reword the help text to get
rid of an outdated marketing term.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/Kconfig | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/net/Kconfig b/drivers/s390/net/Kconfig
index 3850a0f5f0bc..53120e68796e 100644
--- a/drivers/s390/net/Kconfig
+++ b/drivers/s390/net/Kconfig
@@ -63,12 +63,9 @@ config QETH
 	prompt "Gigabit Ethernet device support"
 	depends on CCW && NETDEVICES && IP_MULTICAST && QDIO && ETHERNET
 	help
-	  This driver supports the IBM System z OSA Express adapters
-	  in QDIO mode (all media types), HiperSockets interfaces and z/VM
-	  virtual NICs for Guest LAN and VSWITCH.
-	
-	  For details please refer to the documentation provided by IBM at
-	  <http://www.ibm.com/developerworks/linux/linux390>
+	  This driver supports IBM's OSA Express network adapters in QDIO mode,
+	  HiperSockets interfaces and z/VM virtual NICs for Guest LAN and
+	  VSWITCH.
 
 	  To compile this driver as a module, choose M.
 	  The module name is qeth.
-- 
2.17.1
