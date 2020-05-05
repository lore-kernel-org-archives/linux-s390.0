Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46784 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728834AbgEENBu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 May 2020 09:01:50 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 0/2] log state changes and cleanup
Date: Tue,  5 May 2020 15:01:19 +0200
Message-Id: <20200505130121.103272-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Patch 1 adds the logging of important state changes to enable SMC-R 
users to detect SMC-R link groups that are not redundant and require
user actions. Patch 2 is a contribution to clean up an unused inline 
function.

Karsten Graul (1):
  net/smc: log important pnetid and state change events

YueHaibing (1):
  net/smc: remove unused inline function smc_curs_read

 net/smc/af_smc.c   |  6 ++----
 net/smc/smc_cdc.h  | 17 -----------------
 net/smc/smc_core.c | 34 ++++++++++++++++++++++++++++-----
 net/smc/smc_core.h |  2 +-
 net/smc/smc_ib.c   | 11 +++++++++++
 net/smc/smc_ism.c  |  6 ++++++
 net/smc/smc_llc.c  | 25 ++++++++++++++++++------
 net/smc/smc_llc.h  |  2 +-
 net/smc/smc_pnet.c | 47 +++++++++++++++++++++++++++++++++++++++++++---
 9 files changed, 113 insertions(+), 37 deletions(-)

-- 
2.17.1
