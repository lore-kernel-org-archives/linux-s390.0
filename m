Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0041C48BE5
	for <linux-s390@archiver.kernel.org>; Wed, 16 Jun 2021 14:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7B7160FF4
	for <linux-s390@archiver.kernel.org>; Wed, 16 Jun 2021 14:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbhFPOSa (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 16 Jun 2021 10:18:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29388 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232408AbhFPOS3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 16 Jun 2021 10:18:29 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15GE3xh4189937;
        Wed, 16 Jun 2021 10:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=x1k4OvTRcy7ngy7/7tjXPrYg+8l5fghAALyRl0aJk0M=;
 b=jz9Q8NIl8oa2f0ry5HnqCcbNYsZxVKjVjF1wb1I4CE3GX6gwl85ajx2xqJRAyDnJM6RN
 BVNzyoXZLFxu/mDu5sPxjL8P+AI1rwFHVpKWJWcvPQmliLmGlF7yRDtWDWiPmFCep8qb
 5JKKu1AGRuIfbWDqB3OkkxH12Hckjdip4qXsai1AAGgZLNudMNGuuIohh3lFV/j6wina
 c+0vpyeBuuJdnm98BrmgXicEtzYK2eiaOntjHCe36YRlG0ex4iamoPbNpqzpa1pqOt45
 VlhjyFMDlYwtk+ceUUBJ+dQwPojrackzsHQVAGr4g2Ic7CvYnzfqj29N1RBYLSgaSopH Ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 397jeth6n3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Jun 2021 10:16:22 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15GE3suf189486;
        Wed, 16 Jun 2021 10:16:22 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 397jeth6k4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Jun 2021 10:16:22 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15GECBZL016486;
        Wed, 16 Jun 2021 14:16:20 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma02wdc.us.ibm.com with ESMTP id 394mja0vd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Jun 2021 14:16:20 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15GEGJKe22479174
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 14:16:19 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AAEED2805E;
        Wed, 16 Jun 2021 14:16:19 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36EF428065;
        Wed, 16 Jun 2021 14:16:19 +0000 (GMT)
Received: from cpe-172-100-179-72.stny.res.rr.com (unknown [9.85.128.252])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 16 Jun 2021 14:16:19 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com, jgg@nvidia.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
Subject: [PATCH v5 0/2] s390/vfio-ap: fix memory leak in mdev remove callback
Date:   Wed, 16 Jun 2021 10:16:16 -0400
Message-Id: <20210616141618.938494-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JLEchLKCg2YYG7j2xlS1g_EZuIJrWFYj
X-Proofpoint-ORIG-GUID: 49AaeB5uwhIqHYCP_Wd9cgxVLFtLFMAT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-16_07:2021-06-15,2021-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 spamscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 malwarescore=0 lowpriorityscore=1 bulkscore=1 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106160082
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The mdev remove callback for the vfio_ap device driver bails out with
-EBUSY if the mdev is in use by a KVM guest. The intended purpose was
to prevent the mdev from being removed while in use; however, returning a
non-zero rc does not prevent removal of the mdev. Consequently, the memory
for the resources allocated when the mdev was created are leaked. 

To fix this issue:

* The remove callback will not terminate with -EBUSY when the mdev is in
  use by a KVM guest.
  
* The memory for the resources allocated when the mdev was created will
  be freed.
  
* Since the struct ap_matrix_mdev now gets freed while the guest is
  is still running, we need to ensure that the pointer to the function
  that handles interception of the PQAP instruction executed on the guest
  is not accessed while it is being set to NULL. To prevent this, a r/w
  lock is introduced that protects the function pointer.  
  

Tony Krowiak (2):
  s390/vfio-ap: clean up mdev resources when remove callback invoked
  s390/vfio-ap: r/w lock for PQAP interception handler function pointer

 arch/s390/include/asm/kvm_host.h      |  6 +++---
 arch/s390/kvm/kvm-s390.c              |  1 +
 arch/s390/kvm/priv.c                  |  6 +++---
 drivers/s390/crypto/vfio_ap_ops.c     | 31 ++++++++++++++-------------
 drivers/s390/crypto/vfio_ap_private.h |  2 +-
 5 files changed, 24 insertions(+), 22 deletions(-)

-- 
2.30.2

