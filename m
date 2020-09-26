Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64468 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726849AbgIZKox (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 26 Sep 2020 06:44:53 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 00/14] net/smc: introduce SMC-Dv2 support
Date: Sat, 26 Sep 2020 12:44:18 +0200
Message-Id: <20200926104432.74293-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Please apply the following patch series for smc to netdev's net-next tree.

SMC-Dv2 support (see https://www.ibm.com/support/pages/node/6326337)
provides multi-subnet support for SMC-D, eliminating the current
same-subnet restriction. The new version detects if any of the virtual
ISM devices are on the same system and can therefore be used for an
SMC-Dv2 connection. Furthermore, SMC-Dv2 eliminates the need for
PNET IDs on s390.

Karsten Graul (1):
  net/smc: remove constant and introduce helper to check for a pnet id

Ursula Braun (13):
  net/smc: CLC header fields renaming
  net/smc: separate find device functions
  net/smc: split CLC confirm/accept data to be sent
  net/smc: prepare for more proposed ISM devices
  net/smc: introduce System Enterprise ID (SEID)
  net/smc: introduce CHID callback for ISM devices
  net/smc: introduce list of pnetids for Ethernet devices
  net/smc: determine proposed ISM devices
  net/smc: build and send V2 CLC proposal
  net/smc: determine accepted ISM devices
  net/smc: CLC accept / confirm V2
  net/smc: introduce CLC first contact extension
  net/smc: CLC decline - V2 enhancements

 drivers/s390/net/ism.h     |   7 +
 drivers/s390/net/ism_drv.c |  47 +++
 include/net/smc.h          |   4 +
 net/smc/af_smc.c           | 613 +++++++++++++++++++++++++++++--------
 net/smc/smc.h              |  12 +
 net/smc/smc_clc.c          | 337 +++++++++++++++-----
 net/smc/smc_clc.h          | 179 +++++++++--
 net/smc/smc_core.c         |  25 +-
 net/smc/smc_core.h         |  15 +-
 net/smc/smc_ism.c          |  32 +-
 net/smc/smc_ism.h          |   8 +-
 net/smc/smc_netns.h        |   1 +
 net/smc/smc_pnet.c         | 173 +++++++++--
 net/smc/smc_pnet.h         |  15 +
 14 files changed, 1206 insertions(+), 262 deletions(-)

-- 
2.17.1
