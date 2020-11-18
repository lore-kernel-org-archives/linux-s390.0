Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47356 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726163AbgKRVmG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Nov 2020 16:42:06 -0500
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net 0/2] net/smc: fixes 2020-11-18
Date: Wed, 18 Nov 2020 22:40:36 +0100
Message-Id: <20201118214038.24039-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com, raspl@linux.ibm.com

Please apply the following patch series for smc to netdev's net tree.

Patch 1 fixes the matching of link groups because with SMC-Dv2 the vlanid
should no longer be part of this matching. Patch 2 removes a sparse message.

Karsten Graul (2):
  net/smc: fix matching of existing link groups
  net/smc: fix direct access to ib_gid_addr->ndev in
    smc_ib_determine_gid()

 net/smc/af_smc.c   | 3 ++-
 net/smc/smc_core.c | 3 ++-
 net/smc/smc_ib.c   | 6 +++---
 3 files changed, 7 insertions(+), 5 deletions(-)

-- 
2.17.1
