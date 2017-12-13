From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net 0/4] s390/qeth: fixes 2017-12-13
Date: Wed, 13 Dec 2017 18:56:28 +0100
Message-ID: <20171213175632.100561-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

some more patches for 4.15, that fix multiple issues with IP Takeover
configuration in qeth.
Please queue them up for stable kernels as well (4.9 and newer).

Thanks,
Julian


Julian Wiedmann (4):
  s390/qeth: apply takeover changes when mode is toggled
  s390/qeth: don't apply takeover changes to RXIP
  s390/qeth: lock IP table while applying takeover changes
  s390/qeth: update takeover IPs after configuration change

 drivers/s390/net/qeth_core.h      |  6 ++--
 drivers/s390/net/qeth_core_main.c |  6 ++--
 drivers/s390/net/qeth_l3.h        |  2 +-
 drivers/s390/net/qeth_l3_main.c   | 36 ++++++++++++++++---
 drivers/s390/net/qeth_l3_sys.c    | 75 +++++++++++++++++++++------------------
 5 files changed, 79 insertions(+), 46 deletions(-)

-- 
2.13.5
