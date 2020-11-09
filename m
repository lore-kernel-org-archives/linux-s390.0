Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43690 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729637AbgKIH5W (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Nov 2020 02:57:22 -0500
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net v2 2/2] MAINTAINERS: remove Ursula Braun as s390 network maintainer
Date: Mon,  9 Nov 2020 08:57:06 +0100
Message-Id: <20201109075706.56573-3-jwi@linux.ibm.com>
In-Reply-To: <20201109075706.56573-1-jwi@linux.ibm.com>
References: <20201109075706.56573-1-jwi@linux.ibm.com>
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
index cd123d0a6a2d..fa11fe773df5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15246,7 +15246,6 @@ F:	drivers/iommu/s390-iommu.c
 S390 IUCV NETWORK LAYER
 M:	Julian Wiedmann <jwi@linux.ibm.com>
 M:	Karsten Graul <kgraul@linux.ibm.com>
-M:	Ursula Braun <ubraun@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
 S:	Supported
 W:	http://www.ibm.com/developerworks/linux/linux390/
@@ -15257,7 +15256,6 @@ F:	net/iucv/
 S390 NETWORK DRIVERS
 M:	Julian Wiedmann <jwi@linux.ibm.com>
 M:	Karsten Graul <kgraul@linux.ibm.com>
-M:	Ursula Braun <ubraun@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
 S:	Supported
 W:	http://www.ibm.com/developerworks/linux/linux390/
@@ -15828,7 +15826,6 @@ S:	Maintained
 F:	drivers/misc/sgi-xp/
 
 SHARED MEMORY COMMUNICATIONS (SMC) SOCKETS
-M:	Ursula Braun <ubraun@linux.ibm.com>
 M:	Karsten Graul <kgraul@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
 S:	Supported
-- 
2.17.1
