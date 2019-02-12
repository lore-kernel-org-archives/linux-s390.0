Return-Path: <SRS0=RTe9=QT=vger.kernel.org=netdev-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 7/7] MAINTAINERS: add Karsten as SMC maintainer
Date: Tue, 12 Feb 2019 16:29:56 +0100
In-Reply-To: <20190212152956.71041-1-ubraun@linux.ibm.com>
References: <20190212152956.71041-1-ubraun@linux.ibm.com>
Message-Id: <20190212152956.71041-8-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Add Karsten as additional maintainer for Shared Memory Communications
(SMC) Sockets.

Acked-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 604bca2fc05d..f3af5cde6456 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13760,6 +13760,7 @@ F:	drivers/misc/sgi-xp/
 
 SHARED MEMORY COMMUNICATIONS (SMC) SOCKETS
 M:	Ursula Braun <ubraun@linux.ibm.com>
+M:	Karsten Graul <kgraul@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
 W:	http://www.ibm.com/developerworks/linux/linux390/
 S:	Supported
-- 
2.16.4
