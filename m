Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CB7C7EE2F
	for <linux-s390@archiver.kernel.org>; Fri,  9 Jun 2023 15:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241713AbjFIPiE (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 9 Jun 2023 11:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240625AbjFIPiD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 9 Jun 2023 11:38:03 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFC03589;
        Fri,  9 Jun 2023 08:38:00 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359FbvBB001724;
        Fri, 9 Jun 2023 15:37:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=va+PcU5gENiDPmp8jQDe4O729/GGu/auUBMjTnFa+o0=;
 b=MsY5zvyUXdIyFgPgw1WL61zSK3qJWI+D+hu/p06zrDT/ndC+/rZMZ7hoPu2AjT6T5itR
 7lHOWcA11fqAB5wiCXw4xQAbD+ArzN0YhMLUdlLvia45jtMGUvqaXCAP9u0U15TEFAFB
 HDZr5CnecL79Cgp5L7lqsGkPQ5EtbS2csBWPEVkmvHaJLUxX8KzvBLB0S5RTUQg+Y73m
 fNBzy6uSWnpXYGp1OpBIzgBKeVqFtJs+bYC2Yf4ecUxBtNGIbjqp+PyW0pjmAqJP4gso
 xmczD/XzJpE50C9Dr2Ek2rkjqVK2aT8B0IrfnrDe3L5AudKbk0Mqur6CHOseppWDr8ea SA== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r46vug031-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 15:37:58 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 359BwDkr024529;
        Fri, 9 Jun 2023 15:37:56 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3r2a791eej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 15:37:56 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 359FboqD44433842
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Jun 2023 15:37:50 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BDF8920043;
        Fri,  9 Jun 2023 15:37:50 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACD1F20040;
        Fri,  9 Jun 2023 15:37:50 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  9 Jun 2023 15:37:50 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 6F22EE1540; Fri,  9 Jun 2023 17:37:50 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 1/1] s390/dasd: Use correct lock while counting channel queue length
Date:   Fri,  9 Jun 2023 17:37:50 +0200
Message-Id: <20230609153750.1258763-2-sth@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230609153750.1258763-1-sth@linux.ibm.com>
References: <20230609153750.1258763-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6obkxCcVA876W1fuJZqeKCt6FDuOuMt1
X-Proofpoint-ORIG-GUID: 6obkxCcVA876W1fuJZqeKCt6FDuOuMt1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_10,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306090126
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Jan Höppner <hoeppner@linux.ibm.com>

The lock around counting the channel queue length in the BIODASDINFO
ioctl was incorrectly changed to the dasd_block->queue_lock with commit
583d6535cb9d ("dasd: remove dead code"). This can lead to endless list
iterations and a subsequent crash.

The queue_lock is supposed to be used only for queue lists belonging to
dasd_block. For dasd_device related queue lists the ccwdev lock must be
used.

Fix the mentioned issues by correctly using the ccwdev lock instead of
the queue lock.

Fixes: 583d6535cb9d ("dasd: remove dead code")
Cc: stable@vger.kernel.org # v5.0+
Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index 9327dcdd6e5e..8fca725b3dae 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -552,10 +552,10 @@ static int __dasd_ioctl_information(struct dasd_block *block,
 
 	memcpy(dasd_info->type, base->discipline->name, 4);
 
-	spin_lock_irqsave(&block->queue_lock, flags);
+	spin_lock_irqsave(get_ccwdev_lock(base->cdev), flags);
 	list_for_each(l, &base->ccw_queue)
 		dasd_info->chanq_len++;
-	spin_unlock_irqrestore(&block->queue_lock, flags);
+	spin_unlock_irqrestore(get_ccwdev_lock(base->cdev), flags);
 	return 0;
 }
 
-- 
2.39.2

