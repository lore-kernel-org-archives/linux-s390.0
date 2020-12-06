Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-eopbgr80058.outbound.protection.outlook.com ([40.107.8.58]:53705
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727661AbgLGAAs (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sun, 6 Dec 2020 19:00:48 -0500
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [RFC PATCH net-next 00/13] Make .ndo_get_stats64 sleepable
Date: Mon,  7 Dec 2020 01:59:06 +0200
Message-Id: <20201206235919.393158-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
List-ID: <linux-s390.vger.kernel.org>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pablo Neira Ayuso <pablo@netfilter.org>, Jiri Benc <jbenc@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Stephen Hemminger <stephen@networkplumber.org>, Eric Dumazet <edumazet@google.com>, George McCollister <george.mccollister@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Leon Romanovsky <leon@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>, Veaceslav Falico <vfalico@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, Sridhar Samudrala <sridhar.samudrala@intel.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, Christian Brauner <christian.brauner@ubuntu.com>

This series converts all callers of dev_get_stats() to be in sleepable
context, so that we can do more work in the .ndo_get_stats64 method.

The situation today is that if we have hardware that needs to be
accessed through a slow bus like SPI, or through a firmware, we cannot
do that directly in .ndo_get_stats64, so we have to poll counters
periodically and return a cached (not up to date) copy in the atomic NDO
callback. This is undesirable on both ends: more work than strictly
needed is being done, and the end result is also worse (not guaranteed
to be up to date). So converting the code paths to be compatible with
sleeping seems to make more sense.

Cc: Leon Romanovsky <leon@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>
Cc: Veaceslav Falico <vfalico@gmail.com>
Cc: Andy Gospodarek <andy@greyhouse.net>
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
Cc: Christian Brauner <christian.brauner@ubuntu.com>

Vladimir Oltean (13):
  RDMA/mlx4: remove bogus dev_base_lock usage
  net: mark dev_base_lock for deprecation
  net: introduce a mutex for the netns interface lists
  s390/appldata_net_sum: hold the netdev lists lock when retrieving
    device statistics
  net: bonding: hold the netdev lists lock when retrieving device
    statistics
  net_failover: hold the netdev lists lock when retrieving device
    statistics
  parisc/led: remove trailing whitespaces
  parisc/led: reindent the code that gathers device statistics
  parisc/led: hold the netdev lists lock when retrieving device
    statistics
  net: procfs: hold the netdev lists lock when retrieving device
    statistics
  net: sysfs: don't hold dev_base_lock while retrieving device
    statistics
  net: mark ndo_get_stats64 as being able to sleep
  net: remove obsolete comments about ndo_get_stats64 context from eth
    drivers

 Documentation/networking/netdevices.rst     |   4 +-
 Documentation/networking/statistics.rst     |   9 +-
 arch/s390/appldata/appldata_net_sum.c       |   8 +-
 drivers/infiniband/hw/mlx4/main.c           |   3 -
 drivers/net/bonding/bond_main.c             |  16 +-
 drivers/net/ethernet/cisco/enic/enic_main.c |   1 -
 drivers/net/ethernet/nvidia/forcedeth.c     |   2 -
 drivers/net/ethernet/sfc/efx_common.c       |   1 -
 drivers/net/ethernet/sfc/falcon/efx.c       |   1 -
 drivers/net/net_failover.c                  |  15 +-
 drivers/parisc/led.c                        | 164 ++++++++++----------
 include/net/bonding.h                       |   1 -
 include/net/net_failover.h                  |   3 -
 include/net/net_namespace.h                 |   5 +
 net/core/dev.c                              |  63 +++++---
 net/core/net-procfs.c                       |  13 +-
 net/core/net-sysfs.c                        |   3 +-
 17 files changed, 162 insertions(+), 150 deletions(-)

-- 
2.25.1
