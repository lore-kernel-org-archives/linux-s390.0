From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 00/10] pnetid and SMC-D support
Date: Thu, 28 Jun 2018 19:05:03 +0200
Message-ID: <20180628170513.5089-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, hwippel@linux.ibm.com, sebott@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Dave,

SMC requires a configured pnet table to map Ethernet interfaces to
RoCE adapter ports. For s390 there exists hardware support to group
such devices. The first three patches cover the s390 pnetid support,
enabling SMC-R usage on s390 without configuring an extra pnet table.

SMC currently requires RoCE adapters, and uses RDMA-techniques
implemented with IB-verbs. But s390 offers another method for
intra-CEC Shared Memory communication. The following seven patches
implement a solution to run SMC traffic based on intra-CEC DMA,
called SMC-D.

Thanks, Ursula

Hans Wippel (6):
  net/smc: add base infrastructure for SMC-D and ISM
  net/smc: add pnetid support for SMC-D and ISM
  net/smc: add SMC-D support in CLC messages
  net/smc: add SMC-D support in data transfer
  net/smc: add SMC-D support in af_smc
  net/smc: add SMC-D diag support

Sebastian Ott (1):
  s390/ism: add device driver for internal shared memory

Ursula Braun (3):
  net/smc: determine port attributes independent from pnet table
  net/smc: add pnetid support
  net/smc: optimize consumer cursor updates

 drivers/s390/net/Kconfig      |  10 +
 drivers/s390/net/Makefile     |   3 +
 drivers/s390/net/ism.h        | 221 +++++++++++++++
 drivers/s390/net/ism_drv.c    | 623 ++++++++++++++++++++++++++++++++++++++++++
 include/net/smc.h             |  65 +++++
 include/uapi/linux/smc_diag.h |  10 +
 net/smc/Makefile              |   2 +-
 net/smc/af_smc.c              | 228 ++++++++++++++--
 net/smc/smc.h                 |   7 +-
 net/smc/smc_cdc.c             |  86 +++++-
 net/smc/smc_cdc.h             |  43 ++-
 net/smc/smc_clc.c             | 193 +++++++++----
 net/smc/smc_clc.h             |  81 ++++--
 net/smc/smc_core.c            | 285 ++++++++++++++-----
 net/smc/smc_core.h            |  72 +++--
 net/smc/smc_diag.c            |  18 +-
 net/smc/smc_ib.c              | 134 +++++----
 net/smc/smc_ib.h              |   4 +-
 net/smc/smc_ism.c             | 314 +++++++++++++++++++++
 net/smc/smc_ism.h             |  48 ++++
 net/smc/smc_pnet.c            | 157 +++++++++--
 net/smc/smc_pnet.h            |  16 ++
 net/smc/smc_rx.c              |   2 +-
 net/smc/smc_tx.c              | 205 +++++++++++---
 net/smc/smc_tx.h              |   2 +
 25 files changed, 2505 insertions(+), 324 deletions(-)
 create mode 100644 drivers/s390/net/ism.h
 create mode 100644 drivers/s390/net/ism_drv.c
 create mode 100644 net/smc/smc_ism.c
 create mode 100644 net/smc/smc_ism.h

-- 
2.16.4
