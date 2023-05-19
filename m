Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7EFC77B75
	for <linux-s390@archiver.kernel.org>; Fri, 19 May 2023 10:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjESKXy (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 19 May 2023 06:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjESKXw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 19 May 2023 06:23:52 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B05E6B;
        Fri, 19 May 2023 03:23:50 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JA83B1026982;
        Fri, 19 May 2023 10:23:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=T2jpu9Rne5Ow86/4Hebewk7lX0qetxNKbRkD46hdNvo=;
 b=HIhs78GRym3IDUg69TU/1fE04yW0YWDjQZRg7pF2A11e20N22K54s9Ga1WqQHfoVt6I7
 oEgpg0CWb6fkM80isWJRtGW7WSfsqdqcT82KL0ZBLvVLbvhqEN4MVfOjbpoLhg2sf928
 5AMXfYAuGM0Bd0R8ufFqLE6pj+oAcY6s8Oq0UwB9X4HZLYkHPVsxvnuyna7QYgaEX+PA
 ZqMt86IjsUic6BQf7oFLhb/9mSsjd7LHsQElkq4lq/nUyou3hLgBl686c3d8y38iUB2P
 jrUXhHZccEy5nz6Z/7a+OpUei0RCtIqpMht7ATnXSwzwbHz6FqbUlFkCd2Ut+1lfEBQa 0g== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qp4q5v35b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 10:23:49 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34J4dApR012120;
        Fri, 19 May 2023 10:23:47 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3qj1tdu3xb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 10:23:47 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34JANfbU31916420
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 10:23:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CBBF2005A;
        Fri, 19 May 2023 10:23:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D16E20043;
        Fri, 19 May 2023 10:23:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 19 May 2023 10:23:41 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 0868CE0312; Fri, 19 May 2023 12:23:41 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 1/1] s390/dasd: fix command reject error on ESE devices
Date:   Fri, 19 May 2023 12:23:40 +0200
Message-Id: <20230519102340.3854819-2-sth@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230519102340.3854819-1-sth@linux.ibm.com>
References: <20230519102340.3854819-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Lgog2mtc5TS9BpWXfLbpBjWOzIbSrxa1
X-Proofpoint-GUID: Lgog2mtc5TS9BpWXfLbpBjWOzIbSrxa1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_06,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 adultscore=0 mlxscore=0 clxscore=1011 phishscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305190085
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Formatting a thin-provisioned (ESE) device that is part of a PPRC copy
relation might fail with the following error:

dasd-eckd 0.0.f500: An error occurred in the DASD device driver, reason=09
[...]
24 Byte: 0 MSG 4, no MSGb to SYSOP

During format of an ESE disk the Release Allocated Space command is used.
A bit in the payload of the command is set that is not allowed to be set
for devices in a copy relation. This bit is set to allow the partial
release of an extent.

Check for the existence of a copy relation before setting the respective
bit.

Fixes: 91dc4a197569 ("s390/dasd: Add new ioctl to release space")
Cc: stable@kernel.org # 5.3+
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index ade1369fe5ed..113c509bf6d0 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -127,6 +127,8 @@ static int prepare_itcw(struct itcw *, unsigned int, unsigned int, int,
 			struct dasd_device *, struct dasd_device *,
 			unsigned int, int, unsigned int, unsigned int,
 			unsigned int, unsigned int);
+static int dasd_eckd_query_pprc_status(struct dasd_device *,
+				       struct dasd_pprc_data_sc4 *);
 
 /* initial attempt at a probe function. this can be simplified once
  * the other detection code is gone */
@@ -3733,6 +3735,26 @@ static int count_exts(unsigned int from, unsigned int to, int trks_per_ext)
 	return count;
 }
 
+static int dasd_in_copy_relation(struct dasd_device *device)
+{
+	struct dasd_pprc_data_sc4 *temp;
+	int rc;
+
+	if (!dasd_eckd_pprc_enabled(device))
+		return 0;
+
+	temp = kzalloc(sizeof(*temp), GFP_KERNEL);
+	if (!temp)
+		return -ENOMEM;
+
+	rc = dasd_eckd_query_pprc_status(device, temp);
+	if (!rc)
+		rc = temp->dev_info[0].state;
+
+	kfree(temp);
+	return rc;
+}
+
 /*
  * Release allocated space for a given range or an entire volume.
  */
@@ -3749,6 +3771,7 @@ dasd_eckd_dso_ras(struct dasd_device *device, struct dasd_block *block,
 	int cur_to_trk, cur_from_trk;
 	struct dasd_ccw_req *cqr;
 	u32 beg_cyl, end_cyl;
+	int copy_relation;
 	struct ccw1 *ccw;
 	int trks_per_ext;
 	size_t ras_size;
@@ -3760,6 +3783,10 @@ dasd_eckd_dso_ras(struct dasd_device *device, struct dasd_block *block,
 	if (dasd_eckd_ras_sanity_checks(device, first_trk, last_trk))
 		return ERR_PTR(-EINVAL);
 
+	copy_relation = dasd_in_copy_relation(device);
+	if (copy_relation < 0)
+		return ERR_PTR(copy_relation);
+
 	rq = req ? blk_mq_rq_to_pdu(req) : NULL;
 
 	features = &private->features;
@@ -3788,9 +3815,11 @@ dasd_eckd_dso_ras(struct dasd_device *device, struct dasd_block *block,
 	/*
 	 * This bit guarantees initialisation of tracks within an extent that is
 	 * not fully specified, but is only supported with a certain feature
-	 * subset.
+	 * subset and for devices not in a copy relation.
 	 */
-	ras_data->op_flags.guarantee_init = !!(features->feature[56] & 0x01);
+	if (features->feature[56] & 0x01 && !copy_relation)
+		ras_data->op_flags.guarantee_init = 1;
+
 	ras_data->lss = private->conf.ned->ID;
 	ras_data->dev_addr = private->conf.ned->unit_addr;
 	ras_data->nr_exts = nr_exts;
-- 
2.39.2

