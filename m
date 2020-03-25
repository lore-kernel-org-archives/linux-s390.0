Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33662 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726239AbgCYJfO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 25 Mar 2020 05:35:14 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02P9XX0x130844
        for <linux-s390@vger.kernel.org>; Wed, 25 Mar 2020 05:35:14 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ywet4p94e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 25 Mar 2020 05:35:13 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Wed, 25 Mar 2020 09:35:10 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH v2 net-next 00/11] s390/qeth: updates 2020-03-25
Date: Wed, 25 Mar 2020 10:34:56 +0100
Message-Id: <20200325093507.20831-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Hi Dave,

please apply the following patch series for qeth to netdev's net-next
tree.
Same series as yesterday, with one minor update to patch 1 as per
your review.

This adds
1) NAPI poll support for the async-Completion Queue (with one qdio layer
   patch acked by Heiko),
2) ethtool support for per-queue TX IRQ coalescing,
3) various cleanups.

Thanks,
Julian

Julian Wiedmann (11):
  s390/qeth: simplify RX buffer tracking
  s390/qeth: split out RX poll code
  s390/qeth: remove redundant if-clause in RX poll code
  s390/qdio: extend polling support to multiple queues
  s390/qeth: simplify L3 dev_id logic
  s390/qeth: clean up the mac_bits
  s390/qeth: collect more TX statistics
  s390/qeth: add TX IRQ coalescing support for IQD devices
  s390/qeth: fine-tune MAC Address-related errnos
  s390/qeth: keep track of fixed prio-queue configuration
  s390/qeth: modernize two list helpers

 arch/s390/include/asm/qdio.h      |   9 +-
 drivers/s390/cio/qdio.h           |  11 +-
 drivers/s390/cio/qdio_debug.c     |   4 +-
 drivers/s390/cio/qdio_main.c      |  50 +++----
 drivers/s390/cio/qdio_setup.c     |  16 +--
 drivers/s390/cio/qdio_thinint.c   |  38 +++--
 drivers/s390/net/qeth_core.h      |  28 ++--
 drivers/s390/net/qeth_core_main.c | 224 ++++++++++++++++--------------
 drivers/s390/net/qeth_core_sys.c  |   8 +-
 drivers/s390/net/qeth_ethtool.c   |  76 ++++++++++
 drivers/s390/net/qeth_l2_main.c   |  23 +--
 drivers/s390/net/qeth_l3_main.c   |  30 ++--
 12 files changed, 297 insertions(+), 220 deletions(-)

-- 
2.17.1
