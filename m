From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net 0/7] 390: qeth patches
Date: Thu, 15 Sep 2016 14:39:20 +0200
Message-ID: <20160915123927.86579-1-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

here are several fixes for the s390 qeth driver, built for net.

Thanks,
Ursula

Hans Wippel (1):
  qeth: restore device features after recovery

Thomas Richter (1):
  s390/qeth: fix setting VIPA address

Ursula Braun (5):
  s390/qeth: use ip_lock for hsuid configuration
  s390/qeth: allow hsuid configuration in DOWN state
  qeth: check not more than 16 SBALEs on the completion queue
  qeth: do not limit number of gso segments
  qeth: do not turn on SG per default

 drivers/s390/net/qeth_core.h      |  1 +
 drivers/s390/net/qeth_core_main.c | 32 +++++++++++++++++++++++++++++++-
 drivers/s390/net/qeth_l2_main.c   |  6 +++---
 drivers/s390/net/qeth_l3_main.c   | 29 ++++++++++++++++++++---------
 drivers/s390/net/qeth_l3_sys.c    |  5 +++++
 5 files changed, 60 insertions(+), 13 deletions(-)

-- 
2.8.4
