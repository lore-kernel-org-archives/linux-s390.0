Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18565C433EF
	for <linux-s390@archiver.kernel.org>; Wed, 20 Oct 2021 11:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBD4D610CB
	for <linux-s390@archiver.kernel.org>; Wed, 20 Oct 2021 11:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhJTLxp (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 20 Oct 2021 07:53:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56392 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229548AbhJTLxp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 20 Oct 2021 07:53:45 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KAplu2023958;
        Wed, 20 Oct 2021 07:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=mf382GvJyN4GUUt207UAvLUfUOW7vtNM72JdeRS3E6o=;
 b=fD+CwnP0yQ9cPQ1G9G1v6JWooUsYdXj8sUCt5Y7v1IrBYOb+VpA0+d6hthn/brAEuw5t
 uFc94Bo6Cy6W0Iu++qLchi1HIyKkZUOJklZ7i78y+eyVFbmvBV4F9Yuy3HiNkXpyYgwW
 jlNuds6J1bV9/Vvih7+O8fNk2T2JHTWP76pEH1DAK211pf6KJfb7+n0UtOVOsJKIMmuu
 MpoJhVgK/LplYuEEH8rtQDvXmjaajc9kcjjv0LMIvzJtmXzpAWhwuChJnNXSMSCLFIPm
 TZVt4oBg760KUkamSWIMjRSjAY2tAr0yg6+XdlZcG/lrcC7ZiWXJPUJ8SCDcJs9bJckJ zA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bthqys40q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 07:51:30 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19KBluaO009899;
        Wed, 20 Oct 2021 11:51:28 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3bqpca40wk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 11:51:28 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19KBpPI63277362
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 11:51:25 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33B18AE051;
        Wed, 20 Oct 2021 11:51:25 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22A87AE045;
        Wed, 20 Oct 2021 11:51:25 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 20 Oct 2021 11:51:25 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 78107E07CA; Wed, 20 Oct 2021 13:51:24 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 6/7] s390/dasd: fix missing path conf_data after failed allocation
Date:   Wed, 20 Oct 2021 13:51:23 +0200
Message-Id: <20211020115124.1735254-7-sth@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211020115124.1735254-1-sth@linux.ibm.com>
References: <20211020115124.1735254-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NlRSlOCOeVgikeEJc4fPPByubyi9NivY
X-Proofpoint-ORIG-GUID: NlRSlOCOeVgikeEJc4fPPByubyi9NivY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-20_04,2021-10-20_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110200066
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

dasd_eckd_path_available_action() does a memory allocation to store
the per path configuration data permanently.
In the unlikely case that this allocation fails there is no conf_data
stored for the corresponding path.

This is OK since this is not necessary for an operational path but some
features like control unit initiated reconfiguration (CUIR) do not work.

To fix this add the path to the 'to be verified pathmask' again and
schedule the handler again.

Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 6cfaaddb4fbb..8410a25a65c1 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -1403,6 +1403,14 @@ static void dasd_eckd_path_available_action(struct dasd_device *device,
 		if (conf_data) {
 			memcpy(conf_data, data->rcd_buffer,
 			       DASD_ECKD_RCD_DATA_SIZE);
+		} else {
+			/*
+			 * path is operational but path config data could not
+			 * be stored due to low mem condition
+			 * add it to the error path mask and schedule a path
+			 * verification later that this could be added again
+			 */
+			epm |= lpm;
 		}
 		pos = pathmask_to_pos(lpm);
 		dasd_eckd_store_conf_data(device, conf_data, pos);
@@ -1423,7 +1431,10 @@ static void dasd_eckd_path_available_action(struct dasd_device *device,
 		}
 		dasd_path_add_nppm(device, npm);
 		dasd_path_add_ppm(device, ppm);
-		dasd_path_add_tbvpm(device, epm);
+		if (epm) {
+			dasd_path_add_tbvpm(device, epm);
+			dasd_device_set_timer(device, 50);
+		}
 		dasd_path_add_cablepm(device, cablepm);
 		dasd_path_add_nohpfpm(device, hpfpm);
 		spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
-- 
2.25.1

