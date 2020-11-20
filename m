Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH] scsi: zfcp: fix use-after-free in zfcp_sysfs_port_remove_store
Date: Fri, 20 Nov 2020 15:48:53 +0800
Message-ID: <20201120074853.31706-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-s390.vger.kernel.org>
To: Steffen Maier <maier@linux.ibm.com>, Benjamin Block <bblock@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Qinglang Miao <miaoqinglang@huawei.com>

kfree(port) is called in put_device(&port->dev) so that following
use would cause use-after-free bug.

the former put_device is redundant for device_unregister contains
put_device already. So just remove it to fix this.

Fixes: 83d4e1c33d93 ("[SCSI] zfcp: cleanup port sysfs attribute usage")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/s390/scsi/zfcp_sysfs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_sysfs.c b/drivers/s390/scsi/zfcp_sysfs.c
index 8d9662e8b..06285e452 100644
--- a/drivers/s390/scsi/zfcp_sysfs.c
+++ b/drivers/s390/scsi/zfcp_sysfs.c
@@ -327,8 +327,6 @@ static ssize_t zfcp_sysfs_port_remove_store(struct device *dev,
 	list_del(&port->list);
 	write_unlock_irq(&adapter->port_list_lock);
 
-	put_device(&port->dev);
-
 	zfcp_erp_port_shutdown(port, 0, "syprs_1");
 	device_unregister(&port->dev);
  out:
-- 
2.23.0
