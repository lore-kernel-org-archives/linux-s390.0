From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 0/4] net/smc: splice implementation
Date: Thu,  3 May 2018 18:12:35 +0200
Message-ID: <20180503161239.71747-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ursula.braun@de.ibm.com>

Dave,

Stefan comes up with an smc implementation for splice(). The first
three patches are preparational patches, the 4th patch implements
splice().

Thanks, Ursula

Stefan Raspl (4):
  smc: simplify abort logic
  smc: make smc_rx_wait_data() generic
  smc: allocate RMBs as compound pages
  smc: add support for splice()

 net/smc/af_smc.c   |  40 +++++++++--
 net/smc/smc.h      |   3 +
 net/smc/smc_core.c |  18 ++---
 net/smc/smc_core.h |   1 +
 net/smc/smc_rx.c   | 200 +++++++++++++++++++++++++++++++++++++++++++----------
 net/smc/smc_rx.h   |  12 +++-
 6 files changed, 219 insertions(+), 55 deletions(-)

-- 
2.13.5
