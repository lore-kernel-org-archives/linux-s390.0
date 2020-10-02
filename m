Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44460 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725283AbgJBTyy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 2 Oct 2020 15:54:54 -0400
From: Stefan Haberland <sth@linux.ibm.com>
Subject: [PATCH 07/10] s390/dasd: Fix operational path inconsistency
Date: Fri,  2 Oct 2020 21:39:37 +0200
Message-Id: <20201002193940.24012-8-sth@linux.ibm.com>
In-Reply-To: <20201002193940.24012-1-sth@linux.ibm.com>
References: <20201002193940.24012-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com

From: Jan Höppner <hoeppner@linux.ibm.com>

During online processing and setting up a DASD device, the configuration
data for operational paths is read and validated two times
(dasd_eckd_read_conf()). The first time to provide information that are
necessary for the LCU setup. A second time after the LCU setup as a
device might report different configuration data then.

When the configuration setup for each operational path is being
validated, an initial call to dasd_eckd_clear_conf_data() is issued.
This call wipes all previously available configuration data and path
information for each path.
However, the operational path mask is not updated during this process.

As a result, the stored operational path mask might no longer correspond
to the operational paths mask reported by the CIO layer, as several
paths might be gone between the two dasd_eckd_read_conf() calls.

This inconsistency leads to more severe issues in later path handling
changes. Fix this by removing the channel paths from the operational
path mask during the dasd_eckd_clear_conf_data() call.

Reference-ID: IO1812
Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 274f79869b7c..271768e4606c 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -1029,6 +1029,7 @@ static void dasd_eckd_clear_conf_data(struct dasd_device *device)
 		device->path[i].cssid = 0;
 		device->path[i].ssid = 0;
 		device->path[i].chpid = 0;
+		dasd_path_notoper(device, i);
 	}
 }
 
-- 
2.17.1
