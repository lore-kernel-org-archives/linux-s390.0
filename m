Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18324 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727512AbgBFVid (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 6 Feb 2020 16:38:33 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 016LbrnH096268
        for <linux-s390@vger.kernel.org>; Thu, 6 Feb 2020 16:38:32 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xyhmjpwxj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 06 Feb 2020 16:38:32 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <farman@linux.ibm.com>;
        Thu, 6 Feb 2020 21:38:30 -0000
From: Eric Farman <farman@linux.ibm.com>
Subject: [RFC PATCH v2 7/9] vfio-ccw: Wire up the CRW irq and CRW region
Date: Thu,  6 Feb 2020 22:38:23 +0100
In-Reply-To: <20200206213825.11444-1-farman@linux.ibm.com>
References: <20200206213825.11444-1-farman@linux.ibm.com>
Message-Id: <20200206213825.11444-8-farman@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

From: Farhan Ali <alifm@linux.ibm.com>

Use an IRQ to notify userspace that there is a CRW
pending in the region, related to path-availability
changes on the passthrough subchannel.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---

Notes:
    v1->v2:
     - Remove extraneous 0x0 in crw.rsid assignment [CH]
     - Refactor the building/queueing of a crw into its own routine [EF]
    
    v0->v1: [EF]
     - Place the non-refactoring changes from the previous patch here
     - Clean up checkpatch (whitespace) errors
     - s/chp_crw/crw/
     - Move acquire/release of io_mutex in vfio_ccw_crw_region_read()
       into patch that introduces that region
     - Remove duplicate include from vfio_ccw_drv.c
     - Reorder include in vfio_ccw_private.h

 drivers/s390/cio/vfio_ccw_chp.c     |  5 ++
 drivers/s390/cio/vfio_ccw_drv.c     | 73 +++++++++++++++++++++++++++++
 drivers/s390/cio/vfio_ccw_ops.c     |  4 ++
 drivers/s390/cio/vfio_ccw_private.h |  9 ++++
 include/uapi/linux/vfio.h           |  1 +
 5 files changed, 92 insertions(+)

diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_chp.c
index 8fde94552149..328b4e1d1972 100644
--- a/drivers/s390/cio/vfio_ccw_chp.c
+++ b/drivers/s390/cio/vfio_ccw_chp.c
@@ -98,6 +98,11 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_ccw_private *private,
 		ret = count;
 
 	mutex_unlock(&private->io_mutex);
+
+	/* Notify the guest if more CRWs are on our queue */
+	if (!list_empty(&private->crw) && private->crw_trigger)
+		eventfd_signal(private->crw_trigger, 1);
+
 	return ret;
 }
 
diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 1e1360af1b34..c48c260a129d 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -108,6 +108,31 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
 		eventfd_signal(private->io_trigger, 1);
 }
 
+static void vfio_ccw_crw_todo(struct work_struct *work)
+{
+	struct vfio_ccw_private *private;
+	struct vfio_ccw_crw *crw;
+
+	private = container_of(work, struct vfio_ccw_private, crw_work);
+
+	/* FIXME Ugh, need better control of this list */
+	crw = list_first_entry_or_null(&private->crw,
+				       struct vfio_ccw_crw, next);
+
+	if (crw) {
+		list_del(&crw->next);
+
+		mutex_lock(&private->io_mutex);
+		memcpy(&private->crw_region->crw0, crw->crw, sizeof(*crw->crw));
+		mutex_unlock(&private->io_mutex);
+
+		kfree(crw);
+
+		if (private->crw_trigger)
+			eventfd_signal(private->crw_trigger, 1);
+	}
+}
+
 /*
  * Css driver callbacks
  */
@@ -186,7 +211,9 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
 	if (ret)
 		goto out_free;
 
+	INIT_LIST_HEAD(&private->crw);
 	INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
+	INIT_WORK(&private->crw_work, vfio_ccw_crw_todo);
 	atomic_set(&private->avail, 1);
 	private->state = VFIO_CCW_STATE_STANDBY;
 
@@ -212,9 +239,15 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
 static int vfio_ccw_sch_remove(struct subchannel *sch)
 {
 	struct vfio_ccw_private *private = dev_get_drvdata(&sch->dev);
+	struct vfio_ccw_crw *crw, *temp;
 
 	vfio_ccw_sch_quiesce(sch);
 
+	list_for_each_entry_safe(crw, temp, &private->crw, next) {
+		list_del(&crw->next);
+		kfree(crw);
+	}
+
 	vfio_ccw_mdev_unreg(sch);
 
 	dev_set_drvdata(&sch->dev, NULL);
@@ -276,6 +309,44 @@ static int vfio_ccw_sch_event(struct subchannel *sch, int process)
 	return rc;
 }
 
