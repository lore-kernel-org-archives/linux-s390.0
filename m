Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39852 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727844AbgEBMgS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 2 May 2020 08:36:18 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 00/13] net/smc: add and delete link processing
Date: Sat,  2 May 2020 14:35:39 +0200
Message-Id: <20200502123552.17204-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

These patches add the 'add link' and 'delete link' processing as 
SMC server and client. This processing allows to establish and
remove links of a link group dynamically.

They are based on the patches I sent yesterday, I cannot see yesterdays
patches in the net-next git tree yet.

Karsten Graul (13):
  net/smc: first part of add link processing as SMC client
  net/smc: rkey processing for a new link as SMC client
  net/smc: final part of add link processing as SMC client
  net/smc: first part of add link processing as SMC server
  net/smc: rkey processing for a new link as SMC server
  net/smc: final part of add link processing as SMC server
  net/smc: delete an asymmetric link as SMC server
  net/smc: activate SMC server add link functions
  net/smc: llc_del_link_work and use the LLC flow for delete link
  net/smc: delete link processing as SMC client
  net/smc: delete link processing as SMC server
  net/smc: enqueue local LLC messages
  net/smc: save state of last sent CDC message

 net/smc/af_smc.c   |   4 +-
 net/smc/smc.h      |   4 +
 net/smc/smc_cdc.c  |   6 +
 net/smc/smc_core.c |  29 +-
 net/smc/smc_core.h |   4 +-
 net/smc/smc_llc.c  | 774 +++++++++++++++++++++++++++++++++++++++++++--
 net/smc/smc_llc.h  |   5 +
 net/smc/smc_wr.c   |   2 +-
 net/smc/smc_wr.h   |   1 +
 9 files changed, 786 insertions(+), 43 deletions(-)

-- 
2.17.1
