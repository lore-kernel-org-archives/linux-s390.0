Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40892 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726039AbgGCNVF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Jul 2020 09:21:05 -0400
From: Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH 3/7] scsi: docs: update outdated link to IBM developerworks
Date: Fri,  3 Jul 2020 15:19:59 +0200
Message-Id: <9ab0341d6ddca46cfc885e4cd9dc38f535969b02.1593780621.git.bblock@linux.ibm.com>
In-Reply-To: <cover.1593780621.git.bblock@linux.ibm.com>
References: <cover.1593780621.git.bblock@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Benjamin Block <bblock@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fedor Loshakov <loshakov@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, linux-doc@vger.kernel.org

IBM decided to retire a lot of the content that was previously hosted on
"developerworks", and so some of the links we've used for documentation
are now dead or redirect to some general landing page with no
correlation to what the links were meant to provide.

The s390-tools package is meanwhile also hosted on github, so we can
link to the script directly instead of to the archive.

Reviewed-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Steffen Maier <maier@linux.ibm.com>
Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
---
 Documentation/scsi/scsi-parameters.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/scsi/scsi-parameters.rst b/Documentation/scsi/scsi-parameters.rst
index 9aba897c97ac..e5f68b431f5c 100644
--- a/Documentation/scsi/scsi-parameters.rst
+++ b/Documentation/scsi/scsi-parameters.rst
@@ -94,7 +94,7 @@ parameters may be changed at runtime by the command
 			(/proc/sys/dev/scsi/logging_level).
 			There is also a nice 'scsi_logging_level' script in the
 			S390-tools package, available for download at
-			http://www-128.ibm.com/developerworks/linux/linux390/s390-tools-1.5.4.html
+			https://github.com/ibm-s390-tools/s390-tools/blob/master/scripts/scsi_logging_level
 
 	scsi_mod.scan=	[SCSI] sync (default) scans SCSI busses as they are
 			discovered.  async scans them in kernel threads,
-- 
2.26.2
