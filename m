Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34084 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231201AbhA1Lbw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 28 Jan 2021 06:31:52 -0500
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 0/5] s390/qeth: updates 2021-01-28
Date: Thu, 28 Jan 2021 12:25:46 +0100
Message-Id: <20210128112551.18780-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Hi Dave & Jakub,

please apply the following patch series for qeth to netdev's net-next tree.

Nothing special, mostly fine-tuning and follow-on cleanups for earlier fixes.

Thanks,
Julian

Julian Wiedmann (5):
  s390/qeth: clean up load/remove code for disciplines
  s390/qeth: remove qeth_get_ip_version()
  s390/qeth: pass proto to qeth_l3_get_cast_type()
  s390/qeth: make cast type selection for af_iucv skbs robust
  s390/qeth: don't fake a TX completion interrupt after TX error

 drivers/s390/net/qeth_core.h      | 44 +++++---------
 drivers/s390/net/qeth_core_main.c | 97 +++++++++++++++++--------------
 drivers/s390/net/qeth_core_sys.c  | 10 +---
 drivers/s390/net/qeth_l2_main.c   |  6 +-
 drivers/s390/net/qeth_l3_main.c   | 90 ++++++++++++++++------------
 5 files changed, 125 insertions(+), 122 deletions(-)

-- 
2.17.1
