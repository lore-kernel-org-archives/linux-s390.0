Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55084 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726347AbgGCNV1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Jul 2020 09:21:27 -0400
From: Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH 4/7] scsi: docs: remove invalid link and update text for zfcp kernel config
Date: Fri,  3 Jul 2020 15:20:00 +0200
Message-Id: <96069b9f4c4f056a515b37e89b2bdfccc282e3d3.1593780621.git.bblock@linux.ibm.com>
In-Reply-To: <cover.1593780621.git.bblock@linux.ibm.com>
References: <cover.1593780621.git.bblock@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Benjamin Block <bblock@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fedor Loshakov <loshakov@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org

IBM decided to retire a lot of the content that was previously hosted on
"developerworks", and so some of the links we've used for documentation
are now dead or redirect to some general landing page with no correlation
to what the links were meant to provide.

Change the provided link in the Kconfig file for zfcp to rather refer to
our device drivers book that we regularly update and publish for free,
and whose name hasn't been changed since it was first published.

Our hardware is also not called "IBM eServer zSeries" anymore - in fact,
it hasn't been called like that since 2006. Use a broader term that
covers different server names over time.

Lastly, add a short paragraph about how our HBAs are typically named, to
have some more tangible references.

Reviewed-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Steffen Maier <maier@linux.ibm.com>
Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
---
 drivers/scsi/Kconfig | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index e9ff4cd5fbe9..571473a58f98 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -1469,14 +1469,19 @@ config SCSI_SUNESP
 	  module will be called sun_esp.
 
 config ZFCP
-	tristate "FCP host bus adapter driver for IBM eServer zSeries"
+	tristate "FCP host bus adapter driver for IBM mainframes"
 	depends on S390 && QDIO && SCSI
 	depends on SCSI_FC_ATTRS
 	help
-          If you want to access SCSI devices attached to your IBM eServer
-          zSeries by means of Fibre Channel interfaces say Y.
-          For details please refer to the documentation provided by IBM at
-          <http://oss.software.ibm.com/developerworks/opensource/linux390>
+	  If you want to access SCSI devices attached to your IBM mainframe by
+	  means of Fibre Channel Protocol host bus adapters say Y.
+
+	  Supported HBAs include different models of the FICON Express and FCP
+	  Express I/O cards.
+
+	  For a more complete list, and for more details about setup and
+	  operation refer to the IBM publication "Device Drivers, Features, and
+	  Commands", SC33-8411.
 
           This driver is also available as a module. This module will be
           called zfcp. If you want to compile it as a module, say M here
-- 
2.26.2
