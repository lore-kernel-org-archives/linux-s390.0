Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbhAETBZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Jan 2021 14:01:25 -0500
From: Vladimir Oltean <olteanv@gmail.com>
Subject: [RFC PATCH v2 net-next 00/12] Make .ndo_get_stats64 sleepable
Date: Tue,  5 Jan 2021 20:58:50 +0200
Message-Id: <20210105185902.3922928-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pablo Neira Ayuso <pablo@netfilter.org>, Jiri Benc <jbenc@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Stephen Hemminger <stephen@networkplumber.org>, Eric Dumazet <edumazet@google.com>, George McCollister <george.mccollister@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Jay Vosburgh <j.vosburgh@gmail.com>, Veaceslav Falico <vfalico@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andriin@fb.com>, Daniel Borkmann <daniel@iogearbox.net>, Taehee Yoo <ap420073@gmail.com>, Jiri Pirko <jiri@mellanox.com>, =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>, Paolo Abeni <pabeni@redhat.com>, Christian Brauner <christian.brauner@ubuntu.com>, Florian Westphal <fw@strlen.de>, linux-s390@vger.kernel.org, intel-wired-lan@lists.osuosl.org, linux-parisc@vger.kernel.org, linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org, dev@openvswitch.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Changes in v2:
- Addressed the recursion issues in .ndo_get_stats64 from bonding and
  net_failover.
- Renamed netdev_lists_lock to netif_lists_lock
- Stopped taking netif_lists_lock from drivers as much as possible.

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

This is marked as Request For Comments for a reason.

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

Vladimir Oltean (12):
  net: mark dev_base_lock for deprecation
  net: introduce a mutex for the netns interface lists
  net: procfs: hold netif_lists_lock when retrieving device statistics
  net: sysfs: don't hold dev_base_lock while retrieving device
    statistics
  s390/appldata_net_sum: hold the netdev lists lock when retrieving
    device statistics
  parisc/led: reindent the code that gathers device statistics
  parisc/led: hold the netdev lists lock when retrieving device
    statistics
  net: make dev_get_stats return void
  net: net_failover: ensure .ndo_get_stats64 can sleep
  net: bonding: ensure .ndo_get_stats64 can sleep
  net: mark ndo_get_stats64 as being able to sleep
  net: remove obsolete comments about ndo_get_stats64 context from eth
    drivers

 Documentation/networking/netdevices.rst       |   8 +-
 Documentation/networking/statistics.rst       |   9 +-
 arch/s390/appldata/appldata_net_sum.c         |  33 ++---
 drivers/leds/trigger/ledtrig-netdev.c         |   9 +-
 drivers/net/bonding/bond_main.c               | 121 +++++++++---------
 drivers/net/ethernet/cisco/enic/enic_main.c   |   1 -
 .../net/ethernet/hisilicon/hns/hns_ethtool.c  |  51 ++++----
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |   7 +-
 drivers/net/ethernet/intel/ixgbevf/ethtool.c  |   7 +-
 drivers/net/ethernet/nvidia/forcedeth.c       |   2 -
 drivers/net/ethernet/sfc/efx_common.c         |   1 -
 drivers/net/ethernet/sfc/falcon/efx.c         |   1 -
 drivers/net/net_failover.c                    |  63 ++++++---
 drivers/parisc/led.c                          |  37 +++---
 drivers/scsi/fcoe/fcoe_transport.c            |   6 +-
 drivers/usb/gadget/function/rndis.c           |  45 +++----
 include/linux/netdevice.h                     |  13 +-
 include/net/bonding.h                         |  52 +++++++-
 include/net/net_failover.h                    |   9 +-
 include/net/net_namespace.h                   |   6 +
 net/8021q/vlanproc.c                          |  15 +--
 net/core/dev.c                                |  69 ++++++----
 net/core/net-procfs.c                         |  48 +++----
 net/core/net-sysfs.c                          |  10 +-
 net/openvswitch/vport.c                       |  25 ++--
 25 files changed, 372 insertions(+), 276 deletions(-)

-- 
2.25.1
