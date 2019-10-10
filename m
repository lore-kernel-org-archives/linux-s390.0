Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5904 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733057AbfJJIQa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Oct 2019 04:16:30 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9A8DZ0F145692
        for <linux-s390@vger.kernel.org>; Thu, 10 Oct 2019 04:16:29 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vhy28bmrp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 10 Oct 2019 04:16:29 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <kgraul@linux.ibm.com>;
        Thu, 10 Oct 2019 09:16:27 +0100
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH v2 net 0/3] net/smc: fixes for -net
Date: Thu, 10 Oct 2019 10:16:08 +0200
Message-Id: <20191010081611.35446-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, gor@linux.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Fixes for -net, addressing two races in SMC receive path and
add a missing cleanup when the link group creating fails with
ISM devices and a VLAN id.

v1->v2:
- added fixes tags

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
