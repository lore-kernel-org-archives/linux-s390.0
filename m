From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 0/6] smc: fixes 2017-12-07
Date: Thu,  7 Dec 2017 13:38:43 +0100
Message-ID: <20171207123849.52910-1-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, jwi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Dave,

here are some smc-patches. The initial 4 patches are cleanups.
Patch 5 gets rid of ib_post_sends in tasklet context to avoid peer drops due
to out-of-order receivals.
Patch 6 makes sure, the Linux SMC code understands variable sized CLC proposal
messages built according to RFC7609.

Thanks, Ursula

Ursula Braun (6):
  smc: make smc_close_active_abort() static
  smc: improve smc_clc_send_decline() error handling
  smc: no update for unused sk_write_pending
  smc: cleanup close checking during data receival
  smc: no consumer update in tasklet context
  smc: support variable CLC proposal messages

 net/smc/af_smc.c    | 24 ++++++++-------
 net/smc/smc_cdc.c   | 12 ++------
 net/smc/smc_clc.c   | 84 ++++++++++++++++++++++++++++++++++++++++++++---------
 net/smc/smc_clc.h   | 34 ++++++++++++++++++----
 net/smc/smc_close.c |  2 +-
 net/smc/smc_close.h |  1 -
 net/smc/smc_rx.c    |  5 +---
 net/smc/smc_tx.c    | 11 ++-----
 8 files changed, 118 insertions(+), 55 deletions(-)

-- 
2.13.5
