Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3E7EB64DD
	for <linux-s390@archiver.kernel.org>; Fri, 21 Jul 2023 19:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjGUT4e (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 21 Jul 2023 15:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGUT4d (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 21 Jul 2023 15:56:33 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5494E171A;
        Fri, 21 Jul 2023 12:56:32 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36LJrNQu028287;
        Fri, 21 Jul 2023 19:56:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=+JwHQunyzK2hQJhuOtWsEn4WW3M8KPcxrbRUu0RMVNg=;
 b=jjf2lAaLKl/0wcoUS+z7dqay7cfwXaPr8l8briUh5HF1Kb7QqX6QzXZmU42B0OurPaBY
 1pU16n6mCEqTXf6inH5KRGSpFJqAa6offM/cZS9mHvCS8FqM6shmwrXts7QJ3vbZKHOK
 kyHvis3G8bbj/Jm8mGREBCWs4hr8nN59SxbdfBRIcOLNRtdSc5VQ/8FOYv3Xgnz8j7RA
 RgvFNhYFk9mrlUdW+OHur/Dr2Hbyum1ow4Lmyq8yHEnorYh0XDUgr7yZDrobBh6pzIHm
 v1q4qO7MjYXv799vHBRZicr5G6CXUG38hqe+2tYEwkYrZvfAsC+v11bqPjApASfP86uS 5A== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s00jt8275-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 19:56:30 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36LIC7xB029129;
        Fri, 21 Jul 2023 19:36:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rv6sn14wv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 19:36:53 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36LJan7w57475462
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jul 2023 19:36:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83D1720043;
        Fri, 21 Jul 2023 19:36:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6FABC20040;
        Fri, 21 Jul 2023 19:36:49 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 21 Jul 2023 19:36:49 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id CDB83E26F8; Fri, 21 Jul 2023 21:36:48 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 4/4] s390/dasd: print copy pair message only for the correct error
Date:   Fri, 21 Jul 2023 21:36:47 +0200
Message-Id: <20230721193647.3889634-5-sth@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230721193647.3889634-1-sth@linux.ibm.com>
References: <20230721193647.3889634-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: O742j87j6jgn9Tyuvq1-E9X7SZOYD7ES
X-Proofpoint-GUID: O742j87j6jgn9Tyuvq1-E9X7SZOYD7ES
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_11,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307210172
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The DASD driver has certain types of requests that might be rejected by
the storage server or z/VM because they are not supported. Since the
missing support of the command is not a real issue there is no user
visible kernel error message for this.

For copy pair setups  there is a specific error that IO is not allowed on
secondary devices. This error case is explicitly handled and an error
message is printed.

The code checking for the error did use a bitwise 'and' that is used to
check for specific bits. But in this case the whole sense byte has to
match.

This leads to the problem that the copy pair related error message is
erroneously printed for other error cases that are usually not reported.
This might heavily confuse users and lead to follow on actions that might
disrupt application processing.

Fix by checking the sense byte for the exact value and not single bits.

Cc: <stable@vger.kernel.org> # 6.1+
Fixes: 1fca631a1185 ("s390/dasd: suppress generic error messages for PPRC secondary devices")
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
---
 drivers/s390/block/dasd_3990_erp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd_3990_erp.c b/drivers/s390/block/dasd_3990_erp.c
index 91e9a17b848e..89957bb7244d 100644
--- a/drivers/s390/block/dasd_3990_erp.c
+++ b/drivers/s390/block/dasd_3990_erp.c
@@ -1050,7 +1050,7 @@ dasd_3990_erp_com_rej(struct dasd_ccw_req * erp, char *sense)
 		dev_err(&device->cdev->dev, "An I/O request was rejected"
 			" because writing is inhibited\n");
 		erp = dasd_3990_erp_cleanup(erp, DASD_CQR_FAILED);
-	} else if (sense[7] & SNS7_INVALID_ON_SEC) {
+	} else if (sense[7] == SNS7_INVALID_ON_SEC) {
 		dev_err(&device->cdev->dev, "An I/O request was rejected on a copy pair secondary device\n");
 		/* suppress dump of sense data for this error */
 		set_bit(DASD_CQR_SUPPRESS_CR, &erp->refers->flags);
-- 
2.39.2

