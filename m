Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96719C76188
	for <linux-s390@archiver.kernel.org>; Wed,  5 Apr 2023 14:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237766AbjDEOl7 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 5 Apr 2023 10:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237398AbjDEOl4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 5 Apr 2023 10:41:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C8D40C4;
        Wed,  5 Apr 2023 07:41:43 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 335Dv4r9027460;
        Wed, 5 Apr 2023 14:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=pc7qniAN4vjGcrauIAuGswZmbQTkPmHflKHcwYCNj3Q=;
 b=kO4Ux52eW+aYU6U0g769uBkPy/5Sr6XfA0LKdGYuMork0/NVULoNnFB0ima18l7iCool
 7S/2sbss0DA3yCLlj5Eylv231R3E7QPr4C604sSvPKJP8zF375/4oRO8T29zfoLg5d1H
 VAdlGRxMht/xmyBugN8Sk0UH6QQ6lutiM/EYtxd08wBSg4HrFtcrfLQEJHJAmGqLhKDP
 PwMjsaPXvWO187rRQKxtxhO/Qo3KpgGwhf2LLKx5zAuo5esknVkycNOQeu4IBc4UiM9N
 q1n8Bq1W1bSimY+F6wUKZpafqNHSfYhTpdneqL+FD029m4ZEaZTLpo+ZbwCahe59QT09 mQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3psaamrrg5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 14:20:25 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 334NupWA003364;
        Wed, 5 Apr 2023 14:20:21 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3ppc873cnp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 14:20:21 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 335EKIjo50135678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Apr 2023 14:20:18 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2139F2004D;
        Wed,  5 Apr 2023 14:20:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DAF12004B;
        Wed,  5 Apr 2023 14:20:18 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed,  5 Apr 2023 14:20:18 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 8C160E13E2; Wed,  5 Apr 2023 16:20:17 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 6/7] s390/dasd: add autoquiesce event for start IO error
Date:   Wed,  5 Apr 2023 16:20:16 +0200
Message-Id: <20230405142017.2446986-7-sth@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230405142017.2446986-1-sth@linux.ibm.com>
References: <20230405142017.2446986-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MvuuerSaPPWWQWMozTbs8LvFbVXtpKL-
X-Proofpoint-ORIG-GUID: MvuuerSaPPWWQWMozTbs8LvFbVXtpKL-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_09,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304050127
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Add a check for errors in the start_io function that signal a not
working device. Trigger an autoquiesce event in that case.

Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
---
 drivers/s390/block/dasd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 1bfd0e17a4dc..3696931f8015 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -1452,6 +1452,8 @@ int dasd_start_IO(struct dasd_ccw_req *cqr)
 	case -ENODEV:
 		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 			      "start_IO: -ENODEV device gone, retry");
+		/* this is equivalent to CC=3 for SSCH report this to EER */
+		dasd_handle_autoquiesce(device, cqr, DASD_EER_STARTIO);
 		break;
 	case -EIO:
 		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
-- 
2.37.2

