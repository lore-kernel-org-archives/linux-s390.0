Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC89CC25B0C
	for <linux-s390@archiver.kernel.org>; Thu,  4 Aug 2022 21:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbiHDVqU (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 4 Aug 2022 17:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbiHDVqS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 4 Aug 2022 17:46:18 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C2815FE0;
        Thu,  4 Aug 2022 14:46:17 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 274L7uIG028576;
        Thu, 4 Aug 2022 21:46:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=HtJIKPnr9mkjF7TzF87BGQHENOhKMCEkTPq+6bYpYWI=;
 b=imQvAq0nBPFRflQKhggeS8H5YbBtZNnlmPQmkU6JwJYMzASkxhR+WSfuedfYCLzmLkGq
 kMgYY3evpoLX0NR0pVlv+9FyuER8LpFfmDkCGmTMjVlSzqezli08modMM052NA/bHpTv
 RRriG6br9MK7fLJKD3dhsufSf953DZO76hADs97jC1eZM6WMNdQT3Bc6VxxCvhBkP0c7
 Qdi8ChEogCrhEVWEz6Xby8cEQerDLyANDrP4KdJHUTau2VVz1XdDwZcNsFPy4uo/VUEf
 fghPFymop5F1sl7lOzHT+5csFR+6wmW/D3tWY7xqRf0gK3tsVLodirfeAAp62VF9KFDK bg== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hrn0qhxj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Aug 2022 21:46:12 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 274LLvLZ032135;
        Thu, 4 Aug 2022 21:46:09 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 3hmv98vx5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Aug 2022 21:46:09 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 274Lk6Wh29229516
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Aug 2022 21:46:06 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C86C4C044;
        Thu,  4 Aug 2022 21:46:06 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59C0B4C040;
        Thu,  4 Aug 2022 21:46:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  4 Aug 2022 21:46:06 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 2E5E8E022E; Thu,  4 Aug 2022 23:39:26 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH 1/2] s390/dasd: drop unexpected word 'for' in comments
Date:   Thu,  4 Aug 2022 23:39:25 +0200
Message-Id: <20220804213926.3361574-2-sth@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220804213926.3361574-1-sth@linux.ibm.com>
References: <20220804213926.3361574-1-sth@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: q7zmxBgmG2-3aB7QA25fpjxxmFNkc45r
X-Proofpoint-GUID: q7zmxBgmG2-3aB7QA25fpjxxmFNkc45r
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-04_03,2022-08-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 mlxlogscore=999 clxscore=1015 spamscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208040090
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Jiang Jian <jiangjian@cdjrlc.com>

there is an unexpected word 'for' in the comments that need to be dropped

file - drivers/s390/block/dasd.c
line - 1728

	/* check for for attention message */

changed to:

	/* check for attention message */

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
Link: https://lore.kernel.org/r/20220623102114.33249-1-jiangjian@cdjrlc.com
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 4df8bf6505fc..ea82821599f6 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -1725,7 +1725,7 @@ void dasd_int_handler(struct ccw_device *cdev, unsigned long intparm,
 		dasd_put_device(device);
 	}
 
-	/* check for for attention message */
+	/* check for attention message */
 	if (scsw_dstat(&irb->scsw) & DEV_STAT_ATTENTION) {
 		device = dasd_device_from_cdev_locked(cdev);
 		if (!IS_ERR(device)) {
-- 
2.34.1

