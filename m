Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55916 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726740AbgCRMzY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Mar 2020 08:55:24 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02ICXGTP136469
        for <linux-s390@vger.kernel.org>; Wed, 18 Mar 2020 08:55:24 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yu861rh0v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 18 Mar 2020 08:55:23 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Wed, 18 Mar 2020 12:55:21 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 00/11] s390/qeth: updates 2020-03-18
Date: Wed, 18 Mar 2020 13:54:44 +0100
Message-Id: <20200318125455.5838-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Hi Dave,

please apply the following patch series for qeth to netdev's net-next
tree.

This consists of three parts:
1) support for __GFP_MEMALLOC,
2) several ethtool enhancements (.set_channels, SW Timestamping),
3) the usual cleanups.

Thanks,
Julian

Julian Wiedmann (11):
  s390/qeth: use memory reserves to back RX buffers
  s390/qeth: use memory reserves in TX slow path
  s390/qeth: remove prio-queueing support for z/VM NICs
  s390/qeth: allow configuration of TX queues for z/VM NICs
  s390/qeth: allow configuration of TX queues for IQD devices
  s390/qeth: balance the TX queue selection for IQD devices
  s390/qeth: add SW timestamping support for IQD devices
  s390/qeth: don't report hard-coded driver version
  s390/qeth: add phys_to_virt() translation for AOB
  s390/qeth: remove gratuitous NULL checks
  s390/qeth: use dev->reg_state

 drivers/s390/net/qeth_core.h      |   7 +-
 drivers/s390/net/qeth_core_main.c | 131 ++++++++++++++++++++++--------
 drivers/s390/net/qeth_core_sys.c  |   2 +-
 drivers/s390/net/qeth_ethtool.c   |  43 +++++++++-
 drivers/s390/net/qeth_l2_main.c   |  32 ++++----
 drivers/s390/net/qeth_l3_main.c   |  29 +++----
 6 files changed, 174 insertions(+), 70 deletions(-)

-- 
2.17.1
