Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 31 Aug 2016 01:57:20 +0530
From: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Subject: [PATCH] s390: Remove deprecated create_singlethread_workqueue
Message-ID: <20160830202720.GA31494@Karyakshetra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Steffen Maier <maier@linux.vnet.ibm.com>
Cc: Tejun Heo <tj@kernel.org>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The workqueue "appldata_wq" has been replaced with an ordered dedicated
workqueue.

WQ_MEM_RECLAIM has not been set since the workqueue is not being used on
a memory reclaim path.

The adapter->work_queue queues multiple work items viz
&adapter->scan_work, &port->rport_work, &adapter->ns_up_work,
&adapter->stat_work, adapter->work_queue, &adapter->events.work,
&port->gid_pn_work, &port->test_link_work. Hence, an ordered
dedicated workqueue has been used.

WQ_MEM_RECLAIM has been set to ensure forward progress under memory
pressure.

Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
---
 arch/s390/appldata/appldata_base.c | 2 +-
 drivers/s390/scsi/zfcp_aux.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/appldata/appldata_base.c b/arch/s390/appldata/appldata_base.c
index 15c9424..f587c48 100644
--- a/arch/s390/appldata/appldata_base.c
+++ b/arch/s390/appldata/appldata_base.c
@@ -542,7 +542,7 @@ static int __init appldata_init(void)
 		rc = PTR_ERR(appldata_pdev);
 		goto out_driver;
 	}
-	appldata_wq = create_singlethread_workqueue("appldata");
+	appldata_wq = alloc_ordered_workqueue("appldata", 0);
 	if (!appldata_wq) {
 		rc = -ENOMEM;
 		goto out_device;
diff --git a/drivers/s390/scsi/zfcp_aux.c b/drivers/s390/scsi/zfcp_aux.c
index c00ac46..bcc8f3d 100644
--- a/drivers/s390/scsi/zfcp_aux.c
+++ b/drivers/s390/scsi/zfcp_aux.c
@@ -310,7 +310,7 @@ static int zfcp_setup_adapter_work_queue(struct zfcp_adapter *adapter)

 	snprintf(name, sizeof(name), "zfcp_q_%s",
 		 dev_name(&adapter->ccw_device->dev));
-	adapter->work_queue = create_singlethread_workqueue(name);
+	adapter->work_queue = alloc_ordered_workqueue(name, WQ_MEM_RECLAIM);

 	if (adapter->work_queue)
 		return 0;
--
2.1.4
