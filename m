From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 00/10] net/smc: patches for net-next
Date: Mon, 10 Apr 2017 14:57:55 +0200
Message-ID: <20170410125805.13653-1-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, jwi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

here are some patches for net/smc. Most important are
improvements for socket closing.

Thanks, Ursula

Ursula Braun (10):
  net/smc: get rid of old comment
  net/smc: remove useless smc_ib_devices_list check
  net/smc: return active RoCE port only
  net/smc: guarantee reset of write_blocked for heavy workload
  net/smc: always call the POLL_IN part of sk_wake_async
  net/smc: no socket state changes in tasklet context
  net/smc: guarantee ConnClosed send after shutdown SHUT_WR
  net/smc: remove duplicate unhash
  net/smc: destruct non-accepted sockets
  net/smc: do not use IB_SEND_INLINE together with mapped data

 net/smc/af_smc.c    | 23 +++++++++++------
 net/smc/smc.h       |  1 +
 net/smc/smc_cdc.c   | 11 +++++---
 net/smc/smc_close.c | 74 +++++++++++++++++++++++++++++++++++------------------
 net/smc/smc_close.h |  2 +-
 net/smc/smc_core.c  |  2 +-
 net/smc/smc_ib.c    |  3 ---
 net/smc/smc_pnet.c  |  9 ++++---
 net/smc/smc_pnet.h  |  1 -
 net/smc/smc_rx.c    |  3 +--
 net/smc/smc_tx.c    |  6 ++++-
 net/smc/smc_wr.c    |  2 +-
 12 files changed, 87 insertions(+), 50 deletions(-)

-- 
2.10.2
