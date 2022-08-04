Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF24C25B06
	for <linux-s390@archiver.kernel.org>; Thu,  4 Aug 2022 21:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbiHDVqT (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 4 Aug 2022 17:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbiHDVqS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 4 Aug 2022 17:46:18 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388F315FE2;
        Thu,  4 Aug 2022 14:46:17 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 274La8vn027538;
        Thu, 4 Aug 2022 21:46:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=bI4zxYX9VKdRiXx+JLDGBK4cwXNBclkB5GpuQfxm4oc=;
 b=RSdHQQlK7fji2/veD9uA9TOuc7K4HlVWOoIdOVBNtFR7OsHccAbZ9/5alXf7hLpbZhpb
 8x0zGofVi6J81TiRYmVqZeNEUnq+ETS03LkjJxZwuejoarJg5k2q1YQW2y/sVkkYfCDL
 unJdQ6+Izd3kQRZ01fFOWdVPsaA7DUQEzb9EC7X7zlZF5pKJOf5qXtqGuerVEOuWajb0
 2Md0952fF29rTmxyU3R/CsbjeXJ/BY46EspQOe7U2H587D5PsZismGw1cSEGcudfgYFW
 W5LRcoLNFd3tg5mXpQSCMtuOuQLBulFTCAnk+O9nxgzIEqopRRUg0OY7Tb7ljIjyPp1B pw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hrp6189gw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Aug 2022 21:46:11 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 274LM0Sh015911;
        Thu, 4 Aug 2022 21:46:09 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3hmv98pnxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Aug 2022 21:46:09 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 274LkMY423396646
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Aug 2022 21:46:22 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6937A11C04C;
        Thu,  4 Aug 2022 21:46:06 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5615E11C04A;
        Thu,  4 Aug 2022 21:46:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  4 Aug 2022 21:46:06 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 3140BE0231; Thu,  4 Aug 2022 23:39:26 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH 2/2] s390/dasd: Establish DMA alignment
Date:   Thu,  4 Aug 2022 23:39:26 +0200
Message-Id: <20220804213926.3361574-3-sth@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220804213926.3361574-1-sth@linux.ibm.com>
References: <20220804213926.3361574-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9P9NxUfFw0wqAvUavo1AUaH1oGgT9xVt
X-Proofpoint-ORIG-GUID: 9P9NxUfFw0wqAvUavo1AUaH1oGgT9xVt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-04_03,2022-08-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 spamscore=0 clxscore=1011 mlxscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208040090
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Eric Farman <farman@linux.ibm.com>

linux-next commit bf8d08532bc1 ("iomap: add support for dma aligned
direct-io") changes the alignment requirement to come from the block
device rather than the block size, and the default alignment
requirement is 512-byte boundaries. Since DASD I/O has page
alignments for IDAW/TIDAW requests, let's override this value to
restore the expected behavior.

Make this change for both ECKD and DIAG disciplines, as they both
would fall into this category. Leave FBA alone, since it is always
comprised of 512-byte blocks.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_diag.c | 1 +
 drivers/s390/block/dasd_eckd.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/s390/block/dasd_diag.c b/drivers/s390/block/dasd_diag.c
index e9edf3b6ed7c..94ee59864971 100644
--- a/drivers/s390/block/dasd_diag.c
+++ b/drivers/s390/block/dasd_diag.c
@@ -639,6 +639,7 @@ static void dasd_diag_setup_blk_queue(struct dasd_block *block)
 	/* With page sized segments each segment can be translated into one idaw/tidaw */
 	blk_queue_max_segment_size(q, PAGE_SIZE);
 	blk_queue_segment_boundary(q, PAGE_SIZE - 1);
+	blk_queue_dma_alignment(q, PAGE_SIZE - 1);
 }
 
 static int dasd_diag_pe_handler(struct dasd_device *device,
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 836838f7d686..3cc93e2e4e15 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -6626,6 +6626,7 @@ static void dasd_eckd_setup_blk_queue(struct dasd_block *block)
 	/* With page sized segments each segment can be translated into one idaw/tidaw */
 	blk_queue_max_segment_size(q, PAGE_SIZE);
 	blk_queue_segment_boundary(q, PAGE_SIZE - 1);
+	blk_queue_dma_alignment(q, PAGE_SIZE - 1);
 }
 
 static struct ccw_driver dasd_eckd_driver = {
-- 
2.34.1

