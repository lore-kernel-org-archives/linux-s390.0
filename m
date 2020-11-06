Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 2/2] MAINTAINERS: remove Ursula Braun as s390 network maintainer
Date: Fri,  6 Nov 2020 13:50:08 +0100
Message-Id: <20201106125008.36478-3-jwi@linux.ibm.com>
In-Reply-To: <20201106125008.36478-1-jwi@linux.ibm.com>
References: <20201106125008.36478-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>

From: Ursula Braun <ubraun@linux.ibm.com>

I am retiring soon. Thus this patch removes myself from the
MAINTAINERS file (s390 network).

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
[jwi: fix up the subject]
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 MAINTAINERS | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e73636b75f29..d4462d7e2077 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15259,7 +15259,6 @@ F:	drivers/iommu/s390-iommu.c
 S390 IUCV NETWORK LAYER
 M:	Julian Wiedmann <jwi@linux.ibm.com>
 M:	Karsten Graul <kgraul@linux.ibm.com>
-M:	Ursula Braun <ubraun@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
 S:	Supported
 W:	http://www.ibm.com/developerworks/linux/linux390/
@@ -15270,7 +15269,6 @@ F:	net/iucv/
 S390 NETWORK DRIVERS
 M:	Julian Wiedmann <jwi@linux.ibm.com>
 M:	Karsten Graul <kgraul@linux.ibm.com>
-M:	Ursula Braun <ubraun@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
 S:	Supported
 W:	http://www.ibm.com/developerworks/linux/linux390/
@@ -15844,7 +15842,6 @@ S:	Maintained
 F:	drivers/misc/sgi-xp/
 
 SHARED MEMORY COMMUNICATIONS (SMC) SOCKETS
-M:	Ursula Braun <ubraun@linux.ibm.com>
 M:	Karsten Graul <kgraul@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
 S:	Supported
-- 
2.17.1
