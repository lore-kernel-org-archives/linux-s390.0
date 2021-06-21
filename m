Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51C1C48BC2
	for <linux-s390@archiver.kernel.org>; Mon, 21 Jun 2021 15:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5CE1600D3
	for <linux-s390@archiver.kernel.org>; Mon, 21 Jun 2021 15:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhFUP7f (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 21 Jun 2021 11:59:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51918 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229719AbhFUP7e (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 21 Jun 2021 11:59:34 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15LFXdBH029756;
        Mon, 21 Jun 2021 11:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=GX4Bs1h1h8mJ0KfOjRvkbYASkjQeqaAJys0onAVuIV8=;
 b=Tfj9Uu/uHCEgCUJuluTdSl/hJywvWM8NIl0VY/s9JFcYfND4j4+DtKI2256Sz7mkiiW4
 VtkPIVCAZnSyyQNf6/4vhW7CZX7C/6YXmeW5NkFVnlf0CaH4PWwLgUyRBehjQRoQpDS/
 zwbmVDZ4RJrvt+L0Kx2BD/qvFk3n003vw38Bcd7P5aPoiwGMFLktQHTYo73H/7wQWqZW
 fFsjYlmICUWqpKTzuyErLYsWgQfS+wTYybUnGBmSkfzWCdnY4LtHFDId891M8A1djQdp
 bWgh95YtWWRzOr9Bg5B35waiSsbPwjRCON5ufGOi3xDUHzCKrvGVaLxwVc95ZDFKrdHU Rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39avw7239g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Jun 2021 11:57:17 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15LFY8VU033612;
        Mon, 21 Jun 2021 11:57:17 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39avw72395-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Jun 2021 11:57:17 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15LFpqGU011375;
        Mon, 21 Jun 2021 15:57:16 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma01wdc.us.ibm.com with ESMTP id 399878gd7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Jun 2021 15:57:16 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15LFvGd941353476
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 15:57:16 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50F442805A;
        Mon, 21 Jun 2021 15:57:16 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD3072805E;
        Mon, 21 Jun 2021 15:57:15 +0000 (GMT)
Received: from cpe-172-100-179-72.stny.res.rr.com.com (unknown [9.85.128.252])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 21 Jun 2021 15:57:15 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com, jgg@nvidia.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
Subject: [PATCH v6 1/2] s390/vfio-ap: clean up mdev resources when remove callback invoked
Date:   Mon, 21 Jun 2021 11:57:13 -0400
Message-Id: <20210621155714.1198545-2-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210621155714.1198545-1-akrowiak@linux.ibm.com>
References: <20210621155714.1198545-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KnK1pi32iZ2OR53UFSLlxGAfmWBZKtdT
X-Proofpoint-GUID: KkCTIgWUj95XoFMNThfx7u-PvcHmPCMT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-21_06:2021-06-21,2021-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0 spamscore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106210092
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The mdev remove callback for the vfio_ap device driver bails out with
-EBUSY if the mdev is in use by a KVM guest (i.e., the KVM pointer in the
struct ap_matrix_mdev is not NULL). The intended purpose was
to prevent the mdev from being removed while in use. There are two
problems with this scenario:

1. Returning a non-zero return code from the remove callback does not
   prevent the removal of the mdev.

2. The KVM pointer in the struct ap_matrix_mdev will always be NULL because
   the remove callback will not get invoked until the mdev fd is closed.
   When the mdev fd is closed, the mdev release callback is invoked and
   clears the KVM pointer from the struct ap_matrix_mdev.

Let's go ahead and remove the check for KVM in the remove callback and
allow the cleanup of mdev resources to proceed.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Cc: stable@vger.kernel.org
---
 drivers/s390/crypto/vfio_ap_ops.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index b2c7e10dfdcd..122c85c22469 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -366,16 +366,6 @@ static int vfio_ap_mdev_remove(struct mdev_device *mdev)
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
 	vfio_ap_mdev_reset_queues(mdev);
 	list_del(&matrix_mdev->node);
 	kfree(matrix_mdev);
-- 
2.30.2

