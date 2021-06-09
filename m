Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA05C48BCF
	for <linux-s390@archiver.kernel.org>; Wed,  9 Jun 2021 22:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 806B661364
	for <linux-s390@archiver.kernel.org>; Wed,  9 Jun 2021 22:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhFIWsn (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 9 Jun 2021 18:48:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26620 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229534AbhFIWsm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Jun 2021 18:48:42 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 159MiWKV140516;
        Wed, 9 Jun 2021 18:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=QFsDLGNvWv5mH4iWK1w6XmVRPnPoYnp4yKhy4ilU8v4=;
 b=VaPP7fbSBpOXZChtvEgGJyZjj9ZbS3Mx9YgUo6S6X2dMbJtxfxZ939nCVK8UDtIlQjDZ
 LHPthEPxZHLbogq0/NKxB6kaQCPUbKro6BDKEbNvEItzn/jtb+BZYrTJm7sFNntwAwld
 d+Q45yukrlt/pdgBxYCeGYUV2ygWwOHnHaWrzVb5b6KP3POp40/AVsmcVt82W9h04d0p
 j91hAE17Jh2t+uyLujA3SW/2v3iy9CPya15IbpsxvFjnqNpHZz2lsLpwlnsUMvvf1udb
 TB9plRzGERezgeH5SRv1EzMUfHo+I1lApzsjCSn2s5cK15l18Amfa5muD59ZbK0o62SD tw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3936pt815r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Jun 2021 18:46:45 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 159Mkir6153738;
        Wed, 9 Jun 2021 18:46:44 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3936pt815g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Jun 2021 18:46:44 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 159MfKt7013271;
        Wed, 9 Jun 2021 22:46:43 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01dal.us.ibm.com with ESMTP id 3900w9v3ks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Jun 2021 22:46:43 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 159Mkg4K12190308
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Jun 2021 22:46:42 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 382C7C6059;
        Wed,  9 Jun 2021 22:46:42 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02325C605B;
        Wed,  9 Jun 2021 22:46:40 +0000 (GMT)
Received: from cpe-172-100-179-72.stny.res.rr.com (unknown [9.85.129.35])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jun 2021 22:46:40 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com, jgg@nvidia.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
Subject: [PATCH 0/3] s390/vfio-ap: refactor mdev remove callback and locks
Date:   Wed,  9 Jun 2021 18:46:31 -0400
Message-Id: <20210609224634.575156-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nTdoBIP4RXuGjOoxL79LeEzbXgKqKAZS
X-Proofpoint-GUID: SrkhQFX5xz23_DNr5ixjlwSNHVdk1pvQ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-09_07:2021-06-04,2021-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=541
 bulkscore=0 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106090120
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This series is an expansion of a previous patch series entitled 
's390/vfio-ap: fix memory leak in mdev remove callback'. It has been
renamed because there never really was a memory leak to fix. In addition,
reviews of the previous series gave rise to additional changes to the
locking mechanisms used to control access to various data elements managed
by the vfio_ap device driver.

This patch series:

1. Refactors the mdev remove callback to always clean up mdev resources
2. Adds two semaphores to replace wait queue during KVM pointer set/unset
3. Adds a semaphore to control r/w access to PQAP instruction interception
   handler.

Tony Krowiak (3):
  s390/vfio-ap: clean up mdev resources when remove callback invoked
  s390/vfio-ap: introduce two new r/w locks to replace wait_queue_head_t
  s390/vfio-ap: r/w lock for PQAP interception handler function pointer

 arch/s390/include/asm/kvm_host.h      |   6 +-
 arch/s390/kvm/kvm-s390.c              |   1 +
 arch/s390/kvm/priv.c                  |   6 +-
 drivers/s390/crypto/vfio_ap_ops.c     | 374 ++++++++++----------------
 drivers/s390/crypto/vfio_ap_private.h |  10 +-
 5 files changed, 163 insertions(+), 234 deletions(-)

-- 
2.30.2

