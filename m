From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 0/2] s390/qeth: fixes 2019-09-26
Date: Wed, 26 Sep 2018 18:07:08 +0200
Message-ID: <20180926160710.64739-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

please apply two qeth patches for -net. The first is a trivial cleanup
required for patch #2 by Jean, which fixes a potential endless loop.

Thanks,
Julian


Jean Delvare (1):
  s390: qeth: Fix potential array overrun in cmd/rc lookup

zhong jiang (1):
  s390: qeth_core_mpc: Use ARRAY_SIZE instead of reimplementing its
    function

 drivers/s390/net/qeth_core_main.c |  2 +-
 drivers/s390/net/qeth_core_mpc.c  | 33 ++++++++++++++++-----------------
 drivers/s390/net/qeth_core_mpc.h  |  4 ++--
 3 files changed, 19 insertions(+), 20 deletions(-)

-- 
2.16.4
