Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24984 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726266AbgH0IWV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 27 Aug 2020 04:22:21 -0400
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 0/8] s390/qeth: updates 2020-08-27
Date: Thu, 27 Aug 2020 10:16:57 +0200
Message-Id: <20200827081705.21922-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Hi Dave & Jakub,

please apply the following patch series for qeth to netdev's net-next tree.

Patch 8 makes some improvements to how we handle HW address events,
avoiding some uncertainty around processing stale events after we
switched off the feature.
Except for that it's all straight-forward cleanups.

Thanks,
Julian

Julian Wiedmann (8):
  s390/qeth: clean up qeth_l3_send_setdelmc()'s declaration
  s390/qeth: use to_delayed_work()
  s390/qeth: make queue lock a proper spinlock
  s390/qeth: don't disable address events during initialization
  s390/qeth: don't let HW override the configured port role
  s390/qeth: copy less data from bridge state events
  s390/qeth: unify structs for bridge port state
  s390/qeth: strictly order bridge address events

 drivers/s390/net/qeth_core.h      | 14 ++---
 drivers/s390/net/qeth_core_main.c | 85 ++++++++-------------------
 drivers/s390/net/qeth_core_mpc.h  | 14 +----
 drivers/s390/net/qeth_l2_main.c   | 96 ++++++++++++++++++++-----------
 drivers/s390/net/qeth_l2_sys.c    |  1 +
 drivers/s390/net/qeth_l3_main.c   |  3 +-
 6 files changed, 100 insertions(+), 113 deletions(-)

-- 
2.17.1
