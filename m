Return-Path: <netdev-owner@vger.kernel.org>
From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 0/3] net/smc: fixes 2018-03-14
Date: Wed, 14 Mar 2018 11:00:59 +0100
Message-Id: <20180314100102.40474-1-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

here are smc changes for the net-next tree.
The first patch enables SMC to work with mlx5-RoCE-devices.
Patches 2 and 3 deal with link group freeing.

Thanks, Ursula

Karsten Graul (1):
  net/smc: schedule free_work when link group is terminated

Ursula Braun (2):
  net/smc: pay attention to MAX_ORDER for CQ entries
  net/smc: free link group without pending free_work only

 net/smc/af_smc.c   |  1 +
 net/smc/smc_core.c | 23 +++++++++++++++--------
 net/smc/smc_ib.c   | 10 +++++++++-
 net/smc/smc_wr.h   |  1 -
 4 files changed, 25 insertions(+), 10 deletions(-)

-- 
2.13.5
