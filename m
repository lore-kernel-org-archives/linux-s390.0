Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41122 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727016AbgIJQtV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Sep 2020 12:49:21 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 08/10] s390/net: add SMC config as one of the defaults of CCWGROUP
Date: Thu, 10 Sep 2020 18:48:27 +0200
Message-Id: <20200910164829.65426-9-kgraul@linux.ibm.com>
In-Reply-To: <20200910164829.65426-1-kgraul@linux.ibm.com>
References: <20200910164829.65426-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Guvenc Gulce <guvenc@linux.ibm.com>

arch/s390/net/pnet.c uses ccwgroup function dev_is_ccwgroup()
in pnetid_by_dev_port().
For s390 the net/smc code makes use of function pnetid_by_dev_port().
Make sure ccwgroup is built into the kernel, if smc is to be built
into the kernel.

Signed-off-by: Guvenc Gulce <guvenc@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 drivers/s390/net/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/Kconfig b/drivers/s390/net/Kconfig
index 53120e68796e..bf236d474538 100644
--- a/drivers/s390/net/Kconfig
+++ b/drivers/s390/net/Kconfig
@@ -107,7 +107,7 @@ config QETH_OSX
 
 config CCWGROUP
 	tristate
-	default (LCS || CTCM || QETH)
+	default (LCS || CTCM || QETH || SMC)
 
 config ISM
 	tristate "Support for ISM vPCI Adapter"
-- 
2.17.1
