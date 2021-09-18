Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B15C433EF
	for <linux-s390@archiver.kernel.org>; Sat, 18 Sep 2021 09:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A10960F8F
	for <linux-s390@archiver.kernel.org>; Sat, 18 Sep 2021 09:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238811AbhIRJu4 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 18 Sep 2021 05:50:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24814 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238697AbhIRJuz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 18 Sep 2021 05:50:55 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18I8T3CU004212;
        Sat, 18 Sep 2021 05:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=9dLHDMdViNARy19k1iJaKcR/1w7DgQdslbYG7qyGkG8=;
 b=M6JUja24XsezOIhZx6gVdYVd8Lt0G2khpndZxcekJGJE1GSNEe1gPd5yuMhbaL/6wtZt
 x0INluab4LBSWiw/Fx7E/g8kgeaLMx+ALglACqFAEuXw7yoVGYqAdh861KHg0AgY0x9F
 /onL+lJSm75M1UzfUHJlA8i2tHIxtQYw7K37/NMmWKjjNkKsq09NuJxxACn0uyRXqbwp
 mit2lHchx+7uTVYKOFq/zeVfkg26dngtEMcJkKw2IhNgwp5WbzNXVVo558bnSaLN4CUJ
 2P0N4HyGYcTz13sY7g3bz3OGoD36JupUUw7r3Uc6tAE1UF6ABuIdu9YtDxxxhO4qqTCz EQ== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3b5cmy8udc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Sep 2021 05:49:30 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18I9lFwf013545;
        Sat, 18 Sep 2021 09:49:28 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 3b57chsucr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Sep 2021 09:49:28 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18I9nOPD42074516
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Sep 2021 09:49:25 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD55711C054;
        Sat, 18 Sep 2021 09:49:24 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83C3111C04C;
        Sat, 18 Sep 2021 09:49:24 +0000 (GMT)
Received: from localhost (unknown [9.171.78.247])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 18 Sep 2021 09:49:24 +0000 (GMT)
Date:   Sat, 18 Sep 2021 11:49:23 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.15-rc2
Message-ID: <your-ad-here.call-01631958563-ext-0235@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: A-14OaLgjAoTpgimZbVwD0nUoYSjhk68
X-Proofpoint-ORIG-GUID: A-14OaLgjAoTpgimZbVwD0nUoYSjhk68
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-18_03,2021-09-17_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 mlxlogscore=976 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109180064
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.15-rc2.

Thank you,
Vasily

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.15-3

for you to fetch changes up to f5711f9df9242446feccf2bdb6fdc06a72ca1010:

  s390: remove WARN_DYNAMIC_STACK (2021-09-15 14:29:21 +0200)

----------------------------------------------------------------
s390 updates for 5.15-rc2

- Fix potential out-of-range access during secure boot facility detection.

- Fully validate the VMA before calling follow_pte() in pci code.

- Remove arch specific WARN_DYNAMIC_STACK config option.

- Fix zcrypto kernel doc comments.

- Update defconfigs.

----------------------------------------------------------------
Alexander Egorenkov (1):
      s390/sclp: fix Secure-IPL facility detection

David Hildenbrand (1):
      s390/pci_mmio: fully validate the VMA before calling follow_pte()

Heiko Carstens (3):
      s390: update defconfigs
      s390/ap: fix kernel doc comments
      s390: remove WARN_DYNAMIC_STACK

 arch/s390/Kconfig                 | 10 ----------
 arch/s390/Makefile                |  7 -------
 arch/s390/configs/debug_defconfig |  8 +++++---
 arch/s390/configs/defconfig       |  5 ++++-
 arch/s390/pci/pci_mmio.c          |  4 ++--
 drivers/s390/char/sclp_early.c    |  3 ++-
 drivers/s390/crypto/ap_bus.c      |  3 ++-
 drivers/s390/crypto/ap_queue.c    |  4 ++--
 8 files changed, 17 insertions(+), 27 deletions(-)
