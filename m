Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F78C6FA93
	for <linux-s390@archiver.kernel.org>; Tue, 20 Sep 2022 19:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbiITT0i (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 20 Sep 2022 15:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbiITT0Y (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 20 Sep 2022 15:26:24 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD32A65818;
        Tue, 20 Sep 2022 12:26:23 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28KJCI9w039671;
        Tue, 20 Sep 2022 19:26:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Gdt7n3+LThJ2a82M1ObSUk7whFtghwBvH8gTIcG8iBc=;
 b=Pi6volHCd83vmkFzVrJQdHa3VqzOOZgcsMbF4fltrP+G+lT9zpApIJfGj2yWRgzuFp/J
 JbjZFN1+usYYMshmIqSDTnA++wIAqG0Oicwy8AU027Kagy/7mHNNQuW4YIJ+7rm1fjr8
 cXYGtMQFuT3SPCdo3/5EM2ZY+MGjW/YHm627uEMXl2UaQWXEHackkr0DVfTWYb22/sHv
 uHtCAUpi7x5SG00aECfCsDQGsee8vtkSQINKE3xJghDKifk52ucDDffcCi18USGdzPD3
 mu0ptFavv6BJBZRbv7GnjDENWrRxOsSCySxayhYfbO2HUSQUjnNQ9ZKoIUiixTkGIMow rQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jqkfa0gpn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 19:26:22 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28KJN296005992;
        Tue, 20 Sep 2022 19:26:20 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3jn5gj49fj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 19:26:20 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28KJQHfn43319626
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Sep 2022 19:26:17 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E91CD42045;
        Tue, 20 Sep 2022 19:26:16 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D746B42041;
        Tue, 20 Sep 2022 19:26:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 20 Sep 2022 19:26:16 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 81D7FE07FF; Tue, 20 Sep 2022 21:26:16 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 1/7] s390/dasd: put block allocation in separate function
Date:   Tue, 20 Sep 2022 21:26:10 +0200
Message-Id: <20220920192616.808070-2-sth@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220920192616.808070-1-sth@linux.ibm.com>
References: <20220920192616.808070-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: W4TE7cZ8hDvFcDpupfn51_Fb7lQWyOa5
X-Proofpoint-GUID: W4TE7cZ8hDvFcDpupfn51_Fb7lQWyOa5
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

Put block allocation into a separate function to put some copy pair logic
in it in a later patch.

Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.c | 38 ++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 3cc93e2e4e15..bdb4207d5aa2 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -2012,6 +2012,25 @@ static void dasd_eckd_kick_validate_server(struct dasd_device *device)
 		dasd_put_device(device);
 }
 
+static int dasd_eckd_alloc_block(struct dasd_device *device)
+{
+	struct dasd_block *block;
+	struct dasd_uid temp_uid;
+
+	dasd_eckd_get_uid(device, &temp_uid);
+	if (temp_uid.type == UA_BASE_DEVICE) {
+		block = dasd_alloc_block();
+		if (IS_ERR(block)) {
+			DBF_EVENT_DEVID(DBF_WARNING, device->cdev, "%s",
+					"could not allocate dasd block structure");
+			return PTR_ERR(block);
+		}
+		device->block = block;
+		block->base = device;
+	}
+	return 0;
+}
+
 /*
  * Check device characteristics.
  * If the device is accessible using ECKD discipline, the device is enabled.
@@ -2020,8 +2039,6 @@ static int
 dasd_eckd_check_characteristics(struct dasd_device *device)
 {
 	struct dasd_eckd_private *private = device->private;
-	struct dasd_block *block;
-	struct dasd_uid temp_uid;
 	int rc, i;
 	int readonly;
 	unsigned long value;
@@ -2079,19 +2096,10 @@ dasd_eckd_check_characteristics(struct dasd_device *device)
 			device->default_expires = value;
 	}
 
-	dasd_eckd_get_uid(device, &temp_uid);
-	if (temp_uid.type == UA_BASE_DEVICE) {
-		block = dasd_alloc_block();
-		if (IS_ERR(block)) {
-			DBF_EVENT_DEVID(DBF_WARNING, device->cdev, "%s",
-					"could not allocate dasd "
-					"block structure");
-			rc = PTR_ERR(block);
-			goto out_err1;
-		}
-		device->block = block;
-		block->base = device;
-	}
+	/* check if block device is needed and allocate in case */
+	rc = dasd_eckd_alloc_block(device);
+	if (rc)
+		goto out_err1;
 
 	/* register lcu with alias handling, enable PAV */
 	rc = dasd_alias_make_device_known_to_lcu(device);
-- 
2.34.1

