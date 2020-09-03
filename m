Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47600 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727065AbgICTxi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 3 Sep 2020 15:53:38 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net 0/4] net/smc: fixes 2020-09-03
Date: Thu,  3 Sep 2020 21:53:14 +0200
Message-Id: <20200903195318.39288-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Please apply the following patch series for smc to netdev's net tree.

Patch 1 fixes the toleration of older SMC implementations. Patch 2
takes care of a problem that happens when SMCR is used after SMCD
initialization failed. Patch 3 fixes a problem with freed send buffers,
and patch 4 corrects refcounting when SMC terminates due to device
removal.

Thanks,
Karsten

Karsten Graul (1):
  net/smc: fix toleration of fake add_link messages

Ursula Braun (3):
  net/smc: set rx_off for SMCR explicitly
  net/smc: reset sndbuf_desc if freed
  net/smc: fix sock refcounting in case of termination

 net/smc/smc_close.c | 15 ++++++++-------
 net/smc/smc_core.c  |  3 +++
 net/smc/smc_llc.c   | 15 ++++++++++++++-
 3 files changed, 25 insertions(+), 8 deletions(-)

-- 
2.17.1
