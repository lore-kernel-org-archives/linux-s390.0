Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26842 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726476AbgD2PLi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 29 Apr 2020 11:11:38 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 00/13] net/smc: preparations for SMC-R link failover
Date: Wed, 29 Apr 2020 17:10:36 +0200
Message-Id: <20200429151049.49979-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

This patch series prepares the SMC code for the implementation of SMC-R link 
failover capabilities which are still missing to reach full compliance with 
RFC 7609.
The code changes are separated into 65 patches which together form the new
functionality. I tried to create meaningful patches which allow to follow the 
implementation.

Question: how to handle the remaining 52 patches? All of them are needed for 
link failover to work and should make it into the same merge window. 
Can I send them all together?

The SMC-R implementation will transparently make use of the link failover 
feature when matching RoCE devices are available, no special setup is required.
All RoCE devices with the same PNET ID as the TCP device (hardware-defined or 
user-defined via the smc_pnet tool) are candidates to get used to form a link 
in a link group. When at least 2 RoCE devices are available on both 
communication endpoints then a symmetric link group is formed, meaning the link 
group has 2 independent links. If one RoCE device goes down then all connections 
on this link are moved to the surviving link. Upon recovery of the failing 
device or availability of a new one, the symmetric link group will be restored.

Karsten Graul (13):
  net/smc: rework pnet table to support SMC-R failover
  net/smc: separate function for link initialization
  net/smc: introduce link_idx for link group array
  net/smc: convert static link ID to dynamic references
  net/smc: convert static link ID instances to support multiple links
  net/smc: multi-link support for smc_rmb_rtoken_handling()
  net/smc: add new link state and related helpers
  net/smc: move testlink work to system work queue
  net/smc: simplify link deactivation
  net/smc: use worker to process incoming llc messages
  net/smc: process llc responses in tasklet context
  net/smc: use mutex instead of rwlock_t to protect buffers
  net/smc: move llc layer related init and clear into smc_llc.c

 net/smc/af_smc.c   |  79 ++++---
 net/smc/smc.h      |   1 +
 net/smc/smc_cdc.c  |   8 +-
 net/smc/smc_clc.c  |  12 +-
 net/smc/smc_clc.h  |   1 +
 net/smc/smc_core.c | 542 +++++++++++++++++++++++++++++----------------
 net/smc/smc_core.h |  78 ++++---
 net/smc/smc_ib.c   |  63 +++---
 net/smc/smc_ib.h   |  10 +-
 net/smc/smc_ism.c  |   3 +-
 net/smc/smc_llc.c  | 396 ++++++++++++++++++---------------
 net/smc/smc_llc.h  |  16 +-
 net/smc/smc_pnet.c | 539 +++++++++++++++++++++++++-------------------
 net/smc/smc_pnet.h |   2 +
 net/smc/smc_tx.c   |  13 +-
 net/smc/smc_wr.c   |   2 +-
 16 files changed, 1063 insertions(+), 702 deletions(-)

-- 
2.17.1
