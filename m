Return-Path: <SRS0=wH8C=SN=vger.kernel.org=netdev-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 0/5] net/smc: fixes 2019-04-11
Date: Thu, 11 Apr 2019 11:17:29 +0200
Message-Id: <20190411091734.4263-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, kgraul@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ursula.braun@de.ibm.com>

Dave,

here are some fixes in different areas of the smc code for the net
tree.

Thanks, Ursula

Kangjie Lu (1):
  net/smc: fix a NULL pointer dereference

Karsten Graul (2):
  net/smc: wait for pending work before clcsock release_sock
  net/smc: fix return code from FLUSH command

Ursula Braun (2):
  net/smc: propagate file from SMC to TCP socket
  net/smc: move unhash before release of clcsock

 include/net/sock.h  |  6 ------
 net/smc/af_smc.c    | 58 +++++++++++++++++++++++++++++++++++------------------
 net/smc/smc_close.c | 25 +++++++++++++++++++----
 net/smc/smc_close.h |  1 +
 net/smc/smc_ism.c   |  5 +++++
 net/smc/smc_pnet.c  |  3 ++-
 6 files changed, 68 insertions(+), 30 deletions(-)

-- 
2.16.4
