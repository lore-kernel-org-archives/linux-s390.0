Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BF6C43460
	for <linux-s390@archiver.kernel.org>; Wed, 28 Apr 2021 15:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E9C861407
	for <linux-s390@archiver.kernel.org>; Wed, 28 Apr 2021 15:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236938AbhD1PgS (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 28 Apr 2021 11:36:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52198 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231347AbhD1PgQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Apr 2021 11:36:16 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFXfeN171773;
        Wed, 28 Apr 2021 11:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=1iTVJAxTDxxco/D/n+/zcDtQNRIBj/p1Us04chyu/XU=;
 b=VL4zwXhexNevA3UNBQMzvPmtuBUNf1wcfAnbbgWGWubWJMTorq1w+31Je/D69uII1g/3
 ARO/0LD8jQBWbR2D9w1uyI+26HIhbCY88GWoqDFLfaWw0p3PCu+h10XlZChjiMKPi0ow
 G1haWqCTkSLFMhdjAEkl/BkebmAJLVIwkg0Np+bK7qD/2Af4X+RoIV67uizI0u7cIbhf
 bBD+i+wCBHpgv/BUTu7xEls5g6xoe0laRhH0RN1aaNuVgfPRvrFQJw+2YbTJDbnzlQ+Q
 CL/LLussVl3IduACKzGGeqVCwwEuiK5NcyDVqxVyXBJqwqSO0/Oqw2iHQobab/p9b7hP Bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 387a9grb8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Apr 2021 11:35:29 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13SFXhJG171962;
        Wed, 28 Apr 2021 11:35:29 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 387a9grb7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Apr 2021 11:35:28 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13SFNrVY014994;
        Wed, 28 Apr 2021 15:35:26 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 384akh9ycu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Apr 2021 15:35:26 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13SFZMsx36241886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:22 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69F14AE056;
        Wed, 28 Apr 2021 15:35:22 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57E42AE053;
        Wed, 28 Apr 2021 15:35:22 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 28 Apr 2021 15:35:22 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id F28A3E07EA; Wed, 28 Apr 2021 17:35:21 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH 1/1] s390: dasd: Mundane spelling fixes
Date:   Wed, 28 Apr 2021 17:35:21 +0200
Message-Id: <20210428153521.2050899-2-sth@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210428153521.2050899-1-sth@linux.ibm.com>
References: <20210428153521.2050899-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FgyO-kuWy0HWSyzVjf0BanJkkJ8Ko7W9
X-Proofpoint-ORIG-GUID: ynYdZvoDYaqT6JGFQrwEH1XBDbFmySQy
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-28_09:2021-04-28,2021-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104280101
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Bhaskar Chowdhury <unixbhaskar@gmail.com>

s/Subssystem/Subsystem/ ......two different places
s/reportet/reported/
s/managemnet/management/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.h b/drivers/s390/block/dasd_eckd.h
index ca24a78a256e..73651211789f 100644
--- a/drivers/s390/block/dasd_eckd.h
+++ b/drivers/s390/block/dasd_eckd.h
@@ -52,7 +52,7 @@
 #define DASD_ECKD_CCW_RCD		 0xFA
 #define DASD_ECKD_CCW_DSO		 0xF7
 
-/* Define Subssystem Function / Orders */
+/* Define Subsystem Function / Orders */
 #define DSO_ORDER_RAS			 0x81
 
 /*
@@ -110,7 +110,7 @@
 #define DASD_ECKD_PG_GROUPED		 0x10
 
 /*
- * Size that is reportet for large volumes in the old 16-bit no_cyl field
+ * Size that is reported for large volumes in the old 16-bit no_cyl field
  */
 #define LV_COMPAT_CYL 0xFFFE
 
@@ -555,7 +555,7 @@ struct dasd_dso_ras_ext_range {
 } __packed;
 
 /*
- * Define Subsytem Operation - Release Allocated Space
+ * Define Subsystem Operation - Release Allocated Space
  */
 struct dasd_dso_ras_data {
 	__u8 order;
@@ -676,7 +676,7 @@ struct dasd_eckd_private {
 	struct dasd_ext_pool_sum eps;
 	u32 real_cyl;
 
-	/* alias managemnet */
+	/* alias management */
 	struct dasd_uid uid;
 	struct alias_pav_group *pavgroup;
 	struct alias_lcu *lcu;
-- 
2.25.1

