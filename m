Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 0/3] net/smc: fixes 2018-07-18
Date: Wed, 18 Jul 2018 15:22:48 +0200
Message-Id: <20180718132251.7222-1-ubraun@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ursula.braun@linux.ibm.com>

Dave,

here are small fixes for SMC: The first patch speeds up unidirectional
traffic, the second patch increases security, and the third patch
fixes a problem for fallback cases.

Thanks, Ursula

Karsten Graul (1):
  net/smc: reset recv timeout after clc handshake

Ursula Braun (2):
  net/smc: optimize consumer cursor updates
  net/smc: add error handling for get_user()

 net/smc/af_smc.c  |  3 ++-
 net/smc/smc_clc.c |  3 ++-
 net/smc/smc_tx.c  | 12 ++++++++++--
 3 files changed, 14 insertions(+), 4 deletions(-)

-- 
2.16.4
