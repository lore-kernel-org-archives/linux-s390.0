Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40862 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727536AbgLOJOX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Dec 2020 04:14:23 -0500
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 0/1] net/smc: fix access to parent of an ib device
Date: Tue, 15 Dec 2020 10:10:57 +0100
Message-Id: <20201215091058.49354-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, netdev@vger.kernel.org, linux-s390@vger.kernel.org

Please apply the following patch for smc to netdev's net-next tree.

The patch fixes an access to the parent of an ib device which might be NULL.

I am sending this fix to net-next because the fixed code is still in this
tree only.

Karsten Graul (1):
  net/smc: fix access to parent of an ib device

 net/smc/smc_ib.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

-- 
2.17.1
