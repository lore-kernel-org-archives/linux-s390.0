Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56966 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729226AbfJUONl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 21 Oct 2019 10:13:41 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9LEDJ2a080994
        for <linux-s390@vger.kernel.org>; Mon, 21 Oct 2019 10:13:41 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vqx4sjtfw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 21 Oct 2019 10:13:40 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <kgraul@linux.ibm.com>;
        Mon, 21 Oct 2019 15:13:25 +0100
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 0/8] net/smc: improve termination handling (part 2)
Date: Mon, 21 Oct 2019 16:13:07 +0200
Message-Id: <20191021141315.58969-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, gor@linux.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

More patches to address abnormal termination processing of
sockets and link groups.

Ursula Braun (8):
  net/smc: cancel send and receive for terminated socket
  net/smc: terminate link group without holding lgr lock
  net/smc: improve abnormal termination locking
  net/smc: improve link group freeing
  net/smc: tell peers about abnormal link group termination
  net/smc: improve abnormal termination of link groups
  net/smc: introduce link group termination worker
  net/smc: remove close abort worker

 net/smc/af_smc.c    |   4 ++
 net/smc/smc.h       |   1 +
 net/smc/smc_cdc.c   |   4 +-
 net/smc/smc_close.c |  32 ++++++-----
 net/smc/smc_close.h |   2 +
 net/smc/smc_core.c  | 129 +++++++++++++++++++++++++++++++-------------
 net/smc/smc_core.h  |   9 ++++
 net/smc/smc_llc.c   |   2 +-
 net/smc/smc_rx.c    |  10 +++-
 net/smc/smc_tx.c    |  26 +++++----
 net/smc/smc_wr.c    |  10 ++--
 11 files changed, 157 insertions(+), 72 deletions(-)

-- 
2.17.1
