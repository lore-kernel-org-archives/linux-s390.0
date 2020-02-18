Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50146 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726252AbgBRJXZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 Feb 2020 04:23:25 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01I9JNK6013712
        for <linux-s390@vger.kernel.org>; Tue, 18 Feb 2020 04:23:23 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y85f3e3ht-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 18 Feb 2020 04:23:23 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <vneethv@linux.ibm.com>;
        Tue, 18 Feb 2020 09:23:22 -0000
From: Vineeth Vijayan <vneethv@linux.ibm.com>
Subject: [RFC v2 2/2] s390/cio: add support for fces status notification
Date: Tue, 18 Feb 2020 10:23:17 +0100
In-Reply-To: <20200218092317.49846-1-vneethv@linux.ibm.com>
References: <20200218092317.49846-1-vneethv@linux.ibm.com>
Message-Id: <20200218092317.49846-3-vneethv@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: oberpar@linux.ibm.com
Cc: linux-s390@vger.kernel.org

Fiber channel endpoint security event is received as an sei:nt0 type
in the cio-chsc layer. this information needs to be shared with the
ccwdev devices (dasd for instance) using path_events. Send this
information to the sch layer which will internally use the path-event
for this notification.

Reference-ID: IO1812
Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
---
 arch/s390/include/asm/ccwdev.h |  1 +
 drivers/s390/cio/chp.h         |  1 +
 drivers/s390/cio/chsc.c        | 50 ++++++++++++++++++++++++++++++----
 drivers/s390/cio/device.c      | 19 ++++++++++++-
 4 files changed, 65 insertions(+), 6 deletions(-)

diff --git a/arch/s390/include/asm/ccwdev.h b/arch/s390/include/asm/ccwdev.h
index 865ce1cb86d5..3662bb27bd01 100644
--- a/arch/s390/include/asm/ccwdev.h
+++ b/arch/s390/include/asm/ccwdev.h
@@ -103,6 +103,7 @@ struct ccw_device {
 					       was successfully verified. */
 #define PE_PATHGROUP_ESTABLISHED	0x4 /* A pathgroup was reset and had
 					       to be established again. */
+#define PE_PATH_FCES_EVENT		0x8 /* An event from FCES */
 
 /*
  * Possible CIO actions triggered by the unit check handler.
diff --git a/drivers/s390/cio/chp.h b/drivers/s390/cio/chp.h
index 20259f3fbf45..7ee9eba0abcb 100644
--- a/drivers/s390/cio/chp.h
+++ b/drivers/s390/cio/chp.h
@@ -23,6 +23,7 @@
 #define CHP_OFFLINE 1
 #define CHP_VARY_ON 2
 #define CHP_VARY_OFF 3
+#define CHP_FCES_EVENT 4
 
 struct chp_link {
 	struct chp_id chpid;
diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
index 6218bcb8d21f..c7371b5241a2 100644
--- a/drivers/s390/cio/chsc.c
+++ b/drivers/s390/cio/chsc.c
@@ -37,6 +37,10 @@ static void *sei_page;
 static void *chsc_page;
 static DEFINE_SPINLOCK(chsc_page_lock);
 
+/* Store Event Information VF field definitions*/
+#define SEI_VF_FLA	0xc0 /* Full Link Address*/
+#define SEI_RS_CHPID	0x4  /* 4 in RS field indicates CHPID*/
+
 /**
  * chsc_error_from_response() - convert a chsc response to an error
  * @response: chsc response code
@@ -283,6 +287,29 @@ static void s390_process_res_acc(struct chp_link *link)
 	css_schedule_reprobe();
 }
 
+static int __s390_process_fces_event(struct subchannel *sch, void *data)
+{
+	spin_lock_irq(sch->lock);
+	if (sch->driver && sch->driver->chp_event)
+		sch->driver->chp_event(sch, data, CHP_FCES_EVENT);
+	spin_unlock_irq(sch->lock);
+	fces_event = 0;
+	return 0;
+}
+
+
+static void s390_process_fces_event(struct chp_link *link)
+{
+	/* Wait until previous actions have settled. */
+	css_wait_for_slow_path();
+	/*
+	 * Scan through all subchannels that may be concerned and
+	 * do a validation on those.
+	 */
+	for_each_subchannel_staged(__s390_process_fces_event, NULL, link);
+}
+
+
 struct chsc_sei_nt0_area {
 	u8  flags;
 	u8  vf;				/* validity flags */
@@ -569,13 +596,15 @@ static void chsc_process_sei_ap_cfg_chg(struct chsc_sei_nt0_area *sei_area)
 static void chsc_process_sei_esc_change(struct chsc_sei_nt0_area *sei_area)
 {
 	struct channel_path *chp;
+	struct chp_link link;
 	struct chp_id chpid;
 	int status;
 
-	CIO_CRW_EVENT(4, "chsc: endpoint security status notification (rs=%02x, "
-		      "rs_id=%04x, esc=%x)\n", sei_area->rs, sei_area->rsid,
-		      sei_area->ccdf[0]);
-	if (sei_area->rs != 4)
+	CIO_CRW_EVENT(4, "chsc: endpoint security status notification (rs=%02x "
+			" rs_id=%04x, esc=%x)\n", sei_area->rs, sei_area->rsid,
+			sei_area->ccdf[0]);
+
+	if (sei_area->rs != SEI_RS_CHPID)
 		return;
 	chp_id_init(&chpid);
 	chpid.id = sei_area->rsid;
@@ -593,7 +622,18 @@ static void chsc_process_sei_esc_change(struct chsc_sei_nt0_area *sei_area)
 		mutex_unlock(&chp->lock);
 	}
 
-	/* notify driver? check I/O? */
+	memset(&link, 0, sizeof(struct chp_link));
+	link.chpid = chpid;
+	if ((sei_area->vf & SEI_VF_FLA) != 0) {
+		link.fla = sei_area->fla;
+		if ((sei_area->vf & SEI_VF_FLA) == SEI_VF_FLA)
+			/* full link address */
+			link.fla_mask = 0xffff;
+		else
+			/* link address */
+			link.fla_mask = 0xff00;
+	}
+	s390_process_fces_event(&link);
 }
 
 static void chsc_process_sei_nt2(struct chsc_sei_nt2_area *sei_area)
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 0c6245fc7706..518794a7fab5 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -1165,7 +1165,8 @@ static int io_subchannel_chp_event(struct subchannel *sch,
 				   struct chp_link *link, int event)
 {
 	struct ccw_device *cdev = sch_get_cdev(sch);
-	int mask;
+	int mask, chpid, maskval;
+	int path_event[8];
 
 	mask = chp_ssd_get_mask(&sch->ssd_info, link);
 	if (!mask)
@@ -1200,6 +1201,22 @@ static int io_subchannel_chp_event(struct subchannel *sch,
 			cdev->private->path_new_mask |= mask;
 		io_subchannel_verify(sch);
 		break;
+	case CHP_FCES_EVENT:
+		/* call the path_event functionality and let the
+		 * consumer device know about the end-point security
+		 * event
+		 */
+		for (chpid = 0, maskval = 0x80; chpid < 8; chpid++,
+				maskval >>= 1) {
+			path_event[chpid] = PE_NONE;
+			if (mask == maskval)
+				path_event[chpid] = PE_PATH_FCES_EVENT;
+		}
+		spin_lock_irq(cdev->ccwlock);
+		if (cdev)
+			cdev->drv->path_event(cdev, path_event);
+		spin_unlock_irq(cdev->ccwlock);
+		break;
 	}
 	return 0;
 }
-- 
2.17.1
