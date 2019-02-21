Return-Path: <SRS0=K4f4=Q4=vger.kernel.org=netdev-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 0/6] net/smc: patches 2019-02-21
Date: Thu, 21 Feb 2019 13:00:57 +0100
Message-Id: <20190221120103.10866-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, kgraul@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Dave,

here are patches for SMC:
* patch 1 is a cleanup without functional change
* patches 2-6 enhance SMC pnetid support

Thanks, Ursula

Hans Wippel (5):
  s390/net: convert pnetids to ascii
  net/smc: rework pnet table
  net/smc: add smcd support to the pnet table
  net/smc: add pnet table namespace support
  net/smc: allow PCI IDs as ib device names in the pnet table

Ursula Braun (1):
  net/smc: cleanup for smcr_tx_sndbuf_nonempty

 arch/s390/net/pnet.c |   3 +
 include/net/smc.h    |   1 +
 net/smc/af_smc.c     |  28 +++
 net/smc/smc_ib.c     |   1 -
 net/smc/smc_ib.h     |   2 +
 net/smc/smc_netns.h  |  20 ++
 net/smc/smc_pnet.c   | 629 +++++++++++++++++++++++++++++++++------------------
 net/smc/smc_pnet.h   |  13 +-
 net/smc/smc_tx.c     |   5 +-
 9 files changed, 477 insertions(+), 225 deletions(-)
 create mode 100644 net/smc/smc_netns.h

-- 
2.16.4
