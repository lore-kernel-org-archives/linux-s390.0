Return-Path: <SRS0=h9J9=SO=vger.kernel.org=netdev-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 0/8] net/smc: patches 2019-04-12
Date: Fri, 12 Apr 2019 12:57:22 +0200
Message-Id: <20190412105730.96245-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, kgraul@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Dave,

here are patches for SMC:
* patch 1 improves behavior of non-blocking connect
* patches 2, 3, 5, 7, and 8 improve connecting return codes
* patches 4 and 6 are a cleanups without functional change

Thanks, Ursula

Karsten Graul (7):
  net/smc: fallback to TCP after connect problems
  net/smc: check for ip prefix and subnet
  net/smc: consolidate function parameters
  net/smc: cleanup of get vlan id
  net/smc: code cleanup smc_listen_work
  net/smc: improve smc_listen_work reason codes
  net/smc: improve smc_conn_create reason codes

Ursula Braun (1):
  net/smc: nonblocking connect rework

 net/smc/af_smc.c   | 355 +++++++++++++++++++++++++++--------------------------
 net/smc/smc.h      |  11 +-
 net/smc/smc_clc.c  |  10 +-
 net/smc/smc_clc.h  |  20 +--
 net/smc/smc_core.c |  93 +++++++-------
 net/smc/smc_core.h |  25 +++-
 net/smc/smc_pnet.c |  47 ++++---
 net/smc/smc_pnet.h |   7 +-
 8 files changed, 294 insertions(+), 274 deletions(-)

-- 
2.16.4
