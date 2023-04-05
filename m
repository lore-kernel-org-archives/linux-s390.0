Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5AFC77B60
	for <linux-s390@archiver.kernel.org>; Wed,  5 Apr 2023 14:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238519AbjDEOpk (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 5 Apr 2023 10:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237141AbjDEOpf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 5 Apr 2023 10:45:35 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7437555A2;
        Wed,  5 Apr 2023 07:45:18 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 335Dv5kH027527;
        Wed, 5 Apr 2023 14:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=K9U7CngF092J/Ij/0GiMkCJMBS955G6gSplf3tnSakM=;
 b=PuVzx4bogD+94c32OirHFT1s4IzjF07JZgykKqJhg9IouuO89V5A+O/LIYyu7V+qgrTA
 08kHHTTrz63ABzGQLK39LYyQ5j4yEp9/34hroSMkluFYq1FUamC1ObaAah/WTadaEPCU
 3u9XBrpu7KTLIiB9mtojVthvO/6ou8jh4M8cxTTBV/0pUL0d75FqsTIi3rSeuU3hpFRB
 REXc7emRebtVFwZp6E6YPuIoju0U7Q2jC7XyjWEWO4UU7HxFCON3fDcRAZp5qibHnzjD
 BwDgVKxMAzw7tvNOg0t/iHV5Yb7xkzHZ/QOFEGdCrhUNk9y1DCcQTREyD6skRBvG9Zrf sg== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3psaamrrg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 14:20:24 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3352efn4008120;
        Wed, 5 Apr 2023 14:20:22 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3ppc86tjnt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 14:20:21 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 335EKHed7799420
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Apr 2023 14:20:18 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1BC220043;
        Wed,  5 Apr 2023 14:20:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C079920040;
        Wed,  5 Apr 2023 14:20:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed,  5 Apr 2023 14:20:17 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 83292E128D; Wed,  5 Apr 2023 16:20:17 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 3/7] s390/dasd: add aq_mask sysfs attribute
Date:   Wed,  5 Apr 2023 16:20:13 +0200
Message-Id: <20230405142017.2446986-4-sth@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230405142017.2446986-1-sth@linux.ibm.com>
References: <20230405142017.2446986-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7nFuNBAq6WH_vdwbN89-loZk3hcKavwP
X-Proofpoint-ORIG-GUID: 7nFuNBAq6WH_vdwbN89-loZk3hcKavwP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_09,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304050127
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Add sysfs attribute that controls the DASD autoquiesce feature.
The autoquiesce is disabled when 0 is echoed to the attribute.

A value greater than 0 will enable the feature.
The aq_mask attribute will accept an unsigned integer and the value
will be interpreted as bitmask defining the trigger events that will
lead to an automatic quiesce.

The following autoquiesce triggers will currently be available:

DASD_EER_FATALERROR  1 - any final I/O error
DASD_EER_NOPATH      2 - no remaining paths for the device
DASD_EER_STATECHANGE 3 - a state change interrupt occurred
DASD_EER_PPRCSUSPEND 4 - the device is PPRC suspended
DASD_EER_NOSPC       5 - there is no space remaining on an ESE device
DASD_EER_TIMEOUT     6 - a certain amount of timeouts occurred
DASD_EER_STARTIO     7 - the IO start function encountered an error

The currently supported maximum value is 255.

Bit 31 is reserved for internal usage.
Bit 0 is not used.

Example:

 - deactivate autoquiesce
   $ echo 0 > /sys/bus/ccw/0.0.1234/aq_mask

 - enable autoquiesce for FATALERROR, NOPATH and TIMEOUT
   (0000 0000 0000 0000  0000 0000 0100 0110 => 70)
   $ echo 70 > /sys/bus/ccw/0.0.1234/aq_mask

Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
---
 drivers/s390/block/dasd_devmap.c | 43 ++++++++++++++++++++++++++++++++
 drivers/s390/block/dasd_int.h    | 23 +++++++++++------
 2 files changed, 59 insertions(+), 7 deletions(-)

diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
index df17f0f9cb0f..c7c948c55761 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
@@ -50,6 +50,7 @@ struct dasd_devmap {
         unsigned short features;
 	struct dasd_device *device;
 	struct dasd_copy_relation *copy;
+	unsigned int aq_mask;
 };
 
 /*
@@ -1475,6 +1476,47 @@ dasd_eer_store(struct device *dev, struct device_attribute *attr,
 
 static DEVICE_ATTR(eer_enabled, 0644, dasd_eer_show, dasd_eer_store);
 
+/*
+ * aq_mask controls if the DASD should be quiesced on certain triggers
+ * The aq_mask attribute is interpreted as bitmap of the DASD_EER_* triggers.
+ */
+static ssize_t dasd_aq_mask_show(struct device *dev, struct device_attribute *attr,
+				 char *buf)
+{
+	struct dasd_devmap *devmap;
+	unsigned int aq_mask = 0;
+
+	devmap = dasd_find_busid(dev_name(dev));
+	if (!IS_ERR(devmap))
+		aq_mask = devmap->aq_mask;
+
+	return sysfs_emit(buf, "%d\n", aq_mask);
+}
+
+static ssize_t dasd_aq_mask_store(struct device *dev, struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct dasd_devmap *devmap;
+	unsigned int val;
+
+	if (kstrtouint(buf, 0, &val) || val > DASD_EER_VALID)
+		return -EINVAL;
+
+	devmap = dasd_devmap_from_cdev(to_ccwdev(dev));
+	if (IS_ERR(devmap))
+		return PTR_ERR(devmap);
+
+	spin_lock(&dasd_devmap_lock);
+	devmap->aq_mask = val;
+	if (devmap->device)
+		devmap->device->aq_mask = devmap->aq_mask;
+	spin_unlock(&dasd_devmap_lock);
+
+	return count;
+}
+
+static DEVICE_ATTR(aq_mask, 0644, dasd_aq_mask_show, dasd_aq_mask_store);
+
 /*
  * expiration time for default requests
  */
@@ -2324,6 +2366,7 @@ static struct attribute * dasd_attrs[] = {
 	&dev_attr_copy_pair.attr,
 	&dev_attr_copy_role.attr,
 	&dev_attr_ping.attr,
+	&dev_attr_aq_mask.attr,
 	NULL,
 };
 
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index d0ff4528d489..c4633a4aeeb1 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -444,13 +444,22 @@ struct dasd_discipline {
 
 extern struct dasd_discipline *dasd_diag_discipline_pointer;
 
-/* Trigger IDs for extended error reporting */
-#define DASD_EER_FATALERROR  1
-#define DASD_EER_NOPATH      2
-#define DASD_EER_STATECHANGE 3
-#define DASD_EER_PPRCSUSPEND 4
-#define DASD_EER_NOSPC	     5
-#define DASD_EER_AUTOQUIESCE 31
+/* Trigger IDs for extended error reporting DASD EER and autoquiesce */
+enum eer_trigger {
+	DASD_EER_FATALERROR = 1,
+	DASD_EER_NOPATH,
+	DASD_EER_STATECHANGE,
+	DASD_EER_PPRCSUSPEND,
+	DASD_EER_NOSPC,
+	DASD_EER_TIMEOUTS,
+	DASD_EER_STARTIO,
+
+	/* enum end marker, only add new trigger above */
+	DASD_EER_MAX,
+	DASD_EER_AUTOQUIESCE = 31, /* internal only */
+};
+
+#define DASD_EER_VALID ((1U << DASD_EER_MAX) - 1)
 
 /* DASD path handling */
 
-- 
2.37.2

