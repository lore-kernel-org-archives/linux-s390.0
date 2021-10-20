Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA57C4332F
	for <linux-s390@archiver.kernel.org>; Wed, 20 Oct 2021 11:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DAA661359
	for <linux-s390@archiver.kernel.org>; Wed, 20 Oct 2021 11:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhJTLxv (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 20 Oct 2021 07:53:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56206 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230103AbhJTLxs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 20 Oct 2021 07:53:48 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KAlg39001542;
        Wed, 20 Oct 2021 07:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4EEUixHAGXv+CYhXEeUoICkeTYgNyDWm6vytbWKUEW0=;
 b=K0CCsTQUQELLH1s2TG7SBXraiKZ2buN4jLi15ITnu7Z6VCc01Oc2U3OYJu3wgsSzKixl
 likvcXsRJ5XWhvmYqeBBFXkgM3HFjVeq/uwT0L2Afr9zGCmrDJP7wdFnU0SrybkVFQLJ
 QKMBzgbfMFfQaIOe+a5tTln72rreB8BDON17ouIWayfmlntxWHLsUKejz/H0m+GqA1iq
 u1wL/HePLkLX6nfD6uprL3WMtVer1IhWlC2b08BXmGoxQo/cD32Nrys/BcCA6Z6y2kLn
 TxA1xmxddTzGRisERWVqv0LTR2qmxBCumTgA+RI5MX/wS8Yfmm/OM41dh/4X30IFv9O+ Sg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bthp0h4gu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 07:51:30 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19KBluEa009897;
        Wed, 20 Oct 2021 11:51:28 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3bqpca40wj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 11:51:28 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19KBpPLX6947548
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 11:51:25 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F30FEA4055;
        Wed, 20 Oct 2021 11:51:24 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D98A4A4059;
        Wed, 20 Oct 2021 11:51:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 20 Oct 2021 11:51:24 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 71209E076D; Wed, 20 Oct 2021 13:51:24 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 3/7] s390/dasd: split up dasd_eckd_read_conf
Date:   Wed, 20 Oct 2021 13:51:20 +0200
Message-Id: <20211020115124.1735254-4-sth@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211020115124.1735254-1-sth@linux.ibm.com>
References: <20211020115124.1735254-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BDyFY9xXkB6eIb9zbVhiW69xyV54iOf6
X-Proofpoint-ORIG-GUID: BDyFY9xXkB6eIb9zbVhiW69xyV54iOf6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-20_04,2021-10-20_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110200066
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Move the cabling check out of dasd_eckd_read_conf and split it up into
separate functions to improve readability and re-use functions.

Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.c | 130 +++++++++++++--------------------
 1 file changed, 51 insertions(+), 79 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 460e0f1cca53..f6ff26472936 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -1071,15 +1071,55 @@ static void dasd_eckd_read_fc_security(struct dasd_device *device)
 	}
 }
 
