From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 0/3] net/smc: fixes 2018/05/03
Date: Thu,  3 May 2018 17:57:36 +0200
Message-ID: <20180503155739.55616-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ursula.braun@de.ibm.com>

Dave,

here are smc fixes for 2 problems:
 * receive buffers in SMC must be registered. If registration fails
   these buffers must not be kept within the link group for reuse.
   Patch 1 is a preparational patch; patch 2 contains the fix.
 * sendpage: do not hold the sock lock when calling kernel_sendpage()
             or sock_no_sendpage()

Thanks, Ursula

Karsten Graul (2):
  net/smc: call consolidation
  net/smc: handle unregistered buffers

Stefan Raspl (1):
  smc: fix sendpage() call

 net/smc/af_smc.c   | 43 +++++++++++++++++++++----------------------
 net/smc/smc_core.c | 22 +++++++++++++++++++---
 net/smc/smc_core.h |  3 ++-
 3 files changed, 42 insertions(+), 26 deletions(-)

-- 
2.13.5
