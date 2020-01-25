Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46440 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726300AbgAYPxO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 25 Jan 2020 10:53:14 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00PFa7YW069634
        for <linux-s390@vger.kernel.org>; Sat, 25 Jan 2020 10:53:13 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xrjhy777v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Sat, 25 Jan 2020 10:53:13 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Sat, 25 Jan 2020 15:53:11 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 0/5] s390/qeth: updates 2020-01-25
Date: Sat, 25 Jan 2020 16:52:58 +0100
Message-Id: <20200125155303.40971-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Hi Dave,

please apply the following patch series for qeth to your net-next tree.

This brings a number of cleanups for the init/teardown code paths.

Thanks,
Julian

Julian Wiedmann (5):
  s390/qeth: shift some bridgeport code around
  s390/qeth: consolidate QDIO queue setup
  s390/qeth: consolidate online/offline code
  s390/qeth: make cmd/reply matching more flexible
  s390/qeth: remove HARDSETUP state

 drivers/s390/net/qeth_core.h      |  25 +++--
 drivers/s390/net/qeth_core_main.c | 156 ++++++++++++++++++++++++------
 drivers/s390/net/qeth_core_sys.c  |   2 -
 drivers/s390/net/qeth_l2.h        |   1 -
 drivers/s390/net/qeth_l2_main.c   | 126 ++++++------------------
 drivers/s390/net/qeth_l2_sys.c    |  34 -------
 drivers/s390/net/qeth_l3_main.c   | 109 ++-------------------
 7 files changed, 180 insertions(+), 273 deletions(-)

-- 
2.17.1
