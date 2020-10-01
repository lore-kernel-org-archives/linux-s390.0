Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14276 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732213AbgJARLv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 1 Oct 2020 13:11:51 -0400
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 0/7] s390/net: updates 2020-10-01
Date: Thu,  1 Oct 2020 19:11:29 +0200
Message-Id: <20201001171136.46830-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Hi Dave & Jakub,

please apply the following patch series to netdev's net-next tree.

Patches 1-3 enable qeth to also support the .set_channels() ethtool
callback for OSA devices. This completes support for the full range
of device types.

The other patches are just the usual mix of cleanups.
(Even one for ctcm!)

Thanks,
Julian

Julian Wiedmann (6):
  s390/qeth: keep track of wanted TX queues
  s390/qeth: de-magic the QIB parm area
  s390/qeth: allow configuration of TX queues for OSA devices
  s390/qeth: constify the disciplines
  s390/qeth: use netdev_name()
  s390/qeth: static checker cleanups

Vasily Gorbik (1):
  s390/ctcm: remove orphaned function declarations

 drivers/s390/net/ctcm_fsms.h      |   1 -
 drivers/s390/net/ctcm_mpc.h       |   1 -
 drivers/s390/net/qeth_core.h      |  54 ++++++++--
 drivers/s390/net/qeth_core_main.c | 163 ++++++++++++++----------------
 drivers/s390/net/qeth_core_sys.c  |   6 +-
 drivers/s390/net/qeth_ethtool.c   |  16 ++-
 drivers/s390/net/qeth_l2_main.c   |  28 ++---
 drivers/s390/net/qeth_l3_main.c   |  85 +++++++++-------
 drivers/s390/net/qeth_l3_sys.c    |   8 +-
 9 files changed, 202 insertions(+), 160 deletions(-)

-- 
2.17.1
