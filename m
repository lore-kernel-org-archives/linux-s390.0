Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH] scsi: zfcp: move the position of put_device
Date: Mon, 30 Nov 2020 20:11:49 +0800
Message-ID: <20201130121149.194131-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-s390.vger.kernel.org>
To: Steffen Maier <maier@linux.ibm.com>, Benjamin Block <bblock@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Qinglang Miao <miaoqinglang@huawei.com>

Have the `put_device()` call after `device_unregister()` in both
`zfcp_unit_remove()` and `zfcp_sysfs_port_remove_store()` to make
it more natural, for put_device() ought to be the last time we
touch the object in both functions.

Suggested-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/s390/scsi/zfcp_sysfs.c | 4 ++--
 drivers/s390/scsi/zfcp_unit.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_sysfs.c b/drivers/s390/scsi/zfcp_sysfs.c
index 8d9662e8b..edfeed4ba 100644
--- a/drivers/s390/scsi/zfcp_sysfs.c
+++ b/drivers/s390/scsi/zfcp_sysfs.c
@@ -327,10 +327,10 @@ static ssize_t zfcp_sysfs_port_remove_store(struct device *dev,
 	list_del(&port->list);
 	write_unlock_irq(&adapter->port_list_lock);
 
-	put_device(&port->dev);
-
 	zfcp_erp_port_shutdown(port, 0, "syprs_1");
 	device_unregister(&port->dev);
+
+	put_device(&port->dev);
  out:
 	zfcp_ccw_adapter_put(adapter);
 	return retval ? retval : (ssize_t) count;
diff --git a/drivers/s390/scsi/zfcp_unit.c b/drivers/s390/scsi/zfcp_unit.c
index e67bf7388..4ee355ae1 100644
--- a/drivers/s390/scsi/zfcp_unit.c
+++ b/drivers/s390/scsi/zfcp_unit.c
@@ -255,9 +255,9 @@ int zfcp_unit_remove(struct zfcp_port *port, u64 fcp_lun)
 		scsi_device_put(sdev);
 	}
 
-	put_device(&unit->dev);
-
 	device_unregister(&unit->dev);
 
+	put_device(&unit->dev);
+
 	return 0;
 }
-- 
2.23.0