+static void dasd_eckd_get_uid_string(struct dasd_eckd_private *private,
+				     char *print_uid)
+{
+	struct dasd_uid *uid;
+
+	uid = &private->uid;
+	if (strlen(uid->vduit) > 0)
+		snprintf(print_uid, sizeof(*print_uid),
+			 "%s.%s.%04x.%02x.%s",
+			 uid->vendor, uid->serial, uid->ssid,
+			 uid->real_unit_addr, uid->vduit);
+	else
+		snprintf(print_uid, sizeof(*print_uid),
+			 "%s.%s.%04x.%02x",
+			 uid->vendor, uid->serial, uid->ssid,
+			 uid->real_unit_addr);
+}
+
+static int dasd_eckd_check_cabling(struct dasd_device *device,
+				   void *conf_data, __u8 lpm)
+{
+	struct dasd_eckd_private *private = device->private;
+	char print_path_uid[60], print_device_uid[60];
+	struct dasd_eckd_private path_private;
+
+	path_private.conf_data = conf_data;
+	path_private.conf_len = DASD_ECKD_RCD_DATA_SIZE;
+	if (dasd_eckd_identify_conf_parts(&path_private))
+		return 1;
+
+	if (dasd_eckd_compare_path_uid(device, &path_private)) {
+		dasd_eckd_get_uid_string(&path_private, print_path_uid);
+		dasd_eckd_get_uid_string(private, print_device_uid);
+		dev_err(&device->cdev->dev,
+			"Not all channel paths lead to the same device, path %02X leads to device %s instead of %s\n",
+			lpm, print_path_uid, print_device_uid);
+		return 1;
+	}
+
+	return 0;
+}
+
 static int dasd_eckd_read_conf(struct dasd_device *device)
 {
 	void *conf_data;
 	int conf_len, conf_data_saved;
 	int rc, path_err, pos;
 	__u8 lpm, opm;
-	struct dasd_eckd_private *private, path_private;
-	struct dasd_uid *uid;
-	char print_path_uid[60], print_device_uid[60];
+	struct dasd_eckd_private *private;
 
 	private = device->private;
 	opm = ccw_device_get_path_mask(device->cdev);
@@ -1123,59 +1163,11 @@ static int dasd_eckd_read_conf(struct dasd_device *device)
 			 */
 			dasd_eckd_generate_uid(device);
 			conf_data_saved++;
-		} else {
-			path_private.conf_data = conf_data;
-			path_private.conf_len = DASD_ECKD_RCD_DATA_SIZE;
-			if (dasd_eckd_identify_conf_parts(
-				    &path_private)) {
-				path_private.conf_data = NULL;
-				path_private.conf_len = 0;
-				kfree(conf_data);
-				continue;
-			}
-			if (dasd_eckd_compare_path_uid(
-				    device, &path_private)) {
-				uid = &path_private.uid;
-				if (strlen(uid->vduit) > 0)
-					snprintf(print_path_uid,
-						 sizeof(print_path_uid),
-						 "%s.%s.%04x.%02x.%s",
-						 uid->vendor, uid->serial,
-						 uid->ssid, uid->real_unit_addr,
-						 uid->vduit);
-				else
-					snprintf(print_path_uid,
-						 sizeof(print_path_uid),
-						 "%s.%s.%04x.%02x",
-						 uid->vendor, uid->serial,
-						 uid->ssid,
-						 uid->real_unit_addr);
-				uid = &private->uid;
-				if (strlen(uid->vduit) > 0)
-					snprintf(print_device_uid,
-						 sizeof(print_device_uid),
-						 "%s.%s.%04x.%02x.%s",
-						 uid->vendor, uid->serial,
-						 uid->ssid, uid->real_unit_addr,
-						 uid->vduit);
-				else
-					snprintf(print_device_uid,
-						 sizeof(print_device_uid),
-						 "%s.%s.%04x.%02x",
-						 uid->vendor, uid->serial,
-						 uid->ssid,
-						 uid->real_unit_addr);
-				dev_err(&device->cdev->dev,
-					"Not all channel paths lead to "
-					"the same device, path %02X leads to "
-					"device %s instead of %s\n", lpm,
-					print_path_uid, print_device_uid);
-				path_err = -EINVAL;
-				dasd_path_add_cablepm(device, lpm);
-				continue;
-			}
-			path_private.conf_data = NULL;
-			path_private.conf_len = 0;
+		} else if (dasd_eckd_check_cabling(device, conf_data, lpm)) {
+			dasd_path_add_cablepm(device, lpm);
+			path_err = -EINVAL;
+			kfree(conf_data);
+			continue;
 		}
 
 		pos = pathmask_to_pos(lpm);
@@ -1300,7 +1292,6 @@ static void dasd_eckd_path_available_action(struct dasd_device *device,
 					    struct pe_handler_work_data *data)
 {
 	struct dasd_eckd_private path_private;
-	struct dasd_uid *uid;
 	__u8 path_rcd_buf[DASD_ECKD_RCD_DATA_SIZE];
 	__u8 lpm, opm, npm, ppm, epm, hpfpm, cablepm;
 	struct dasd_conf_data *conf_data;
@@ -1397,19 +1388,8 @@ static void dasd_eckd_path_available_action(struct dasd_device *device,
 			if (rebuild_device_uid(device, data) ||
 			    dasd_eckd_compare_path_uid(
 				    device, &path_private)) {
-				uid = &path_private.uid;
-				if (strlen(uid->vduit) > 0)
-					snprintf(print_uid, sizeof(print_uid),
-						 "%s.%s.%04x.%02x.%s",
-						 uid->vendor, uid->serial,
-						 uid->ssid, uid->real_unit_addr,
-						 uid->vduit);
-				else
-					snprintf(print_uid, sizeof(print_uid),
-						 "%s.%s.%04x.%02x",
-						 uid->vendor, uid->serial,
-						 uid->ssid,
-						 uid->real_unit_addr);
+				dasd_eckd_get_uid_string(&path_private,
+							 print_uid);
 				dev_err(&device->cdev->dev,
 					"The newly added channel path %02X "
 					"will not be used because it leads "
@@ -5820,15 +5800,7 @@ static int dasd_eckd_reload_device(struct dasd_device *device)
 	dasd_eckd_get_uid(device, &uid);
 
 	if (old_base != uid.base_unit_addr) {
-		if (strlen(uid.vduit) > 0)
-			snprintf(print_uid, sizeof(print_uid),
-				 "%s.%s.%04x.%02x.%s", uid.vendor, uid.serial,
-				 uid.ssid, uid.base_unit_addr, uid.vduit);
-		else
-			snprintf(print_uid, sizeof(print_uid),
-				 "%s.%s.%04x.%02x", uid.vendor, uid.serial,
-				 uid.ssid, uid.base_unit_addr);
-
+		dasd_eckd_get_uid_string(private, print_uid);
 		dev_info(&device->cdev->dev,
 			 "An Alias device was reassigned to a new base device "
 			 "with UID: %s\n", print_uid);
-- 
2.25.1

