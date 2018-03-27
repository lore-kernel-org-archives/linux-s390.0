From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net 0/1] net/smc: fix clc problem
Date: Tue, 27 Mar 2018 10:43:49 +0200
Message-ID: <20180327084350.92847-1-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Dave,

the conversion from kernel_recvmsg() to sock_recvmsg() introduced a
problem for SMC. This patch fixes it.

Thanks, Ursula

Ursula Braun (1):
  net/smc: use announced length in sock_recvmsg()

 net/smc/smc_clc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.13.5
