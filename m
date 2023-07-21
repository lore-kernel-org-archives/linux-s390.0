Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAFAC41513
	for <linux-s390@archiver.kernel.org>; Fri, 21 Jul 2023 19:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjGUTg7 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 21 Jul 2023 15:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjGUTg5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 21 Jul 2023 15:36:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C542D45;
        Fri, 21 Jul 2023 12:36:56 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36LJBJ2V007744;
        Fri, 21 Jul 2023 19:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=HRtiiFVAzuRkDh2mijfMHiCiyFWpzBcHTBb49VM3mtI=;
 b=SS8TyXE3/UcmKYLaggkXhWv+knd2i0+K9CAbQJdKE0dAlyEEAcjdk7Dph8qgPJIx/VEQ
 pzs/DO4zYKjl6W7kOMLdE+OQNfrp70qmVmnad7NEFWLYdJZ5UT0NFD4eitWgttEFo8Kj
 B9B3jwd6S/efxomKti02PsVgcgWkpQGgNSuxsHpQ9g6aZgvh8smbATk9j2KIdXJdAj7g
 qmkceHVxWX69RdOh5xA9OrXUMtBZEE0iHkU7F6WQTTCcTQs8o1FT5w4hd6BvGM/V+zHo
 bi2RaCOJHnqUvg3iz+w2CZ2OnuO/HgbBDcnwksVu3OSOV9DLxupR395UJExenf+OdcrL 1w== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ryp358c5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 19:36:54 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36LI4mxD005272;
        Fri, 21 Jul 2023 19:36:53 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rv65y142t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 19:36:53 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36LJanTM20185648
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jul 2023 19:36:49 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F12BB20043;
        Fri, 21 Jul 2023 19:36:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF69820040;
        Fri, 21 Jul 2023 19:36:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 21 Jul 2023 19:36:48 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 4A78CE26F7; Fri, 21 Jul 2023 21:36:48 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 2/4] s390/dasd: use correct number of retries for ERP requests
Date:   Fri, 21 Jul 2023 21:36:45 +0200
Message-Id: <20230721193647.3889634-3-sth@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230721193647.3889634-1-sth@linux.ibm.com>
References: <20230721193647.3889634-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sU2G7bt4KnNdQW92C6f1yWQL5xuta4lk
X-Proofpoint-GUID: sU2G7bt4KnNdQW92C6f1yWQL5xuta4lk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_11,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307210172
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

If a DASD request fails an error recovery procedure (ERP) request might
be built as a copy of the original request to do error recovery.

The ERP request gets a number of retries assigned.
This number is always 256 no matter what other value might have been set
for the original request. This is not what is expected when a user
specifies a certain amount of retries for the device via sysfs.

Correctly use the number of retries of the original request for ERP
requests.

Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
---
 drivers/s390/block/dasd_3990_erp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd_3990_erp.c b/drivers/s390/block/dasd_3990_erp.c
index 9fd36c468706..91e9a17b848e 100644
--- a/drivers/s390/block/dasd_3990_erp.c
+++ b/drivers/s390/block/dasd_3990_erp.c
@@ -2441,7 +2441,7 @@ static struct dasd_ccw_req *dasd_3990_erp_add_erp(struct dasd_ccw_req *cqr)
 	erp->block    = cqr->block;
 	erp->magic    = cqr->magic;
 	erp->expires  = cqr->expires;
-	erp->retries  = 256;
+	erp->retries  = device->default_retries;
 	erp->buildclk = get_tod_clock();
 	erp->status = DASD_CQR_FILLED;
 
-- 
2.39.2

