From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 0/1] net/smc: shutdown fix
Date: Thu, 19 Apr 2018 15:56:39 +0200
Message-ID: <20180419135640.2907-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, stephen@networkplumber.org, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.vnet.ibm.com>

Dave,

Stephen Hemminger reported this problem recently:
   https://bugzilla.kernel.org/show_bug.cgi?id=199429

This patch fixes the problem and is a candidate for -stable.

Thanks, Ursula

Ursula Braun (1):
  net/smc: fix shutdown in state SMC_LISTEN

 net/smc/af_smc.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

-- 
2.13.5
