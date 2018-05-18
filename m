From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 0/9] net/smc: cleanups 2018-05-18
Date: Fri, 18 May 2018 09:34:09 +0200
Message-ID: <20180518073418.91878-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ursula.braun@de.ibm.com>

Hi Dave,

here are SMC patches for net-next providing restructuring and cleanup
in different areas.

Thanks, Ursula

Hans Wippel (9):
  net/smc: add common buffer size in send and receive buffer descriptors
  net/smc: move link group list to smc_core
  net/smc: rename connection index to RMBE index
  net/smc: calculate write offset in RMB only once per connection
  net/smc: move smc_core specific code from smc.h to smc_core
  net/smc: restructure CDC message reception
  net/smc: do a few smc_core.c cleanups
  net/smc: change smc_buf_free function parameters
  net/smc: restructure client and server code in af_smc

 net/smc/af_smc.c   | 587 +++++++++++++++++++++++++++++------------------------
 net/smc/smc.h      |  46 +----
 net/smc/smc_cdc.c  |  55 +++--
 net/smc/smc_clc.c  |   4 +-
 net/smc/smc_clc.h  |   2 +-
 net/smc/smc_core.c | 115 ++++++++---
 net/smc/smc_core.h |  18 +-
 net/smc/smc_diag.c |   5 +-
 net/smc/smc_ib.c   |  13 +-
 net/smc/smc_rx.c   |  10 +-
 net/smc/smc_tx.c   |  30 +--
 net/smc/smc_tx.h   |   2 +-
 12 files changed, 481 insertions(+), 406 deletions(-)

-- 
2.16.3
