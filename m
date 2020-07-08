Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51238 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729909AbgGHPFY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Jul 2020 11:05:24 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net 0/5] net/smc: fixes 2020-07-08
Date: Wed,  8 Jul 2020 17:05:10 +0200
Message-Id: <20200708150515.44938-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Please apply the following patch series for smc to netdev's net tree.

The patches fix problems found during more testing of SMC
functionality, resulting in hang conditions and unneeded link
deactivations. The clc module was hardened to be prepared for
possible future SMCD versions.

Thanks,
Karsten

Karsten Graul (2):
  net/smc: separate LLC wait queues for flow and messages
  net/smc: fix work request handling

Ursula Braun (3):
  net/smc: fix sleep bug in smc_pnet_find_roce_resource()
  net/smc: switch smcd_dev_list spinlock to mutex
  net/smc: tolerate future SMCD versions

 net/smc/smc_clc.c  | 45 ++++++++++++++++-------
 net/smc/smc_clc.h  |  2 +
 net/smc/smc_core.c | 51 +++++++++++++++-----------
 net/smc/smc_core.h |  4 +-
 net/smc/smc_ib.c   | 11 +++---
 net/smc/smc_ib.h   |  3 +-
 net/smc/smc_ism.c  | 11 +++---
 net/smc/smc_ism.h  |  3 +-
 net/smc/smc_llc.c  | 91 ++++++++++++++++++++++++++++------------------
 net/smc/smc_pnet.c | 37 ++++++++++---------
 net/smc/smc_wr.c   | 10 +++--
 11 files changed, 163 insertions(+), 105 deletions(-)

-- 
2.17.1
