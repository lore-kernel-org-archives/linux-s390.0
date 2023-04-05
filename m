Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51804C7619A
	for <linux-s390@archiver.kernel.org>; Wed,  5 Apr 2023 14:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238073AbjDEOVr (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 5 Apr 2023 10:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238159AbjDEOVe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 5 Apr 2023 10:21:34 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE9365B4;
        Wed,  5 Apr 2023 07:21:02 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 335E5Xjr012614;
        Wed, 5 Apr 2023 14:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=NvhqejzlhmjRM7wQ/qoA6+OzhVw6T62MZI5vJX2MCDY=;
 b=f9HfXBHAM/EeXcFIJ+2I/tNYyuap8VKwVQnyUVhlJKhVSJ4yFVXXmoZIDiK3dqwclCzy
 nkAMp8iHC4nPVNMQYqdfaM6r2zhiopZUIRLRcybPRMcErtJd9F5huNAM2icYI4+YgPl7
 YhIwWao35xVgcRFAw1HyoMNyJvcn7UklOwH/HeYevMxubFTELG0Yl4fAFrRNrIzy6vJk
 X5Big887LM9vAiaLWONp6za8X20YJ+aiu4UlIkzBOrT8z1YV7tzUqzr/eEuCLL3lw6BW
 FONw5oDVrVC9/k5Xncic0lm4w9jW+lZxc62Si5WiGwRIlRn2OQZEhb11FlHpaIn6Btg7 HA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ps7n3dh0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 14:20:23 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3355SQ5d015821;
        Wed, 5 Apr 2023 14:20:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3ppc873cnm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 14:20:21 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 335EKHMg60031302
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Apr 2023 14:20:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFE3B20043;
        Wed,  5 Apr 2023 14:20:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B11E82004D;
        Wed,  5 Apr 2023 14:20:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed,  5 Apr 2023 14:20:17 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 85F03E13C2; Wed,  5 Apr 2023 16:20:17 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 4/7] s390/dasd: add aq_requeue sysfs attribute
Date:   Wed,  5 Apr 2023 16:20:14 +0200
Message-Id: <20230405142017.2446986-5-sth@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230405142017.2446986-1-sth@linux.ibm.com>
References: <20230405142017.2446986-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Yah03fj-0NoguClZuY0zRJbFtgDip_nL
X-Proofpoint-ORIG-GUID: Yah03fj-0NoguClZuY0zRJbFtgDip_nL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_09,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304050127
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Add a sysfs attribute to control if all IO requests will be requeued to
the blocklayer in case of an autoquiesce event or not.

A value of 1 means that in case of an autoquiesce event all IO requests
will be requeued to the blocklayer.

A value of 0 means that the device will only be stopped.

Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
---
 drivers/s390/block/dasd_devmap.c | 36 ++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
index c7c948c55761..95c7959c7949 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
@@ -1517,6 +1517,41 @@ static ssize_t dasd_aq_mask_store(struct device *dev, struct device_attribute *a
 
 static DEVICE_ATTR(aq_mask, 0644, dasd_aq_mask_show, dasd_aq_mask_store);
 
+/*
+ * aq_requeue controls if requests are returned to the blocklayer on quiesce
+ * or if requests are only not started
+ */
+static ssize_t dasd_aqr_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct dasd_devmap *devmap;
+	int flag;
+
+	devmap = dasd_find_busid(dev_name(dev));
+	if (!IS_ERR(devmap))
+		flag = (devmap->features & DASD_FEATURE_REQUEUEQUIESCE) != 0;
+	else
+		flag = (DASD_FEATURE_DEFAULT &
+			DASD_FEATURE_REQUEUEQUIESCE) != 0;
+	return sysfs_emit(buf, "%d\n", flag);
+}
+
+static ssize_t dasd_aqr_store(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	bool val;
+	int rc;
+
+	if (kstrtobool(buf, &val))
+		return -EINVAL;
+
+	rc = dasd_set_feature(to_ccwdev(dev), DASD_FEATURE_REQUEUEQUIESCE, val);
+
+	return rc ? : count;
+}
+
+static DEVICE_ATTR(aq_requeue, 0644, dasd_aqr_show, dasd_aqr_store);
+
 /*
  * expiration time for default requests
  */
@@ -2367,6 +2402,7 @@ static struct attribute * dasd_attrs[] = {
 	&dev_attr_copy_role.attr,
 	&dev_attr_ping.attr,
 	&dev_attr_aq_mask.attr,
+	&dev_attr_aq_requeue.attr,
 	NULL,
 };
 
-- 
2.37.2

