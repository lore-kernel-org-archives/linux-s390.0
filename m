Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32366 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728013AbgIOU6E (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Sep 2020 16:58:04 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 0/1] net/smc: fix 2020-09-15
Date: Tue, 15 Sep 2020 22:57:08 +0200
Message-Id: <20200915205709.50325-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Please apply the following patch for smc to netdev's net-next tree.

The patch fixes a problem that was revealed by a smatch warning. Because the
fixed patch is still only in net-next tree I am sending this fix to net-next.

Karsten Graul (1):
  net/smc: check variable before dereferencing in smc_close.c

 net/smc/smc_close.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.17.1
