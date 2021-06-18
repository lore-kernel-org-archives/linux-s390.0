Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7220C48BDF
	for <linux-s390@archiver.kernel.org>; Fri, 18 Jun 2021 14:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AFF761209
	for <linux-s390@archiver.kernel.org>; Fri, 18 Jun 2021 14:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbhFRODz (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 18 Jun 2021 10:03:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29654 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230387AbhFRODz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 18 Jun 2021 10:03:55 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15IDWpU2196043;
        Fri, 18 Jun 2021 10:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=+pWbFSs9Iel7c/V4vUdVowfVW9cWcsmHw41QoLDbzW8=;
 b=YTD5/cbMFv9IuLeOoGsQWoGW0Gfxwj+FxhcdHlpa48ph50pikgjitgxUdC9aycgmJNLd
 hfsH33kp8DXwJfzA59KRNFJ2O9NSKa7G8/20VEHVw6Ju0hcLQJXAfwRcv+EUgLqkAY+P
 S9HkBwo0MUsfaQzLP50IMRpl8Bi+Ywp+9oqcdDgKVMCfiX7dKkrSYr+hBjU0oaZX/pdV
 6niErhE4HZvtXvfj1eJ+05mFiMfgwDAIn6mvAsSH3iW92WW90I+iimLZJjBVX/iDnFO7
 +1ixS3Poz1gV2tBhGXqEjfrAqp/PAklcCdLpbg07L7oXzcVtO2KhbtCCyFAVV8wJJG4f kA== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 398veu10x8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 10:01:38 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15IDXYKo028789;
        Fri, 18 Jun 2021 13:35:25 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma03dal.us.ibm.com with ESMTP id 394mjantaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 13:35:25 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15IDZOmD20971892
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 13:35:24 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0FD5124053;
        Fri, 18 Jun 2021 13:35:24 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6BE9C124055;
        Fri, 18 Jun 2021 13:35:24 +0000 (GMT)
Received: from jason-laptop.ibmuc.com (unknown [9.85.129.236])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 18 Jun 2021 13:35:24 +0000 (GMT)
From:   "Jason J. Herne" <jjherne@linux.ibm.com>
To:     linux-s390@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, pasic@linux.ibm.com,
        akrowiak@linux.ibm.com, jgg@nvidia.com
Subject: [PATCH] s390/vfio-ap: Fix module unload memory leak of matrix_dev
Date:   Fri, 18 Jun 2021 09:35:24 -0400
Message-Id: <20210618133524.22386-1-jjherne@linux.ibm.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fjSSk91C9yEJ3whwbg-z7CYgn84sDl3n
X-Proofpoint-ORIG-GUID: fjSSk91C9yEJ3whwbg-z7CYgn84sDl3n
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-18_07:2021-06-18,2021-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106180079
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

vfio_ap_matrix_dev_release is shadowing the global matrix_dev with driver
data that never gets set. So when release is called we end up not freeing
matrix_dev. The fix is to remove the shadow variable and just free the
global.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_drv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index 7dc72cb718b0..6d3eea838e18 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -82,8 +82,6 @@ static void vfio_ap_queue_dev_remove(struct ap_device *apdev)
 
 static void vfio_ap_matrix_dev_release(struct device *dev)
 {
-	struct ap_matrix_dev *matrix_dev = dev_get_drvdata(dev);
-
 	kfree(matrix_dev);
 }
 
-- 
2.21.1

