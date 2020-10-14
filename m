Return-Path: <netdev-owner@vger.kernel.org>
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net 0/3] net/smc: fixes 2020-10-14
Date: Wed, 14 Oct 2020 19:43:26 +0200
Message-Id: <20201014174329.35791-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Please apply the following patch series for smc to netdev's net tree.

The first patch fixes a possible use-after-free of delayed llc events.
Patch 2 corrects the number of DMB buffer sizes. And patch 3 ensures
a correctly formatted return code when smc_ism_register_dmb() fails to
create a new DMB.

Karsten Graul (3):
  net/smc: fix use-after-free of delayed events
  net/smc: fix valid DMBE buffer sizes
  net/smc: fix invalid return code in smcd_new_buf_create()

 net/smc/smc_core.c |  5 +++--
 net/smc/smc_llc.c  | 13 +++++--------
 2 files changed, 8 insertions(+), 10 deletions(-)

-- 
2.17.1
