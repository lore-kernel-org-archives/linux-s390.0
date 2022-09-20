Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021C3C54EE9
	for <linux-s390@archiver.kernel.org>; Tue, 20 Sep 2022 19:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbiITT0m (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 20 Sep 2022 15:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbiITT0Z (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 20 Sep 2022 15:26:25 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002A07269E;
        Tue, 20 Sep 2022 12:26:23 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28KJCFQe039501;
        Tue, 20 Sep 2022 19:26:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=CFZBTZXU9jpdiaFmR45tSBkJkO4uumXgouRyAY4oLvA=;
 b=TCALZUx9cucOXUAg369ypyewQbS0xoEbAWlf1St7MvQ3j2wMdErfzWKqufx6FqMN1WD8
 XPv8a9II8kCHkOYOSJ+aWrT6ZJIpYhR9Euy9x97rhcP1MOzkoLqgZiReUGlmB2bhe8dm
 y542+ofHrYmmwc44tUIyQ1C1Q71LrC6n/x87t/+oyupIQZQSQ/gD9JMVfoJwxIGmzFGi
 kSlxeWnXPvN36ExWK3XmogUmUg91YHbkiGR5TNNe3IegFXhfUfQHrJmcedAd3sfBWxsc
 8A1pyCaI4K2I5NdyYuy6kLFE8zrUeWa+BFpqM7Yqd7iQmE7phVXh/Uysm9yrS3gbijvl nA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jqkfa0gpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 19:26:22 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28KJNH3I006781;
        Tue, 20 Sep 2022 19:26:20 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3jn5gj49fn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 19:26:20 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28KJQHTN36045286
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Sep 2022 19:26:17 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 418384C040;
        Tue, 20 Sep 2022 19:26:17 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A7284C046;
        Tue, 20 Sep 2022 19:26:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 20 Sep 2022 19:26:17 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id A1C9FE0812; Tue, 20 Sep 2022 21:26:16 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 7/7] s390/dasd: add device ping attribute
Date:   Tue, 20 Sep 2022 21:26:16 +0200
Message-Id: <20220920192616.808070-8-sth@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220920192616.808070-1-sth@linux.ibm.com>
References: <20220920192616.808070-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tJ3Npa0w8XDQ3gQHS9yp3enBHjjbpN6N
X-Proofpoint-GUID: tJ3Npa0w8XDQ3gQHS9yp3enBHjjbpN6N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_09,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209200114
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Add a function to check if a device is accessible.
This makes mostly sense for copy pair secondary devices but it will work
for all devices.

The sysfs attribute ping is a write only attribute and will issue a NOP
CCW to the device.
In case of success it will return zero. If the device is not accessible
it will return an error code.

Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
---
 drivers/s390/block/dasd_devmap.c | 35 +++++++++++++++++++++++++
 drivers/s390/block/dasd_eckd.c   | 44 ++++++++++++++++++++++++++++++++
 drivers/s390/block/dasd_eckd.h   |  1 +
 drivers/s390/block/dasd_int.h    |  1 +
 4 files changed, 81 insertions(+)

diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
index ca5c9e963662..2f7341412ea9 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
@@ -2234,6 +2234,40 @@ dasd_copy_role_show(struct device *dev,
 }
 static DEVICE_ATTR(copy_role, 0444, dasd_copy_role_show, NULL);
 
+static ssize_t dasd_device_ping(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct dasd_device *device;
+	size_t rc;
+
+	device = dasd_device_from_cdev(to_ccwdev(dev));
+	if (IS_ERR(device))
+		return -ENODEV;
+
+	/*
+	 * do not try during offline processing
+	 * early check only
+	 * the sleep_on function itself checks for offline
+	 * processing again
+	 */
+	if (test_bit(DASD_FLAG_OFFLINE, &device->flags)) {
+		rc = -EBUSY;
+		goto out;
+	}
+	if (!device->discipline || !device->discipline->device_ping) {
+		rc = -EOPNOTSUPP;
+		goto out;
+	}
+	rc = device->discipline->device_ping(device);
+	if (!rc)
+		rc = count;
+out:
+	dasd_put_device(device);
+	return rc;
+}
+static DEVICE_ATTR(ping, 0200, NULL, dasd_device_ping);
+
 #define DASD_DEFINE_ATTR(_name, _func)					\
 static ssize_t dasd_##_name##_show(struct device *dev,			\
 				   struct device_attribute *attr,	\
@@ -2292,6 +2326,7 @@ static struct attribute * dasd_attrs[] = {
 	&dev_attr_fc_security.attr,
 	&dev_attr_copy_pair.attr,
 	&dev_attr_copy_role.attr,
+	&dev_attr_ping.attr,
 	NULL,
 };
 
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index d4d3bd33553b..95b0cd071cad 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -6277,6 +6277,49 @@ static int dasd_eckd_query_pprc_status(struct dasd_device *device,
 	return rc;
 }
 
+/*
+ * ECKD NOP - no operation
+ */
+static int dasd_eckd_nop(struct dasd_device *device)
+{
+	struct dasd_ccw_req *cqr;
+	struct ccw1 *ccw;
+	int rc;
+
+	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 1, 1, device, NULL);
+	if (IS_ERR(cqr)) {
+		DBF_EVENT_DEVID(DBF_WARNING, device->cdev, "%s",
+				"Could not allocate NOP request");
+		return PTR_ERR(cqr);
+	}
+	cqr->startdev = device;
+	cqr->memdev = device;
+	cqr->block = NULL;
+	cqr->retries = 1;
+	cqr->expires = 10 * HZ;
+
+	ccw = cqr->cpaddr;
+	ccw->cmd_code = DASD_ECKD_CCW_NOP;
+	ccw->flags |= CCW_FLAG_SLI;
+
+	cqr->buildclk = get_tod_clock();
+	cqr->status = DASD_CQR_FILLED;
+
+	rc = dasd_sleep_on_interruptible(cqr);
+	if (rc != 0) {
+		DBF_EVENT_DEVID(DBF_WARNING, device->cdev,
+				"NOP failed with rc=%d\n", rc);
+		rc = -EOPNOTSUPP;
+	}
+	dasd_sfree_request(cqr, cqr->memdev);
+	return rc;
+}
+
+static int dasd_eckd_device_ping(struct dasd_device *device)
+{
+	return dasd_eckd_nop(device);
+}
+
 /*
  * Perform Subsystem Function - CUIR response
  */
