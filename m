Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1928 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727896AbgEHRXs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 8 May 2020 13:23:48 -0400
From: Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH 7/8] zfcp: fence early sysfs interfaces for accesses of shost objects
Date: Fri,  8 May 2020 19:23:34 +0200
Message-Id: <ef65366d309993ca91b6917727590ca7ca166c8f.1588956679.git.bblock@linux.ibm.com>
In-Reply-To: <cover.1588956679.git.bblock@linux.ibm.com>
References: <cover.1588956679.git.bblock@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Benjamin Block <bblock@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fedor Loshakov <loshakov@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org

When setting an adapter online for the first time, we also create a
couple of entries for it in the sysfs device tree. This is also true
even if the adapter has not yet ever gone successfully through exchange
config and exchange port data.

When moving the scsi host object allocation and registration to after
the first exchange config and exchange port data, this make
the `port_rescan` attribute susceptible to invalid pointer-dereferences
of the shost field before the adapter is fully initialized.

When written to, it schedules a `scan_work` item that will in turn make
use of the associated fibre channel host object to check the topology
used for this FCP device.

Because scanning for remote ports can't be done successfully without
completing exchange config and exchange port data first, we can simply
fence `port_rescan`, and so prevent the illegal access.

As with cases where we can't get a reference to the adapter, we also
return -ENODEV here. Applications need to handle that errno today
already.

After a successful allocation of the scsi host object nothing changes in
the work flow.

Reviewed-by: Steffen Maier <maier@linux.ibm.com>
Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_sysfs.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_sysfs.c b/drivers/s390/scsi/zfcp_sysfs.c
index 7ec30ded0169..8d9662e8b717 100644
--- a/drivers/s390/scsi/zfcp_sysfs.c
+++ b/drivers/s390/scsi/zfcp_sysfs.c
@@ -216,10 +216,22 @@ static ssize_t zfcp_sysfs_port_rescan_store(struct device *dev,
 {
 	struct ccw_device *cdev = to_ccwdev(dev);
 	struct zfcp_adapter *adapter = zfcp_ccw_adapter_by_cdev(cdev);
+	int retval = 0;
 
 	if (!adapter)
 		return -ENODEV;
 
+	/*
+	 * If `scsi_host` is missing, we can't schedule `scan_work`, as it
+	 * makes use of the corresponding fc_host object. But this state is
+	 * only possible if xconfig/xport data has never completed yet,
+	 * and we couldn't successfully scan for ports anyway.
+	 */
+	if (adapter->scsi_host == NULL) {
+		retval = -ENODEV;
+		goto out;
+	}
+
 	/*
 	 * Users wish is our command: immediately schedule and flush a
 	 * worker to conduct a synchronous port scan, that is, neither
@@ -227,9 +239,9 @@ static ssize_t zfcp_sysfs_port_rescan_store(struct device *dev,
 	 */
 	queue_delayed_work(adapter->work_queue, &adapter->scan_work, 0);
 	flush_delayed_work(&adapter->scan_work);
+out:
 	zfcp_ccw_adapter_put(adapter);
-
-	return (ssize_t) count;
+	return retval ? retval : (ssize_t) count;
 }
 static ZFCP_DEV_ATTR(adapter, port_rescan, S_IWUSR, NULL,
 		     zfcp_sysfs_port_rescan_store);
-- 
2.17.1
