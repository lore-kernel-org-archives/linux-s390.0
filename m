Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65366 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728074AbgD3N4K (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Apr 2020 09:56:10 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 00/14] net/smc: add event-based framework for LLC msgs
Date: Thu, 30 Apr 2020 15:55:37 +0200
Message-Id: <20200430135551.26267-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

These patches are the next step towards SMC-R link failover support. They add
a new framework to handle Link Layer Control (LLC) messages and adapt the
existing code to use the new framework.

Karsten Graul (14):
  net/smc: add event-based llc_flow framework
  net/smc: enqueue all received LLC messages
  net/smc: introduce link group type
  net/smc: add logic to evaluate CONFIRM_LINK messages to LLC layer
  net/smc: adapt SMC server code to use the LLC flow
  net/smc: adapt SMC client code to use the LLC flow
  net/smc: multiple link support and LLC flow for
    smc_llc_do_confirm_rkey
  net/smc: multiple link support and LLC flow for smc_llc_do_delete_rkey
  net/smc: move the TEST_LINK response processing into event handler
  net/smc: new smc_rtoken_set functions for multiple link support
  net/smc: adapt SMC remote CONFIRM_RKEY processing to use the LLC flow
  net/smc: adapt SMC remote DELETE_RKEY processing to use the LLC flow
  net/smc: remove handling of CONFIRM_RKEY_CONTINUE
  net/smc: remove obsolete link state DELETING

 net/smc/af_smc.c   | 108 +++++----
 net/smc/smc_clc.h  |   1 +
 net/smc/smc_core.c |  63 +++++-
 net/smc/smc_core.h |  50 ++++-
 net/smc/smc_llc.c  | 535 ++++++++++++++++++++++++++++++---------------
 net/smc/smc_llc.h  |  15 +-
 6 files changed, 525 insertions(+), 247 deletions(-)

-- 
2.17.1
