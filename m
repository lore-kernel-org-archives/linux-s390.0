Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CD4C43217
	for <linux-s390@archiver.kernel.org>; Wed, 20 Oct 2021 11:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEF5D61359
	for <linux-s390@archiver.kernel.org>; Wed, 20 Oct 2021 11:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbhJTLxt (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 20 Oct 2021 07:53:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27860 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229998AbhJTLxp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 20 Oct 2021 07:53:45 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KAHLQX030565;
        Wed, 20 Oct 2021 07:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=Gqxoyj5c1zeoxc0SofuvckchIWWZQ0YbGwW7ZeByXE4=;
 b=T+cokZX9kTM523aYdqRKFcEdR8KTyBi4MeWDXyuIA9xIXTPze7FCdAyIque8I1lODDR8
 ZCivjSU3k4yZab+vqsfD3Rt7WOyxryLAYRtgiHYrkrs2MMOX9w0+TH+sAnTwc7UVFddd
 nBWBXY72IwarUKfU0AsqsOD7xXSLIs5MT/a5sFUPAtjqjCuunzhhcpEU1S2WtRivZQIZ
 O7Jtpnh4sMeb0Yq5lrYmfq2MFZI6JsC520qmtqsrt680nL+3Z+UYcqt90uWogn0g7aJK
 cJ7b0mININjTqpGVpMkOQLXueQiZXEkSbPXL1IZmYMpM94xME9LhdL/pzael1oN9YS3W Ew== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bth7tsrds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 07:51:30 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19KBlVUj014011;
        Wed, 20 Oct 2021 11:51:28 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 3bqpcbsg0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 11:51:28 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19KBjYvm55443770
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 11:45:34 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEE68A405B;
        Wed, 20 Oct 2021 11:51:24 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC046A4054;
        Wed, 20 Oct 2021 11:51:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 20 Oct 2021 11:51:24 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 6C8B3E01ED; Wed, 20 Oct 2021 13:51:24 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 1/7] s390/dasd: handle request magic consistently as unsigned int
Date:   Wed, 20 Oct 2021 13:51:18 +0200
Message-Id: <20211020115124.1735254-2-sth@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211020115124.1735254-1-sth@linux.ibm.com>
References: <20211020115124.1735254-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bTWK7C6MoxXQzTnfkFVMUVznnuq9jMuv
X-Proofpoint-GUID: bTWK7C6MoxXQzTnfkFVMUVznnuq9jMuv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-20_04,2021-10-20_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=793
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110200066
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Heiko Carstens <hca@linux.ibm.com>

Get rid of the rather odd casts to character pointer of the
dasd_ccw_req magic member and simply use the unsigned int value
unmodified everywhere.

Acked-by: Jan Höppner <hoeppner@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_3990_erp.c | 6 +++---
 drivers/s390/block/dasd_erp.c      | 8 ++++----
 drivers/s390/block/dasd_int.h      | 2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/block/dasd_3990_erp.c b/drivers/s390/block/dasd_3990_erp.c
index 4691a3c35d72..299001ad9a32 100644
--- a/drivers/s390/block/dasd_3990_erp.c
+++ b/drivers/s390/block/dasd_3990_erp.c
@@ -201,7 +201,7 @@ dasd_3990_erp_DCTL(struct dasd_ccw_req * erp, char modifier)
 	struct ccw1 *ccw;
 	struct dasd_ccw_req *dctl_cqr;
 
-	dctl_cqr = dasd_alloc_erp_request((char *) &erp->magic, 1,
+	dctl_cqr = dasd_alloc_erp_request(erp->magic, 1,
 					  sizeof(struct DCTL_data),
 					  device);
 	if (IS_ERR(dctl_cqr)) {
@@ -1652,7 +1652,7 @@ dasd_3990_erp_action_1B_32(struct dasd_ccw_req * default_erp, char *sense)
 	}
 
 	/* Build new ERP request including DE/LO */
-	erp = dasd_alloc_erp_request((char *) &cqr->magic,
+	erp = dasd_alloc_erp_request(cqr->magic,
 				     2 + 1,/* DE/LO + TIC */
 				     sizeof(struct DE_eckd_data) +
 				     sizeof(struct LO_eckd_data), device);
@@ -2388,7 +2388,7 @@ static struct dasd_ccw_req *dasd_3990_erp_add_erp(struct dasd_ccw_req *cqr)
 	}
 
 	/* allocate additional request block */
-	erp = dasd_alloc_erp_request((char *) &cqr->magic,
+	erp = dasd_alloc_erp_request(cqr->magic,
 				     cplength, datasize, device);
 	if (IS_ERR(erp)) {
                 if (cqr->retries <= 0) {
diff --git a/drivers/s390/block/dasd_erp.c b/drivers/s390/block/dasd_erp.c
index ba4fa372d02d..c07e6e713518 100644
--- a/drivers/s390/block/dasd_erp.c
+++ b/drivers/s390/block/dasd_erp.c
@@ -24,7 +24,7 @@
 #include "dasd_int.h"
 
 struct dasd_ccw_req *
-dasd_alloc_erp_request(char *magic, int cplength, int datasize,
+dasd_alloc_erp_request(unsigned int magic, int cplength, int datasize,
 		       struct dasd_device * device)
 {
 	unsigned long flags;
@@ -33,8 +33,8 @@ dasd_alloc_erp_request(char *magic, int cplength, int datasize,
 	int size;
 
 	/* Sanity checks */
-	BUG_ON( magic == NULL || datasize > PAGE_SIZE ||
-	     (cplength*sizeof(struct ccw1)) > PAGE_SIZE);
+	BUG_ON(datasize > PAGE_SIZE ||
+	       (cplength*sizeof(struct ccw1)) > PAGE_SIZE);
 
 	size = (sizeof(struct dasd_ccw_req) + 7L) & -8L;
 	if (cplength > 0)
@@ -62,7 +62,7 @@ dasd_alloc_erp_request(char *magic, int cplength, int datasize,
 		cqr->data = data;
  		memset(cqr->data, 0, datasize);
 	}
-	strncpy((char *) &cqr->magic, magic, 4);
+	cqr->magic = magic;
 	ASCEBC((char *) &cqr->magic, 4);
 	set_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
 	dasd_get_device(device);
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 155428bfed8a..15d8731c1eee 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -887,7 +887,7 @@ void dasd_proc_exit(void);
 /* externals in dasd_erp.c */
 struct dasd_ccw_req *dasd_default_erp_action(struct dasd_ccw_req *);
 struct dasd_ccw_req *dasd_default_erp_postaction(struct dasd_ccw_req *);
-struct dasd_ccw_req *dasd_alloc_erp_request(char *, int, int,
+struct dasd_ccw_req *dasd_alloc_erp_request(unsigned int, int, int,
 					    struct dasd_device *);
 void dasd_free_erp_request(struct dasd_ccw_req *, struct dasd_device *);
 void dasd_log_sense(struct dasd_ccw_req *, struct irb *);
-- 
2.25.1

