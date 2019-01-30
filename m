Return-Path: <SRS0=auZG=QG=vger.kernel.org=netdev-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 0/9] net/smc: fixes 2019-01-30
Date: Wed, 30 Jan 2019 18:50:59 +0100
Message-Id: <20190130175108.103221-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Dave,

here are some fixes in different areas of the smc code for the net
tree.

Thanks, Ursula

Hans Wippel (1):
  net/smc: allow 16 byte pnetids in netlink policy

Karsten Graul (7):
  net/smc: prevent races between smc_lgr_terminate() and smc_conn_free()
  net/smc: don't wait for send buffer space when data was already sent
  net/smc: recvmsg and splice_read should return 0 after shutdown
  net/smc: do not wait under send_lock
  net/smc: call smc_cdc_msg_send() under send_lock
  net/smc: use device link provided in qp_context
  net/smc: fix use of variable in cleared area

Ursula Braun (1):
  net/smc: fix another sizeof to int comparison

 net/smc/af_smc.c   | 11 ++++++++++-
 net/smc/smc_cdc.c  |  5 ++++-
 net/smc/smc_clc.c  |  2 +-
 net/smc/smc_core.c |  4 ++++
 net/smc/smc_ib.c   |  6 +++---
 net/smc/smc_pnet.c |  2 +-
 net/smc/smc_tx.c   | 17 +++++++----------
 net/smc/smc_wr.c   |  8 ++++----
 8 files changed, 34 insertions(+), 21 deletions(-)

-- 
2.16.4
