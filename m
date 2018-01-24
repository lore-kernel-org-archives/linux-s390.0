From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 0/6] net/smc: socket closing improvements
Date: Wed, 24 Jan 2018 10:28:11 +0100
Message-ID: <20180124092817.103089-1-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, jwi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Dave,

while the first 2 patches are just small cleanups, the remaing
patches affect socket closing.

Thanks, Ursula

Ursula Braun (6):
  net/smc: use local struct sock variables consistently
  net/smc: simplify function smc_clcsock_accept()
  net/smc: get rid of tx_pend waits in socket closing
  net/smc: make wait for work request uninterruptible
  net/smc: improve state change handling after close wait
  net/smc: continue waiting if peer signals write_shutdown

 net/smc/af_smc.c    |  40 +++++++++-----------
 net/smc/smc_cdc.c   |  11 ------
 net/smc/smc_cdc.h   |   1 -
 net/smc/smc_close.c | 103 +++++++++++++++++++++++-----------------------------
 net/smc/smc_tx.c    |   4 +-
 net/smc/smc_wr.c    |  31 +++-------------
 net/smc/smc_wr.h    |   2 -
 7 files changed, 71 insertions(+), 121 deletions(-)

-- 
2.13.5
