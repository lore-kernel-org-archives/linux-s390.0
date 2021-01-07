Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25338 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728687AbhAGRZg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 7 Jan 2021 12:25:36 -0500
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 0/3] s390/qeth: fixes 2021-01-07
Date: Thu,  7 Jan 2021 18:24:39 +0100
Message-Id: <20210107172442.1737-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Hi Dave & Jakub,

please apply the following patch series to netdev's net tree.

This brings two locking fixes for the device control path.
Also one fix for a path where our .ndo_features_check() attempts to
access a non-existent L2 header.

Thanks,
Julian

Julian Wiedmann (3):
  s390/qeth: fix deadlock during recovery
  s390/qeth: fix locking for discipline setup / removal
  s390/qeth: fix L2 header access in qeth_l3_osa_features_check()

 drivers/s390/net/qeth_core.h      |  3 ++-
 drivers/s390/net/qeth_core_main.c | 38 ++++++++++++++++++++-----------
 drivers/s390/net/qeth_l2_main.c   |  2 +-
 drivers/s390/net/qeth_l3_main.c   |  4 ++--
 4 files changed, 30 insertions(+), 17 deletions(-)

-- 
2.17.1
