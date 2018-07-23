Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 0/5] net/smc: patches 2018-07-23
Date: Mon, 23 Jul 2018 13:53:07 +0200
Message-Id: <20180723115312.54694-1-ubraun@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Dave,

here are some small patches for SMC: Just the first patch contains a
functional change. It allows to differ between the modes SMCR and SMCD
on s390 when monitoring SMC sockets. The remaining patches are cleanups
without functional changes.

Thanks, Ursula

Karsten Graul (1):
  net/smc: provide smc mode in smc_diag.c

Stefan Raspl (2):
  net/smc: eliminate cursor read and write calls
  net/smc: add function to get link group from link

Ursula Braun (2):
  net/smc: use DECLARE_BITMAP for rtokens_used_mask
  net/smc: remove local variable page in smc_rx_splice()

 include/uapi/linux/smc_diag.h |  9 ++++++++-
 net/smc/af_smc.c              |  8 ++------
 net/smc/smc_cdc.c             | 35 ++++++++++++--------------------
 net/smc/smc_cdc.h             | 43 ++++++++++++++--------------------------
 net/smc/smc_core.h            |  8 ++++++--
 net/smc/smc_diag.c            |  7 ++++++-
 net/smc/smc_ib.c              |  3 +--
 net/smc/smc_llc.c             | 30 ++++++++--------------------
 net/smc/smc_rx.c              | 19 +++++-------------
 net/smc/smc_tx.c              | 46 ++++++++++++-------------------------------
 net/smc/smc_tx.h              |  4 ++--
 net/smc/smc_wr.c              | 27 +++++--------------------
 12 files changed, 84 insertions(+), 155 deletions(-)

-- 
2.16.4
