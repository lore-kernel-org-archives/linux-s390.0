Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C61C4167E
	for <linux-s390@archiver.kernel.org>; Wed, 20 Oct 2021 11:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0BAA61359
	for <linux-s390@archiver.kernel.org>; Wed, 20 Oct 2021 11:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhJTLxv (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 20 Oct 2021 07:53:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42890 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230156AbhJTLxs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 20 Oct 2021 07:53:48 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KBmqmg040692;
        Wed, 20 Oct 2021 07:51:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=2ubsGR7WJ1lm64GsdrzZRdbRhx7DuNomWoW5rRHxRIY=;
 b=Xzk0mQSSnSgJ5NUinxRaTKyCmO3CPOZV7S9R8Op+jUA9UVILD7HICOTO8OxCcVEBI0gf
 7bL9SbrOpRt/R5hlY8SXtMgZkJSM29dqlMYzmGO6wOcDQs0PiFTbjbxu0EaKWKaDmZYf
 9qZlf3GAI6M/GssL4OtMubv0A+j9Ee7UK6rzXORKBkzWnqK6YbIvWiiSYEMgVl+9fTq/
 wdHDVlK8qmNAQM9+RzEXKgQByxMm2onef3vXCauqW/lWkptvNFh7gKms709tTF5X8OcL
 aJsHeQmttQwXGZSuIo+Ugtzpb4KsAM276P5QWzWtSmKFl1xfnulkORw2V0p3QflpvmgJ 0Q== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3btjjm810k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 07:51:31 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19KBlWRb021456;
        Wed, 20 Oct 2021 11:51:29 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 3bqpca1g6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 11:51:28 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19KBpPOf65929504
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 11:51:25 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E0384C063;
        Wed, 20 Oct 2021 11:51:25 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2870E4C050;
        Wed, 20 Oct 2021 11:51:25 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 20 Oct 2021 11:51:25 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 75DF7E07B5; Wed, 20 Oct 2021 13:51:24 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 5/7] s390/dasd: summarize dasd configuration data in a separate structure
Date:   Wed, 20 Oct 2021 13:51:22 +0200
Message-Id: <20211020115124.1735254-6-sth@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211020115124.1735254-1-sth@linux.ibm.com>
References: <20211020115124.1735254-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mlz2LfV11QxN9CRZYI7fojZ95uSQ9B2T
X-Proofpoint-GUID: mlz2LfV11QxN9CRZYI7fojZ95uSQ9B2T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-20_04,2021-10-20_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110200066
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Summarize the dasd configuration data in a separate structure so that
functions that need temporary config data do not need to allocate the
whole eckd_private structure.

Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.c | 182 ++++++++++++++++-----------------
 drivers/s390/block/dasd_eckd.h |  13 ++-
 2 files changed, 98 insertions(+), 97 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 248006291c29..6cfaaddb4fbb 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -560,8 +560,8 @@ static int prefix_LRE(struct ccw1 *ccw, struct PFX_eckd_data *pfxdata,
 		return -EINVAL;
 	}
 	pfxdata->format = format;
-	pfxdata->base_address = basepriv->ned->unit_addr;
-	pfxdata->base_lss = basepriv->ned->ID;
+	pfxdata->base_address = basepriv->conf.ned->unit_addr;
+	pfxdata->base_lss = basepriv->conf.ned->ID;
 	pfxdata->validity.define_extent = 1;
 
 	/* private uid is kept up to date, conf_data may be outdated */
@@ -736,32 +736,30 @@ dasd_eckd_cdl_reclen(int recid)
 	return LABEL_SIZE;
 }
 /* create unique id from private structure. */
