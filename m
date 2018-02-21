Return-Path: <netdev-owner@vger.kernel.org>
From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 0/5] net/smc: fixes 2018-02-21
Date: Wed, 21 Feb 2018 12:32:30 +0100
Message-Id: <20180221113235.46702-1-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, jwi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Dave,

here are some smc-patches for net-next. Besides cleanups, the link id
field of the LLC confirm link reply is changed to comply with RFC7609.

Thanks, Ursula

Karsten Graul (4):
  smc: fix structure size
  smc: move netinfo function to file smc_clc.c
  smc: remove unused fields from smc structures
  smc: use link_id of server in confirm link reply

Stefan Raspl (1):
  smc: cleanup smc_llc.h and smc_clc.h headers

 net/smc/af_smc.c   | 65 ++++++++----------------------------------------------
 net/smc/smc.h      |  5 +----
 net/smc/smc_cdc.c  |  2 +-
 net/smc/smc_cdc.h  |  2 +-
 net/smc/smc_clc.c  | 47 +++++++++++++++++++++++++++++++++++++--
 net/smc/smc_clc.h  |  8 ++-----
 net/smc/smc_core.c |  8 +++----
 net/smc/smc_core.h |  1 -
 net/smc/smc_llc.c  | 32 ++++++++++++++++++++++++++-
 net/smc/smc_llc.h  | 28 -----------------------
 10 files changed, 94 insertions(+), 104 deletions(-)

-- 
2.13.5
