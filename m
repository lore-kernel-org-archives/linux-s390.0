Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39508 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728094AbgCXSZa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 24 Mar 2020 14:25:30 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02OI5nVB168017
        for <linux-s390@vger.kernel.org>; Tue, 24 Mar 2020 14:25:29 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yynky4mhc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 24 Mar 2020 14:25:24 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Tue, 24 Mar 2020 18:24:59 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 00/11] s390/qeth: updates 2020-03-24
Date: Tue, 24 Mar 2020 19:24:37 +0100
Message-Id: <20200324182448.95362-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Hi Dave,

please apply the following patch series for qeth to netdev's net-next
tree.

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

 arch/s390/include/asm/qdio.h      |  11 +-
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
 12 files changed, 299 insertions(+), 220 deletions(-)

-- 
2.17.1
