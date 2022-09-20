Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13C1C6FA82
	for <linux-s390@archiver.kernel.org>; Tue, 20 Sep 2022 19:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiITT0f (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 20 Sep 2022 15:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbiITT0Y (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 20 Sep 2022 15:26:24 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BD352DD8;
        Tue, 20 Sep 2022 12:26:23 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28KJJ09J021736;
        Tue, 20 Sep 2022 19:26:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=dpfCNnfPbbEC5kErlztzTMbhQyBiJWkwpGI6tZbf/po=;
 b=TrIorz97EQnQP50ZaZvcheLEZ4SaZcqYxBPUqADO+S7Z0OQJkuYzngd8ml8IdMIz+65A
 Wq3T/h/pBhrAgcpb5Ljq67hiQBYeAg3wpGLAECz+4vYlVpuUdbLb0t+VOXV8FnCI9QGd
 Vh4XwF6AyaQhPQc9fzCUxfLE7cJKWCe/lMJnpOf394i36vp717l6PyFOkApMEaxrHh+u
 8MPaFSaDSf2ZH0IphOWjtWy/HmC0AGjWCUtpOVJZIel/XgaVRLEvKJFDLpNbZ3B4Zaew
 ej3dvsOiHtq+tHRb5F26cuCz6B6Vh9E8w/0usMc30bCriXdBH6Tsm2aropGIynz7ocQV TA== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jqk21904e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 19:26:22 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28KJM7fA023233;
        Tue, 20 Sep 2022 19:26:20 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 3jn5ghk6g6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 19:26:20 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28KJQHgt43319628
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Sep 2022 19:26:17 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04625A4040;
        Tue, 20 Sep 2022 19:26:17 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6494A4053;
        Tue, 20 Sep 2022 19:26:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 20 Sep 2022 19:26:16 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 919CBE0806; Tue, 20 Sep 2022 21:26:16 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 4/7] s390/dasd: add copy pair swap capability
Date:   Tue, 20 Sep 2022 21:26:13 +0200
Message-Id: <20220920192616.808070-5-sth@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220920192616.808070-1-sth@linux.ibm.com>
References: <20220920192616.808070-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 46YnNb0dF4Bdtga48WETwMyVLlP27Z_c
X-Proofpoint-GUID: 46YnNb0dF4Bdtga48WETwMyVLlP27Z_c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_09,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015 mlxscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209200114
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

In case of errors or misbehaviour of the primary device a controlled
failover to one of the configured secondary devices needs to be
performed.

The swap processing stops I/O on the primary device, all requests are
re-queued to the blocklayer queue, the entries in the copy relation are
swapped and finally the link to the blockdevice is moved from primary to
secondary dasd device.
After this, the secondary becomes the new primary device and I/O is
restarted on that device.

Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
---
 drivers/s390/block/dasd.c        |  3 +-
 drivers/s390/block/dasd_devmap.c |  1 +
 drivers/s390/block/dasd_eckd.c   | 94 ++++++++++++++++++++++++++++++++
 drivers/s390/block/dasd_int.h    | 20 +++++++
 4 files changed, 117 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index ea82821599f6..c03f26e79f45 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -3927,7 +3927,7 @@ EXPORT_SYMBOL_GPL(dasd_generic_space_avail);
 /*
  * clear active requests and requeue them to block layer if possible
  */
-static int dasd_generic_requeue_all_requests(struct dasd_device *device)
+int dasd_generic_requeue_all_requests(struct dasd_device *device)
 {
 	struct list_head requeue_queue;
 	struct dasd_ccw_req *cqr, *n;
@@ -4001,6 +4001,7 @@ static int dasd_generic_requeue_all_requests(struct dasd_device *device)
 	dasd_schedule_device_bh(device);
 	return rc;
 }
+EXPORT_SYMBOL_GPL(dasd_generic_requeue_all_requests);
 
 static void do_requeue_requests(struct work_struct *work)
 {
diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
index 28c244aa75cf..ca5c9e963662 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
@@ -937,6 +937,7 @@ void dasd_add_link_to_gendisk(struct gendisk *gdp, struct dasd_device *device)
 	gdp->private_data = devmap;
 	spin_unlock(&dasd_devmap_lock);
 }
+EXPORT_SYMBOL(dasd_add_link_to_gendisk);
 
 struct dasd_device *dasd_device_from_gendisk(struct gendisk *gdp)
 {
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index c8a226f070fa..d4d3bd33553b 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -6119,6 +6119,99 @@ static int dasd_hosts_print(struct dasd_device *device, struct seq_file *m)
 	return 0;
 }
 
+static struct dasd_device
+*copy_relation_find_device(struct dasd_copy_relation *copy,
+			   char *busid)
+{
+	int i;
+
+	for (i = 0; i < DASD_CP_ENTRIES; i++) {
+		if (copy->entry[i].configured &&
+		    strncmp(copy->entry[i].busid, busid, DASD_BUS_ID_SIZE) == 0)
+			return copy->entry[i].device;
+	}
+	return NULL;
+}
+
+/*
+ * set the new active/primary device
+ */
+static void copy_pair_set_active(struct dasd_copy_relation *copy, char *new_busid,
+				 char *old_busid)
+{
+	int i;
+
+	for (i = 0; i < DASD_CP_ENTRIES; i++) {
+		if (copy->entry[i].configured &&
+		    strncmp(copy->entry[i].busid, new_busid,
+			    DASD_BUS_ID_SIZE) == 0) {
+			copy->active = &copy->entry[i];
+			copy->entry[i].primary = true;
+		} else if (copy->entry[i].configured &&
+			   strncmp(copy->entry[i].busid, old_busid,
+				   DASD_BUS_ID_SIZE) == 0) {
+			copy->entry[i].primary = false;
+		}
+	}
+}
+
+/*
+ * The function will swap the role of a given copy pair.
+ * During the swap operation the relation of the blockdevice is disconnected
+ * from the old primary and connected to the new.
+ *
+ * IO is paused on the block queue before swap and may be resumed afterwards.
+ */
+static int dasd_eckd_copy_pair_swap(struct dasd_device *device, char *prim_busid,
+				    char *sec_busid)
+{
+	struct dasd_device *primary, *secondary;
+	struct dasd_copy_relation *copy;
+	struct dasd_block *block;
+	struct gendisk *gdp;
+
+	copy = device->copy;
+	if (!copy)
+		return DASD_COPYPAIRSWAP_INVALID;
+	primary = copy->active->device;
+	if (!primary)
+		return DASD_COPYPAIRSWAP_INVALID;
+	/* double check if swap has correct primary */
+	if (strncmp(dev_name(&primary->cdev->dev), prim_busid, DASD_BUS_ID_SIZE) != 0)
+		return DASD_COPYPAIRSWAP_PRIMARY;
+
+	secondary = copy_relation_find_device(copy, sec_busid);
+	if (!secondary)
+		return DASD_COPYPAIRSWAP_SECONDARY;
+
+	/*
+	 * usually the device should be quiesced for swap
+	 * for paranoia stop device and requeue requests again
+	 */
+	dasd_device_set_stop_bits(primary, DASD_STOPPED_PPRC);
+	dasd_device_set_stop_bits(secondary, DASD_STOPPED_PPRC);
+	dasd_generic_requeue_all_requests(primary);
+
+	/* swap DASD internal device <> block assignment */
+	block = primary->block;
+	primary->block = NULL;
+	secondary->block = block;
+	block->base = secondary;
+	/* set new primary device in COPY relation */
+	copy_pair_set_active(copy, sec_busid, prim_busid);
+
+	/* swap blocklayer device link */
+	gdp = block->gdp;
+	dasd_add_link_to_gendisk(gdp, secondary);
+
+	/* re-enable device */
+	dasd_device_remove_stop_bits(primary, DASD_STOPPED_PPRC);
+	dasd_device_remove_stop_bits(secondary, DASD_STOPPED_PPRC);
+	dasd_schedule_device_bh(secondary);
+
+	return DASD_COPYPAIRSWAP_SUCCESS;
+}
+
 /*
  * Perform Subsystem Function - Peer-to-Peer Remote Copy Extended Query
  */
@@ -6805,6 +6898,7 @@ static struct dasd_discipline dasd_eckd_discipline = {
 	.ese_read = dasd_eckd_ese_read,
 	.pprc_status = dasd_eckd_query_pprc_status,
 	.pprc_enabled = dasd_eckd_pprc_enabled,
+	.copy_pair_swap = dasd_eckd_copy_pair_swap,
 };
 
 static int __init
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index d9794ec03722..3c55c29155ef 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -438,6 +438,7 @@ struct dasd_discipline {
 	int (*ese_read)(struct dasd_ccw_req *, struct irb *);
 	int (*pprc_status)(struct dasd_device *, struct	dasd_pprc_data_sc4 *);
 	bool (*pprc_enabled)(struct dasd_device *);
+	int (*copy_pair_swap)(struct dasd_device *, char *, char *);
 };
 
 extern struct dasd_discipline *dasd_diag_discipline_pointer;
@@ -681,6 +682,7 @@ struct dasd_queue {
 #define DASD_STOPPED_PENDING 4         /* long busy */
 #define DASD_STOPPED_DC_WAIT 8         /* disconnected, wait */
 #define DASD_STOPPED_SU      16        /* summary unit check handling */
+#define DASD_STOPPED_PPRC    32        /* PPRC swap */
 #define DASD_STOPPED_NOSPC   128       /* no space left */
 
 /* per device flags */
@@ -705,6 +707,22 @@ struct dasd_queue {
 
 void dasd_put_device_wake(struct dasd_device *);
 
+/*
+ * return values to be returned from the copy pair swap function
+ * 0x00: swap successful
+ * 0x01: swap data invalid
+ * 0x02: no active device found
+ * 0x03: wrong primary specified
+ * 0x04: secondary device not found
+ * 0x05: swap already running
+ */
+#define DASD_COPYPAIRSWAP_SUCCESS	0
+#define DASD_COPYPAIRSWAP_INVALID	1
+#define DASD_COPYPAIRSWAP_NOACTIVE	2
+#define DASD_COPYPAIRSWAP_PRIMARY	3
+#define DASD_COPYPAIRSWAP_SECONDARY	4
+#define DASD_COPYPAIRSWAP_MULTIPLE	5
+
 /*
  * Reference count inliners
  */
@@ -889,6 +907,8 @@ int dasd_generic_verify_path(struct dasd_device *, __u8);
 void dasd_generic_space_exhaust(struct dasd_device *, struct dasd_ccw_req *);
 void dasd_generic_space_avail(struct dasd_device *);
 
+int dasd_generic_requeue_all_requests(struct dasd_device *);
+
 int dasd_generic_read_dev_chars(struct dasd_device *, int, void *, int);
 char *dasd_get_sense(struct irb *);
 
-- 
2.34.1

