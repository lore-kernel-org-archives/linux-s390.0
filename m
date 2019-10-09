Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23632 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729814AbfJIIH6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Oct 2019 04:07:58 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9987JxX133112
        for <linux-s390@vger.kernel.org>; Wed, 9 Oct 2019 04:07:57 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vhbewrnef-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 09 Oct 2019 04:07:57 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <kgraul@linux.ibm.com>;
        Wed, 9 Oct 2019 09:07:55 +0100
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 0/5] net/smc: improve termination handling
Date: Wed,  9 Oct 2019 10:07:42 +0200
Message-Id: <20191009080747.95516-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, gor@linux.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

First set of patches to improve termination handling.

Ursula Braun (5):
  net/smc: separate SMCD and SMCR link group lists
  net/smc: separate locks for SMCD and SMCR link group lists
  net/smc: increase device refcount for added link group
  net/smc: no new connections on disappearing devices
  net/smc: improve close of terminated socket

 include/net/smc.h   |   3 ++
 net/smc/smc_close.c |  40 ++++------------
 net/smc/smc_core.c  | 113 ++++++++++++++++++++++++++++++++++----------
 net/smc/smc_ib.c    |  15 +++++-
 net/smc/smc_ib.h    |   1 +
 net/smc/smc_ism.c   |   5 ++
 net/smc/smc_pnet.c  |   5 +-
 7 files changed, 124 insertions(+), 58 deletions(-)

-- 
2.17.1
