Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49466 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729368AbgGPPjQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 16 Jul 2020 11:39:16 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net 00/10] net/smc: fixes 2020-07-16
Date: Thu, 16 Jul 2020 17:37:36 +0200
Message-Id: <20200716153746.77303-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Please apply the following patch series for smc to netdev's net tree.

The patches address problems caused by late or unexpected link layer
control packets, dma sync calls for unmapped memory, freed buffers
that are not removed from the buffer list and a possible null pointer
access that results in a crash.

Thanks,
Karsten

Karsten Graul (10):
  net/smc: handle unexpected response types for confirm link
  net/smc: clear link during SMC client link down processing
  net/smc: fix link lookup for new rdma connections
  net/smc: protect smc ib device initialization
  net/smc: drop out-of-flow llc response messages
  net/smc: move add link processing for new device into llc layer
  net/smc: fix handling of delete link requests
  net/smc: do not call dma sync for unmapped memory
  net/smc: remove freed buffer from list
  net/smc: fix restoring of fallback changes

 net/smc/af_smc.c   |  12 +++--
 net/smc/smc_core.c | 105 ++++++++-----------------------------
 net/smc/smc_core.h |   5 ++
 net/smc/smc_ib.c   |  16 ++++--
 net/smc/smc_ib.h   |   1 +
 net/smc/smc_llc.c  | 127 ++++++++++++++++++++++++++++++---------------
 net/smc/smc_llc.h  |   2 +-
 7 files changed, 135 insertions(+), 133 deletions(-)

-- 
2.17.1
