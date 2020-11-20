Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7508 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727058AbgKTJJu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 20 Nov 2020 04:09:50 -0500
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 0/4] s390/qeth: fixes 2020-11-20
Date: Fri, 20 Nov 2020 10:09:35 +0100
Message-Id: <20201120090939.101406-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Hi Jakub,

please apply the following patch series to netdev's net tree.

This brings several fixes for qeth's af_iucv-specific code paths.

Also one fix by Alexandra for the recently added BR_LEARNING_SYNC
support. We want to trust the feature indication bit, so that HW can
mask it out if there's any issues on their end.

Thanks,
Julian

Alexandra Winter (1):
  s390/qeth: Remove pnso workaround

Julian Wiedmann (3):
  s390/qeth: make af_iucv TX notification call more robust
  s390/qeth: fix af_iucv notification race
  s390/qeth: fix tear down of async TX buffers

 drivers/s390/net/qeth_core.h      |  9 ++--
 drivers/s390/net/qeth_core_main.c | 82 ++++++++++++++++++++-----------
 drivers/s390/net/qeth_l2_main.c   | 18 +------
 3 files changed, 62 insertions(+), 47 deletions(-)

-- 
2.17.1
