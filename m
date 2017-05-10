From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net 0/4] s390/net fixes
Date: Wed, 10 May 2017 19:07:50 +0200
Message-ID: <20170510170754.53922-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hello Dave,

some qeth fixes for -net, the OSM/OSN one being the most crucial.
Please also queue these up for stable.

Thanks,
Julian

Julian Wiedmann (2):
  s390/qeth: unbreak OSM and OSN support
  s390/qeth: avoid null pointer dereference on OSN

Ursula Braun (2):
  s390/qeth: handle sysfs error during initialization
  s390/qeth: add missing hash table initializations

 drivers/s390/net/qeth_core.h      |  4 ++++
 drivers/s390/net/qeth_core_main.c | 21 ++++++++++++---------
 drivers/s390/net/qeth_core_sys.c  | 24 ++++++++++++++++--------
 drivers/s390/net/qeth_l2.h        |  2 ++
 drivers/s390/net/qeth_l2_main.c   | 26 ++++++++++++++++++++------
 drivers/s390/net/qeth_l2_sys.c    |  8 ++++++++
 drivers/s390/net/qeth_l3_main.c   |  8 +++++++-
 7 files changed, 69 insertions(+), 24 deletions(-)

-- 
2.10.2
