Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 0/5] net/smc: fixes 2018-09-18
Date: Tue, 18 Sep 2018 15:46:33 +0200
Message-Id: <20180918134638.90271-1-ubraun@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Dave,

here are some fixes in different areas of the smc code for the net
tree.

Thanks, Ursula

Karsten Graul (1):
  net/smc: no urgent data check for listen sockets

Ursula Braun (3):
  net/smc: fix non-blocking connect problem
  net/smc: remove duplicate mutex_unlock
  net/smc: enable fallback for connection abort in state INIT

YueHaibing (1):
  net/smc: fix sizeof to int comparison

 net/smc/af_smc.c    | 26 ++++++++++++++++----------
 net/smc/smc_clc.c   | 14 ++++++--------
 net/smc/smc_close.c | 14 +++++++-------
 3 files changed, 29 insertions(+), 25 deletions(-)

-- 
2.16.4
