Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9952 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405869AbfJWNoW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 23 Oct 2019 09:44:22 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9NDiIDA106714
        for <linux-s390@vger.kernel.org>; Wed, 23 Oct 2019 09:44:21 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vtnj16kqx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 23 Oct 2019 09:44:21 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <kgraul@linux.ibm.com>;
        Wed, 23 Oct 2019 14:44:18 +0100
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net 0/2] net/smc: fixes for -net
Date: Wed, 23 Oct 2019 15:44:04 +0200
Message-Id: <20191023134406.66319-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Fixes for the net tree, covering a memleak when closing
SMC fallback sockets and fix SMC-R connection establishment
when vlan-ids are used.

Ursula Braun (2):
  net/smc: fix closing of fallback SMC sockets
  net/smc: keep vlan_id for SMC-R in smc_listen_work()

 net/smc/af_smc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

-- 
2.17.1
