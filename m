Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57258 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726794AbgIJQtV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Sep 2020 12:49:21 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 00/10] net/smc: updates 2020-09-10
Date: Thu, 10 Sep 2020 18:48:19 +0200
Message-Id: <20200910164829.65426-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Please apply the following patch series for smc to netdev's net-next tree.

This patch series is a mix of various improvements and cleanups.
The patches 1 and 10 improve the handling of large parallel workloads.
Patch 8 corrects a kernel config default for config CCWGROUP on s390.
Patch 9 allows userspace tools to retrieve socket information for more
sockets.

Guvenc Gulce (2):
  s390/net: Add SMC config as one of the defaults of CCWGROUP
  net/smc: Use the retry mechanism for netlink messages

Karsten Graul (1):
  net/smc: use separate work queues for different worker types

Ursula Braun (7):
  net/smc: reduce active tcp_listen workers
  net/smc: introduce better field names
  net/smc: dynamic allocation of CLC proposal buffer
  net/smc: common routine for CLC accept and confirm
  net/smc: improve server ISM device determination
  net/smc: reduce smc_listen_decline() calls
  net/smc: immediate freeing in smc_lgr_cleanup_early()

 drivers/s390/net/Kconfig |   2 +-
 net/smc/af_smc.c         | 216 +++++++++++++++++++---------------
 net/smc/smc.h            |   7 ++
 net/smc/smc_cdc.c        |   4 +-
 net/smc/smc_clc.c        | 243 ++++++++++++++++++---------------------
 net/smc/smc_clc.h        |  93 +++++++--------
 net/smc/smc_close.c      |   7 +-
 net/smc/smc_core.c       |  56 ++++-----
 net/smc/smc_core.h       |  11 +-
 net/smc/smc_diag.c       |  30 +++--
 net/smc/smc_llc.c        |   2 +-
 net/smc/smc_pnet.c       |   5 +-
 net/smc/smc_tx.c         |  10 +-
 13 files changed, 357 insertions(+), 329 deletions(-)

-- 
2.17.1
