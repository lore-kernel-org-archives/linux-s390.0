Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F4DC11F6B
	for <linux-s390@archiver.kernel.org>; Thu,  1 Jul 2021 14:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A46E613FE
	for <linux-s390@archiver.kernel.org>; Thu,  1 Jul 2021 14:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbhGAOZD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:25:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10268 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231844AbhGAOZD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 1 Jul 2021 10:25:03 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 161E3xtg128197;
        Thu, 1 Jul 2021 10:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=7agZkIpsC2LRYLAD4XcQ1e0Q0LX6YB0rF6KDf4uXmXI=;
 b=VS0AYFL6BmTqVD/kKrhjlhJFTuZCk8exCi+VHgWHDHIax4qXuXdhbQtUdOxC7+798+Rt
 GA9l1K6VxSrUSnbMedzfUqOxkNy2l5lBG67uQLT15cWT1wFNqrNAEjTjbrz6iQoDFzwd
 exVxulxpqs5YPMBtRMqQI7T8/5nG234qySXnuBhWRB9WCkViAHKg84U0YqF5GKXRdi2A
 kAV9o5eREWjA3K4cSo/TxSH4VpvqdbA6QWgl3mk+e8aZdEcdgLx9Pdf6/X5e8kjdiCQl
 z9QxI+bpDz2LO13XSuU2WOh6u8IH5UHqJD+94hu2VpX3AJI6vnGh6horGMas+qGgb7gY XA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39hepr1m5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 10:22:27 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 161ECIe3031392;
        Thu, 1 Jul 2021 14:22:25 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 39duv8jf5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 14:22:24 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 161EKf6P16974290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Jul 2021 14:20:41 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E4DB74C04E;
        Thu,  1 Jul 2021 14:22:21 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA0EB4C046;
        Thu,  1 Jul 2021 14:22:21 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  1 Jul 2021 14:22:21 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 87E25E0671; Thu,  1 Jul 2021 16:22:21 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 1/2] dasd: unexport dasd_set_target_state
Date:   Thu,  1 Jul 2021 16:22:20 +0200
Message-Id: <20210701142221.3408680-2-sth@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210701142221.3408680-1-sth@linux.ibm.com>
References: <20210701142221.3408680-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2dICG6uHjyB2yHM18MJ28da9b5seXdqF
X-Proofpoint-GUID: 2dICG6uHjyB2yHM18MJ28da9b5seXdqF
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-01_08:2021-07-01,2021-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 adultscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107010088
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

dasd_set_target_state is only used inside of dasd_mod.ko, so don't
export it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index c8df75e99f4c..e34c6cc61983 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -621,7 +621,6 @@ void dasd_set_target_state(struct dasd_device *device, int target)
 	mutex_unlock(&device->state_mutex);
 	dasd_put_device(device);
 }
-EXPORT_SYMBOL(dasd_set_target_state);
 
 /*
  * Enable devices with device numbers in [from..to].
-- 
2.25.1

