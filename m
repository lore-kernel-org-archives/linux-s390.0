Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B79C54EE9
	for <linux-s390@archiver.kernel.org>; Tue, 20 Sep 2022 19:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiITT0h (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 20 Sep 2022 15:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbiITT0Y (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 20 Sep 2022 15:26:24 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B4A51A11;
        Tue, 20 Sep 2022 12:26:23 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28KJIaVh013924;
        Tue, 20 Sep 2022 19:26:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=TDJkBDekJN3cNZVDtaQEzNe5h7ulxPKuetL3VQdnTyw=;
 b=nuPCDhAAYYfBeUPAXu0QdjvFigk72rfb0uqEN9Aa8Bk0a0werNJ9j8efoOxHoaW6/k23
 UscBoQkRkyF560lyz4zc6DzJN+eazW1Hs6Gdhk9RriduEAzGVnSzI1jDQ4vBIzXz1uoX
 5WUbFye1p1WO2c4LoAhXzHDJLXGP27M3ai8Q1qK8AKz2NK6VmpnKfjOJH/khpMXqgltB
 KDRfXbMzmmV/oBhD5F1448O3oeTovFSkJ9cgjGEo4fvAibhk1WrOSlJJZ6Q8OE4nfgaj
 fBwDi3KcO5VX1a2q3djpOUkMovePL4Gtglk0b7x4YDhjPm7GyyHNHiL78IFy3IWxUfjH BA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jqjp9sjvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 19:26:22 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28KJNDKB005774;
        Tue, 20 Sep 2022 19:26:20 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3jn5v8mad2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 19:26:20 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28KJQHe336045284
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Sep 2022 19:26:17 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F4FE52054;
        Tue, 20 Sep 2022 19:26:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 1C33D52051;
        Tue, 20 Sep 2022 19:26:17 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 9B8B7E080C; Tue, 20 Sep 2022 21:26:16 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 6/7] s390/dasd: suppress generic error messages for PPRC secondary devices
Date:   Tue, 20 Sep 2022 21:26:15 +0200
Message-Id: <20220920192616.808070-7-sth@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220920192616.808070-1-sth@linux.ibm.com>
References: <20220920192616.808070-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1Z108dGtnlSmieFEkU8tO6yMyLfrW6_j
X-Proofpoint-GUID: 1Z108dGtnlSmieFEkU8tO6yMyLfrW6_j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_09,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 clxscore=1015 impostorscore=0 phishscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209200114
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Suppress generic command reject messages and dump of sense data for
Peer-To-Peer-Remote-Copy (PPRC) secondary errors.
If IO is issued on a PPRC secondary device, a specific
error message is printed instead.

Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
---
 arch/s390/include/asm/scsw.h       | 5 +++++
 drivers/s390/block/dasd_3990_erp.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/s390/include/asm/scsw.h b/arch/s390/include/asm/scsw.h
index 7ce584aff5bb..322bdcd4b616 100644
--- a/arch/s390/include/asm/scsw.h
+++ b/arch/s390/include/asm/scsw.h
@@ -215,6 +215,11 @@ union scsw {
 #define SNS2_ENV_DATA_PRESENT	0x10
 #define SNS2_INPRECISE_END	0x04
 
+/*
+ * architectured values for PPRC errors
+ */
+#define SNS7_INVALID_ON_SEC	0x0e
+
 /**
  * scsw_is_tm - check for transport mode scsw
  * @scsw: pointer to scsw
diff --git a/drivers/s390/block/dasd_3990_erp.c b/drivers/s390/block/dasd_3990_erp.c
index 299001ad9a32..81d283b3cd3b 100644
--- a/drivers/s390/block/dasd_3990_erp.c
+++ b/drivers/s390/block/dasd_3990_erp.c
@@ -1050,6 +1050,11 @@ dasd_3990_erp_com_rej(struct dasd_ccw_req * erp, char *sense)
 		dev_err(&device->cdev->dev, "An I/O request was rejected"
 			" because writing is inhibited\n");
 		erp = dasd_3990_erp_cleanup(erp, DASD_CQR_FAILED);
+	} else if (sense[7] & SNS7_INVALID_ON_SEC) {
+		dev_err(&device->cdev->dev, "An I/O request was rejected on a copy pair secondary device\n");
+		/* suppress dump of sense data for this error */
+		set_bit(DASD_CQR_SUPPRESS_CR, &erp->refers->flags);
+		erp = dasd_3990_erp_cleanup(erp, DASD_CQR_FAILED);
 	} else {
 		/* fatal error -  set status to FAILED
 		   internal error 09 - Command Reject */
-- 
2.34.1

