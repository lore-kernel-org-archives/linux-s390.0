Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51174 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404038AbgKXRvK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 24 Nov 2020 12:51:10 -0500
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next v5 00/14] net/smc: Add support for generic netlink API
Date: Tue, 24 Nov 2020 18:50:33 +0100
Message-Id: <20201124175047.56949-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, netdev@vger.kernel.org, linux-s390@vger.kernel.org

Please apply the following patch series for smc to netdev's net-next tree.

Previous version of this patch series was using the sock_diag netlink
infrastructure. This version is using the generic netlink API. Generic
netlink API offers a better type safety between kernel and userspace
communication.
Using the generic netlink API, smc module can provide now information
about SMC linkgroups, links and devices (both for SMC-R and SMC-D).

v2: Add missing include to uapi header smc_diag.h.

v3: Apply code style recommendations from review comments.
    Instead of using EXPORTs to allow the smc_diag module to access
    data of the smc module, introduce struct smc_diag_ops and let
    smc_diag access the required data using function pointers.

v4: Address checkpatch.pl warnings. Do not use static inline for
    functions.

v5: Use generic netlink API instead of the sock_diag netlink
    infrastructure.

Guvenc Gulce (13):
  net/smc: Use active link of the connection
  net/smc: Add connection counters for links
  net/smc: Add link counters for IB device ports
  net/smc: Add diagnostic information to smc ib-device
  net/smc: Add diagnostic information to link structure
  net/smc: Refactor smc ism v2 capability handling
  net/smc: Introduce generic netlink interface for diagnostic purposes
  net/smc: Add support for obtaining system information
  net/smc: Introduce SMCR get linkgroup command
  net/smc: Introduce SMCR get link command
  net/smc: Add SMC-D Linkgroup diagnostic support
  net/smc: Add support for obtaining SMCD device list
  net/smc: Add support for obtaining SMCR device list

Karsten Graul (1):
  net/smc: use helper smc_conn_abort() in listen processing

 include/uapi/linux/smc.h | 126 ++++++++++++
 net/smc/Makefile         |   2 +-
 net/smc/af_smc.c         |  33 ++--
 net/smc/smc_clc.c        |   5 +
 net/smc/smc_clc.h        |   1 +
 net/smc/smc_core.c       | 407 ++++++++++++++++++++++++++++++++++++++-
 net/smc/smc_core.h       |  49 +++++
 net/smc/smc_diag.c       |  23 +--
 net/smc/smc_ib.c         | 204 ++++++++++++++++++++
 net/smc/smc_ib.h         |   6 +
 net/smc/smc_ism.c        | 103 +++++++++-
 net/smc/smc_ism.h        |   6 +-
 net/smc/smc_netlink.c    | 104 ++++++++++
 net/smc/smc_netlink.h    |  32 +++
 net/smc/smc_pnet.c       |   2 +
 15 files changed, 1059 insertions(+), 44 deletions(-)
 create mode 100644 net/smc/smc_netlink.c
 create mode 100644 net/smc/smc_netlink.h

-- 
2.17.1
