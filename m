From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net 3/3] MAINTAINERS: add Julian Wiedmann
Date: Thu, 23 Mar 2017 14:55:10 +0100
Message-ID: <20170323135510.98972-4-ubraun@linux.vnet.ibm.com>
References: <20170323135510.98972-1-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170323135510.98972-1-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, jwi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Add Julian Wiedmann as additional maintainer for drivers/s390/net
and net/iucv.

Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c45c02b..e48678d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10808,6 +10808,7 @@ F:	drivers/s390/block/dasd*
 F:	block/partitions/ibm.c
 
 S390 NETWORK DRIVERS
+M:	Julian Wiedmann <jwi@linux.vnet.ibm.com>
 M:	Ursula Braun <ubraun@linux.vnet.ibm.com>
 L:	linux-s390@vger.kernel.org
 W:	http://www.ibm.com/developerworks/linux/linux390/
@@ -10838,6 +10839,7 @@ S:	Supported
 F:	drivers/s390/scsi/zfcp_*
 
 S390 IUCV NETWORK LAYER
+M:	Julian Wiedmann <jwi@linux.vnet.ibm.com>
 M:	Ursula Braun <ubraun@linux.vnet.ibm.com>
 L:	linux-s390@vger.kernel.org
 W:	http://www.ibm.com/developerworks/linux/linux390/
-- 
2.8.4
