From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 00/10] more s390/net updates
Date: Tue, 11 Apr 2017 16:11:09 +0200
Message-ID: <20170411141119.82526-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

here's a second batch of s390/net patches for net-next.
A mixed bunch of qeth cleanups, and a few patches to add support for
ETHTOOL_GLINKSETTINGS.

Thanks,
Julian

Julian Wiedmann (10):
  s390/qeth: move common ioctl handling to core
  s390/qeth: move NAPI poll routine to core
  s390/qeth: move gdev shutdown handler to core
  s390/qeth: remove unused parameter
  s390/qeth: use correct return type for hard_start_xmit()
  s390/qeth: use and remove some defines
  s390/qeth: clean up qeth_set_ecmd_adv_sup()
  s390/qeth: convert to ETHTOOL_GLINKSETTINGS API
  s390/qeth: use LINK_MODE_* to report the link characteristics
  s390/qeth: remove unimplemented gdev routines

 drivers/s390/net/qeth_core.h      |  21 +--
 drivers/s390/net/qeth_core_main.c | 349 ++++++++++++++++++++++++++------------
 drivers/s390/net/qeth_l2_main.c   | 153 +----------------
 drivers/s390/net/qeth_l3_main.c   | 138 +--------------
 4 files changed, 268 insertions(+), 393 deletions(-)

-- 
2.10.2
