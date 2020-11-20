Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH] scsi: zfcp: fix use-after-free in zfcp_unit_remove
Date: Fri, 20 Nov 2020 15:48:54 +0800
Message-ID: <20201120074854.31754-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-s390.vger.kernel.org>
To: Steffen Maier <maier@linux.ibm.com>, Benjamin Block <bblock@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Qinglang Miao <miaoqinglang@huawei.com>

kfree(port) is called in put_device(&port->dev) so that following
use would cause use-after-free bug.

The former put_device is redundant for device_unregister contains
put_device already. So just remove it to fix this.

Fixes: 86bdf218a717 ("[SCSI] zfcp: cleanup unit sysfs attribute usage")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/s390/scsi/zfcp_unit.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_unit.c b/drivers/s390/scsi/zfcp_unit.c
index e67bf7388..664b77853 100644
--- a/drivers/s390/scsi/zfcp_unit.c
+++ b/drivers/s390/scsi/zfcp_unit.c
@@ -255,8 +255,6 @@ int zfcp_unit_remove(struct zfcp_port *port, u64 fcp_lun)
 		scsi_device_put(sdev);
 	}
 
-	put_device(&unit->dev);
-
 	device_unregister(&unit->dev);
 
 	return 0;
-- 
2.23.0
