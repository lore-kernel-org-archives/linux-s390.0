Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E90DC48BD1
	for <linux-s390@archiver.kernel.org>; Wed,  9 Jun 2021 22:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63B7061364
	for <linux-s390@archiver.kernel.org>; Wed,  9 Jun 2021 22:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhFIWsp (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 9 Jun 2021 18:48:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64920 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229534AbhFIWso (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Jun 2021 18:48:44 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 159MY4Iv061458;
        Wed, 9 Jun 2021 18:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=LsJ9JB8hmnCeeIHNbVxfHe5EGeETrkQAREDQHRTZpDA=;
 b=St6615HgM/E1nQIWSipSIq5WUYnPOPiAwfBBw3l8RO9uV0s/D6+MO0AeYkaSPGrS5/GL
 83TtLNADKvsEwhsdtfagbC/SIXpGXfY0GjfqYILNFhQQ4rc/vYtRwZk5quqpWS8ccFcc
 c3Ez5V7FtcLXec0c7MAYGm7MwiGsW/LZEBbRm2KeDAtvCYltoxggv3OtYGosVCYBpjsz
 QwwFSkqbk1OIFGhV3T89puvs2To5AvhqykYxgLkocMSTwsDRDHki7T359d1uWVlyrBeh
 9775CE6ak+gwM1F0KwePl4LMsJ5Lcvbh3sObm8JTyMXldTYKECU9mjy1m2mifptF+4Pb WA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3936128yrs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Jun 2021 18:46:46 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 159MYBJF064857;
        Wed, 9 Jun 2021 18:46:46 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3936128yrm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Jun 2021 18:46:46 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 159Mgspb007226;
        Wed, 9 Jun 2021 22:46:45 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma05wdc.us.ibm.com with ESMTP id 3900w9ubjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Jun 2021 22:46:45 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 159MkiTu30081306
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Jun 2021 22:46:44 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 330A6C6059;
        Wed,  9 Jun 2021 22:46:44 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95AAAC6055;
        Wed,  9 Jun 2021 22:46:42 +0000 (GMT)
Received: from cpe-172-100-179-72.stny.res.rr.com (unknown [9.85.129.35])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jun 2021 22:46:42 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com, jgg@nvidia.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
Subject: [PATCH 1/3] s390/vfio-ap: clean up mdev resources when remove callback invoked
Date:   Wed,  9 Jun 2021 18:46:32 -0400
Message-Id: <20210609224634.575156-2-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210609224634.575156-1-akrowiak@linux.ibm.com>
References: <20210609224634.575156-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ak32z3irZ5WEqTQm2E36PhiBLGyjviDa
X-Proofpoint-ORIG-GUID: B3WEdKF1B1u0Z_Gb6nf6YN4B_CFU-gv7
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-09_07:2021-06-04,2021-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 adultscore=0 phishscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106090120
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

