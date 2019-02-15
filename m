Return-Path: <SRS0=4yje=QW=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 0/7] s390/qeth: updates 2019-02-15
Date: Fri, 15 Feb 2019 19:22:24 +0100
Message-Id: <20190215182231.90709-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

please apply a few more qeth patches to net-next. Along with some smaller
improvements, this revamps our code for the SW statistics that are exposed
through ETHTOOL_GSTATS.

Thanks,
Julian


Julian Wiedmann (7):
  s390/qeth: allow manual recovery when device is SOFTSETUP
  s390/qeth: use a static Output Queue array
  s390/qeth: reduce ethtool statistics
  s390/qeth: move ethtool code into its own file
  s390/qeth: overhaul ethtool statistics
  s390/qeth: add support for ETHTOOL_GRINGPARAM
  s390/qeth: split out OSN netdev ops

 drivers/s390/net/Makefile         |   2 +-
 drivers/s390/net/qeth_core.h      | 133 ++++------
 drivers/s390/net/qeth_core_main.c | 545 ++++++--------------------------------
 drivers/s390/net/qeth_core_mpc.h  |   1 +
 drivers/s390/net/qeth_core_sys.c  |  41 +--
 drivers/s390/net/qeth_ethtool.c   | 370 ++++++++++++++++++++++++++
 drivers/s390/net/qeth_l2_main.c   |  85 +++---
 drivers/s390/net/qeth_l3_main.c   |  54 ++--
 8 files changed, 582 insertions(+), 649 deletions(-)
 create mode 100644 drivers/s390/net/qeth_ethtool.c

-- 
2.16.4
