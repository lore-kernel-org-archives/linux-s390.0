Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48033C07E9B
	for <linux-s390@archiver.kernel.org>; Mon, 19 Jul 2021 23:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2778460FE9
	for <linux-s390@archiver.kernel.org>; Mon, 19 Jul 2021 23:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357771AbhGSWf0 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 19 Jul 2021 18:35:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21396 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1357618AbhGSSyx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 19 Jul 2021 14:54:53 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16JJXuDh141732;
        Mon, 19 Jul 2021 15:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=6wXL8kYv7PIHuPHbF8+Ujp0VE7YSWe+NXheDrO5+zMg=;
 b=tIwFa4zUvvjq6Rd5L+BlVlr6nEhyn20iBBMlxVw4Sn4sRo7FvLJP+uZMllNB7beT2b6D
 roeD2XOleIwsf8I7HAmp6huwruQVzpdYWNV4HQbCGBmkckW+MGqLjpx0N0OWI65E02Xk
 6oky7p1Dt4sSQdlE0BtrVMPLt2RPo1dlBgKl/XykK0WLDCvfLYskvKS0oE2GU9iJvkB4
 H/TS237pmlmCOmOTv0Zv9orrNTiMtEMHA9MgUHGpx11NpmntUykltd0Zj8x6Eiyz0O+u
 Z78Rppq5ZsENy1xc20KciOar2rbPbLwyTXsnN/Am4I8iOs5zn6IeGU1w3wSF7f17nonW TA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39wch9xcsv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jul 2021 15:35:06 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16JJXvVw141804;
        Mon, 19 Jul 2021 15:35:06 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39wch9xcs3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jul 2021 15:35:06 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16JJRalx016117;
        Mon, 19 Jul 2021 19:35:05 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma05wdc.us.ibm.com with ESMTP id 39upuajb7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jul 2021 19:35:05 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16JJZ5X340894868
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jul 2021 19:35:05 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C9E011206F;
        Mon, 19 Jul 2021 19:35:05 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54FEF11206E;
        Mon, 19 Jul 2021 19:35:04 +0000 (GMT)
Received: from fedora.ibmuc.com (unknown [9.85.184.30])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 19 Jul 2021 19:35:04 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com, jgg@nvidia.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com, david@redhat.com
Subject: [PATCH 0/2] s390/vfio-ap: do not open code locks for VFIO_GROUP_NOTIFY_SET_KVM notification
Date:   Mon, 19 Jul 2021 15:35:01 -0400
Message-Id: <20210719193503.793910-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nfv7yS_eUVlvpRgulUmoBRHGySaD-g-T
X-Proofpoint-GUID: CFiAGp56OYfDFRpW8CD3ZHVKKD99PFiC
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-19_09:2021-07-19,2021-07-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 mlxlogscore=934 bulkscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107190111
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This series is actually only comprised of a single patch to replace the
open coded locks used during VFIO_GROUP_NOTIFY_SET_KVM notification. The
first patch is included because it is a pre-req slotted to be merged but is
not yet available in the kernel.

Tony Krowiak (2):
  s390/vfio-ap: r/w lock for PQAP interception handler function pointer
  s390/vfio-ap: replace open coded locks for VFIO_GROUP_NOTIFY_SET_KVM
    notification

 arch/s390/include/asm/kvm_host.h      |   8 +-
 arch/s390/kvm/kvm-s390.c              |  28 +++++-
 arch/s390/kvm/priv.c                  |  10 +-
 drivers/s390/crypto/vfio_ap_ops.c     | 127 +++++++++-----------------
 drivers/s390/crypto/vfio_ap_private.h |   4 +-
 5 files changed, 77 insertions(+), 100 deletions(-)

-- 
2.30.2

