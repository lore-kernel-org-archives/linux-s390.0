Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F708C11F67
	for <linux-s390@archiver.kernel.org>; Thu,  1 Jul 2021 14:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27ED9613FE
	for <linux-s390@archiver.kernel.org>; Thu,  1 Jul 2021 14:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbhGAOZC (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:25:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53180 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231844AbhGAOZB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 1 Jul 2021 10:25:01 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 161E47SW128501;
        Thu, 1 Jul 2021 10:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=trtc93CzZcm9S+1QkbKhiiniiHBiwcL5KBMtbOQwhps=;
 b=GTVocm/++oFIkKfiJ9PQy1fAXLjjUCqhs8iNwolC4P1szI6KNdaFLBn1j3sEwuyugPzA
 F4A3avx02SI60kBwYB1Ljfik6NsSmmJ+2v5/z7ydLcZeE5ZWfLFGAaFY6WSZF9VaShR1
 M22UlWB7Gbf9ila8jhCtLpqA1KYXsbFwje/CLxqrY3FJTGGwzK/etBo/1CzTmwHK7GVR
 cBnL9cATI4bKOX3CdnmNiEqXbLgbq51G3aZ6h/Y4D30IyQDr1illkNfKp8bX8L+YaKY6
 aZfrjPlvUueH4OdiZ32r87jj7HnuCcZp9S5k7RPaUtfMw09E4FSkK6qcWwFw8f0Ni+av 1g== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39hdyfu67w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 10:22:27 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 161EDLhN001959;
        Thu, 1 Jul 2021 14:22:25 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 39h19bgemr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 14:22:25 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 161EKfUT32834036
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Jul 2021 14:20:41 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EECB64C04A;
        Thu,  1 Jul 2021 14:22:21 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DAAEA4C050;
        Thu,  1 Jul 2021 14:22:21 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  1 Jul 2021 14:22:21 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 8A168E07EC; Thu,  1 Jul 2021 16:22:21 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 2/2] s390/dasd: Avoid field over-reading memcpy()
Date:   Thu,  1 Jul 2021 16:22:21 +0200
Message-Id: <20210701142221.3408680-3-sth@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210701142221.3408680-1-sth@linux.ibm.com>
References: <20210701142221.3408680-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HAqG1i0y3nkTEPReptHdtHtH2MTzF4uj
X-Proofpoint-ORIG-GUID: HAqG1i0y3nkTEPReptHdtHtH2MTzF4uj
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-01_08:2021-07-01,2021-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 mlxscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0
 clxscore=1011 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107010088
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field array bounds checking for memcpy(), memmove(), and memset(),
avoid intentionally reading across neighboring array fields.

Add a wrapping structure to serve as the memcpy() source, so the compiler
can do appropriate bounds checking, avoiding this future warning:

In function '__fortify_memcpy',
    inlined from 'create_uid' at drivers/s390/block/dasd_eckd.c:749:2:
./include/linux/fortify-string.h:246:4: error: call to '__read_overflow2_field' declared with attribute error: detected read beyond size of field (2nd parameter)

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.c | 2 +-
 drivers/s390/block/dasd_eckd.h | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index a6ac505cbdd7..0de1a463c509 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -746,7 +746,7 @@ static void create_uid(struct dasd_eckd_private *private)
 	memcpy(uid->vendor, private->ned->HDA_manufacturer,
 	       sizeof(uid->vendor) - 1);
 	EBCASC(uid->vendor, sizeof(uid->vendor) - 1);
-	memcpy(uid->serial, private->ned->HDA_location,
+	memcpy(uid->serial, &private->ned->serial,
 	       sizeof(uid->serial) - 1);
 	EBCASC(uid->serial, sizeof(uid->serial) - 1);
 	uid->ssid = private->gneq->subsystemID;
diff --git a/drivers/s390/block/dasd_eckd.h b/drivers/s390/block/dasd_eckd.h
index 73651211789f..65e4630ad2ae 100644
--- a/drivers/s390/block/dasd_eckd.h
+++ b/drivers/s390/block/dasd_eckd.h
@@ -332,8 +332,10 @@ struct dasd_ned {
 	__u8 dev_type[6];
 	__u8 dev_model[3];
 	__u8 HDA_manufacturer[3];
-	__u8 HDA_location[2];
-	__u8 HDA_seqno[12];
+	struct {
+		__u8 HDA_location[2];
+		__u8 HDA_seqno[12];
+	} serial;
 	__u8 ID;
 	__u8 unit_addr;
 } __attribute__ ((packed));
-- 
2.25.1

