Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52274 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728203AbgECMjr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 3 May 2020 08:39:47 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next v2 00/11] net/smc: add and delete link processing
Date: Sun,  3 May 2020 14:38:39 +0200
Message-Id: <20200503123850.57261-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

These patches add the 'add link' and 'delete link' processing as 
SMC server and client. This processing allows to establish and
remove links of a link group dynamically.

v2: Fix mess up with unused static functions. Merge patch 8 into patch 4.
    Postpone patch 13 to next series.

Karsten Graul (11):
  net/smc: first part of add link processing as SMC client
  net/smc: rkey processing for a new link as SMC client
  net/smc: final part of add link processing as SMC client
  net/smc: first part of add link processing as SMC server
  net/smc: rkey processing for a new link as SMC server
  net/smc: final part of add link processing as SMC server
  net/smc: delete an asymmetric link as SMC server
  net/smc: llc_del_link_work and use the LLC flow for delete link
  net/smc: delete link processing as SMC client
  net/smc: delete link processing as SMC server
  net/smc: enqueue local LLC messages

 net/smc/af_smc.c   |   4 +-
 net/smc/smc_core.c |  29 +-
 net/smc/smc_core.h |   4 +-
 net/smc/smc_llc.c  | 798 +++++++++++++++++++++++++++++++++++++++++++--
 net/smc/smc_llc.h  |   5 +
 net/smc/smc_wr.c   |   2 +-
 net/smc/smc_wr.h   |   1 +
 7 files changed, 800 insertions(+), 43 deletions(-)

-- 
2.17.1
