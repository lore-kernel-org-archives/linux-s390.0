From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next v2 0/4] net/smc: fixes from 2018-05-17 - v2
Date: Thu, 19 Apr 2018 15:56:51 +0200
Message-ID: <20180419135655.3058-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ursula.braun@linux.vnet.ibm.com>

Dave,

thanks for your feedback and pointing out the kernel_setsockopt()
problem(s) in patch 2/4. Here is now version 2 of the patch series
with patches 2-4 implementing sockopts that require special
handling in SMC.

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
  net/smc: handle sockopt TCP_NODELAY
  net/smc: handle sockopt TCP_CORK
  net/smc: handle sockopt TCP_DEFER_ACCEPT

 net/smc/af_smc.c  | 193 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 net/smc/smc.h     |  12 ++++
 net/smc/smc_cdc.c |   2 +-
 net/smc/smc_cdc.h |   2 +-
 net/smc/smc_rx.c  |   2 +-
 net/smc/smc_rx.h  |   1 +
 net/smc/smc_tx.c  |  16 ++++-
 net/smc/smc_tx.h  |   8 +++
 8 files changed, 225 insertions(+), 11 deletions(-)

-- 
2.13.5
