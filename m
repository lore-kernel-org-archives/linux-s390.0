Return-Path: <SRS0=RTe9=QT=vger.kernel.org=netdev-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 0/7] net/smc: patches 2019-02-12
Date: Tue, 12 Feb 2019 16:29:49 +0100
Message-Id: <20190212152956.71041-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Dave,

here are patches for SMC:
* patches 1 and 3 optimize SMC-R tx logic
* patch 2 is a cleanup without functional change
* patch 4 optimizes rx logic
* patches 5 and 6 improve robustness in link group and IB event handling
* patch 7 establishes Karsten Graul as another SMC maintainer

Thanks, Ursula

Karsten Graul (6):
  net/smc: reset cursor update required flag
  net/smc: move wake up of close waiters to main send function
  net/smc: no delay when waiting for free transfer buffers
  net/smc: reduce amount of status updates to peer
  net/smc: always check for connections in smc_lgr_free_work()
  net/smc: check port_idx of ib event, update handled events

Ursula Braun (1):
  MAINTAINERS: add Karsten as SMC maintainer

 MAINTAINERS        |  1 +
 net/smc/smc_cdc.c  | 29 ++++++++++++-----------------
 net/smc/smc_core.c |  6 ++----
 net/smc/smc_ib.c   | 24 ++++++++++++++++--------
 net/smc/smc_tx.c   | 12 ++++++++----
 5 files changed, 39 insertions(+), 33 deletions(-)

-- 
2.16.4
