Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4204 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727976AbgBQPZF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 Feb 2020 10:25:05 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01HFJMtL143322
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 10:25:04 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y6dh42js8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 10:25:04 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <ubraun@linux.ibm.com>;
        Mon, 17 Feb 2020 15:25:02 -0000
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 0/6] net/smc: patches 2020-02-17
Date: Mon, 17 Feb 2020 16:24:49 +0100
Message-Id: <20200217152455.15341-1-ubraun@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, kgraul@linux.ibm.com, ubraun@linux.ibm.com

Hi Dave,

here are patches for SMC making termination tasks more perfect.

Thanks, Ursula

Karsten Graul (5):
  net/smc: improve smc_lgr_cleanup()
  net/smc: use termination worker under send_lock
  net/smc: do not delete lgr from list twice
  net/smc: remove unused parameter of smc_lgr_terminate()
  net/smc: simplify normal link termination

Ursula Braun (1):
  net/smc: reduce port_event scheduling

 net/smc/smc_clc.c  |  2 +-
 net/smc/smc_core.c | 26 +++++++++++---------------
 net/smc/smc_core.h |  8 +-------
 net/smc/smc_ib.c   | 44 +++++++++++++++++++++++++++++---------------
 net/smc/smc_llc.c  |  2 +-
 net/smc/smc_tx.c   |  2 +-
 6 files changed, 44 insertions(+), 40 deletions(-)

-- 
2.17.1
