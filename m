Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55674 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S462940AbgJWSsn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 23 Oct 2020 14:48:43 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net 0/3] net/smc: fixes 2020-10-23
Date: Fri, 23 Oct 2020 20:48:27 +0200
Message-Id: <20201023184830.59548-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Please apply the following patch series for smc to netdev's net tree.

Patch 1 fixes a potential null pointer dereference. Patch 2 takes care
of a suppressed return code and patch 3 corrects the system EID in the
ISM driver.

Karsten Graul (3):
  net/smc: fix null pointer dereference in smc_listen_decline()
  net/smc: fix suppressed return code
  s390/ism: fix incorrect system EID

 drivers/s390/net/ism_drv.c | 2 +-
 net/smc/af_smc.c           | 7 ++++---
 net/smc/smc_core.c         | 7 +++++--
 3 files changed, 10 insertions(+), 6 deletions(-)

-- 
2.17.1
