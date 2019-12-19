Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19256 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726622AbfLSIoA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 19 Dec 2019 03:44:00 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBJ8gW7L146064
        for <linux-s390@vger.kernel.org>; Thu, 19 Dec 2019 03:43:58 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wyhccs33c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 19 Dec 2019 03:43:58 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <sth@linux.ibm.com>;
        Thu, 19 Dec 2019 08:43:56 -0000
From: Stefan Haberland <sth@linux.ibm.com>
Subject: [PATCH 3/3] s390/dasd: fix typo in copyright statement
Date: Thu, 19 Dec 2019 09:43:52 +0100
In-Reply-To: <20191219084352.75114-1-sth@linux.ibm.com>
References: <20191219084352.75114-1-sth@linux.ibm.com>
Message-Id: <20191219084352.75114-4-sth@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com

coypright -> copyright

Reported-by: Kate Stewart <kstewart@linuxfoundation.org>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_fba.h  | 2 +-
 drivers/s390/block/dasd_proc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/block/dasd_fba.h b/drivers/s390/block/dasd_fba.h
index 8f75df06e893..45ddabec4017 100644
--- a/drivers/s390/block/dasd_fba.h
+++ b/drivers/s390/block/dasd_fba.h
@@ -2,7 +2,7 @@
 /*
  * Author(s)......: Holger Smolinski <Holger.Smolinski@de.ibm.com>
  * Bugreports.to..: <Linux390@de.ibm.com>
- * Coypright IBM Corp. 1999, 2000
+ * Copyright IBM Corp. 1999, 2000
  *
  */
 
diff --git a/drivers/s390/block/dasd_proc.c b/drivers/s390/block/dasd_proc.c
index 1770b99f607e..8d4d69ea5baf 100644
--- a/drivers/s390/block/dasd_proc.c
+++ b/drivers/s390/block/dasd_proc.c
@@ -5,7 +5,7 @@
  *		    Carsten Otte <Cotte@de.ibm.com>
  *		    Martin Schwidefsky <schwidefsky@de.ibm.com>
  * Bugreports.to..: <Linux390@de.ibm.com>
- * Coypright IBM Corp. 1999, 2002
+ * Copyright IBM Corp. 1999, 2002
  *
  * /proc interface for the dasd driver.
  *
-- 
2.17.1
