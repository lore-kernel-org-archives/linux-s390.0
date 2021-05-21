Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8012C4707D
	for <linux-s390@archiver.kernel.org>; Fri, 21 May 2021 19:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBC1F60D07
	for <linux-s390@archiver.kernel.org>; Fri, 21 May 2021 19:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239101AbhEUTiW (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 21 May 2021 15:38:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32342 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239099AbhEUTiV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 21 May 2021 15:38:21 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14LJYMp9033980;
        Fri, 21 May 2021 15:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ZPboIRUw5VI0ht5DfThXJWc1BV0ZLm8bnhapMm5xNVY=;
 b=SawuD/6DVqA6rNlG3azVRbhMFVJCR5hFFJHN3iZ8fzxRZ7R0TXedKpe1Gle4xOYkKbi/
 4cht6B6mlSPGipdE8ejrjqm7qUh/zN5GT8qBXgTPoD0ArnckJLrKuqxqA2gSTcsTHRzQ
 /YmF15gomHUZQ1wcm4jjgZTxPb/wlzr9qfzMlOaQoq/As5WX/R2mtcwJVsSrGcw2Bzhh
 wHXh0hD/9bS4Vk0mN7M+ci1tmEqpR7vTrCW//4Y3odzJ7Z8Rg1L1AjdL5RzbA8SCXtld
 sF6vwxOV3/lssO9RpVNShEitS+zivbabfeKPA4VG20YA8e6w+PsbdDhPWG1NadDMPruV tg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38pjdp117q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 May 2021 15:36:56 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14LJYNFL034066;
        Fri, 21 May 2021 15:36:56 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38pjdp1177-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 May 2021 15:36:56 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14LJZJCS008577;
        Fri, 21 May 2021 19:36:54 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma05wdc.us.ibm.com with ESMTP id 38j7tbsn0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 May 2021 19:36:54 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14LJart727590946
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 19:36:53 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B48F6E050;
        Fri, 21 May 2021 19:36:53 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A7F86E04C;
        Fri, 21 May 2021 19:36:52 +0000 (GMT)
Received: from cpe-172-100-179-72.stny.res.rr.com (unknown [9.85.177.219])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 21 May 2021 19:36:52 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com, jgg@nvidia.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
Subject: [PATCH v4 1/2] s390/vfio-ap: fix memory leak in mdev remove callback
Date:   Fri, 21 May 2021 15:36:47 -0400
Message-Id: <20210521193648.940864-2-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210521193648.940864-1-akrowiak@linux.ibm.com>
References: <20210521193648.940864-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WLKCatEXMHZ6oeTGk5mM6n4YN6M11OeS
X-Proofpoint-ORIG-GUID: 3D3viOYNtGAtkJhbKBR6FBY81fx9SAKX
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-21_08:2021-05-20,2021-05-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2105210103
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The mdev remove callback for the vfio_ap device driver bails out with
-EBUSY if the mdev is in use by a KVM guest. The intended purpose was
to prevent the mdev from being removed while in use; however, returning a
non-zero rc does not prevent removal. This could result in a memory leak
of the resources allocated when the mdev was created. In addition, the
KVM guest will still have access to the AP devices assigned to the mdev
even though the mdev no longer exists.

To prevent this scenario, cleanup will be done - including unplugging the
AP adapters, domains and control domains - regardless of whether the mdev
is in use by a KVM guest or not.

Fixes: 258287c994de ("s390: vfio-ap: implement mediated device open callback")
Cc: stable@vger.kernel.org
Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index b2c7e10dfdcd..f90c9103dac2 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -26,6 +26,7 @@
 
 static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev);
 static struct vfio_ap_queue *vfio_ap_find_queue(int apqn);
+static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev);
 
 static int match_apqn(struct device *dev, const void *data)
 {
@@ -366,17 +367,7 @@ static int vfio_ap_mdev_remove(struct mdev_device *mdev)
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 
 	mutex_lock(&matrix_dev->lock);
-
-	/*
-	 * If the KVM pointer is in flux or the guest is running, disallow
-	 * un-assignment of control domain.
-	 */
-	if (matrix_mdev->kvm_busy || matrix_mdev->kvm) {
-		mutex_unlock(&matrix_dev->lock);
-		return -EBUSY;
-	}
-
-	vfio_ap_mdev_reset_queues(mdev);
+	vfio_ap_mdev_unset_kvm(matrix_mdev);
 	list_del(&matrix_mdev->node);
 	kfree(matrix_mdev);
 	mdev_set_drvdata(mdev, NULL);
-- 
2.30.2

