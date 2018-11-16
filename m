From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net V3 0/5] net/smc: fixes 2018-11-12
Date: Fri, 16 Nov 2018 13:36:12 +0100
Message-ID: <20181116123617.72948-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Dave,

here is V3 of some net/smc fixes in different areas for the net tree.

v1->v2:
   do not define 8-byte alignment for union smcd_cdc_cursor in
   patch 4/5 "net/smc: atomic SMCD cursor handling"
v2->v3:
   stay with 8-byte alignment for union smcd_cdc_cursor in
   patch 4/5 "net/smc: atomic SMCD cursor handling", but get rid of
   __packed for struct smcd_cdc_msg

Thanks, Ursula

Hans Wippel (2):
  net/smc: abort CLC connection in smc_release
  net/smc: add SMC-D shutdown signal

Karsten Graul (1):
  net/smc: use queue pair number when matching link group

Ursula Braun (2):
  net/smc: atomic SMCD cursor handling
  net/smc: use after free fix in smc_wr_tx_put_slot()

 net/smc/af_smc.c   | 11 +++++++----
 net/smc/smc_cdc.c  | 24 ++++++++++++----------
 net/smc/smc_cdc.h  | 58 +++++++++++++++++++++++++++++++++++++++++-------------
 net/smc/smc_core.c | 20 +++++++++++++------
 net/smc/smc_core.h |  5 +++--
 net/smc/smc_ism.c  | 43 +++++++++++++++++++++++++++++-----------
 net/smc/smc_ism.h  |  1 +
 net/smc/smc_wr.c   |  4 +++-
 8 files changed, 118 insertions(+), 48 deletions(-)

-- 
2.16.4
