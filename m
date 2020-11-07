Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30444 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727084AbgKGNAR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 7 Nov 2020 08:00:17 -0500
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next v3 00/15] net/smc: extend diagnostic netlink interface
Date: Sat,  7 Nov 2020 13:59:43 +0100
Message-Id: <20201107125958.16384-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com, raspl@linux.ibm.com

Please apply the following patch series for smc to netdev's net-next tree.

This patch series refactors the current netlink API in smc_diag module
which is used for diagnostic purposes and extends the netlink API in a
backward compatible way so that the extended API can provide information
about SMC linkgroups, links and devices (both for SMC-R and SMC-D) and
can still work with the legacy netlink API.

Please note that patch 9 triggers a checkpatch warning because a comment
line was added using the style of the already existing comment block.

v2: In patch 10, add missing include to uapi header smc_diag.h.

v3: Apply code style recommendations from review comments.
    Instead of using EXPORTs to allow the smc_diag module to access
    data of the smc module, introduce struct smc_diag_ops and let
    smc_diag access the required data using function pointers.

Guvenc Gulce (14):
  net/smc: Use active link of the connection
  net/smc: Add connection counters for links
  net/smc: Add link counters for IB device ports
  net/smc: Add diagnostic information to smc ib-device
  net/smc: Add diagnostic information to link structure
  net/smc: Refactor the netlink reply processing routine
  net/smc: Add ability to work with extended SMC netlink API
  net/smc: Introduce SMCR get linkgroup command
  net/smc: Introduce SMCR get link command
  net/smc: Add SMC-D Linkgroup diagnostic support
  net/smc: Add support for obtaining SMCD device list
  net/smc: Add support for obtaining SMCR device list
  net/smc: Refactor smc ism v2 capability handling
  net/smc: Add support for obtaining system information

Karsten Graul (1):
  net/smc: use helper smc_conn_abort() in listen processing

 include/net/smc.h             |   2 +-
 include/uapi/linux/smc.h      |   8 +
 include/uapi/linux/smc_diag.h | 109 +++++
 net/smc/af_smc.c              |  29 +-
 net/smc/smc.h                 |   4 +-
 net/smc/smc_clc.c             |   5 +
 net/smc/smc_clc.h             |   1 +
 net/smc/smc_core.c            |  62 ++-
 net/smc/smc_core.h            |  55 ++-
 net/smc/smc_diag.c            | 768 ++++++++++++++++++++++++++++++----
 net/smc/smc_ib.c              |  45 ++
 net/smc/smc_ib.h              |   5 +-
 net/smc/smc_ism.c             |   8 +-
 net/smc/smc_ism.h             |   5 +-
 net/smc/smc_pnet.c            |   3 +
 15 files changed, 986 insertions(+), 123 deletions(-)

-- 
2.17.1
