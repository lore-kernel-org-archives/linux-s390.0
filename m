Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10462 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727393AbfLRQfC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Dec 2019 11:35:02 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBIGYv6I053731
        for <linux-s390@vger.kernel.org>; Wed, 18 Dec 2019 11:35:02 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wykb6tkdf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 18 Dec 2019 11:35:01 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Wed, 18 Dec 2019 16:34:55 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 0/9] s390/qeth: features 2019-12-18
Date: Wed, 18 Dec 2019 17:34:41 +0100
Message-Id: <20191218163450.36731-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Hi Dave,

please apply the following patch series to your net-next tree.
Nothing major, just the usual mix of small improvements and cleanups.

Thanks,
Julian


Julian Wiedmann (9):
  s390/qeth: only handle IRQs while device is online
  s390/qeth: wake up all waiters from qeth_irq()
  s390/qeth: overhaul L3 IP address dump code
  s390/qeth: clean up L3 sysfs code
  s390/qeth: remove open-coded inet_make_mask()
  s390/qeth: don't raise NETDEV_REBOOT event from L3 offline path
  s390/qeth: stop yielding the ip_lock during IPv4 registration
  s390/qeth: consolidate helpers for capability checking
  s390/qeth: make use of napi_schedule_irqoff()

 drivers/s390/net/qeth_core.h      |  54 ++--------
 drivers/s390/net/qeth_core_main.c | 125 ++++++++++------------
 drivers/s390/net/qeth_core_mpc.h  |  21 ++--
 drivers/s390/net/qeth_l3.h        |   6 +-
 drivers/s390/net/qeth_l3_main.c   | 106 ++++++------------
 drivers/s390/net/qeth_l3_sys.c    | 172 ++++++++++--------------------
 6 files changed, 176 insertions(+), 308 deletions(-)

-- 
2.17.1
