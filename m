Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42606 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727130AbfLRPcg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Dec 2019 10:32:36 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBIFSKkS138435
        for <linux-s390@vger.kernel.org>; Wed, 18 Dec 2019 10:32:35 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wyp9esh4c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 18 Dec 2019 10:32:35 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Wed, 18 Dec 2019 15:32:33 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 0/3] s390/qeth: fixes 2019-12-18
Date: Wed, 18 Dec 2019 16:32:25 +0100
Message-Id: <20191218153228.29908-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Hi Dave,

please apply the following patch series to your net tree.
This brings two fixes for initialization / teardown issues, and one
ENOTSUPP cleanup.

Thanks,
Julian


Julian Wiedmann (3):
  s390/qeth: handle error due to unsupported transport mode
  s390/qeth: fix promiscuous mode after reset
  s390/qeth: don't return -ENOTSUPP to userspace

 drivers/s390/net/qeth_core_main.c | 14 +++++++-------
 drivers/s390/net/qeth_core_mpc.h  |  5 +++++
 drivers/s390/net/qeth_core_sys.c  |  2 +-
 drivers/s390/net/qeth_l2_main.c   |  1 +
 drivers/s390/net/qeth_l2_sys.c    |  3 ++-
 drivers/s390/net/qeth_l3_main.c   |  1 +
 6 files changed, 17 insertions(+), 9 deletions(-)

-- 
2.17.1
