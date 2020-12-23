Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730041AbgLWCXi (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 22 Dec 2020 21:23:38 -0500
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 24/66] s390/dasd: Fix operational path inconsistency
Date: Tue, 22 Dec 2020 21:22:10 -0500
Message-Id: <20201223022253.2793452-24-sashal@kernel.org>
In-Reply-To: <20201223022253.2793452-1-sashal@kernel.org>
References: <20201223022253.2793452-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: =?UTF-8?q?Jan=20H=C3=B6ppner?= <hoeppner@linux.ibm.com>, Stefan Haberland <sth@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org

From: Jan Höppner <hoeppner@linux.ibm.com>

[ Upstream commit 9e34c8ba91697cb7441805c36d92ab3e695df6e0 ]

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

Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/block/dasd_eckd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index aa651403546ff..8769b90c49a30 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -979,6 +979,7 @@ static void dasd_eckd_clear_conf_data(struct dasd_device *device)
 		device->path[i].cssid = 0;
 		device->path[i].ssid = 0;
 		device->path[i].chpid = 0;
+		dasd_path_notoper(device, i);
 	}
 }
 
-- 
2.27.0
