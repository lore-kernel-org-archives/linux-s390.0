Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE9AC48BE8
	for <linux-s390@archiver.kernel.org>; Fri, 18 Jun 2021 17:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7BFD61004
	for <linux-s390@archiver.kernel.org>; Fri, 18 Jun 2021 17:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbhFRRPK (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 18 Jun 2021 13:15:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63358 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232598AbhFRRPK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 18 Jun 2021 13:15:10 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15IH3frh031546;
        Fri, 18 Jun 2021 13:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=UyYdy8cqxOzHqUrJb0iTgtqQLsdzwr2B/pQPf/HGKrA=;
 b=fK46gyf/7x9j6o1Eou1TmeCjcsZ9/l81z/f7FoQfRYteXSoM7ypDeO+Bpz6xhCZ0g0z7
 FuZbS7VWm+2Rtichie7uXE/NV9YD1USIDcwqoiG1cAo4fHRlyzyi+6slLfOFWDhy1r++
 ZvkGkA9Hc9TB4iWCsZDoGevRBA7NkXzRmT12NuYDD5OAtQHbm9VR1Da9PL961N/eQtrr
 r9HIx4zRCKA9VjxtsVXsp7uR2O6OWpaCSTya9QgwnO3nzPW6q9nvjTCAAILOVN2nff8j
 W2dFdk2oxd6FCsbtqPn3f1sxw+prRsyveMM7GFSkXcy3c8jIWo98nAYim7jZXnyc4o93 Dg== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 398y4e11u6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 13:12:58 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15IH3VP5010383;
        Fri, 18 Jun 2021 17:12:57 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma05wdc.us.ibm.com with ESMTP id 3954gkxc1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 17:12:57 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15IHCuam21561724
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 17:12:56 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60FFD6E050;
        Fri, 18 Jun 2021 17:12:56 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8A896E04E;
        Fri, 18 Jun 2021 17:12:55 +0000 (GMT)
Received: from jason-laptop.ibmuc.com (unknown [9.85.129.236])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 18 Jun 2021 17:12:55 +0000 (GMT)
From:   "Jason J. Herne" <jjherne@linux.ibm.com>
To:     linux-s390@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, pasic@linux.ibm.com,
        akrowiak@linux.ibm.com, jgg@nvidia.com
Subject: [PATCH v2] s390/vfio-ap: Fix module unload memory leak of matrix_dev
Date:   Fri, 18 Jun 2021 13:12:55 -0400
Message-Id: <20210618171255.2025-1-jjherne@linux.ibm.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bEJgEve1o4XsWk7QyHfuRkc9wVQd96GE
X-Proofpoint-ORIG-GUID: bEJgEve1o4XsWk7QyHfuRkc9wVQd96GE
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-18_10:2021-06-18,2021-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106180100
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

vfio_ap_matrix_dev_release is shadowing the global matrix_dev with a NULL
pointer. Driver data for the matrix device is never set and so
dev_get_drvdata() always returns NULL. When release is called we end up
not freeing matrix_dev. The fix is to remove the shadow variable and get
the correct pointer from the device using container_of. We'll also NULL
the global to prevent any future use.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_drv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index 7dc72cb718b0..40e66cb363d1 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -82,9 +82,8 @@ static void vfio_ap_queue_dev_remove(struct ap_device *apdev)
 
 static void vfio_ap_matrix_dev_release(struct device *dev)
 {
-	struct ap_matrix_dev *matrix_dev = dev_get_drvdata(dev);
-
-	kfree(matrix_dev);
+	kfree(container_of(dev, struct ap_matrix_dev, device));
+	matrix_dev = NULL;
 }
 
 static int matrix_bus_match(struct device *dev, struct device_driver *drv)
-- 
2.21.1

