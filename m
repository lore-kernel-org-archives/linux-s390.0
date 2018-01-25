From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 0/6] net/smc: more socket closing improvements
Date: Thu, 25 Jan 2018 11:15:30 +0100
Message-ID: <20180125101536.15727-1-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, jwi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Dave,

these patches improve the smc behavior for abnormal socket closing.

Thanks, Ursula

Ursula Braun (6):
  net/smc: cancel tx worker in case of socket aborts
  net/smc: handle state SMC_PEERFINCLOSEWAIT correctly
  net/smc: terminate link group for ib_post_send problems
  net/smc: do not reuse a linkgroup with setup problems
  net/smc: wake up wr_reg_wait when terminating a link group
  net/smc: check for healthy link group resp. connections

 net/smc/af_smc.c    | 17 +++++++++++++++++
 net/smc/smc_cdc.c   |  9 +++++++--
 net/smc/smc_close.c | 33 +++++++++++++++++++--------------
 net/smc/smc_core.c  | 11 ++++++++---
 net/smc/smc_diag.c  |  6 ++++--
 net/smc/smc_tx.c    | 19 +++++++++++++++----
 net/smc/smc_wr.c    | 19 +++++++++++++------
 7 files changed, 83 insertions(+), 31 deletions(-)

-- 
2.13.5