@@ -6899,6 +6942,7 @@ static struct dasd_discipline dasd_eckd_discipline = {
 	.pprc_status = dasd_eckd_query_pprc_status,
 	.pprc_enabled = dasd_eckd_pprc_enabled,
 	.copy_pair_swap = dasd_eckd_copy_pair_swap,
+	.device_ping = dasd_eckd_device_ping,
 };
 
 static int __init
diff --git a/drivers/s390/block/dasd_eckd.h b/drivers/s390/block/dasd_eckd.h
index 4da9d0331be5..f9299bd184ba 100644
--- a/drivers/s390/block/dasd_eckd.h
+++ b/drivers/s390/block/dasd_eckd.h
@@ -13,6 +13,7 @@
 /*****************************************************************************
  * SECTION: CCW Definitions
  ****************************************************************************/
+#define DASD_ECKD_CCW_NOP		 0x03
 #define DASD_ECKD_CCW_WRITE		 0x05
 #define DASD_ECKD_CCW_READ		 0x06
 #define DASD_ECKD_CCW_WRITE_HOME_ADDRESS 0x09
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 3c55c29155ef..c7223c4eba52 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -439,6 +439,7 @@ struct dasd_discipline {
 	int (*pprc_status)(struct dasd_device *, struct	dasd_pprc_data_sc4 *);
 	bool (*pprc_enabled)(struct dasd_device *);
 	int (*copy_pair_swap)(struct dasd_device *, char *, char *);
+	int (*device_ping)(struct dasd_device *);
 };
 
 extern struct dasd_discipline *dasd_diag_discipline_pointer;
-- 
2.34.1

