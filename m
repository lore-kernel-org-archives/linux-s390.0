Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 0/3] net/smc: fixes 2018-08-08
Date: Wed,  8 Aug 2018 14:13:18 +0200
Message-Id: <20180808121321.516-1-ubraun@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Dave,

here are small fixes for SMC: The first patch makes sure, shutdown code
is not executed for sockets in state SMC_LISTEN. The second patch resets
send and receive buffer values for accepted sockets, since TCP buffer size
optimizations for the internal CLC socket should not be forwarded to the
outer SMC socket. The third patch solves a race between connect and ioctl
reported by syzbot.

Kind regards, Ursula

Ursula Braun (3):
  net/smc: no shutdown in state SMC_LISTEN
  net/smc: allow sysctl rmem and wmem defaults for servers
  net/smc: move sock lock in smc_ioctl()

 net/smc/af_smc.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

-- 
2.16.4
