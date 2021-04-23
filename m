Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8295EC433ED
	for <linux-s390@archiver.kernel.org>; Fri, 23 Apr 2021 10:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 405C2613C4
	for <linux-s390@archiver.kernel.org>; Fri, 23 Apr 2021 10:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241890AbhDWKJ1 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 23 Apr 2021 06:09:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38688 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229961AbhDWKJ1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 23 Apr 2021 06:09:27 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13NA44Rg063707;
        Fri, 23 Apr 2021 06:08:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=hOVQIrh11RfnIEGXfJicBYPU7nTaTqr9grqTJ0gaRos=;
 b=JHZxL4Pz4dbPUt29pp6gnlS5Uhk6SITK7b2ai/54FBUNaiPRUg9xLJYTz7HFyDrgVgQc
 U8BHpI4WRc/HtTNELN8jzOg6uzVV8pdgBo3R0Jy1pYuUHmH2mFWUvo9qkxuvmJRzunCU
 2aX2RWVJQsertsMSO4XENOxzEIsmxzjOQofvsA8n94ykOAouv0UE3+JCdkZYiqlGAUlP
 lWQTuwLcxaVUT7FmYnr06Or+xCUcmVa691v+fg2Z2xxM5dMqmdfT/jJ07js2eNBofBUX
 XJDu9hCXko1TjEn+gNGwC4uiCadoW5eRMsyBic/5MNvR9ZKI//h/AX4KOvmNhPlOMvhd ng== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 383av9u01f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Apr 2021 06:08:48 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13NA8gxK000825;
        Fri, 23 Apr 2021 10:08:47 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 37ypxh9uc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Apr 2021 10:08:47 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13NA8KA034669004
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Apr 2021 10:08:20 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 007F64C04A;
        Fri, 23 Apr 2021 10:08:44 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9C164C046;
        Fri, 23 Apr 2021 10:08:43 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 23 Apr 2021 10:08:43 +0000 (GMT)
From:   Vineeth Vijayan <vneethv@linux.ibm.com>
To:     oberpar@linux.ibm.com, christian.ehrhardt@canonical.com,
        borntraeger@de.ibm.com, linux-s390@vger.kernel.org
Subject: [PATCH] s390/cio: Remove the invalid condition on IO_SCH_UNREG
Date:   Fri, 23 Apr 2021 12:08:43 +0200
Message-Id: <20210423100843.2230969-1-vneethv@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XAFudhO29ZXB0GNIj27AqvofmevTc78w
X-Proofpoint-GUID: XAFudhO29ZXB0GNIj27AqvofmevTc78w
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-23_03:2021-04-23,2021-04-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104230062
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The condition to check the cdev pointer validity on
css_sch_device_unregister() is a leftover from the 'commit c97cd8c81d4a
("s390/cio: Remove pm support from ccw bus driver")'. This could lead to a
situation, where detaching the disk is not happening completely. Remove
this invalid condition in the IO_SCH_UNREG case.

Fixes: 8cc0dcfdc1c0 ("s390/cio: remove pm support from ccw bus driver")
Reported-by: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Suggested-by: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
---
 drivers/s390/cio/device.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 3f026021e95e..84f659cafe76 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -1532,8 +1532,7 @@ static int io_subchannel_sch_event(struct subchannel *sch, int process)
 	switch (action) {
 	case IO_SCH_ORPH_UNREG:
 	case IO_SCH_UNREG:
-		if (!cdev)
-			css_sch_device_unregister(sch);
+		css_sch_device_unregister(sch);
 		break;
 	case IO_SCH_ORPH_ATTACH:
 	case IO_SCH_UNREG_ATTACH:
-- 
2.25.1

