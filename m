Return-Path: <netdev-owner@vger.kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 2/2] MAINTAINERS: add Karsten Graul as S390 NETWORK DRIVERS maintainer
Date: Wed, 13 May 2020 09:42:30 +0200
Message-Id: <20200513074230.967-3-ubraun@linux.ibm.com>
In-Reply-To: <20200513074230.967-1-ubraun@linux.ibm.com>
References: <20200513074230.967-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, kgraul@linux.ibm.com, weiyongjun1@huawei.com, ubraun@linux.ibm.com

Add Karsten as additional maintainer for drivers/s390/net .
One of his focal points is the ism driver.

Cc: Julian Wiedmann <jwi@linux.ibm.com>
Acked-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 88bf36ab2b22..85894787825e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14644,6 +14644,7 @@ F:	drivers/iommu/s390-iommu.c
 
 S390 IUCV NETWORK LAYER
 M:	Julian Wiedmann <jwi@linux.ibm.com>
+M:	Karsten Graul <kgraul@linux.ibm.com>
 M:	Ursula Braun <ubraun@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
 S:	Supported
-- 
2.17.1
