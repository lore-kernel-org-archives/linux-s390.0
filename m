Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E1DC4332D
	for <linux-s390@archiver.kernel.org>; Tue, 16 Mar 2021 09:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 251C365013
	for <linux-s390@archiver.kernel.org>; Tue, 16 Mar 2021 09:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbhCPJpY (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 16 Mar 2021 05:45:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2956 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234833AbhCPJpU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 16 Mar 2021 05:45:20 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12G9XZZr052102;
        Tue, 16 Mar 2021 05:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=nOwEDKqj8mfQXaVI7b+g2CXodwCOeNS2FNnDKN1JiEY=;
 b=pO2sCVjRJ7clLMYQUGCzBq5agUIc4jloVDfEWt0ou0Py39vLBVePkkWnqCa6l5A8vRzi
 G9x7Bao8hFlC0WoPyZszekgTHMOUQU3aBjaXs/bi9DLb85wteCgw+9gvTsRSdLE0ORYb
 NYo/kVFVbyTDS1T125sbhLcSkXmYfomy1ZYb9QJiKTloMZa9RP94SCdYc1dMxTajlDuP
 gg19/dUpj018xnw4Q7X97OIxEcn5DOOM1eh+6Lg5pTEpSMNcQpYOtj7eExuQcmJIXFiD
 IOGpdyTAnv36mkKf52nXJXD8r+5vySAze8FV54msmNpIASh8/pq1hMl1QKKbKJwk6fgn 7w== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37arj1k2ec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Mar 2021 05:45:19 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12G9gS6A030086;
        Tue, 16 Mar 2021 09:45:17 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 378mnh2q3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Mar 2021 09:45:17 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12G9jE1h21627302
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Mar 2021 09:45:14 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87B1E42041;
        Tue, 16 Mar 2021 09:45:14 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 723A44204C;
        Tue, 16 Mar 2021 09:45:14 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 16 Mar 2021 09:45:14 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id ECD2FE1336; Tue, 16 Mar 2021 10:45:13 +0100 (CET)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH 2/2] s390/dasd: let driver core manage the sysfs attributes
Date:   Tue, 16 Mar 2021 10:45:13 +0100
Message-Id: <20210316094513.2601218-3-sth@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210316094513.2601218-1-sth@linux.ibm.com>
References: <20210316094513.2601218-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-16_03:2021-03-15,2021-03-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 mlxscore=0 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103160065
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Julian Wiedmann <jwi@linux.ibm.com>

Wire up device_driver->dev_groups, so that really_probe() creates the
sysfs attributes for us automatically.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>

---
 drivers/s390/block/dasd.c        | 17 ++---------------
 drivers/s390/block/dasd_devmap.c | 15 ++-------------
 drivers/s390/block/dasd_eckd.c   |  1 +
 drivers/s390/block/dasd_fba.c    |  1 +
 drivers/s390/block/dasd_int.h    |  3 +--
 5 files changed, 7 insertions(+), 30 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index ba9ce4e0d30a..a446f7c1ec68 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -3440,15 +3440,6 @@ static void dasd_generic_auto_online(void *data, async_cookie_t cookie)
  */
 int dasd_generic_probe(struct ccw_device *cdev)
 {
-	int ret;
-
-	ret = dasd_add_sysfs_files(cdev);
-	if (ret) {
-		DBF_EVENT_DEVID(DBF_WARNING, cdev, "%s",
-				"dasd_generic_probe: could not add "
-				"sysfs entries");
-		return ret;
-	}
 	cdev->handler = &dasd_int_handler;
 
 	/*
@@ -3489,15 +3480,13 @@ void dasd_generic_remove(struct ccw_device *cdev)
 	struct dasd_block *block;
 
 	device = dasd_device_from_cdev(cdev);
-	if (IS_ERR(device)) {
-		dasd_remove_sysfs_files(cdev);
+	if (IS_ERR(device))
 		return;
-	}
+
 	if (test_and_set_bit(DASD_FLAG_OFFLINE, &device->flags) &&
 	    !test_bit(DASD_FLAG_SAFE_OFFLINE_RUNNING, &device->flags)) {
 		/* Already doing offline processing */
 		dasd_put_device(device);
-		dasd_remove_sysfs_files(cdev);
 		return;
 	}
 	/*
@@ -3516,8 +3505,6 @@ void dasd_generic_remove(struct ccw_device *cdev)
 	 */
 	if (block)
 		dasd_free_block(block);
-
-	dasd_remove_sysfs_files(cdev);
 }
 EXPORT_SYMBOL_GPL(dasd_generic_remove);
 
diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
index 03d27ee9cac6..2c40fe15da55 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
@@ -1772,12 +1772,13 @@ static const struct attribute_group ext_pool_attr_group = {
 	.attrs = ext_pool_attrs,
 };
 
-static const struct attribute_group *dasd_attr_groups[] = {
+const struct attribute_group *dasd_dev_groups[] = {
 	&dasd_attr_group,
 	&capacity_attr_group,
 	&ext_pool_attr_group,
 	NULL,
 };
+EXPORT_SYMBOL_GPL(dasd_dev_groups);
 
 /*
  * Return value of the specified feature.
@@ -1895,18 +1896,6 @@ void dasd_path_remove_kobjects(struct dasd_device *device)
 }
 EXPORT_SYMBOL(dasd_path_remove_kobjects);
 
-int dasd_add_sysfs_files(struct ccw_device *cdev)
-{
-	return sysfs_create_groups(&cdev->dev.kobj, dasd_attr_groups);
-}
-
-void
-dasd_remove_sysfs_files(struct ccw_device *cdev)
-{
-	sysfs_remove_groups(&cdev->dev.kobj, dasd_attr_groups);
-}
-
-
 int
 dasd_devmap_init(void)
 {
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 65eb87cbbb9b..a6ac505cbdd7 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -6630,6 +6630,7 @@ static struct ccw_driver dasd_eckd_driver = {
 	.driver = {
 		.name	= "dasd-eckd",
 		.owner	= THIS_MODULE,
+		.dev_groups = dasd_dev_groups,
 	},
 	.ids	     = dasd_eckd_ids,
 	.probe	     = dasd_eckd_probe,
diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
index f76fe05b66c6..4789410885e4 100644
--- a/drivers/s390/block/dasd_fba.c
+++ b/drivers/s390/block/dasd_fba.c
@@ -64,6 +64,7 @@ static struct ccw_driver dasd_fba_driver = {
 	.driver = {
 		.name	= "dasd-fba",
 		.owner	= THIS_MODULE,
+		.dev_groups = dasd_dev_groups,
 	},
 	.ids         = dasd_fba_ids,
 	.probe       = dasd_generic_probe,
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index b8a04c42d1d2..1c59b0e86a9f 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -854,8 +854,7 @@ void dasd_delete_device(struct dasd_device *);
 int dasd_get_feature(struct ccw_device *, int);
 int dasd_set_feature(struct ccw_device *, int, int);
 
-int dasd_add_sysfs_files(struct ccw_device *);
-void dasd_remove_sysfs_files(struct ccw_device *);
+extern const struct attribute_group *dasd_dev_groups[];
 void dasd_path_create_kobj(struct dasd_device *, int);
 void dasd_path_create_kobjects(struct dasd_device *);
 void dasd_path_remove_kobjects(struct dasd_device *);
-- 
2.25.1

