Return-Path: <netdev-owner@vger.kernel.org>
From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net 0/3] net/smc: fixes 2018-02-28
Date: Wed, 28 Feb 2018 12:44:06 +0100
Message-Id: <20180228114409.33645-1-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Dave,

here are 3 smc bug fixes for the net-tree. Karsten's first patch is
the reworked version of last week's
   "[PATCH net-next 2/5] net/smc: fix structure size"
patch, now solved without using __packed, and now targetted for net
instead of net-next.

Thanks, Ursula

Davide Caratti (1):
  net/smc: fix NULL pointer dereference on sock_create_kern() error path

Karsten Graul (2):
  net/smc: use a constant for control message length
  net/smc: use link_id of server in confirm link reply

 net/smc/af_smc.c   | 4 +++-
 net/smc/smc_cdc.c  | 2 +-
 net/smc/smc_core.c | 3 ++-
 net/smc/smc_llc.c  | 2 +-
 4 files changed, 7 insertions(+), 4 deletions(-)

-- 
2.13.5
