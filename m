Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29490 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388226AbgJBPJn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 2 Oct 2020 11:09:43 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 0/2] net/smc: updates 2020-10-02
Date: Fri,  2 Oct 2020 17:09:25 +0200
Message-Id: <20201002150927.72261-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Please apply the following patch series for smc to netdev's net-next tree.

Patch 1 improves the ISM device payload of a CLC porposal message, patch 2
adds to use an array to access the system EID fields.

Karsten Graul (2):
  net/smc: send ISM devices with unique chid in CLC proposal
  net/smc: use an array to check fields in system EID

 net/smc/af_smc.c  | 18 +++++++++++++++++-
 net/smc/smc_ism.c |  2 +-
 2 files changed, 18 insertions(+), 2 deletions(-)

-- 
2.17.1
