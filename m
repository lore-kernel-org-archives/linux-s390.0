Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 0/4] net/smc: patches 2018-07-25
Date: Wed, 25 Jul 2018 16:35:29 +0200
Message-Id: <20180725143533.7082-1-ubraun@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Dave,

here are 4 more patches for SMC: The first one is just a small
code cleanup in preparation for patch 2. Patch 2 switches to the
use of the vlan-gid for VLAN traffic. Patch 3 improves diagnosis
when creating SMC connections. Patch 4 improves synchronization
between local and remote link groups.

Thanks, Ursula

Karsten Graul (2):
  net/smc: provide fallback reason code
  net/smc: improve delete link processing

Ursula Braun (2):
  net/smc: fewer parameters for smc_llc_send_confirm_link()
  net/smc: use correct vlan gid of RoCE device

 include/uapi/linux/smc_diag.h |  6 +++
 net/smc/af_smc.c              | 86 ++++++++++++++++++++++---------------------
 net/smc/smc.h                 |  2 +
 net/smc/smc_clc.c             | 16 ++++----
 net/smc/smc_clc.h             | 20 ++++++----
 net/smc/smc_core.c            | 84 +++++++++++++++++++++++-------------------
 net/smc/smc_core.h            |  9 +++--
 net/smc/smc_diag.c            |  8 +++-
 net/smc/smc_ib.c              | 41 ++++++++++++++++++---
 net/smc/smc_ib.h              |  3 +-
 net/smc/smc_llc.c             | 50 +++++++++++++------------
 net/smc/smc_llc.h             |  7 ++--
 net/smc/smc_pnet.c            | 30 ++++++++++-----
 net/smc/smc_pnet.h            |  3 +-
 net/smc/smc_wr.c              |  7 +---
 15 files changed, 228 insertions(+), 144 deletions(-)

-- 
2.16.4
