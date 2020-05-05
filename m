Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39604 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728660AbgEEM1v (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 May 2020 08:27:51 -0400
From: Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v4 1/8] vfio-ccw: Introduce new helper functions to free/destroy regions
Date: Tue,  5 May 2020 14:27:38 +0200
Message-Id: <20200505122745.53208-2-farman@linux.ibm.com>
In-Reply-To: <20200505122745.53208-1-farman@linux.ibm.com>
References: <20200505122745.53208-1-farman@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>

From: Farhan Ali <alifm@linux.ibm.com>

Consolidate some of the cleanup code for the regions, so that
as more are added we reduce code duplication.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---

Notes:
    v1->v2:
     - Add Conny's r-b
    
    v0->v1: [EF]
     - Commit message

 drivers/s390/cio/vfio_ccw_drv.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 339a6bc0339b..8715c1c2f1e1 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -116,6 +116,14 @@ static void vfio_ccw_sch_irq(struct subchannel *sch)
 	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_INTERRUPT);
 }
 
+static void vfio_ccw_free_regions(struct vfio_ccw_private *private)
+{
+	if (private->cmd_region)
+		kmem_cache_free(vfio_ccw_cmd_region, private->cmd_region);
+	if (private->io_region)
+		kmem_cache_free(vfio_ccw_io_region, private->io_region);
+}
+
 static int vfio_ccw_sch_probe(struct subchannel *sch)
 {
 	struct pmcw *pmcw = &sch->schib.pmcw;
@@ -181,10 +189,7 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
 	cio_disable_subchannel(sch);
 out_free:
 	dev_set_drvdata(&sch->dev, NULL);
-	if (private->cmd_region)
-		kmem_cache_free(vfio_ccw_cmd_region, private->cmd_region);
-	if (private->io_region)
-		kmem_cache_free(vfio_ccw_io_region, private->io_region);
+	vfio_ccw_free_regions(private);
 	kfree(private->cp.guest_cp);
 	kfree(private);
 	return ret;
@@ -200,8 +205,7 @@ static int vfio_ccw_sch_remove(struct subchannel *sch)
 
 	dev_set_drvdata(&sch->dev, NULL);
 
-	kmem_cache_free(vfio_ccw_cmd_region, private->cmd_region);
-	kmem_cache_free(vfio_ccw_io_region, private->io_region);
+	vfio_ccw_free_regions(private);
 	kfree(private->cp.guest_cp);
 	kfree(private);
 
@@ -304,6 +308,12 @@ static void vfio_ccw_debug_exit(void)
 	debug_unregister(vfio_ccw_debug_trace_id);
 }
 
+static void vfio_ccw_destroy_regions(void)
+{
+	kmem_cache_destroy(vfio_ccw_cmd_region);
+	kmem_cache_destroy(vfio_ccw_io_region);
+}
+
 static int __init vfio_ccw_sch_init(void)
 {
 	int ret;
@@ -346,8 +356,7 @@ static int __init vfio_ccw_sch_init(void)
 	return ret;
 
 out_err:
-	kmem_cache_destroy(vfio_ccw_cmd_region);
-	kmem_cache_destroy(vfio_ccw_io_region);
+	vfio_ccw_destroy_regions();
 	destroy_workqueue(vfio_ccw_work_q);
 	vfio_ccw_debug_exit();
 	return ret;
@@ -357,8 +366,7 @@ static void __exit vfio_ccw_sch_exit(void)
 {
 	css_driver_unregister(&vfio_ccw_sch_driver);
 	isc_unregister(VFIO_CCW_ISC);
-	kmem_cache_destroy(vfio_ccw_io_region);
-	kmem_cache_destroy(vfio_ccw_cmd_region);
+	vfio_ccw_destroy_regions();
 	destroy_workqueue(vfio_ccw_work_q);
 	vfio_ccw_debug_exit();
 }
-- 
2.17.1
