Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6706 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728606AbgEAKsb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 1 May 2020 06:48:31 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 00/13] net/smc: extent buffer mapping and port handling
Date: Fri,  1 May 2020 12:48:00 +0200
Message-Id: <20200501104813.76601-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Add functionality to map/unmap and register/unregister memory buffers for
specific SMC-R links and for the whole link group. Prepare LLC layer messages
for the support of multiple links and extent the processing of adapter events.
And add further small preparations needed for the SMC-R failover support.

Karsten Graul (13):
  net/smc: multiple link support for rmb buffer registration
  net/smc: unmapping of buffers to support multiple links
  net/smc: map and register buffers for a new link
  net/smc: extend smc_llc_send_add_link() and smc_llc_send_delete_link()
  net/smc: mutex to protect the lgr against parallel reconfigurations
  net/smc: remember PNETID of IB device for later device matching
  net/smc: add smcr_port_add() and smcr_link_up() processing
  net/smc: add smcr_port_err() and smcr_link_down() processing
  net/smc: take link down instead of terminating the link group
  net/smc: remove DELETE LINK processing from smc_core.c
  net/smc: introduce smc_pnet_find_alt_roce()
  net/smc: allocate index for a new link
  net/smc: llc_add_link_work to handle ADD_LINK LLC requests

 net/smc/af_smc.c   |  63 +++----
 net/smc/smc_core.c | 420 +++++++++++++++++++++++++++++++++++----------
 net/smc/smc_core.h |  18 +-
 net/smc/smc_ib.c   |   3 +-
 net/smc/smc_llc.c  | 150 ++++++++++------
 net/smc/smc_llc.h  |  19 +-
 net/smc/smc_pnet.c |  15 +-
 net/smc/smc_pnet.h |   5 +-
 net/smc/smc_tx.c   |   2 +-
 net/smc/smc_wr.c   |  19 +-
 10 files changed, 518 insertions(+), 196 deletions(-)

-- 
2.17.1
