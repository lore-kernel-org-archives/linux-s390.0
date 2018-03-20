Return-Path: <netdev-owner@vger.kernel.org>
From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 0/1] net/ipv4: SMC and SYN Cookies
Date: Tue, 20 Mar 2018 16:53:39 +0100
Message-Id: <20180320155340.18017-1-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Dave,

net/smc code is based on the SMC TCP experimental option.
Please apply Hans' patch to fix an inconsistency when SYN cookies
are active.

Thanks, Ursula

Hans Wippel (1):
  net/ipv4: disable SMC TCP option with SYN Cookies

 net/ipv4/tcp_output.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.13.5
