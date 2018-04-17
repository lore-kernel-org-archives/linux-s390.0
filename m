From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 0/4] net/smc: fixes 2018-04-17
Date: Tue, 17 Apr 2018 17:18:11 +0200
Message-ID: <20180417151815.77191-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ursula.braun@linux.vnet.ibm.com>

Dave,

here are smc changes for the net-next tree.
The first patch assures the size of struct smc_cdc_msg is 44 bytes.
Patches 2 to 4 implement sockopts that require special handling in SMC.

Thanks, Ursula

Karsten Graul (1):
  net/smc: fix structure size

Ursula Braun (3):
  net/smc: handle sockopt TCP_NODELAY
  net/smc: handle sockopt TCP_CORK
  net/smc: handle sockopt TCP_DEFER_ACCEPT

 net/smc/af_smc.c  | 177 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 net/smc/smc.h     |  12 ++++
 net/smc/smc_cdc.c |   2 +-
 net/smc/smc_cdc.h |   2 +-
 net/smc/smc_rx.c  |   2 +-
 net/smc/smc_rx.h  |   1 +
 net/smc/smc_tx.c  |  16 ++++-
 net/smc/smc_tx.h  |   8 +++
 8 files changed, 211 insertions(+), 9 deletions(-)

-- 
2.13.5
