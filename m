Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32408 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726491AbgDFHlY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Apr 2020 03:41:24 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0367ZHim035549
        for <linux-s390@vger.kernel.org>; Mon, 6 Apr 2020 03:41:23 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 306mjcbwks-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 06 Apr 2020 03:41:23 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <sth@linux.ibm.com>;
        Mon, 6 Apr 2020 08:41:04 +0100
From: Stefan Haberland <sth@linux.ibm.com>
Subject: [PATCH 1/1] s390: Cleanup removed IOSCHED_DEADLINE
Date: Mon,  6 Apr 2020 09:41:18 +0200
In-Reply-To: <20200406074118.86849-1-sth@linux.ibm.com>
References: <20200406074118.86849-1-sth@linux.ibm.com>
Message-Id: <20200406074118.86849-2-sth@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com

From: Krzysztof Kozlowski <krzk@kernel.org>

CONFIG_IOSCHED_DEADLINE is gone since commit f382fb0bcef4 ("block:
remove legacy IO schedulers").

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/block/Kconfig b/drivers/s390/block/Kconfig
index a8682f69effc..1f06b19cb290 100644
--- a/drivers/s390/block/Kconfig
+++ b/drivers/s390/block/Kconfig
@@ -26,7 +26,7 @@ config DASD
 	def_tristate y
 	prompt "Support for DASD devices"
 	depends on CCW && BLOCK
-	select IOSCHED_DEADLINE
+	select MQ_IOSCHED_DEADLINE
 	help
 	  Enable this option if you want to access DASDs directly utilizing
 	  S/390s channel subsystem commands. This is necessary for running
-- 
2.17.1
