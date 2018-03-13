Return-Path: <netdev-owner@vger.kernel.org>
From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH V2 net 0/1] net/smc: listen socket closing
Date: Tue, 13 Mar 2018 10:41:53 +0100
Message-Id: <20180313094154.65533-1-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

last week you asked for a better solution using generic infrastructure
to fix the closing of a listening SMC socket.
This made me realize that flush_work() is an appropriate way to make
sure the smc_tcp_listen_worker has finished processing (incl. the
release of the internal clcsock.)

Thanks, Ursula

Ursula Braun (1):
  net/smc: simplify wait when closing listen socket

 net/smc/af_smc.c    |  4 ----
 net/smc/smc_close.c | 25 +++----------------------
 2 files changed, 3 insertions(+), 26 deletions(-)

-- 
2.13.5
