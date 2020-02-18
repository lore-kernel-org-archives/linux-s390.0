Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46720 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726199AbgBRJXX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 Feb 2020 04:23:23 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01I9L3RA153719
        for <linux-s390@vger.kernel.org>; Tue, 18 Feb 2020 04:23:22 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y6dq6wbcs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 18 Feb 2020 04:23:22 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <vneethv@linux.ibm.com>;
        Tue, 18 Feb 2020 09:23:20 -0000
From: Vineeth Vijayan <vneethv@linux.ibm.com>
Subject: [RFC v2 1/2] s390/cio: handle changes related to endpoint security
Date: Tue, 18 Feb 2020 10:23:16 +0100
In-Reply-To: <20200218092317.49846-1-vneethv@linux.ibm.com>
References: <20200218092317.49846-1-vneethv@linux.ibm.com>
Message-Id: <20200218092317.49846-2-vneethv@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: oberpar@linux.ibm.com
Cc: linux-s390@vger.kernel.org

From: Sebastian Ott <sebott@linux.ibm.com>

Reference-ID: IO1812
Signed-off-by: Sebastian Ott <sebott@linux.ibm.com>
---
 drivers/s390/cio/chsc.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
index b7256ea5b669..6218bcb8d21f 100644
--- a/drivers/s390/cio/chsc.c
+++ b/drivers/s390/cio/chsc.c
@@ -566,6 +566,36 @@ static void chsc_process_sei_ap_cfg_chg(struct chsc_sei_nt0_area *sei_area)
 	ap_bus_cfg_chg();
 }
 
+static void chsc_process_sei_esc_change(struct chsc_sei_nt0_area *sei_area)
+{
+	struct channel_path *chp;
+	struct chp_id chpid;
+	int status;
+
+	CIO_CRW_EVENT(4, "chsc: endpoint security status notification (rs=%02x, "
+		      "rs_id=%04x, esc=%x)\n", sei_area->rs, sei_area->rsid,
+		      sei_area->ccdf[0]);
+	if (sei_area->rs != 4)
+		return;
+	chp_id_init(&chpid);
+	chpid.id = sei_area->rsid;
+	/* allocate a new channel path structure, if needed */
+	status = chp_get_status(chpid);
+	if (!status)
+		return;
+
+	if (status < 0) {
+		chp_new(chpid);
+	} else {
+		chp = chpid_to_chp(chpid);
+		mutex_lock(&chp->lock);
+		chp_update_desc(chp);
+		mutex_unlock(&chp->lock);
+	}
+
+	/* notify driver? check I/O? */
+}
+
 static void chsc_process_sei_nt2(struct chsc_sei_nt2_area *sei_area)
 {
 	switch (sei_area->cc) {
@@ -607,6 +637,9 @@ static void chsc_process_sei_nt0(struct chsc_sei_nt0_area *sei_area)
 	case 14: /* scm available notification */
 		chsc_process_sei_scm_avail(sei_area);
 		break;
+	case 15: /* endpoint security status update notification */
+		chsc_process_sei_esc_change(sei_area);
+		break;
 	default: /* other stuff */
 		CIO_CRW_EVENT(2, "chsc: sei nt0 unhandled cc=%d\n",
 			      sei_area->cc);
-- 
2.17.1
