Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E61EE6457
	for <linux-s390@archiver.kernel.org>; Fri, 15 Sep 2023 13:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbjIONKT (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 15 Sep 2023 09:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjIONKT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 15 Sep 2023 09:10:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B881AC;
        Fri, 15 Sep 2023 06:10:14 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FD8Uvg012772;
        Fri, 15 Sep 2023 13:10:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=ognN6eNgcoZ+CTd3WoSswsNhkcSq2Z99q9EGFG/+3cQ=;
 b=TX2AY8SXeZbhPq41pijkvcKmkgRbTe1bC4boISbFAjkKtE995Iht/eh3B2x/1SohLMpI
 SZMEML/7P6jQYmlR7hfNhI5aD7y2IzI+mo7PnpjWvyPL2ZblFtQeoxYjPOcRpHYJaXJI
 5b2hTVdo2MmA3XiL2PIxWAi4VIR21uxtSzoYEiMhm364eTBjxSYoKIjGLsA1+F0zjQ6v
 PG4tvS0S9SXzFIlLSr1SyUALpTxW7t/MoJxZhs/EtL9N4mboV9jhN1X0BS5WU6wDBJ1+
 ccknM/XRb1q0kiGXPaZduikaLh/G69QjQbyV9eaKq5B4jQ6gLC13FDjsmjrhlaK1RDWH 9A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t4qp8rav1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 13:10:10 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38FD8bfd014148;
        Fri, 15 Sep 2023 13:10:09 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t4qp8rann-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 13:10:09 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38FCgY8W011942;
        Fri, 15 Sep 2023 13:10:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t15r2k7fh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 13:10:05 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38FDA2fi15205100
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 13:10:02 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5E9820043;
        Fri, 15 Sep 2023 13:10:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2B112004D;
        Fri, 15 Sep 2023 13:10:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 15 Sep 2023 13:10:01 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 588B8E068B; Fri, 15 Sep 2023 15:10:01 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Justin Stitt <justinstitt@google.com>
Subject: [PATCH 3/3] partitions/ibm: Introduce defines for magic string length values
Date:   Fri, 15 Sep 2023 15:10:01 +0200
Message-Id: <20230915131001.697070-4-sth@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230915131001.697070-1-sth@linux.ibm.com>
References: <20230915131001.697070-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NZ4u1pgwskf_iUJXQKXZ38lk-sehK_0c
X-Proofpoint-GUID: niXk2pGcCQXpefjk_4FXAMFPpB4QgI1k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_09,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 spamscore=0 mlxlogscore=991 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309150117
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Jan Höppner <hoeppner@linux.ibm.com>

The length values for volume label type and volume label id are
hard-coded in several places. Provide defines for those values and
replace all occurrences accordingly.

Note that the length is defined and used, and not the size since the
volume label type string and volume label id string are not
nul-terminated.

Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 block/partitions/ibm.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/block/partitions/ibm.c b/block/partitions/ibm.c
index 7b0a3f13d180..82d9c4c3fb41 100644
--- a/block/partitions/ibm.c
+++ b/block/partitions/ibm.c
@@ -61,6 +61,10 @@ static sector_t cchhb2blk(struct vtoc_cchhb *ptr, struct hd_geometry *geo)
 		ptr->b;
 }
 
+/* Volume Label Type/ID Length */
+#define DASD_VOL_TYPE_LEN	4
+#define DASD_VOL_ID_LEN		6
+
 /* Volume Label Types */
 #define DASD_VOLLBL_TYPE_VOL1 0
 #define DASD_VOLLBL_TYPE_LNX1 1
@@ -91,7 +95,7 @@ static int get_label_by_type(const char *type)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(dasd_vollabels); i++) {
-		if (!memcmp(type, dasd_vollabels[i].type, 4))
+		if (!memcmp(type, dasd_vollabels[i].type, DASD_VOL_TYPE_LEN))
 			return dasd_vollabels[i].idx;
 	}
 
@@ -138,19 +142,19 @@ static int find_label(struct parsed_partitions *state,
 		if (data == NULL)
 			continue;
 		memcpy(label, data, sizeof(*label));
-		memcpy(type, data, 4);
-		EBCASC(type, 4);
+		memcpy(type, data, DASD_VOL_TYPE_LEN);
+		EBCASC(type, DASD_VOL_TYPE_LEN);
 		put_dev_sector(sect);
 		switch (get_label_by_type(type)) {
 		case DASD_VOLLBL_TYPE_VOL1:
-			memcpy(name, label->vol.volid, 6);
-			EBCASC(name, 6);
+			memcpy(name, label->vol.volid, DASD_VOL_ID_LEN);
+			EBCASC(name, DASD_VOL_ID_LEN);
 			*labelsect = testsect[i];
 			return 1;
 		case DASD_VOLLBL_TYPE_LNX1:
 		case DASD_VOLLBL_TYPE_CMS1:
-			memcpy(name, label->lnx.volid, 6);
-			EBCASC(name, 6);
+			memcpy(name, label->lnx.volid, DASD_VOL_ID_LEN);
+			EBCASC(name, DASD_VOL_ID_LEN);
 			*labelsect = testsect[i];
 			return 1;
 		default:
@@ -328,8 +332,8 @@ int ibm_partition(struct parsed_partitions *state)
 	sector_t nr_sectors;
 	dasd_information2_t *info;
 	struct hd_geometry *geo;
-	char type[5] = {0,};
-	char name[7] = {0,};
+	char type[DASD_VOL_TYPE_LEN + 1] = "";
+	char name[DASD_VOL_ID_LEN + 1] = "";
 	sector_t labelsect;
 	union label_t *label;
 
-- 
2.39.2

