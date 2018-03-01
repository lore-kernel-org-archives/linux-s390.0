Return-Path: <netdev-owner@vger.kernel.org>
From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 0/8] net/smc: Link Layer Control enhancements
Date: Thu,  1 Mar 2018 13:51:25 +0100
Message-Id: <20180301125133.12211-1-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Dave,

here is a series of smc patches enabling SMC communication with peers
supporting more than one link per link group.

The first three patches are preparing code cleanups.

Thanks, Ursula

Karsten Graul (7):
  net/smc: move netinfo function to file smc_clc.c
  net/smc: remove unused fields from smc structures
  net/smc: respond to test link messages
  net/smc: process confirm/delete rkey messages
  net/smc: do not allow eyecatchers in rmbe
  net/smc: process add/delete link messages
  net/smc: prevent new connections on link group

Stefan Raspl (1):
  net/smc: cleanup smc_llc.h and smc_clc.h headers

 net/smc/af_smc.c   | 127 ++++++++---------
 net/smc/smc.h      |   5 +-
 net/smc/smc_clc.c  |  47 +++++-
 net/smc/smc_clc.h  |   9 +-
 net/smc/smc_core.c |  77 +++++++---
 net/smc/smc_core.h |  16 ++-
 net/smc/smc_llc.c  | 408 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 net/smc/smc_llc.h  |  41 ++----
 8 files changed, 592 insertions(+), 138 deletions(-)

-- 
2.13.5
