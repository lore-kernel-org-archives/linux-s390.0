Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAE5C76188
	for <linux-s390@archiver.kernel.org>; Wed,  5 Apr 2023 15:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238746AbjDEP2s (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 5 Apr 2023 11:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238419AbjDEP2f (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 5 Apr 2023 11:28:35 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FAE10D7;
        Wed,  5 Apr 2023 08:28:33 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 335DphOV009814;
        Wed, 5 Apr 2023 14:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=7kxY822MPocNKSdqvn57EZwmW7rbq5ipdqzd+HiheKI=;
 b=HWJQIhCQICU+ugfbgBtAkph91SaEUG2uDos3f3ma2hRPrcArJP1tyUBhdKkYdRHasVdE
 LGw5k6DOhmKe+cheKDiyeZPWwAsnW/Y6GVvQZPVcjG149jSdv/brzHMcGs9OgFSXG2EX
 mmucnOhq3hywNVdgPYI1vI8+meD0sGufwsSf2Gk+PHGeYVLNdzTs0Bc1dUMFFzFAnzXt
 w/OD79tKEdvNUXRd0YMOlnTWTJsvuDoGGJ3H/Tabe0FCxbcA7JiePRq1zJpZRZ3SnYLR
 fi4HGYPSXd7fXrkQWeDtt0LZB1pgw60mgq/xAxTleDgD/AZTa2yGKF+fGfgeoxOO8yxc tw== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ps8fym6d3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 14:20:24 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3354n3DC029047;
        Wed, 5 Apr 2023 14:20:21 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3ppc86tjqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 14:20:21 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 335EKIFQ48824832
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Apr 2023 14:20:18 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 214D12004E;
        Wed,  5 Apr 2023 14:20:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DAAF20040;
        Wed,  5 Apr 2023 14:20:18 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed,  5 Apr 2023 14:20:18 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 88E53E13E0; Wed,  5 Apr 2023 16:20:17 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 5/7] s390/dasd: add aq_timeouts autoquiesce trigger
Date:   Wed,  5 Apr 2023 16:20:15 +0200
Message-Id: <20230405142017.2446986-6-sth@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230405142017.2446986-1-sth@linux.ibm.com>
References: <20230405142017.2446986-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UmBwgRq4TrRSHC0fPznxUENod8KSyKkY
X-Proofpoint-ORIG-GUID: UmBwgRq4TrRSHC0fPznxUENod8KSyKkY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_09,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304050127
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Add a sysfs attribute aq_timeouts that controls after how many
timeouts a autoquiesce event might be triggered.

The default value is 32768 which is the maximum number of retries
for the DASD device driver DASD_RETRIES_MAX. This means that the
timeout trigger will never happen.

The default value for DASD retries is 255.
Setting the value to below 255 will trigger the timeout autoquiesce
event before an IO error is generated.

Also add the check for the configured amount of timeouts and trigger
an autoquiesce event if exceeded.

Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
---
 drivers/s390/block/dasd.c        | 11 ++++++++
 drivers/s390/block/dasd_devmap.c | 47 ++++++++++++++++++++++++++++++++
 drivers/s390/block/dasd_eckd.c   |  1 +
 drivers/s390/block/dasd_int.h    |  1 +
 4 files changed, 60 insertions(+)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 8186473b9aa7..1bfd0e17a4dc 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -1953,6 +1953,16 @@ static void __dasd_device_process_final_queue(struct dasd_device *device,
 	}
 }
 
+/*
+ * check if device should be autoquiesced due to too many timeouts
+ */
+static void __dasd_device_check_autoquiesce_timeout(struct dasd_device *device,
+						    struct dasd_ccw_req *cqr)
+{
+	if ((device->default_retries - cqr->retries) >= device->aq_timeouts)
+		dasd_handle_autoquiesce(device, cqr, DASD_EER_TIMEOUTS);
+}
+
 /*
  * Take a look at the first request on the ccw queue and check
  * if it reached its expire time. If so, terminate the IO.
@@ -1987,6 +1997,7 @@ static void __dasd_device_check_expire(struct dasd_device *device)
 				"remaining\n", cqr, (cqr->expires/HZ),
 				cqr->retries);
 		}
+		__dasd_device_check_autoquiesce_timeout(device, cqr);
 	}
 }
 
diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
index 95c7959c7949..620fab01b710 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
@@ -1552,6 +1552,52 @@ static ssize_t dasd_aqr_store(struct device *dev, struct device_attribute *attr,
 
 static DEVICE_ATTR(aq_requeue, 0644, dasd_aqr_show, dasd_aqr_store);
 
+/*
+ * aq_timeouts controls how much retries have to time out until
+ * a device gets autoquiesced
+ */
+static ssize_t
+dasd_aq_timeouts_show(struct device *dev, struct device_attribute *attr,
+		      char *buf)
+{
+	struct dasd_device *device;
+	int len;
+
+	device = dasd_device_from_cdev(to_ccwdev(dev));
+	if (IS_ERR(device))
+		return -ENODEV;
+	len = sysfs_emit(buf, "%u\n", device->aq_timeouts);
+	dasd_put_device(device);
+	return len;
+}
+
+static ssize_t
+dasd_aq_timeouts_store(struct device *dev, struct device_attribute *attr,
+		       const char *buf, size_t count)
+{
+	struct dasd_device *device;
+	unsigned int val;
+
+	device = dasd_device_from_cdev(to_ccwdev(dev));
+	if (IS_ERR(device))
+		return -ENODEV;
+
+	if ((kstrtouint(buf, 10, &val) != 0) ||
+	    val > DASD_RETRIES_MAX || val == 0) {
+		dasd_put_device(device);
+		return -EINVAL;
+	}
+
+	if (val)
+		device->aq_timeouts = val;
+
+	dasd_put_device(device);
+	return count;
+}
+
+static DEVICE_ATTR(aq_timeouts, 0644, dasd_aq_timeouts_show,
+		   dasd_aq_timeouts_store);
+
 /*
  * expiration time for default requests
  */
@@ -2403,6 +2449,7 @@ static struct attribute * dasd_attrs[] = {
 	&dev_attr_ping.attr,
 	&dev_attr_aq_mask.attr,
 	&dev_attr_aq_requeue.attr,
+	&dev_attr_aq_timeouts.attr,
 	NULL,
 };
 
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 1a69f97e88fb..ade1369fe5ed 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -2109,6 +2109,7 @@ dasd_eckd_check_characteristics(struct dasd_device *device)
 	device->default_retries = DASD_RETRIES;
 	device->path_thrhld = DASD_ECKD_PATH_THRHLD;
 	device->path_interval = DASD_ECKD_PATH_INTERVAL;
+	device->aq_timeouts = DASD_RETRIES_MAX;
 
 	if (private->conf.gneq) {
 		value = 1;
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index c4633a4aeeb1..33f812f0e515 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -638,6 +638,7 @@ struct dasd_device {
 	struct kset *paths_info;
 	struct dasd_copy_relation *copy;
 	unsigned long aq_mask;
+	unsigned int aq_timeouts;
 };
 
 struct dasd_block {
-- 
2.37.2

