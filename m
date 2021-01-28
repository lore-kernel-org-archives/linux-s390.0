Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29006 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231448AbhA1Ll5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 28 Jan 2021 06:41:57 -0500
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 0/5] net/iucv: updates 2021-01-28
Date: Thu, 28 Jan 2021 12:41:03 +0100
Message-Id: <20210128114108.39409-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Hi Dave & Jakub,

please apply the following patch series for iucv to netdev's net-next tree.

This reworks & simplifies the TX notification path in af_iucv, so that we
can send out SG skbs over TRANS_HIPER sockets. Also remove a noisy
WARN_ONCE() in the RX path.

Thanks,
Julian

Alexander Egorenkov (1):
  net/af_iucv: remove WARN_ONCE on malformed RX packets

Julian Wiedmann (4):
  net/af_iucv: don't lookup the socket on TX notification
  net/af_iucv: count packets in the xmit path
  net/af_iucv: don't track individual TX skbs for TRANS_HIPER sockets
  net/af_iucv: build SG skbs for TRANS_HIPER sockets

 drivers/s390/net/qeth_core_main.c |   6 +-
 include/net/iucv/af_iucv.h        |   3 +-
 net/iucv/af_iucv.c                | 122 ++++++++++++------------------
 3 files changed, 53 insertions(+), 78 deletions(-)

-- 
2.17.1
