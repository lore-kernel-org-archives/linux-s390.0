From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net 0/2] net/smc: fixes for smc buffer handling
Date: Tue, 21 Nov 2017 13:23:52 +0100
Message-ID: <20171121122354.44006-1-ubraun@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, jwi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, geert@linux-m68k.org, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Dave,

here are 2 cleanup patches for smc buffer handling.

Thanks, Ursula

Geert Uytterhoeven (1):
  net/smc: Fix preinitialization of buf_desc in __smc_buf_create()

Ursula Braun (1):
  net/smc: use sk_rcvbuf as start for rmb creation

 net/smc/smc_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.13.5
