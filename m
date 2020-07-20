Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1652 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726012AbgGTOZB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 20 Jul 2020 10:25:01 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net 0/2] net/smc: fixes 2020-07-20
Date: Mon, 20 Jul 2020 16:24:27 +0200
Message-Id: <20200720142429.17916-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Please apply the following patch series for smc to netdev's net tree.

Patch 1 fixes a problem with a buffer that is not put back when the
connection was killed in the meantime.
Patch 2 fixes a wrong behaviour when the maximum dmb buffer count
exceeded.

Thanks,
Karsten

Karsten Graul (2):
  net/smc: put slot when connection is killed
  net/smc: fix dmb buffer shortage

 net/smc/smc_cdc.c  | 6 +++++-
 net/smc/smc_core.c | 4 ++--
 2 files changed, 7 insertions(+), 3 deletions(-)

-- 
2.17.1
