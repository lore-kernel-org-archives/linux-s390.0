From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 0/1] smc: fix potential use after free
Date: Mon, 30 Jan 2017 10:55:03 +0100
Message-ID: <20170130095504.7940-1-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ubraun@linux.vnet.ibm.com, dan.carpenter@oracle.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ursula.braun@de.ibm.com>

Hi Dave,

please add Dan's fix for the smc-code. Thanks, Dan and Dave!

Regards, Ursula Braun

Dan Carpenter (1):
  smc: Reset rx/tx buffer descriptor in case of errors

 net/smc/smc_core.c | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.8.4
