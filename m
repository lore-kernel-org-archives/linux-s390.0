Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30458 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730344AbfKTNVe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 20 Nov 2019 08:21:34 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAKDIPiZ050214
        for <linux-s390@vger.kernel.org>; Wed, 20 Nov 2019 08:21:33 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wd3fkp9su-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 20 Nov 2019 08:21:32 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Wed, 20 Nov 2019 13:21:04 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 0/2] s390/qeth: fixes 2019-11-20
Date: Wed, 20 Nov 2019 14:20:55 +0100
Message-Id: <20191120132057.1788-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Hi Dave,

please apply two late qeth fixes to your net tree.

The first fixes a deadlock that can occur if a qeth device is set
offline while in the middle of processing deferred HW events.
The second patch converts the return value of an error path to
use -EIO, so that it can be passed back to userspace.

Thanks,
Julian


Julian Wiedmann (2):
  s390/qeth: fix potential deadlock on workqueue flush
  s390/qeth: return proper errno on IO error

 drivers/s390/net/qeth_core.h      |  1 +
 drivers/s390/net/qeth_core_main.c | 10 +++++-----
 drivers/s390/net/qeth_l2_main.c   | 21 ++++++++++++++-------
 drivers/s390/net/qeth_l2_sys.c    | 14 +++++++++++++-
 4 files changed, 33 insertions(+), 13 deletions(-)

-- 
2.17.1
