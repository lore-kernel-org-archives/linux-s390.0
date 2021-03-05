Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C93EC433E6
	for <linux-s390@archiver.kernel.org>; Fri,  5 Mar 2021 12:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61DE665012
	for <linux-s390@archiver.kernel.org>; Fri,  5 Mar 2021 12:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhCEMzG (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 5 Mar 2021 07:55:06 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37642 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230052AbhCEMyq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 5 Mar 2021 07:54:46 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 125CXF8P058704;
        Fri, 5 Mar 2021 07:54:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ZHK+e5+M6phaF+3fy7Cqjm/QvX4wZFJbJ8rZX0O6a0I=;
 b=qA9sEY/2SOaEwU88evBbq8SksXq8RM5j/NoWv1aTWA7/0Emxs4NeeGpCEbHLyTkShKdF
 9Kf0s/7Dl3l5dy9M5b1Mrlb1RyY48WvVocKF5N+Lhaw03SraJETGGpKX0KUaXteVM5Zj
 IYdeWLdqJ/MUpFrt5UJWSJvB9LWIxSUfSG6ORA6kzaxecGOslROjPM7k9kH79RYXjy7E
 Oq7cJOmJdq/kXSArnimSPyvB2VzM8BxclUTk259cMer/x0j0K3dTiMcaHWy5fjkd5VDq
 cdSJeCHL7Q5ZV1aEZXFqMy0ti1nUc9Wf0hPO8U0ILTvmuxNN/S3XVcfU7Zw8Qufqf8TF jQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 373k57bgd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Mar 2021 07:54:45 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 125CbkPB010136;
        Fri, 5 Mar 2021 12:54:43 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 37293ft0qs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Mar 2021 12:54:43 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 125CsPg633882578
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 Mar 2021 12:54:25 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A2F352059;
        Fri,  5 Mar 2021 12:54:40 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 3722D52051;
        Fri,  5 Mar 2021 12:54:40 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id C09C0E0519; Fri,  5 Mar 2021 13:54:39 +0100 (CET)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 1/2] s390/dasd: fix hanging DASD driver unbind
Date:   Fri,  5 Mar 2021 13:54:38 +0100
Message-Id: <20210305125439.568125-2-sth@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210305125439.568125-1-sth@linux.ibm.com>
References: <20210305125439.568125-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-05_08:2021-03-03,2021-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=920 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103050063
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

In case of an unbind of the DASD device driver the function
dasd_generic_remove() is called which shuts down the device.
Among others this functions removes the int_handler from the cdev.
During shutdown the device cancels all outstanding IO requests and waits
for completion of the clear request.
Unfortunately the clear interrupt will never be received when there is no
interrupt handler connected.

Fix by moving the int_handler removal after the call to the state machine
where no request or interrupt is outstanding.

Cc: stable@vger.kernel.org
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Tested-by: Bjoern Walk <bwalk@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
---
 drivers/s390/block/dasd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 28c04a4efa66..22805115ebc2 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -3487,8 +3487,6 @@ void dasd_generic_remove(struct ccw_device *cdev)
 	struct dasd_device *device;
 	struct dasd_block *block;
 
-	cdev->handler = NULL;
-
 	device = dasd_device_from_cdev(cdev);
 	if (IS_ERR(device)) {
 		dasd_remove_sysfs_files(cdev);
@@ -3507,6 +3505,7 @@ void dasd_generic_remove(struct ccw_device *cdev)
 	 * no quite down yet.
 	 */
 	dasd_set_target_state(device, DASD_STATE_NEW);
+	cdev->handler = NULL;
 	/* dasd_delete_device destroys the device reference. */
 	block = device->block;
 	dasd_delete_device(device);
-- 
2.25.1

