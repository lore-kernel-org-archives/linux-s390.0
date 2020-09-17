Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23774 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726180AbgIQUxs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 17 Sep 2020 16:53:48 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 0/1] net/smc: fix 2020-09-17
Date: Thu, 17 Sep 2020 22:46:01 +0200
Message-Id: <20200917204602.14586-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Please apply the following patch for smc to netdev's net-next tree.

The patch fixes a problem reported by Dan. Because the fixed patch is
still only in net-next tree I am sending this fix to net-next.

Ursula Braun (1):
  net/smc: fix double kfree in smc_listen_work()

 net/smc/af_smc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.17.1
