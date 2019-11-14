Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30596 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726106AbfKNMC7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Nov 2019 07:02:59 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAEBx4x7005760
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 07:02:58 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w94y24dgc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 07:02:57 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <kgraul@linux.ibm.com>;
        Thu, 14 Nov 2019 12:02:55 -0000
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 0/8] net/smc: improve termination handling (part 3)
Date: Thu, 14 Nov 2019 13:02:39 +0100
Message-Id: <20191114120247.68889-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Part 3 of the SMC termination patches improves the link group
termination processing and introduces the ability to immediately
terminate a link group.

Ursula Braun (8):
  net/smc: fix final cleanup sequence for SMCD devices
  net/smc: immediate termination for SMCD link groups
  net/smc: abnormal termination of SMCD link groups
  net/smc: introduce bookkeeping of SMCD link groups
  net/smc: no WR buffer wait for terminating link group
  net/smc: abnormal termination without orderly flag
  net/smc: wait for tx completions before link freeing
  net/smc: immediate termination for SMCR link groups

 drivers/s390/net/ism.h |   2 -
 include/net/smc.h      |   4 +
 net/smc/smc_cdc.c      |   3 +
 net/smc/smc_clc.c      |   2 +-
 net/smc/smc_close.c    |  25 ++++--
 net/smc/smc_core.c     | 197 ++++++++++++++++++++++++++++++-----------
 net/smc/smc_core.h     |   8 +-
 net/smc/smc_ib.c       |   5 +-
 net/smc/smc_ism.c      |  22 ++++-
 net/smc/smc_llc.c      |   9 +-
 net/smc/smc_tx.c       |   2 +-
 net/smc/smc_wr.c       |  37 ++++++--
 net/smc/smc_wr.h       |  10 +++
 13 files changed, 250 insertions(+), 76 deletions(-)

-- 
2.17.1
