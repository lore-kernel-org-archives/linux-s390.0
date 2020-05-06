Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30046 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728349AbgEFIJ6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 May 2020 04:09:58 -0400
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH v2 net-next 00/10] s390/qeth: updates 2020-05-06
Date: Wed,  6 May 2020 10:09:39 +0200
Message-Id: <20200506080949.3915-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Hi Dave,

please apply the following patch series for qeth to netdev's net-next
tree.
Same patches as yesterday, except that the ethtool reset has been
dropped for now.

This primarily adds infrastructure to deal with HW offloads when the
packets get forwarded over the adapter's internal switch.
Aside from that, just some minor tweaking for the TX code.

Thanks,
Julian

Julian Wiedmann (10):
  s390/qeth: keep track of LP2LP capability for csum offload
  s390/qeth: process local address events
  s390/qeth: add debugfs file for local IP addresses
  s390/qeth: extract helpers for next-hop lookup
  s390/qeth: don't use restricted offloads for local traffic
  s390/qeth: merge TX skb mapping code
  s390/qeth: indicate contiguous TX buffer elements
  s390/qeth: set TX IRQ marker on last buffer in a group
  s390/qeth: return error when starting a reset fails
  s390/qeth: clean up Kconfig help text

 drivers/s390/net/Kconfig          |   9 +-
 drivers/s390/net/qeth_core.h      |  49 +++-
 drivers/s390/net/qeth_core_main.c | 465 +++++++++++++++++++++++++-----
 drivers/s390/net/qeth_core_mpc.h  |  25 ++
 drivers/s390/net/qeth_core_sys.c  |  15 +-
 drivers/s390/net/qeth_l2_main.c   |   2 +
 drivers/s390/net/qeth_l3_main.c   |  19 +-
 7 files changed, 486 insertions(+), 98 deletions(-)

-- 
2.17.1
