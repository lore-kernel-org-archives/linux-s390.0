From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net 0/3] s390/qeth: fixes 2017-12-01
Date: Fri,  1 Dec 2017 10:14:48 +0100
Message-ID: <20171201091451.52270-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

please apply the following three fixes for 4.15. These should also go
back to stable.

Thanks,
Julian


Julian Wiedmann (3):
  s390/qeth: fix thinko in IPv4 multicast address tracking
  s390/qeth: fix GSO throughput regression
  s390/qeth: build max size GSO skbs on L2 devices

 drivers/s390/net/qeth_core.h      |  3 +++
 drivers/s390/net/qeth_core_main.c | 31 +++++++++++++++++++++++++++++++
 drivers/s390/net/qeth_l2_main.c   |  4 ++--
 drivers/s390/net/qeth_l3_main.c   |  7 +++++--
 4 files changed, 41 insertions(+), 4 deletions(-)

-- 
2.13.5
