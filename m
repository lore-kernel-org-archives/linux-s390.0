Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19272 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726532AbgKQQPe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 17 Nov 2020 11:15:34 -0500
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 0/9] s390/qeth: updates 2020-11-17
Date: Tue, 17 Nov 2020 17:15:11 +0100
Message-Id: <20201117161520.1089-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Hi Jakub,

please apply the following patch series for qeth to netdev's net-next tree.

This brings some cleanups, and a bunch of improvements for our
.get_link_ksettings() code.

Julian Wiedmann (8):
  s390/qeth: don't call INIT_LIST_HEAD() on iob's list entry
  s390/qeth: reduce rtnl locking for switchdev events
  s390/qeth: tolerate error when querying card info
  s390/qeth: improve QUERY CARD INFO processing
  s390/qeth: set static link info during initialization
  s390/qeth: clean up default cases for ethtool link mode
  s390/qeth: use QUERY OAT for initial link info
  s390/qeth: improve selection of ethtool link modes

Kaixu Xia (1):
  s390/qeth: remove useless if/else

 drivers/s390/net/qeth_core.h      |  24 ++-
 drivers/s390/net/qeth_core_main.c | 232 ++++++++++++++++++++++++++--
 drivers/s390/net/qeth_core_mpc.h  |  40 ++++-
 drivers/s390/net/qeth_ethtool.c   | 243 +++++++++++-------------------
 drivers/s390/net/qeth_l2_main.c   |  33 ++--
 drivers/s390/net/qeth_l3_main.c   |   5 +-
 6 files changed, 378 insertions(+), 199 deletions(-)

-- 
2.17.1
