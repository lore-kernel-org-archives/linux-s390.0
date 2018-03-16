Return-Path: <netdev-owner@vger.kernel.org>
From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 0/3] net/smc: IPv6 support
Date: Fri, 16 Mar 2018 15:06:38 +0100
Message-Id: <20180316140641.7059-1-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Dave,

these smc patches for the net-next tree add IPv6 support.

Thanks, Ursula

Karsten Graul (3):
  net/smc: restructure netinfo for CLC proposal msgs
  net/smc: add ipv6 support to CLC layer
  net/smc: enable ipv6 support for smc

 net/smc/af_smc.c  |  78 +++++++++++++--------
 net/smc/smc.h     |   4 +-
 net/smc/smc_clc.c | 203 +++++++++++++++++++++++++++++++++++++++++++++---------
 net/smc/smc_clc.h |  17 +++--
 4 files changed, 235 insertions(+), 67 deletions(-)

-- 
2.13.5
