From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next v2 0/4] net/smc: small features 2018/04/30
Date: Wed,  2 May 2018 16:56:43 +0200
Message-ID: <20180502145647.36147-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ursula.braun@linux.ibm.com>

Dave,

here are 4 smc patches for net-next covering small new features
in different areas:
   * link health check
   * diagnostics for IPv6 smc sockets
   * ioctl
   * improvement for vlan determination

v2 changes:
   * better title
   * patch 2 - remove compile problem for disabled CONFIG_IPV6

Thanks, Ursula

Karsten Graul (2):
  net/smc: periodic testlink support
  net/smc: ipv6 support for smc_diag.c

Ursula Braun (2):
  net/smc: handle ioctls SIOCINQ, SIOCOUTQ, and SIOCOUTQNSD
  net/smc: determine vlan_id of stacked net_device

 net/smc/af_smc.c   | 39 +++++++++++++++++++++++++++++-----
 net/smc/smc_core.c | 28 +++++++++++++++++++++---
 net/smc/smc_core.h |  4 ++++
 net/smc/smc_diag.c | 39 ++++++++++++++++++++++++++--------
 net/smc/smc_llc.c  | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 net/smc/smc_llc.h  |  3 +++
 net/smc/smc_wr.c   |  1 +
 7 files changed, 158 insertions(+), 18 deletions(-)

-- 
2.13.5
