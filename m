From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 0/6] s390/qeth: fixes 2018-04-19
Date: Thu, 19 Apr 2018 12:52:05 +0200
Message-ID: <20180419105211.83935-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

new mail address, same old me.

Please apply the following qeth fixes for 4.17. The common theme
seems to be error handling improvements in various areas of cmd IO.

Patches 1-3 should also go back to stable.

Thank you,
Julian


Julian Wiedmann (6):
  s390/qeth: fix error handling in adapter command callbacks
  s390/qeth: avoid control IO completion stalls
  s390/qeth: handle failure on workqueue creation
  s390/qeth: fix MAC address update sequence
  s390/qeth: fix request-side race during cmd IO timeout
  s390/qeth: use Read device to query hypervisor for MAC

 drivers/s390/net/qeth_core.h      |   2 -
 drivers/s390/net/qeth_core_main.c | 158 +++++++++++++++++---------------------
 drivers/s390/net/qeth_core_mpc.h  |  12 +++
 drivers/s390/net/qeth_l2_main.c   |  59 +++++++-------
 4 files changed, 116 insertions(+), 115 deletions(-)

-- 
2.13.5
