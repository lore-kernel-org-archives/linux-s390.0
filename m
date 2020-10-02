Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64078 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388377AbgJBTjs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 2 Oct 2020 15:39:48 -0400
From: Stefan Haberland <sth@linux.ibm.com>
Subject: [PATCH 03/10] s390/cio: Add support for FCES status notification
Date: Fri,  2 Oct 2020 21:39:33 +0200
Message-Id: <20201002193940.24012-4-sth@linux.ibm.com>
In-Reply-To: <20201002193940.24012-1-sth@linux.ibm.com>
References: <20201002193940.24012-1-sth@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com

From: Vineeth Vijayan <vneethv@linux.ibm.com>

Fibre Channel Endpoint-Security event is received as an sei:nt0 type
in the CIO layer. This information needs to be shared with the
CCW device drivers using the path_events callback.

Reference-ID: IO1812
Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
Co-developed-by: Sebastian Ott <sebott@linux.ibm.com>
Signed-off-by: Sebastian Ott <sebott@linux.ibm.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Acked-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 arch/s390/include/asm/ccwdev.h |  2 ++
 drivers/s390/cio/chp.h         |  1 +
 drivers/s390/cio/chsc.c        | 62 +++++++++++++++++++++++++++++-----
 drivers/s390/cio/device.c      | 15 +++++++-
 4 files changed, 70 insertions(+), 10 deletions(-)

diff --git a/arch/s390/include/asm/ccwdev.h b/arch/s390/include/asm/ccwdev.h
index 3cfe1eb89838..14e1bbfd969e 100644
--- a/arch/s390/include/asm/ccwdev.h
+++ b/arch/s390/include/asm/ccwdev.h
@@ -104,6 +104,8 @@ struct ccw_device {
 					       was successfully verified. */
 #define PE_PATHGROUP_ESTABLISHED	0x4 /* A pathgroup was reset and had
 					       to be established again. */
+#define PE_PATH_FCES_EVENT		0x8 /* The FCES Status of a path has
+					     * changed. */
 
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
index 513fc5748d6e..04fbcfcf9e42 100644
--- a/drivers/s390/cio/chsc.c
+++ b/drivers/s390/cio/chsc.c
@@ -37,6 +37,9 @@ static void *sei_page;
 static void *chsc_page;
 static DEFINE_SPINLOCK(chsc_page_lock);
 
+#define SEI_VF_FLA	0xc0 /* VF flag for Full Link Address */
+#define SEI_RS_CHPID	0x4  /* 4 in RS field indicates CHPID */
+
 /**
  * chsc_error_from_response() - convert a chsc response to an error
  * @response: chsc response code
@@ -285,6 +288,15 @@ static void s390_process_res_acc(struct chp_link *link)
 	css_schedule_reprobe();
 }
 
+static int process_fces_event(struct subchannel *sch, void *data)
+{
+	spin_lock_irq(sch->lock);
+	if (sch->driver && sch->driver->chp_event)
+		sch->driver->chp_event(sch, data, CHP_FCES_EVENT);
+	spin_unlock_irq(sch->lock);
+	return 0;
+}
+
 struct chsc_sei_nt0_area {
 	u8  flags;
 	u8  vf;				/* validity flags */
@@ -362,6 +374,16 @@ static char *store_ebcdic(char *dest, const char *src, unsigned long len,
 	return dest + len;
 }
 
+static void chsc_link_from_sei(struct chp_link *link,
+				struct chsc_sei_nt0_area *sei_area)
+{
+	if ((sei_area->vf & SEI_VF_FLA) != 0) {
+		link->fla	= sei_area->fla;
+		link->fla_mask	= ((sei_area->vf & SEI_VF_FLA) == SEI_VF_FLA) ?
+							0xffff : 0xff00;
+	}
+}
+
 /* Format node ID and parameters for output in LIR log message. */
 static void format_node_data(char *params, char *id, struct node_descriptor *nd)
 {
@@ -451,15 +473,7 @@ static void chsc_process_sei_res_acc(struct chsc_sei_nt0_area *sei_area)
 	}
 	memset(&link, 0, sizeof(struct chp_link));
 	link.chpid = chpid;
-	if ((sei_area->vf & 0xc0) != 0) {
-		link.fla = sei_area->fla;
-		if ((sei_area->vf & 0xc0) == 0xc0)
-			/* full link address */
-			link.fla_mask = 0xffff;
-		else
-			/* link address */
-			link.fla_mask = 0xff00;
-	}
+	chsc_link_from_sei(&link, sei_area);
 	s390_process_res_acc(&link);
 }
 
@@ -568,6 +582,33 @@ static void chsc_process_sei_ap_cfg_chg(struct chsc_sei_nt0_area *sei_area)
 	ap_bus_cfg_chg();
 }
 
+static void chsc_process_sei_fces_event(struct chsc_sei_nt0_area *sei_area)
+{
+	struct chp_link link;
+	struct chp_id chpid;
+	struct channel_path *chp;
+
+	CIO_CRW_EVENT(4,
+	"chsc: FCES status notification (rs=%02x, rs_id=%04x, FCES-status=%x)\n",
+		sei_area->rs, sei_area->rsid, sei_area->ccdf[0]);
+
+	if (sei_area->rs != SEI_RS_CHPID)
+		return;
+	chp_id_init(&chpid);
+	chpid.id = sei_area->rsid;
+
+	/* Ignore the event on unknown/invalid chp */
+	chp = chpid_to_chp(chpid);
+	if (!chp)
+		return;
+
+	memset(&link, 0, sizeof(struct chp_link));
+	link.chpid = chpid;
+	chsc_link_from_sei(&link, sei_area);
+
+	for_each_subchannel_staged(process_fces_event, NULL, &link);
+}
+
 static void chsc_process_sei_nt2(struct chsc_sei_nt2_area *sei_area)
 {
 	switch (sei_area->cc) {
@@ -609,6 +650,9 @@ static void chsc_process_sei_nt0(struct chsc_sei_nt0_area *sei_area)
 	case 14: /* scm available notification */
 		chsc_process_sei_scm_avail(sei_area);
 		break;
+	case 15: /* FCES event notification */
+		chsc_process_sei_fces_event(sei_area);
+		break;
 	default: /* other stuff */
 		CIO_CRW_EVENT(2, "chsc: sei nt0 unhandled cc=%d\n",
 			      sei_area->cc);
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index b29fe8d50baf..aab13c78db9f 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -1170,7 +1170,8 @@ static int io_subchannel_chp_event(struct subchannel *sch,
 				   struct chp_link *link, int event)
 {
 	struct ccw_device *cdev = sch_get_cdev(sch);
-	int mask;
+	int mask, chpid, valid_bit;
+	int path_event[8];
 
 	mask = chp_ssd_get_mask(&sch->ssd_info, link);
 	if (!mask)
@@ -1205,6 +1206,18 @@ static int io_subchannel_chp_event(struct subchannel *sch,
 			cdev->private->path_new_mask |= mask;
 		io_subchannel_verify(sch);
 		break;
+	case CHP_FCES_EVENT:
+		/* Forward Endpoint Security event */
+		for (chpid = 0, valid_bit = 0x80; chpid < 8; chpid++,
+				valid_bit >>= 1) {
+			if (mask & valid_bit)
+				path_event[chpid] = PE_PATH_FCES_EVENT;
+			else
+				path_event[chpid] = PE_NONE;
+		}
+		if (cdev)
+			cdev->drv->path_event(cdev, path_event);
+		break;
 	}
 	return 0;
 }
-- 
2.17.1
