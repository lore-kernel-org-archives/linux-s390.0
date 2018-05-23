From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 0/4] patches 2018-05-23
Date: Wed, 23 May 2018 16:38:08 +0200
Message-ID: <20180523143812.25824-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Dave,

here are more smc-patches for net-next:

Patch 1 fixes an ioctl problem detected by syzbot.

Patch 2 improves smc_lgr_list locking in case of abnormal link
group termination. If you want to receive a version for the net-tree,
please let me know. It would look somewhat different, since the port
terminate code has been moved to smc_core.c on net-next.

Patch 3 enables SMC to deal with urgent data.

Patch 4 is a minor improvement to avoid out-of-sync linkgroups
between 2 peers.

Thanks, Ursula

Hans Wippel (1):
  net/smc: lock smc_lgr_list in port_terminate()

Stefan Raspl (1):
  net/smc: urgent data support

Ursula Braun (2):
  net/smc: return 0 for ioctl calls in states INIT and CLOSED
  net/smc: longer delay when freeing client link groups

 net/smc/af_smc.c   |  42 ++++++++++++++++---
 net/smc/smc.h      |  15 +++++++
 net/smc/smc_cdc.c  |  44 ++++++++++++++++++--
 net/smc/smc_cdc.h  |  13 ++++++
 net/smc/smc_core.c |  19 +++++++--
 net/smc/smc_rx.c   | 120 +++++++++++++++++++++++++++++++++++++++++++++++------
 net/smc/smc_tx.c   |  55 ++++++++++++++++--------
 net/smc/smc_tx.h   |   2 +-
 8 files changed, 267 insertions(+), 43 deletions(-)

-- 
2.16.3
