From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 0/7] s390/qeth: updates 2018-08-09
Date: Thu,  9 Aug 2018 14:47:57 +0200
Message-ID: <20180809124804.20056-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

one more set of patches for net-next. This is all sorts of cleanups and
more refactoring on the way to using netdev_priv. Please apply.

Thanks,
Julian


Gustavo A. R. Silva (1):
  s390/qeth: use true and false for boolean values

Julian Wiedmann (6):
  s390/qeth: extract helper for MPC protocol type
  s390/qeth: reduce hard-coded access to ccw channels
  s390/qeth: use qeth_setup_ccw() to set up all CCWs
  s390/qeth: do basic setup for data channel
  s390/qeth: clean up card initialization
  s390/qeth: don't restrict qeth_card to DMA memory

 drivers/s390/net/qeth_core.h      |   6 +-
 drivers/s390/net/qeth_core_main.c | 202 ++++++++++++++++----------------------
 drivers/s390/net/qeth_core_mpc.c  |  11 ---
 drivers/s390/net/qeth_core_mpc.h  |   4 -
 drivers/s390/net/qeth_l2_main.c   |  15 +--
 drivers/s390/net/qeth_l3_main.c   |   4 +-
 6 files changed, 98 insertions(+), 144 deletions(-)

-- 
2.16.4
