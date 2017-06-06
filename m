From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 0/9] s390/net updates
Date: Tue,  6 Jun 2017 14:33:41 +0200
Message-ID: <20170606123350.13781-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

please apply the following qeth updates for net-next.

Aside from some janitorial changes, this adds early setup for virtualized
HiperSockets devices - building upon the code that landed via -net earlier.

Thanks,
Julian

Julian Wiedmann (8):
  s390/qeth: remove support for IPA_IP_FRAGMENTATION
  s390/qeth: remove skb_is_nonlinear() check on IQD
  s390/qeth: query IPv6 IPA support on HiperSockets
  s390/qeth: log bridgeport capabilities
  s390/qeth: add missing strings for IPA return codes
  s390/qeth: consolidate pack buffer flushing
  s390/qeth: silence qeth_fix_features()
  s390/qeth: do early device setup for z/VM IQD NICs

Ursula Braun (1):
  s390/qeth: add support for early L3 device setup

 drivers/s390/net/qeth_core.h      |   2 +
 drivers/s390/net/qeth_core_main.c | 117 ++++++++++++++++++++------------------
 drivers/s390/net/qeth_core_mpc.c  |   2 +
 drivers/s390/net/qeth_core_mpc.h  |   2 +-
 drivers/s390/net/qeth_core_sys.c  |   2 +-
 drivers/s390/net/qeth_l2_main.c   |   8 +++
 drivers/s390/net/qeth_l3.h        |   1 +
 drivers/s390/net/qeth_l3_main.c   |  59 ++++++-------------
 drivers/s390/net/qeth_l3_sys.c    |  11 ++++
 9 files changed, 105 insertions(+), 99 deletions(-)

-- 
2.11.2
