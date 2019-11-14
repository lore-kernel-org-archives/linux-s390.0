Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63534 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726994AbfKNKTs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Nov 2019 05:19:48 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAEAJ6EI037254
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 05:19:46 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w92b9drh7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 05:19:41 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Thu, 14 Nov 2019 10:19:31 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 00/11] s390/qeth: updates 2019-11-14
Date: Thu, 14 Nov 2019 11:19:13 +0100
Message-Id: <20191114101924.29558-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Hi Dave,

please apply the following qeth patches to net-next.
Along with the usual cleanups, this
(1) reduces collateral packet loss in the RX path when dealing with
    bad packets and/or allocation errors, and
(2) simplifies how the L3 driver deals with mcast IP addresses.

Thanks,
Julian


Julian Wiedmann (11):
  s390/qeth: gather more detailed RX dropped/error statistics
  s390/qeth: support per-frame invalidation
  s390/qeth: drop unwanted packets earlier in RX path
  s390/qeth: handle skb allocation error gracefully
  s390/qeth: clean up error path in qeth_core_probe_device()
  s390/qeth: fine-tune L3 mcast locking
  s390/qeth: remove gratuitious RX modeset
  s390/qeth: consolidate L3 mcast registration code
  s390/qeth: remove VLAN tracking for L3 devices
  s390/qeth: replace qeth_l3_get_addr_buffer()
  s390/qeth: don't check drvdata in sysfs code

 drivers/s390/net/qeth_core.h      |  10 +-
 drivers/s390/net/qeth_core_main.c |  82 +++++++----
 drivers/s390/net/qeth_core_mpc.h  |   1 +
 drivers/s390/net/qeth_core_sys.c  |  80 +----------
 drivers/s390/net/qeth_ethtool.c   |   2 +
 drivers/s390/net/qeth_l2_main.c   |  26 ++--
 drivers/s390/net/qeth_l2_sys.c    |  29 ----
 drivers/s390/net/qeth_l3.h        |   1 +
 drivers/s390/net/qeth_l3_main.c   | 226 ++++++++----------------------
 drivers/s390/net/qeth_l3_sys.c    |  94 -------------
 10 files changed, 139 insertions(+), 412 deletions(-)

-- 
2.17.1