-static void create_uid(struct dasd_eckd_private *private)
+static void create_uid(struct dasd_conf *conf, struct dasd_uid *uid)
 {
 	int count;
-	struct dasd_uid *uid;
 
-	uid = &private->uid;
 	memset(uid, 0, sizeof(struct dasd_uid));
-	memcpy(uid->vendor, private->ned->HDA_manufacturer,
+	memcpy(uid->vendor, conf->ned->HDA_manufacturer,
 	       sizeof(uid->vendor) - 1);
 	EBCASC(uid->vendor, sizeof(uid->vendor) - 1);
-	memcpy(uid->serial, &private->ned->serial,
+	memcpy(uid->serial, &conf->ned->serial,
 	       sizeof(uid->serial) - 1);
 	EBCASC(uid->serial, sizeof(uid->serial) - 1);
-	uid->ssid = private->gneq->subsystemID;
-	uid->real_unit_addr = private->ned->unit_addr;
-	if (private->sneq) {
-		uid->type = private->sneq->sua_flags;
+	uid->ssid = conf->gneq->subsystemID;
+	uid->real_unit_addr = conf->ned->unit_addr;
+	if (conf->sneq) {
+		uid->type = conf->sneq->sua_flags;
 		if (uid->type == UA_BASE_PAV_ALIAS)
-			uid->base_unit_addr = private->sneq->base_unit_addr;
+			uid->base_unit_addr = conf->sneq->base_unit_addr;
 	} else {
 		uid->type = UA_BASE_DEVICE;
 	}
-	if (private->vdsneq) {
+	if (conf->vdsneq) {
 		for (count = 0; count < 16; count++) {
 			sprintf(uid->vduit+2*count, "%02x",
-				private->vdsneq->uit[count]);
+				conf->vdsneq->uit[count]);
 		}
 	}
 }
@@ -776,10 +774,10 @@ static int dasd_eckd_generate_uid(struct dasd_device *device)
 
 	if (!private)
 		return -ENODEV;
-	if (!private->ned || !private->gneq)
+	if (!private->conf.ned || !private->conf.gneq)
 		return -ENODEV;
 	spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
-	create_uid(private);
+	create_uid(&private->conf, &private->uid);
 	spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
 	return 0;
 }
@@ -803,14 +801,15 @@ static int dasd_eckd_get_uid(struct dasd_device *device, struct dasd_uid *uid)
  * return 0 for match
  */
 static int dasd_eckd_compare_path_uid(struct dasd_device *device,
-				      struct dasd_eckd_private *private)
+				      struct dasd_conf *path_conf)
 {
 	struct dasd_uid device_uid;
+	struct dasd_uid path_uid;
 
-	create_uid(private);
+	create_uid(path_conf, &path_uid);
 	dasd_eckd_get_uid(device, &device_uid);
 
-	return memcmp(&device_uid, &private->uid, sizeof(struct dasd_uid));
+	return memcmp(&device_uid, &path_uid, sizeof(struct dasd_uid));
 }
 
 static void dasd_eckd_fill_rcd_cqr(struct dasd_device *device,
@@ -946,34 +945,34 @@ static int dasd_eckd_read_conf_lpm(struct dasd_device *device,
 	return ret;
 }
 
-static int dasd_eckd_identify_conf_parts(struct dasd_eckd_private *private)
+static int dasd_eckd_identify_conf_parts(struct dasd_conf *conf)
 {
 
 	struct dasd_sneq *sneq;
 	int i, count;
 
-	private->ned = NULL;
-	private->sneq = NULL;
-	private->vdsneq = NULL;
-	private->gneq = NULL;
-	count = private->conf_len / sizeof(struct dasd_sneq);
-	sneq = (struct dasd_sneq *)private->conf_data;
+	conf->ned = NULL;
+	conf->sneq = NULL;
+	conf->vdsneq = NULL;
+	conf->gneq = NULL;
+	count = conf->len / sizeof(struct dasd_sneq);
+	sneq = (struct dasd_sneq *)conf->data;
 	for (i = 0; i < count; ++i) {
 		if (sneq->flags.identifier == 1 && sneq->format == 1)
-			private->sneq = sneq;
+			conf->sneq = sneq;
 		else if (sneq->flags.identifier == 1 && sneq->format == 4)
-			private->vdsneq = (struct vd_sneq *)sneq;
+			conf->vdsneq = (struct vd_sneq *)sneq;
 		else if (sneq->flags.identifier == 2)
-			private->gneq = (struct dasd_gneq *)sneq;
+			conf->gneq = (struct dasd_gneq *)sneq;
 		else if (sneq->flags.identifier == 3 && sneq->res1 == 1)
-			private->ned = (struct dasd_ned *)sneq;
+			conf->ned = (struct dasd_ned *)sneq;
 		sneq++;
 	}
-	if (!private->ned || !private->gneq) {
-		private->ned = NULL;
-		private->sneq = NULL;
-		private->vdsneq = NULL;
-		private->gneq = NULL;
+	if (!conf->ned || !conf->gneq) {
+		conf->ned = NULL;
+		conf->sneq = NULL;
+		conf->vdsneq = NULL;
+		conf->gneq = NULL;
 		return -EINVAL;
 	}
 	return 0;
@@ -1016,9 +1015,9 @@ static void dasd_eckd_store_conf_data(struct dasd_device *device,
 	 * with the new one if this points to the same data
 	 */
 	cdp = device->path[chp].conf_data;
-	if (private->conf_data == cdp) {
-		private->conf_data = (void *)conf_data;
-		dasd_eckd_identify_conf_parts(private);
+	if (private->conf.data == cdp) {
+		private->conf.data = (void *)conf_data;
+		dasd_eckd_identify_conf_parts(&private->conf);
 	}
 	ccw_device_get_schid(device->cdev, &sch_id);
 	device->path[chp].conf_data = conf_data;
@@ -1036,8 +1035,8 @@ static void dasd_eckd_clear_conf_data(struct dasd_device *device)
 	struct dasd_eckd_private *private = device->private;
 	int i;
 
-	private->conf_data = NULL;
-	private->conf_len = 0;
+	private->conf.data = NULL;
+	private->conf.len = 0;
 	for (i = 0; i < 8; i++) {
 		kfree(device->path[i].conf_data);
 		device->path[i].conf_data = NULL;
@@ -1071,22 +1070,22 @@ static void dasd_eckd_read_fc_security(struct dasd_device *device)
 	}
 }
 
-static void dasd_eckd_get_uid_string(struct dasd_eckd_private *private,
+static void dasd_eckd_get_uid_string(struct dasd_conf *conf,
 				     char *print_uid)
 {
-	struct dasd_uid *uid;
+	struct dasd_uid uid;
 
-	uid = &private->uid;
-	if (strlen(uid->vduit) > 0)
+	create_uid(conf, &uid);
+	if (strlen(uid.vduit) > 0)
 		snprintf(print_uid, sizeof(*print_uid),
 			 "%s.%s.%04x.%02x.%s",
-			 uid->vendor, uid->serial, uid->ssid,
-			 uid->real_unit_addr, uid->vduit);
+			 uid.vendor, uid.serial, uid.ssid,
+			 uid.real_unit_addr, uid.vduit);
 	else
 		snprintf(print_uid, sizeof(*print_uid),
 			 "%s.%s.%04x.%02x",
-			 uid->vendor, uid->serial, uid->ssid,
-			 uid->real_unit_addr);
+			 uid.vendor, uid.serial, uid.ssid,
+			 uid.real_unit_addr);
 }
 
 static int dasd_eckd_check_cabling(struct dasd_device *device,
@@ -1094,16 +1093,16 @@ static int dasd_eckd_check_cabling(struct dasd_device *device,
 {
 	struct dasd_eckd_private *private = device->private;
 	char print_path_uid[60], print_device_uid[60];
-	struct dasd_eckd_private path_private;
+	struct dasd_conf path_conf;
 
-	path_private.conf_data = conf_data;
-	path_private.conf_len = DASD_ECKD_RCD_DATA_SIZE;
-	if (dasd_eckd_identify_conf_parts(&path_private))
+	path_conf.data = conf_data;
+	path_conf.len = DASD_ECKD_RCD_DATA_SIZE;
+	if (dasd_eckd_identify_conf_parts(&path_conf))
 		return 1;
 
-	if (dasd_eckd_compare_path_uid(device, &path_private)) {
-		dasd_eckd_get_uid_string(&path_private, print_path_uid);
-		dasd_eckd_get_uid_string(private, print_device_uid);
+	if (dasd_eckd_compare_path_uid(device, &path_conf)) {
+		dasd_eckd_get_uid_string(&path_conf, print_path_uid);
+		dasd_eckd_get_uid_string(&private->conf, print_device_uid);
 		dev_err(&device->cdev->dev,
 			"Not all channel paths lead to the same device, path %02X leads to device %s instead of %s\n",
 			lpm, print_path_uid, print_device_uid);
@@ -1149,11 +1148,11 @@ static int dasd_eckd_read_conf(struct dasd_device *device)
 		if (!conf_data_saved) {
 			/* initially clear previously stored conf_data */
 			dasd_eckd_clear_conf_data(device);
-			private->conf_data = conf_data;
-			private->conf_len = conf_len;
-			if (dasd_eckd_identify_conf_parts(private)) {
-				private->conf_data = NULL;
-				private->conf_len = 0;
+			private->conf.data = conf_data;
+			private->conf.len = conf_len;
+			if (dasd_eckd_identify_conf_parts(&private->conf)) {
+				private->conf.data = NULL;
+				private->conf.len = 0;
 				kfree(conf_data);
 				continue;
 			}
@@ -1203,7 +1202,7 @@ static u32 get_fcx_max_data(struct dasd_device *device)
 		return 0;
 	/* is transport mode supported? */
 	fcx_in_css = css_general_characteristics.fcx;
-	fcx_in_gneq = private->gneq->reserved2[7] & 0x04;
+	fcx_in_gneq = private->conf.gneq->reserved2[7] & 0x04;
 	fcx_in_features = private->features.feature[40] & 0x80;
 	tpm = fcx_in_css && fcx_in_gneq && fcx_in_features;
 
@@ -1272,9 +1271,9 @@ static int rebuild_device_uid(struct dasd_device *device,
 					"returned error %d", rc);
 			break;
 		}
-		memcpy(private->conf_data, data->rcd_buffer,
+		memcpy(private->conf.data, data->rcd_buffer,
 		       DASD_ECKD_RCD_DATA_SIZE);
-		if (dasd_eckd_identify_conf_parts(private)) {
+		if (dasd_eckd_identify_conf_parts(&private->conf)) {
 			rc = -ENODEV;
 		} else /* first valid path is enough */
 			break;
@@ -1289,10 +1288,10 @@ static int rebuild_device_uid(struct dasd_device *device,
 static void dasd_eckd_path_available_action(struct dasd_device *device,
 					    struct pe_handler_work_data *data)
 {
-	struct dasd_eckd_private path_private;
 	__u8 path_rcd_buf[DASD_ECKD_RCD_DATA_SIZE];
 	__u8 lpm, opm, npm, ppm, epm, hpfpm, cablepm;
 	struct dasd_conf_data *conf_data;
+	struct dasd_conf path_conf;
 	unsigned long flags;
 	char print_uid[60];
 	int rc, pos;
@@ -1356,11 +1355,11 @@ static void dasd_eckd_path_available_action(struct dasd_device *device,
 		 */
 		memcpy(&path_rcd_buf, data->rcd_buffer,
 		       DASD_ECKD_RCD_DATA_SIZE);
-		path_private.conf_data = (void *) &path_rcd_buf;
-		path_private.conf_len = DASD_ECKD_RCD_DATA_SIZE;
-		if (dasd_eckd_identify_conf_parts(&path_private)) {
-			path_private.conf_data = NULL;
-			path_private.conf_len = 0;
+		path_conf.data = (void *)&path_rcd_buf;
+		path_conf.len = DASD_ECKD_RCD_DATA_SIZE;
+		if (dasd_eckd_identify_conf_parts(&path_conf)) {
+			path_conf.data = NULL;
+			path_conf.len = 0;
 			continue;
 		}
 
@@ -1371,7 +1370,7 @@ static void dasd_eckd_path_available_action(struct dasd_device *device,
 		 * the first working path UID will be used as device UID
 		 */
 		if (dasd_path_get_opm(device) &&
-		    dasd_eckd_compare_path_uid(device, &path_private)) {
+		    dasd_eckd_compare_path_uid(device, &path_conf)) {
 			/*
 			 * the comparison was not successful
 			 * rebuild the device UID with at least one
@@ -1385,9 +1384,8 @@ static void dasd_eckd_path_available_action(struct dasd_device *device,
 			 */
 			if (rebuild_device_uid(device, data) ||
 			    dasd_eckd_compare_path_uid(
-				    device, &path_private)) {
-				dasd_eckd_get_uid_string(&path_private,
-							 print_uid);
+				    device, &path_conf)) {
+				dasd_eckd_get_uid_string(&path_conf, print_uid);
 				dev_err(&device->cdev->dev,
 					"The newly added channel path %02X "
 					"will not be used because it leads "
@@ -1603,8 +1601,8 @@ static int dasd_eckd_read_vol_info(struct dasd_device *device)
 	prssdp = cqr->data;
 	prssdp->order = PSF_ORDER_PRSSD;
 	prssdp->suborder = PSF_SUBORDER_VSQ;	/* Volume Storage Query */
-	prssdp->lss = private->ned->ID;
-	prssdp->volume = private->ned->unit_addr;
+	prssdp->lss = private->conf.ned->ID;
+	prssdp->volume = private->conf.ned->unit_addr;
 
 	ccw = cqr->cpaddr;
 	ccw->cmd_code = DASD_ECKD_CCW_PSF;
@@ -2063,11 +2061,11 @@ dasd_eckd_check_characteristics(struct dasd_device *device)
 	device->path_thrhld = DASD_ECKD_PATH_THRHLD;
 	device->path_interval = DASD_ECKD_PATH_INTERVAL;
 
-	if (private->gneq) {
+	if (private->conf.gneq) {
 		value = 1;
-		for (i = 0; i < private->gneq->timeout.value; i++)
+		for (i = 0; i < private->conf.gneq->timeout.value; i++)
 			value = 10 * value;
-		value = value * private->gneq->timeout.number;
+		value = value * private->conf.gneq->timeout.number;
 		/* do not accept useless values */
 		if (value != 0 && value <= DASD_EXPIRES_MAX)
 			device->default_expires = value;
@@ -2174,10 +2172,10 @@ static void dasd_eckd_uncheck_device(struct dasd_device *device)
 		return;
 
 	dasd_alias_disconnect_device_from_lcu(device);
-	private->ned = NULL;
-	private->sneq = NULL;
-	private->vdsneq = NULL;
-	private->gneq = NULL;
+	private->conf.ned = NULL;
+	private->conf.sneq = NULL;
+	private->conf.vdsneq = NULL;
+	private->conf.gneq = NULL;
 	dasd_eckd_clear_conf_data(device);
 	dasd_path_remove_kobjects(device);
 }
@@ -3729,8 +3727,8 @@ dasd_eckd_dso_ras(struct dasd_device *device, struct dasd_block *block,
 	 * subset.
 	 */
 	ras_data->op_flags.guarantee_init = !!(features->feature[56] & 0x01);
-	ras_data->lss = private->ned->ID;
-	ras_data->dev_addr = private->ned->unit_addr;
+	ras_data->lss = private->conf.ned->ID;
+	ras_data->dev_addr = private->conf.ned->unit_addr;
 	ras_data->nr_exts = nr_exts;
 
 	if (by_extent) {
@@ -4272,8 +4270,8 @@ static int prepare_itcw(struct itcw *itcw,
 
 	memset(&pfxdata, 0, sizeof(pfxdata));
 	pfxdata.format = 1; /* PFX with LRE */
-	pfxdata.base_address = basepriv->ned->unit_addr;
-	pfxdata.base_lss = basepriv->ned->ID;
+	pfxdata.base_address = basepriv->conf.ned->unit_addr;
+	pfxdata.base_lss = basepriv->conf.ned->ID;
 	pfxdata.validity.define_extent = 1;
 
 	/* private uid is kept up to date, conf_data may be outdated */
@@ -4942,9 +4940,9 @@ dasd_eckd_fill_info(struct dasd_device * device,
 	info->characteristics_size = sizeof(private->rdc_data);
 	memcpy(info->characteristics, &private->rdc_data,
 	       sizeof(private->rdc_data));
-	info->confdata_size = min((unsigned long)private->conf_len,
-				  sizeof(info->configuration_data));
-	memcpy(info->configuration_data, private->conf_data,
+	info->confdata_size = min_t(unsigned long, private->conf.len,
+				    sizeof(info->configuration_data));
+	memcpy(info->configuration_data, private->conf.data,
 	       info->confdata_size);
 	return 0;
 }
@@ -5801,7 +5799,7 @@ static int dasd_eckd_reload_device(struct dasd_device *device)
 	dasd_eckd_get_uid(device, &uid);
 
 	if (old_base != uid.base_unit_addr) {
-		dasd_eckd_get_uid_string(private, print_uid);
+		dasd_eckd_get_uid_string(&private->conf, print_uid);
 		dev_info(&device->cdev->dev,
 			 "An Alias device was reassigned to a new base device "
 			 "with UID: %s\n", print_uid);
@@ -5939,8 +5937,8 @@ static int dasd_eckd_query_host_access(struct dasd_device *device,
 	prssdp->order = PSF_ORDER_PRSSD;
 	prssdp->suborder = PSF_SUBORDER_QHA;	/* query host access */
 	/* LSS and Volume that will be queried */
-	prssdp->lss = private->ned->ID;
-	prssdp->volume = private->ned->unit_addr;
+	prssdp->lss = private->conf.ned->ID;
+	prssdp->volume = private->conf.ned->unit_addr;
 	/* all other bytes of prssdp must be zero */
 
 	ccw = cqr->cpaddr;
diff --git a/drivers/s390/block/dasd_eckd.h b/drivers/s390/block/dasd_eckd.h
index 65e4630ad2ae..a91b265441cc 100644
--- a/drivers/s390/block/dasd_eckd.h
+++ b/drivers/s390/block/dasd_eckd.h
@@ -658,16 +658,19 @@ struct dasd_conf_data {
 	struct dasd_gneq gneq;
 } __packed;
 
-struct dasd_eckd_private {
-	struct dasd_eckd_characteristics rdc_data;
-	u8 *conf_data;
-	int conf_len;
-
+struct dasd_conf {
+	u8 *data;
+	int len;
 	/* pointers to specific parts in the conf_data */
 	struct dasd_ned *ned;
 	struct dasd_sneq *sneq;
 	struct vd_sneq *vdsneq;
 	struct dasd_gneq *gneq;
+};
+
+struct dasd_eckd_private {
+	struct dasd_eckd_characteristics rdc_data;
+	struct dasd_conf conf;
 
 	struct eckd_count count_area[5];
 	int init_cqr_status;
-- 
2.25.1

