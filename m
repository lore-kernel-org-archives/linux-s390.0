Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33986 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726359AbgIWIhN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 23 Sep 2020 04:37:13 -0400
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 0/9] s390/qeth: updates 2020-09-23
Date: Wed, 23 Sep 2020 10:36:51 +0200
Message-Id: <20200923083700.44624-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Hi Dave & Jakub,

please apply the following patch series for qeth to netdev's net-next tree.

This brings all sorts of cleanups. Highlights are more code sharing in
the init/teardown paths, and more fine-grained rollback on errors during
initialization (instead of a full-blown teardown).

Thanks,
Julian

Julian Wiedmann (9):
  s390/qeth: don't init refcount twice for mcast IPs
  s390/qeth: relax locking for ipato config data
  s390/qeth: clean up string ops in qeth_l3_parse_ipatoe()
  s390/qeth: replace deprecated simple_stroul()
  s390/qeth: tighten ucast IP locking
  s390/qeth: cancel cmds earlier during teardown
  s390/qeth: consolidate online code
  s390/qeth: consolidate teardown code
  s390/qeth: remove forward declarations in L2 code

 drivers/s390/net/qeth_core.h      |  22 +-
 drivers/s390/net/qeth_core_main.c |  71 +++--
 drivers/s390/net/qeth_core_sys.c  |  65 ++---
 drivers/s390/net/qeth_l2.h        |   7 +
 drivers/s390/net/qeth_l2_main.c   | 412 +++++++++++++-----------------
 drivers/s390/net/qeth_l3.h        |   4 +-
 drivers/s390/net/qeth_l3_main.c   |  88 ++-----
 drivers/s390/net/qeth_l3_sys.c    |  64 ++---
 8 files changed, 338 insertions(+), 395 deletions(-)

-- 
2.17.1
