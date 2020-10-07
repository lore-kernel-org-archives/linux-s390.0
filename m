Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36736 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728017AbgJGU56 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Oct 2020 16:57:58 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 0/3] net/smc: updates 2020-10-07
Date: Wed,  7 Oct 2020 22:57:40 +0200
Message-Id: <20201007205743.83535-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Please apply the following patch series for smc to netdev's net-next tree.

Patch 1 and 2 address warnings from static code checkers, and patch 3 handles
a case when all proposed ISM V2 devices fail to init and no V1 devices are
tried afterwards.

Karsten Graul (3):
  net/smc: consolidate unlocking in same function
  net/smc: cleanup buffer usage in smc_listen_work()
  net/smc: restore smcd_version when all ISM V2 devices failed to init

 net/smc/af_smc.c | 92 +++++++++++++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 44 deletions(-)

-- 
2.17.1
