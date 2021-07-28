Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E42C432BE
	for <linux-s390@archiver.kernel.org>; Wed, 28 Jul 2021 19:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8949E60EFD
	for <linux-s390@archiver.kernel.org>; Wed, 28 Jul 2021 19:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbhG1TDH (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 28 Jul 2021 15:03:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59202 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231154AbhG1TDG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Jul 2021 15:03:06 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16SIf0EY028915;
        Wed, 28 Jul 2021 15:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=8IQoq9d9JRaCzftcndSZz9ID4zL4uP+cWMNHvn6nuv0=;
 b=e572/hQBhnKICMvWf+xzr4nqFQNoFyKPa+92ne7e7Yq2wQVYA2pPDFRcErgxYdrUHA+6
 De+WL+pcq4wrJk3t06QO+IFbA7Dy41TgQxpd+Mh5G6FrKvJsIcKJ2Mua2HbSKuDAEbl/
 nBsc8leG6ioX3mKKz/ZLT6gslQ1jbqCIWBc7oK4SSQadjW7YE23lqXGzsfwnp1i550eG
 jCMSnqHrY6WxaqQRDKhFfq+QAGp/Xrg9ctj1qyj+IHH2B0iqGK8YLKl0S/nAC0IqG5m0
 k8PO7Y0uot5SNVE0OIS/V6Ond7QkjpjWBPkBR2vKDb5H6q1L9KtWpFwKwsZKan+e4LpF XA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a3bwm1gq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 15:03:02 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16SIqIoi106631;
        Wed, 28 Jul 2021 15:03:01 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a3bwm1gp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 15:03:01 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16SJ2j49014691;
        Wed, 28 Jul 2021 19:02:59 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 3a235kgtuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 19:02:59 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16SJ2tl230736734
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jul 2021 19:02:55 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 86E96AE04D;
        Wed, 28 Jul 2021 19:02:55 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B0C4AE045;
        Wed, 28 Jul 2021 19:02:55 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Jul 2021 19:02:55 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 0/4] s390: add kfence support
Date:   Wed, 28 Jul 2021 21:02:50 +0200
Message-Id: <20210728190254.3921642-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: j97TaW2Of8FDCrA7PepNrglp6nV4Z9Jg
X-Proofpoint-ORIG-GUID: borSlyoue7H9mxxHLLVA9li_lNMCF4-y
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-28_09:2021-07-27,2021-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 suspectscore=0 mlxscore=0 phishscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 priorityscore=1501 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107280106
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello,

this patch series adds kfence support for s390, and was mainly
developed by Sven Schnelle. Given that he is currently busy I send
this out for him, since I'd like to get an ACK for the second patch,
which touches kfence common code.

This was already discussed here:
https://lore.kernel.org/lkml/CANpmjNPAS5kDsADb-DwvdFR9nRnX47-mFuEG2vmMPn5U3i3sGQ@mail.gmail.com/

With that ACK I'd like to carry the series via the s390 tree, so it
gets upstream during the next merge window. Hopefully that's ok.

Thanks,
Heiko

Heiko Carstens (1):
  s390/mm: implement set_memory_4k()

Sven Schnelle (3):
  kfence: add function to mask address bits
  s390: add support for KFENCE
  s390: add kfence region to pagetable dumper

 arch/s390/Kconfig                  |  1 +
 arch/s390/include/asm/kfence.h     | 42 ++++++++++++++++++++++++++++++
 arch/s390/include/asm/set_memory.h |  6 +++++
 arch/s390/mm/dump_pagetables.c     | 14 ++++++++++
 arch/s390/mm/fault.c               |  9 +++++--
 arch/s390/mm/init.c                |  3 ++-
 arch/s390/mm/pageattr.c            | 15 ++++++++---
 mm/kfence/kfence_test.c            | 13 ++++++++-
 8 files changed, 96 insertions(+), 7 deletions(-)
 create mode 100644 arch/s390/include/asm/kfence.h

-- 
2.25.1

