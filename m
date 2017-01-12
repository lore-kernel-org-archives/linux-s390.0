From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 0/2] net/smc: fix typo and clc-bug
Date: Thu, 12 Jan 2017 14:57:13 +0100
Message-ID: <20170112135715.64242-1-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Dave,

I received 2 bug reports for my new AF_SMC-code. Here are the fixes for them.

Thanks,
Ursula

Ursula Braun (2):
  smc-typo-in-core-sock
  smc-macaddr-len

 net/core/sock.c   |  2 +-
 net/smc/smc_clc.c | 10 ++++------
 net/smc/smc_ib.h  |  4 +++-
 3 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.8.4
