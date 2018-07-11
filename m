From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 00/10] s390/qeth: updates 2018-07-11
Date: Wed, 11 Jul 2018 17:42:37 +0200
Message-ID: <20180711154247.5523-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

please apply this first batch of qeth patches for net-next. It brings the
usual cleanups, and some performance improvements to the transmit paths.

Thanks,
Julian


Julian Wiedmann (10):
  s390/qeth: various buffer management cleanups
  s390/qeth: remove unused buffer->aob pointer
  s390/qeth: fine-tune RX modesetting
  s390/qeth: clean up Output Queue selection
  s390/qeth: consolidate ccwgroup driver definition
  s390/qeth: clean up exported symbols
  s390/qeth: increase GSO max size for eligible L3 devices
  s390/qeth: add a L3 xmit wrapper
  s390/qeth: speed-up L3 IQD xmit
  s390/qeth: speed-up IPv4 OSA xmit

 drivers/s390/net/qeth_core.h      |  22 ++-
 drivers/s390/net/qeth_core_main.c | 131 +++++---------
 drivers/s390/net/qeth_core_mpc.h  |   2 +
 drivers/s390/net/qeth_l2.h        |   5 +
 drivers/s390/net/qeth_l2_main.c   |  20 +--
 drivers/s390/net/qeth_l3_main.c   | 360 ++++++++++++++++++++++----------------
 6 files changed, 281 insertions(+), 259 deletions(-)

-- 
2.16.4
