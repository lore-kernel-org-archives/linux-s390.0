Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAC8C4338F
	for <linux-s390@archiver.kernel.org>; Mon, 23 Aug 2021 21:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 034646126A
	for <linux-s390@archiver.kernel.org>; Mon, 23 Aug 2021 21:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbhHWVVu (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 23 Aug 2021 17:21:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51490 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232748AbhHWVVt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 23 Aug 2021 17:21:49 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17NL4FV3113514;
        Mon, 23 Aug 2021 17:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=QufmtMxdBZvcr+jjUj4VvuCrq5CpGGcCO+Y7g75m3D8=;
 b=idlamu0EY7va5u/m9QqgHLJ9kmBkqzHzMLcrhk5sl3OXSCVBEqJsUjxHQVFPEeqw5frx
 zGwOuZE0G15VXW/fabKxkfxn5MTlzhltLHr+L/aNpwFe7xJNG7fqihZ2A+q3kygJ+JCn
 L/3GSIxUB0D13qWeg/AYfY0rCaDHkO6p5mAgt76oPxoYUSfkZ4LMkK6+9RNT14kMjwrs
 8jpK828d9Dka6cCdNfbZTfy5oN0eHCdMEIH2XERAZbSKdI9WaLDLcMX3Dk6TkDr0PuID
 Succz9RQffd5BfYneKh8isrS8+P96REUxCaTk264CUjtW1c8+K51jW6t6hJG1YgVFjpR Dg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3am1evn87e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 17:21:05 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17NLE9Dv001823;
        Mon, 23 Aug 2021 17:21:04 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3am1evn86v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 17:21:04 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17NLCJSa006090;
        Mon, 23 Aug 2021 21:21:03 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma01dal.us.ibm.com with ESMTP id 3ajs4cnpx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 21:21:03 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17NLL1v323265550
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 21:21:01 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B938FBE062;
        Mon, 23 Aug 2021 21:21:01 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 222C6BE05D;
        Mon, 23 Aug 2021 21:20:59 +0000 (GMT)
Received: from cpe-172-100-181-211.stny.res.rr.com.com (unknown [9.160.182.229])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 23 Aug 2021 21:20:58 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com, jgg@nvidia.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
Subject: [PATCH v2 0/2] s390/vfio-ap: do not open code locks for
Date:   Mon, 23 Aug 2021 17:20:45 -0400
Message-Id: <20210823212047.1476436-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0Nt-SA7n_wA93Yh31Q2nTVBjzm0UzWzw
X-Proofpoint-ORIG-GUID: H80mRCCCc3TIdUJRTrCBUjTWqOM5pF0C
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-23_04:2021-08-23,2021-08-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108230144
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The subject line does not necessarily encompass both patches of this
two-patch series, but I left it as versions 1 and 2 used this subject
line and I didn't want to confuse those who reviewed those patches.

Change log v1->v2:
-----------------
* Both of these patches were rebased on Alex's linux-vfio-next tree taken
  from https://github.com/awilliam/linux-vfio.git.
  
* Replaced kvm_s390_module_hook structure with a function pointer to the
  interception handler for the PQAP(AQIC) instruction.

Tony Krowiak (2):
  s390/vfio-ap: r/w lock for PQAP interception handler function pointer
  s390/vfio-ap: replace open coded locks for VFIO_GROUP_NOTIFY_SET_KVM
    notification

 arch/s390/include/asm/kvm_host.h      |   8 +-
 arch/s390/kvm/kvm-s390.c              |  32 ++++++-
 arch/s390/kvm/priv.c                  |  15 +--
 drivers/s390/crypto/vfio_ap_ops.c     | 127 +++++++++-----------------
 drivers/s390/crypto/vfio_ap_private.h |   4 +-
 5 files changed, 84 insertions(+), 102 deletions(-)

-- 
2.31.1

