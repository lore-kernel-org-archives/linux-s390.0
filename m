From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 00/11] s390/qeth: updates 2018-07-19
Date: Thu, 19 Jul 2018 12:43:47 +0200
Message-ID: <20180719104358.79696-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

please apply one more round of qeth patches to net-next.
This brings additional performance improvements for the transmit code,
and some refactoring to pave the way for using netdev_priv.
Also, two minor fixes for rare corner cases.

Thanks,
Julian


Julian Wiedmann (11):
  s390/qeth: fix race in used-buffer accounting
  s390/qeth: reset layer2 attribute on layer switch
  s390/qeth: remove redundant netif_carrier_ok() checks
  s390/qeth: allocate netdevice early
  s390/qeth: don't cache HW port number
  s390/qeth: simplify max MTU handling
  s390/qeth: use core MTU range checking
  s390/qeth: add statistics for consumed buffer elements
  s390/qeth: merge linearize-check into HW header construction
  s390/qeth: add support for constrained HW headers
  s390/qeth: speed up L2 IQD xmit

 drivers/s390/net/qeth_core.h      |  11 +-
 drivers/s390/net/qeth_core_main.c | 283 ++++++++++++++++++++++++--------------
 drivers/s390/net/qeth_core_mpc.h  |   1 +
 drivers/s390/net/qeth_core_sys.c  |  18 ++-
 drivers/s390/net/qeth_l2_main.c   | 176 +++++++-----------------
 drivers/s390/net/qeth_l3_main.c   | 112 +++++----------
 drivers/s390/net/qeth_l3_sys.c    |   6 +-
 7 files changed, 287 insertions(+), 320 deletions(-)

-- 
2.16.4
