Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38110 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726744AbgEDMTO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 May 2020 08:19:14 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 00/12] net/smc: add failover processing
Date: Mon,  4 May 2020 14:18:36 +0200
Message-Id: <20200504121848.46585-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

This patch series adds the actual SMC-R link failover processing and 
improved link group termination. There will be one more (very small) 
series after this which will complete the SMC-R link failover support.

Karsten Graul (12):
  net/smc: save state of last sent CDC message
  net/smc: switch connections to alternate link
  net/smc: send failover validation message
  net/smc: handle incoming CDC validation message
  net/smc: wait for departure of an IB message
  net/smc: send DELETE_LINK,ALL message and wait for send to complete
  net/smc: assign link to a new connection
  net/smc: asymmetric link tagging
  net/smc: add termination reason and handle LLC protocol violation
  net/smc: improve termination processing
  net/smc: create improved SMC-R link_uid
  net/smc: save SMC-R peer link_uid

 net/smc/af_smc.c   |   2 +
 net/smc/smc.h      |   6 +
 net/smc/smc_cdc.c  |  86 +++++++++++--
 net/smc/smc_cdc.h  |   2 +
 net/smc/smc_core.c | 303 +++++++++++++++++++++++++++++++++++++--------
 net/smc/smc_core.h |  14 ++-
 net/smc/smc_llc.c  | 111 +++++++++++++++--
 net/smc/smc_llc.h  |  12 ++
 net/smc/smc_tx.c   |  12 +-
 net/smc/smc_wr.c   |  39 ++++++
 net/smc/smc_wr.h   |   2 +
 11 files changed, 514 insertions(+), 75 deletions(-)

-- 
2.17.1
