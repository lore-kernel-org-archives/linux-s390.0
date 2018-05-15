From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 00/10] net/smc: enhancements 2018/05/15
Date: Tue, 15 May 2018 17:04:53 +0200
Message-ID: <20180515150503.47265-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ursula.braun@de.ibm.com>

Dave,

here are smc patches for net-next. The first one is a fix for net-next
commit 01d2f7e2cdd3 "net/smc: sockopts TCP_NODELAY and TCP_CORK".
Patch 7 improves Connection Layer Control error handling, patch 10
improves abnormal termination of link groups. The remaining patches
from Karsten improve Link Layer Control code.

Thanks, Ursula

Karsten Graul (9):
  net/smc: register new rmbs with the peer
  net/smc: remove unnecessary cast
  net/smc: simplify test_link function usage
  net/smc: move link llc initialization to llc layer
  net/smc: use a workqueue to defer llc send
  net/smc: handle all error codes from smc_conn_create()
  net/smc: set link inactive before calling smc_lgr_free()
  net/smc: drop messages when link state is inactive
  net/smc: check for pending termination

Ursula Braun (1):
  net/smc: no tx work trigger for fallback sockets

 net/smc/af_smc.c   |  27 +++++---
 net/smc/smc_clc.c  |   2 +-
 net/smc/smc_core.c |  23 ++++---
 net/smc/smc_core.h |   6 +-
 net/smc/smc_llc.c  | 196 +++++++++++++++++++++++++++++++++++++++++------------
 net/smc/smc_llc.h  |   7 +-
 6 files changed, 196 insertions(+), 65 deletions(-)

-- 
2.16.3
