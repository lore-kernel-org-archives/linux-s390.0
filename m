Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E619C04A6A
	for <linux-s390@archiver.kernel.org>; Fri, 21 Jul 2023 19:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjGUThA (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 21 Jul 2023 15:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjGUTg5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 21 Jul 2023 15:36:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861102D47;
        Fri, 21 Jul 2023 12:36:56 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36LJaJ0m023589;
        Fri, 21 Jul 2023 19:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=GFNORjK6Kwv+3kcKZri3G/vaE1mXnONf5tLrJIPSCrs=;
 b=VKdbeqF9n9CtdqZgSJlgnAr0wxuzg+6WcXW+gqKQHXrrC3oTjaHZrLmp9eurkqkZU5Ya
 t1Z4euenf1YiEfJrcmG5Qwx3n9lWDEeit/LeRWvBdCUGD8QuhlOXDUpmf/g8jliYOZkR
 gPI36bONvY5LRPsyBQPbuyUcCnOqzIV+krx/fAP+oT9vfI4B+ezJHoTrG9QK3kdx9DF3
 N6X7xagnrHeNeIu43VaQJvawccAvb7g+q+L+3aDfXr2S/Ckex/9pK5dUPr9hPRjWXDHf
 +9LEFLwO1tQCQxnvAviu7M0CdRwYw3H7/PVNErPlGt0C8jm+ZQvslN7bC4T6xRAbcvFV OA== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ryc7gm938-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 19:36:54 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36LHO1ms031299;
        Fri, 21 Jul 2023 19:36:53 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rv79k6t74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 19:36:53 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36LJamAc15401550
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jul 2023 19:36:48 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACA7620043;
        Fri, 21 Jul 2023 19:36:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A49F20040;
        Fri, 21 Jul 2023 19:36:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 21 Jul 2023 19:36:48 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 13771E267F; Fri, 21 Jul 2023 21:36:47 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 1/4] s390/dasd: fix hanging device after quiesce/resume
Date:   Fri, 21 Jul 2023 21:36:44 +0200
Message-Id: <20230721193647.3889634-2-sth@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230721193647.3889634-1-sth@linux.ibm.com>
References: <20230721193647.3889634-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: V45p5sNVCHsH0uN-AjquOFpj061vGnqS
X-Proofpoint-ORIG-GUID: V45p5sNVCHsH0uN-AjquOFpj061vGnqS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_11,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 clxscore=1015
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307210172
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Quiesce and resume are functions that tell the DASD driver to stop/resume
issuing I/Os to a specific DASD.

On resume dasd_schedule_block_bh() is called to kick handling of IO
requests again. This does unfortunately not cover internal requests which
are used for path verification for example.

This could lead to a hanging device when a path event or anything else
that triggers internal requests occurs on a quiesced device.

Fix by also calling dasd_schedule_device_bh() which triggers handling of
internal requests on resume.

Fixes: 8e09f21574ea ("[S390] dasd: add hyper PAV support to DASD device driver, part 1")

Cc: stable@vger.kernel.org
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
---
 drivers/s390/block/dasd_ioctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index 513a7e6eee63..d55862605b82 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -131,6 +131,7 @@ static int dasd_ioctl_resume(struct dasd_block *block)
 	spin_unlock_irqrestore(get_ccwdev_lock(base->cdev), flags);
 
 	dasd_schedule_block_bh(block);
+	dasd_schedule_device_bh(base);
 	return 0;
 }
 
-- 
2.39.2

