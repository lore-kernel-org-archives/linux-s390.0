Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25652 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726043AbgGZSez (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sun, 26 Jul 2020 14:34:55 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 0/2] net/smc: show unique rsn code for exceeded max dmb count
Date: Sun, 26 Jul 2020 20:34:26 +0200
Message-Id: <20200726183428.3284-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Resolve some confusion at the user side when the reason code shows
out-of-memory but actually there is enough memory left.

Karsten Graul (2):
  s390/ism: indicate correct error reason in ism_alloc_dmb()
  net/smc: unique reason code for exceeded max dmb count

 drivers/s390/net/ism_drv.c |  2 +-
 net/smc/af_smc.c           | 13 +++++++++----
 net/smc/smc_clc.h          |  1 +
 net/smc/smc_core.c         |  4 ++--
 4 files changed, 13 insertions(+), 7 deletions(-)

-- 
2.17.1
