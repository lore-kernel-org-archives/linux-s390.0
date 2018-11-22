From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 00/10] net/smc: patches 2018-11-22
Date: Thu, 22 Nov 2018 10:26:33 +0100
Message-ID: <20181122092643.26820-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Dave,

here are more patches for SMC:
* patches 1-3 and 7 are cleanups without functional change
* patches 4-6 and 8 are optimizations of existing code
* patches 9 and 10 introduce and exploit LLC message DELETE RKEY

Thanks, Ursula

Karsten Graul (3):
  net/smc: avoid a delay by waiting for nothing
  net/smc: add infrastructure to send delete rkey messages
  net/smc: unregister rkeys of unused buffer

Ursula Braun (7):
  net/smc: cleanup tcp_listen_worker initialization
  net/smc: make smc_lgr_free() static
  net/smc: remove sock_error detour in clc-functions
  net/smc: allow fallback after clc timeouts
  net/smc: no link delete for a never active link
  net/smc: short wait for late smc_clc_wait_msg
  net/smc: cleanup listen worker mutex unlocking

 net/smc/af_smc.c   | 51 ++++++++++++++++++++++++------------------------
 net/smc/smc_clc.c  | 33 ++++++++++++++-----------------
 net/smc/smc_clc.h  |  3 ++-
 net/smc/smc_core.c | 16 ++++++++++++---
 net/smc/smc_core.h |  6 ++++--
 net/smc/smc_llc.c  | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 net/smc/smc_llc.h  |  2 ++
 7 files changed, 117 insertions(+), 51 deletions(-)

-- 
2.16.4
