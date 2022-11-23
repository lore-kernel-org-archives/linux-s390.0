Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA12C47088
	for <linux-s390@archiver.kernel.org>; Wed, 23 Nov 2022 16:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238875AbiKWQHh (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 23 Nov 2022 11:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238724AbiKWQHe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 23 Nov 2022 11:07:34 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64773C61;
        Wed, 23 Nov 2022 08:07:28 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ANEbbPL001867;
        Wed, 23 Nov 2022 16:07:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=oNLbb9V6qFquUYdCGPNMZSqw6K78fzSxEib02NJGxUQ=;
 b=M4CYxDn3q7HreiBVb9b9+uSCAHsIIIxHH+PqDiaCQM5/K6Vr34QYVoI91hVmnWuCCcbt
 uM9Y9Um0IEIG60gKv/G2/f1S+AN0PzZtNZXfLiR0AUMm0YLd9VifrM+/YyMxeyfLQ3NB
 PTWYBTzsA5AnWKjLzmSSwLKhVAGSxAyzyN/gHneVjgI4vd256YxTb8PIYUErbzkE6zQK
 xuFZitnKYJtLddlx2cUxBr58SNMMlEF7w8Gfa8M9FkAP1Q9mELYMLR7Rkyb6AtlggKnL
 VG8+wXqWIJ6LREhbHBAIYWYnsOY9SDuXuJHxFijduJiyAvDakUPkFDyZCuG+DDXjafqS Mg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3m0ytbbmc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 16:07:27 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2ANFPf16006031;
        Wed, 23 Nov 2022 16:07:26 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3m0ytbbmbh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 16:07:26 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2ANG6OIP015312;
        Wed, 23 Nov 2022 16:07:25 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 3kxpdj4rn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 16:07:24 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2ANG7Kuc42139980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Nov 2022 16:07:21 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42C1BAE065;
        Wed, 23 Nov 2022 16:07:20 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31355AE04D;
        Wed, 23 Nov 2022 16:07:20 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 23 Nov 2022 16:07:20 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id EA0E6E08AB; Wed, 23 Nov 2022 17:07:19 +0100 (CET)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Colin Ian King <colin.i.king@gmail.com>
Subject: [PATCH 3/4] s390/dasd: fix no record found for raw_track_access
Date:   Wed, 23 Nov 2022 17:07:18 +0100
Message-Id: <20221123160719.3002694-4-sth@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221123160719.3002694-1-sth@linux.ibm.com>
References: <20221123160719.3002694-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IuBLFYeoMrqSvlOJt6-Hgz6xVvd9Lex0
X-Proofpoint-GUID: 3dJiOuIMIWV8kb3XbS0_n7dx5LuFH0SS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-23_08,2022-11-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 adultscore=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211230114
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

For DASD devices in raw_track_access mode only full track images are
read and written.
For this purpose it is not necessary to do search operation in the
locate record extended function. The documentation even states that
this might fail if the searched record is not found on a track.

Currently the driver sets a value of 1 in the search field for the first
record after record zero. This is the default for disks not in
raw_track_access mode but record 1 might be missing on a completely
empty track.

There has not been any problem with this on IBM storage servers but it
might lead to errors with DASD devices on other vendors storage servers.

Fix this by setting the search field to 0. Record zero is always available
even on a completely empty track.

Fixes: e4dbb0f2b5dd ("[S390] dasd: Add support for raw ECKD access.")
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 85bf045c2ff9..5d0b9991e91a 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -4722,7 +4722,6 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_raw(struct dasd_device *startdev,
 	struct dasd_device *basedev;
 	struct req_iterator iter;
 	struct dasd_ccw_req *cqr;
-	unsigned int first_offs;
 	unsigned int trkcount;
 	unsigned long *idaws;
 	unsigned int size;
@@ -4756,7 +4755,6 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_raw(struct dasd_device *startdev,
 	last_trk = (blk_rq_pos(req) + blk_rq_sectors(req) - 1) /
 		DASD_RAW_SECTORS_PER_TRACK;
 	trkcount = last_trk - first_trk + 1;
-	first_offs = 0;
 
 	if (rq_data_dir(req) == READ)
 		cmd = DASD_ECKD_CCW_READ_TRACK;
@@ -4800,13 +4798,13 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_raw(struct dasd_device *startdev,
 
 	if (use_prefix) {
 		prefix_LRE(ccw++, data, first_trk, last_trk, cmd, basedev,
-			   startdev, 1, first_offs + 1, trkcount, 0, 0);
+			   startdev, 1, 0, trkcount, 0, 0);
 	} else {
 		define_extent(ccw++, data, first_trk, last_trk, cmd, basedev, 0);
 		ccw[-1].flags |= CCW_FLAG_CC;
 
 		data += sizeof(struct DE_eckd_data);
-		locate_record_ext(ccw++, data, first_trk, first_offs + 1,
+		locate_record_ext(ccw++, data, first_trk, 0,
 				  trkcount, cmd, basedev, 0, 0);
 	}
 
-- 
2.34.1

