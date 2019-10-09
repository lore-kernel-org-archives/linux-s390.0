Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62130 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725776AbfJIIFT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Oct 2019 04:05:19 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9983H6J161971
        for <linux-s390@vger.kernel.org>; Wed, 9 Oct 2019 04:05:18 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vgyqbvbx4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 09 Oct 2019 04:05:17 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <kgraul@linux.ibm.com>;
        Wed, 9 Oct 2019 09:04:58 +0100
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net 0/3] net/smc: fixes for -net
Date: Wed,  9 Oct 2019 10:04:38 +0200
Message-Id: <20191009080441.76077-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, gor@linux.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Fixes for -net, more info in commit logs.

Karsten Graul (2):
  net/smc: receive returns without data
  net/smc: receive pending data after RCV_SHUTDOWN

Ursula Braun (1):
  net/smc: fix SMCD link group creation with VLAN id

 net/smc/smc_core.c |  5 ++++-
 net/smc/smc_rx.c   | 29 +++++++++++++++++++++--------
 2 files changed, 25 insertions(+), 9 deletions(-)

-- 
2.17.1
