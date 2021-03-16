Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A76C433DB
	for <linux-s390@archiver.kernel.org>; Tue, 16 Mar 2021 09:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 964F864D9D
	for <linux-s390@archiver.kernel.org>; Tue, 16 Mar 2021 09:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbhCPJp0 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 16 Mar 2021 05:45:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36568 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234600AbhCPJpU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 16 Mar 2021 05:45:20 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12G9WjfY104058;
        Tue, 16 Mar 2021 05:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=bDUhv/Rmalkj9sUfNGJQMSrk0ND1XsfonOZvh4zo72g=;
 b=AE/2Yhab3ABEE+1MHBZTd0xDNgEJCBsRhVLzTYRFejW+KHDeqzN2F76dqw9ilv1qZKTm
 aXHaRRFf+2fooBde02jEGqMp43nrFZhyp7v+OInn2+VmTvSiSiYOa9593ub/Pap2HK1a
 WL+N0iFtIvLatt8ghzc7TLf+ZqzX85R0c2GRg7uvpgC7jcR4JMT87iWRNu048pngq2Fk
 upUsAzUTEtP8u4nGSmrGKKk25sUolA+VSJAMClFzrIlEK9n10uUVS7BB0mV6k0nC6qHH
 wFGX6J3ja/jaJizz388VwFit5IR/jFVbTXRp3vL8YfVPmP4FPYTiIXmTAWIillkDwGqu AQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37ah5f545v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Mar 2021 05:45:19 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12G9gnqx009041;
        Tue, 16 Mar 2021 09:45:17 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 378n18jpkk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Mar 2021 09:45:17 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12G9iw3f31195520
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Mar 2021 09:44:58 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 838D0A4054;
        Tue, 16 Mar 2021 09:45:14 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6EEBFA4064;
        Tue, 16 Mar 2021 09:45:14 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 16 Mar 2021 09:45:14 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id EA52AE11F1; Tue, 16 Mar 2021 10:45:13 +0100 (CET)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH 1/2] s390/dasd: remove dasd_fba_probe() wrapper
Date:   Tue, 16 Mar 2021 10:45:12 +0100
Message-Id: <20210316094513.2601218-2-sth@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210316094513.2601218-1-sth@linux.ibm.com>
References: <20210316094513.2601218-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-16_03:2021-03-15,2021-03-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103160065
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Julian Wiedmann <jwi@linux.ibm.com>

commit e03c5941f904 ("s390/dasd: Remove unused parameter from
dasd_generic_probe()") allows us to wire the generic callback up
directly, avoiding the additional level of indirection.

While at it also remove the forward declaration for the dasd_fba_driver
struct, it's no longer needed.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>

---
 drivers/s390/block/dasd_fba.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
index 1aeb68794ce8..f76fe05b66c6 100644
--- a/drivers/s390/block/dasd_fba.c
+++ b/drivers/s390/block/dasd_fba.c
@@ -54,13 +54,6 @@ static struct ccw_device_id dasd_fba_ids[] = {
 
 MODULE_DEVICE_TABLE(ccw, dasd_fba_ids);
 
-static struct ccw_driver dasd_fba_driver; /* see below */
-static int
-dasd_fba_probe(struct ccw_device *cdev)
-{
-	return dasd_generic_probe(cdev);
-}
-
 static int
 dasd_fba_set_online(struct ccw_device *cdev)
 {
@@ -73,7 +66,7 @@ static struct ccw_driver dasd_fba_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.ids         = dasd_fba_ids,
-	.probe       = dasd_fba_probe,
+	.probe       = dasd_generic_probe,
 	.remove      = dasd_generic_remove,
 	.set_offline = dasd_generic_set_offline,
 	.set_online  = dasd_fba_set_online,
-- 
2.25.1

