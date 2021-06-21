Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED46C4743C
	for <linux-s390@archiver.kernel.org>; Mon, 21 Jun 2021 15:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 463F461151
	for <linux-s390@archiver.kernel.org>; Mon, 21 Jun 2021 15:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhFUP7e (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 21 Jun 2021 11:59:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45106 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230204AbhFUP7e (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 21 Jun 2021 11:59:34 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15LFX6dO191314;
        Mon, 21 Jun 2021 11:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=WBFi8baW0KdalP6xDuyxPaggXWABzdhRnlZ7Z5xwJmY=;
 b=XGuGnGKgsxzB2l4Sn/+uRRsZOOI6ebATqHCcMhTd3Q/Bkpo6zylAI8Vp0xVPpu2O3JwO
 sGC+7f+hkRpJmjmpTkoQqWaZwuyu/Yi0i1KfwbEKqijVqWn6G34qekG22q6R1Mu0PUnW
 WRL132eQqs19rZOOq4o+ctQhRiCdSESqy2I54KvTy+wmagtU+84O7uxe5OvUrbayAk3j
 HR/gGzm8FtcJms5cnKS1TBTaFqWTUR3MxVsIhiHE4sx0xpiN9Jbcdz2nmL2LdDf4EUPc
 ArDwY4Cx+fvWfCmRFjkI/W8bnVT/4YiDVxpoNQm7IbwkR9dg7d2vnHr+eTCPeVtw635J Vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39aufe5bev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Jun 2021 11:57:17 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15LFY4Bb195112;
        Mon, 21 Jun 2021 11:57:17 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39aufe5beb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Jun 2021 11:57:17 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15LFqQYT022857;
        Mon, 21 Jun 2021 15:57:16 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03wdc.us.ibm.com with ESMTP id 3998790fc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Jun 2021 15:57:16 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15LFvFaV24838438
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 15:57:15 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFF772805A;
        Mon, 21 Jun 2021 15:57:15 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49B7228059;
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
Subject: [PATCH v6 0/2] s390/vfio-ap: fix memory leak in mdev remove callback
Date:   Mon, 21 Jun 2021 11:57:12 -0400
Message-Id: <20210621155714.1198545-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xuMBTNm57KW6SrOWR-ZpfYYFPYEwnikE
X-Proofpoint-ORIG-GUID: C9yyjcFEcWrCSPZcJGBBR-rsmzPZFPGl
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-21_06:2021-06-21,2021-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 bulkscore=1 malwarescore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=1 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106210092
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
  
Change log:
v5 -> v6:
--------
* Replaced struct kvm_s390_module_hook with function pointer
  int (*crypto_hook)(struct kvm_vcpu *vcpu) 

Tony Krowiak (2):
  s390/vfio-ap: clean up mdev resources when remove callback invoked
  s390/vfio-ap: r/w lock for PQAP interception handler function pointer

 arch/s390/include/asm/kvm_host.h      |  8 +++----
 arch/s390/kvm/kvm-s390.c              |  1 +
 arch/s390/kvm/priv.c                  | 10 ++++----
 drivers/s390/crypto/vfio_ap_ops.c     | 33 ++++++++++++++-------------
 drivers/s390/crypto/vfio_ap_private.h |  2 +-
 5 files changed, 28 insertions(+), 26 deletions(-)

-- 
2.30.2

