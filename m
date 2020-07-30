Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12820 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726275AbgG3PBa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Jul 2020 11:01:30 -0400
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 0/4] s390/qeth: updates 2020-07-30
Date: Thu, 30 Jul 2020 17:01:17 +0200
Message-Id: <20200730150121.18005-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Hi Dave & Jakub,

please apply the following patch series for qeth to netdev's net-next tree.

This primarily brings some modernization to the RX path, laying the
groundwork for smarter RX refill policies.
Some of the patches are tagged as fixes, but really target only rare /
theoretical issues. So given where we are in the release cycle and that we
touch the main RX path, taking them through net-next seems more appropriate.

Thanks,
Julian

Julian Wiedmann (4):
  s390/qeth: tolerate pre-filled RX buffer
  s390/qeth: integrate RX refill worker with NAPI
  s390/qeth: don't process empty bridge port events
  s390/qeth: use all configured RX buffers

 drivers/s390/net/qeth_core.h      |  2 +-
 drivers/s390/net/qeth_core_main.c | 76 +++++++++++++++++--------------
 drivers/s390/net/qeth_l2_main.c   |  5 +-
 drivers/s390/net/qeth_l3_main.c   |  1 -
 4 files changed, 48 insertions(+), 36 deletions(-)

-- 
2.17.1