+static void vfio_ccw_alloc_crw(struct vfio_ccw_private *private,
+			       struct chp_link *link,
+			       unsigned int erc)
+{
+	struct vfio_ccw_crw *vc_crw;
+	struct crw *crw;
+
+	/*
+	 * If unable to allocate a CRW, just drop the event and
+	 * carry on.  The guest will either see a later one or
+	 * learn when it issues its own store subchannel.
+	 */
+	vc_crw = kzalloc(sizeof(*vc_crw), GFP_ATOMIC);
+	if (!vc_crw)
+		return;
+
+	/*
+	 * Build in the first CRW space, but don't chain anything
+	 * into the second one even though the space exists.
+	 */
+	crw = &vc_crw->crw[0];
+
+	/*
+	 * Presume every CRW we handle is reported by a channel-path.
+	 * Maybe not future-proof, but good for what we're doing now.
+	 *
+	 * FIXME Sort of a lie, since we're converting a CRW
+	 * reported by a channel-path into one issued to each
+	 * subchannel, but still saying it's coming from the path.
+	 */
+	crw->rsc = CRW_RSC_CPATH;
+	crw->rsid = (link->chpid.cssid << 8) | link->chpid.id;
+	crw->erc = erc;
+
+	list_add_tail(&vc_crw->next, &private->crw);
+	queue_work(vfio_ccw_work_q, &private->crw_work);
+}
+
 static int vfio_ccw_chp_event(struct subchannel *sch,
 			      struct chp_link *link, int event)
 {
@@ -303,6 +374,7 @@ static int vfio_ccw_chp_event(struct subchannel *sch,
 	case CHP_OFFLINE:
 		/* Path is gone */
 		cio_cancel_halt_clear(sch, &retry);
+		vfio_ccw_alloc_crw(private, link, CRW_ERC_PERRN);
 		break;
 	case CHP_VARY_ON:
 		/* Path logically turned on */
@@ -312,6 +384,7 @@ static int vfio_ccw_chp_event(struct subchannel *sch,
 	case CHP_ONLINE:
 		/* Path became available */
 		sch->lpm |= mask & sch->opm;
+		vfio_ccw_alloc_crw(private, link, CRW_ERC_INIT);
 		break;
 	}
 
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index f3033f8fc96d..8b3ed5b45277 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -393,6 +393,7 @@ static int vfio_ccw_mdev_get_irq_info(struct vfio_irq_info *info)
 {
 	switch (info->index) {
 	case VFIO_CCW_IO_IRQ_INDEX:
+	case VFIO_CCW_CRW_IRQ_INDEX:
 		info->count = 1;
 		info->flags = VFIO_IRQ_INFO_EVENTFD;
 		break;
@@ -420,6 +421,9 @@ static int vfio_ccw_mdev_set_irqs(struct mdev_device *mdev,
 	case VFIO_CCW_IO_IRQ_INDEX:
 		ctx = &private->io_trigger;
 		break;
+	case VFIO_CCW_CRW_IRQ_INDEX:
+		ctx = &private->crw_trigger;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index 8289b6850e59..a701f09c6943 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -17,6 +17,7 @@
 #include <linux/eventfd.h>
 #include <linux/workqueue.h>
 #include <linux/vfio_ccw.h>
+#include <asm/crw.h>
 #include <asm/debug.h>
 
 #include "css.h"
@@ -59,6 +60,11 @@ int vfio_ccw_register_async_dev_regions(struct vfio_ccw_private *private);
 int vfio_ccw_register_schib_dev_regions(struct vfio_ccw_private *private);
 int vfio_ccw_register_crw_dev_regions(struct vfio_ccw_private *private);
 
+struct vfio_ccw_crw {
+	struct list_head	next;
+	struct crw		crw[2];
+};
+
 /**
  * struct vfio_ccw_private
  * @sch: pointer to the subchannel
@@ -98,9 +104,12 @@ struct vfio_ccw_private {
 	struct channel_program	cp;
 	struct irb		irb;
 	union scsw		scsw;
+	struct list_head	crw;
 
 	struct eventfd_ctx	*io_trigger;
+	struct eventfd_ctx	*crw_trigger;
 	struct work_struct	io_work;
+	struct work_struct	crw_work;
 } __aligned(8);
 
 extern int vfio_ccw_mdev_reg(struct subchannel *sch);
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 5024636d7615..1bdf32772545 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -579,6 +579,7 @@ enum {
 
 enum {
 	VFIO_CCW_IO_IRQ_INDEX,
+	VFIO_CCW_CRW_IRQ_INDEX,
 	VFIO_CCW_NUM_IRQS
 };
 
-- 
2.17.1
