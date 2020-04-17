Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5038 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728094AbgDQJsm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 17 Apr 2020 05:48:42 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03H9aoBH013584
        for <linux-s390@vger.kernel.org>; Fri, 17 Apr 2020 05:48:41 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30f9f6rx82-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 17 Apr 2020 05:48:41 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <sth@linux.ibm.com>;
        Fri, 17 Apr 2020 10:48:35 +0100
From: Stefan Haberland <sth@linux.ibm.com>
Subject: [PATCH 1/1] s390/dasd: remove IOSCHED_DEADLINE from DASD Kconfig
Date: Fri, 17 Apr 2020 11:48:35 +0200
In-Reply-To: <20200417094835.60247-1-sth@linux.ibm.com>
References: <20200417094835.60247-1-sth@linux.ibm.com>
Message-Id: <20200417094835.60247-2-sth@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com

CONFIG_IOSCHED_DEADLINE was removed with
commit f382fb0bcef4 ("block: remove legacy IO schedulers")

and setting of the scheduler was removed with
commit a5fd8ddce2af ("s390/dasd: remove setting of scheduler from driver").

So get rid of the select.

Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/s390/block/Kconfig b/drivers/s390/block/Kconfig
index a8682f69effc..376f1efbbb86 100644
--- a/drivers/s390/block/Kconfig
+++ b/drivers/s390/block/Kconfig
@@ -26,7 +26,6 @@ config DASD
 	def_tristate y
 	prompt "Support for DASD devices"
 	depends on CCW && BLOCK
-	select IOSCHED_DEADLINE
 	help
 	  Enable this option if you want to access DASDs directly utilizing
 	  S/390s channel subsystem commands. This is necessary for running
-- 
2.17.1
