From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next v3 0/4] fixes from 2018-04-17 - v3
Date: Thu, 26 Apr 2018 17:18:19 +0200
Message-ID: <20180426151823.78967-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ursula.braun@linux.ibm.com>

Dave,

in the mean time we challenged the benefit of these CLC handshake
optimizations for the sockopts TCP_NODELAY and TCP_CORK.
We decided to give up on them for now, since SMC still works
properly without.
There is now version 3 of the patch series with patches 2-4 implementing
sockopts that require special handling in SMC.

Version 3 changes
   * no deferring of setsockopts TCP_NODELAY and TCP_CORK anymore
   * allow fallback for some sockopts eliminating SMC usage
   * when setting TCP_NODELAY always enforce data transmission
     (not only together with corked data)

Version 2 changes of Patch 2/4 (and 3/4):
   * return error -EOPNOTSUPP for TCP_FASTOPEN sockopts
   * fix a kernel_setsockopt() usage bug by switching parameter
     variable from type "u8" to "int"
   * add return code validation when calling kernel_setsockopt()
   * propagate a setsockopt error on the internal CLC socket
     to the SMC socket.

Regards, Ursula

Karsten Graul (1):
  net/smc: fix structure size

Ursula Braun (3):
  net/smc: handle sockopts forcing fallback
  net/smc: handle sockopt TCP_CORK
  net/smc: handle sockopt TCP_DEFER_ACCEPT

 net/smc/af_smc.c  | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 net/smc/smc.h     |  4 +++
 net/smc/smc_cdc.c |  2 +-
 net/smc/smc_cdc.h |  2 +-
 net/smc/smc_rx.c  |  2 +-
 net/smc/smc_rx.h  |  1 +
 net/smc/smc_tx.c  | 24 ++++++++++++--
 7 files changed, 122 insertions(+), 11 deletions(-)

-- 
2.13.5
