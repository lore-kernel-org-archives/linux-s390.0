Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61180 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727579AbfKPQrq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 16 Nov 2019 11:47:46 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAGGkvuc077998
        for <linux-s390@vger.kernel.org>; Sat, 16 Nov 2019 11:47:44 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wact3ucpq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Sat, 16 Nov 2019 11:47:44 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <kgraul@linux.ibm.com>;
        Sat, 16 Nov 2019 16:47:43 -0000
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 0/4] last part of termination improvements
Date: Sat, 16 Nov 2019 17:47:28 +0100
Message-Id: <20191116164732.47059-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Patches 1 and 2 finish the set of termination patches, introducing 
a reboot handler that terminates all link groups. Patch 3 adds an 
rcu_barrier before the module is unloaded, and patch 4 is cleanup.

Ursula Braun (4):
  net/smc: introduce bookkeeping of SMCR link groups
  net/smc: guarantee removal of link groups in reboot
  net/smc: use rcu_barrier() on module unload
  net/smc: remove unused constant

 net/smc/af_smc.c    | 20 +++++++++++++++-----
 net/smc/smc_close.c |  2 --
 net/smc/smc_core.c  | 39 +++++++++++++++++++++++++++++++++++++++
 net/smc/smc_core.h  |  1 +
 net/smc/smc_ib.c    |  4 +++-
 net/smc/smc_ib.h    |  3 +++
 6 files changed, 61 insertions(+), 8 deletions(-)

-- 
2.17.1
