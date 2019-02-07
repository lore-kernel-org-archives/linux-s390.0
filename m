Return-Path: <SRS0=t9U+=QO=vger.kernel.org=netdev-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 0/7] net/smc: patches 2019-02-07
Date: Thu,  7 Feb 2019 15:56:13 +0100
Message-Id: <20190207145620.92811-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Dave,

here are patches for SMC:
* patches 1, 3, and 6 are cleanups without functional change
* patch 2 postpones closing of internal clcsock
* patches 4 and 5 improve link group creation locking
* patch 7 restores AF_SMC as diag_family field

Thanks, Ursula

Hans Wippel (2):
  net/smc: unlock LGR pending lock earlier for SMC-D
  net/smc: use client and server LGR pending locks for SMC-R

Karsten Graul (2):
  net/smc: move code to clear the conn->lgr field
  net/smc: original socket family in inet_sock_diag

Ursula Braun (3):
  s390/net: move pnet constants
  net/smc: postpone release of clcsock
  net/smc: use smc_curs_copy() for SMC-D

 arch/s390/include/asm/pnet.h |  8 -----
 arch/s390/net/pnet.c         |  8 +++++
 net/smc/af_smc.c             | 85 ++++++++++++++++++++++++++------------------
 net/smc/smc_cdc.h            |  9 ++---
 net/smc/smc_close.c          |  7 +++-
 net/smc/smc_core.c           |  5 +--
 net/smc/smc_diag.c           |  3 +-
 7 files changed, 74 insertions(+), 51 deletions(-)

-- 
2.16.4
