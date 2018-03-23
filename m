Return-Path: <netdev-owner@vger.kernel.org>
From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH V2 net 0/1] net/ipv4: SMC and SYN Cookies
Date: Fri, 23 Mar 2018 11:05:44 +0100
Message-Id: <20180323100545.78607-1-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com, hwippel@linux.vnet.ibm.com, eric.dumazet@gmail.com
List-ID: <linux-s390.vger.kernel.org>

Dave,

net/smc code is based on the SMC TCP experimental option.
Please apply Hans' patch to fix an inconsistency when SYN cookies
are active.

V2 includes the changes proposed by Eric Dumazet.

Thanks, Ursula

Hans Wippel (1):
  net/ipv4: disable SMC TCP option with SYN Cookies

 net/ipv4/syncookies.c | 2 ++
 net/ipv4/tcp_input.c  | 3 +++
 net/ipv6/syncookies.c | 2 ++
 3 files changed, 7 insertions(+)

-- 
2.13.5
