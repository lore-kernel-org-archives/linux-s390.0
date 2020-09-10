Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13374 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726967AbgIJRYF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Sep 2020 13:24:05 -0400
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 0/8] s390/qeth: updates 2020-09-10
Date: Thu, 10 Sep 2020 19:23:43 +0200
Message-Id: <20200910172351.5622-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>, Alexandra Winter <wintera@linux.ibm.com>, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>

Hi Dave & Jakub,

subject to positive review by the bridge maintainers on patch 5,
please apply the following patch series to netdev's net-next tree.

Alexandra adds BR_LEARNING_SYNC support to qeth. In addition to the
main qeth changes (controlling the feature, and raising switchdev
events), this also needs
- Patch 1 and 2 for some s390/cio infrastructure improvements
  (acked by Heiko to go in via net-next), and
- Patch 5 to introduce a new switchdev_notifier_type, so that a driver
  can clear all previously learned entries from the bridge FDB in case
  things go out-of-sync later on.

Thanks,
Julian

Alexandra Winter (8):
  s390/cio: Add new Operation Code OC3 to PNSO
  s390/cio: Helper functions to read CSSID, IID, and CHID
  s390/qeth: Detect PNSO OC3 capability
  s390/qeth: Translate address events into switchdev notifiers
  bridge: Add SWITCHDEV_FDB_FLUSH_TO_BRIDGE notifier
  s390/qeth: Reset address notification in case of buffer overflow
  s390/qeth: implement ndo_bridge_getlink for learning_sync
  s390/qeth: implement ndo_bridge_setlink for learning_sync

 arch/s390/include/asm/ccwdev.h    |   9 +-
 arch/s390/include/asm/chsc.h      |   7 +
 arch/s390/include/asm/css_chars.h |   4 +-
 drivers/s390/cio/chsc.c           |  22 +-
 drivers/s390/cio/chsc.h           |   8 +-
 drivers/s390/cio/css.c            |  11 +-
 drivers/s390/cio/css.h            |   4 +-
 drivers/s390/cio/device_ops.c     |  93 ++++++-
 drivers/s390/net/qeth_core.h      |  12 +-
 drivers/s390/net/qeth_core_main.c |  40 ++-
 drivers/s390/net/qeth_l2.h        |   2 +-
 drivers/s390/net/qeth_l2_main.c   | 430 +++++++++++++++++++++++++++++-
 drivers/s390/net/qeth_l2_sys.c    |  16 +-
 include/net/switchdev.h           |   1 +
 net/bridge/br.c                   |   5 +
 15 files changed, 611 insertions(+), 53 deletions(-)

-- 
2.17.1
