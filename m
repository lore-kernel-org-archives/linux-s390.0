Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2846 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728841AbgBNH7O (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 14 Feb 2020 02:59:14 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01E7rYdm071443
        for <linux-s390@vger.kernel.org>; Fri, 14 Feb 2020 02:59:14 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y4j87e6qb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 14 Feb 2020 02:59:13 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <kgraul@linux.ibm.com>;
        Fri, 14 Feb 2020 07:59:11 -0000
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net 0/2] net/smc: fixes for -net
Date: Fri, 14 Feb 2020 08:58:58 +0100
Message-Id: <20200214075900.31624-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Fix a syzbot finding and a problem with the CLC handshake content.

Ursula Braun (2):
  net/smc: transfer fasync_list in case of fallback
  net/smc: no peer ID in CLC decline for SMCD

 net/smc/af_smc.c  | 2 ++
 net/smc/smc_clc.c | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.17.1
