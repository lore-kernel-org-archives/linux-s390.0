Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14424 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725770AbgLGNOj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 7 Dec 2020 08:14:39 -0500
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 0/6] s390/qeth: updates 2020-12-07
Date: Mon,  7 Dec 2020 14:12:27 +0100
Message-Id: <20201207131233.90383-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Hi Jakub,

please apply the following patch series for qeth to netdev's net-next tree.

Some sysfs cleanups (with the prep work in ccwgroup acked by Heiko), and
a few improvements to the code that deals with async TX completion
notifications for IQD devices.

This also brings the missing patch from the previous net-next submission.

Thanks,
Julian

Julian Wiedmann (6):
  s390/qeth: don't call INIT_LIST_HEAD() on iob's list entry
  s390/ccwgroup: use bus->dev_groups for bus-based sysfs attributes
  s390/qeth: use dev->groups for common sysfs attributes
  s390/qeth: don't replace a fully completed async TX buffer
  s390/qeth: remove QETH_QDIO_BUF_HANDLED_DELAYED state
  s390/qeth: make qeth_qdio_handle_aob() more robust

 drivers/s390/cio/ccwgroup.c       |  12 +---
 drivers/s390/net/qeth_core.h      |  10 +--
 drivers/s390/net/qeth_core_main.c | 111 +++++++++++++++++-------------
 drivers/s390/net/qeth_core_sys.c  |  41 +++++------
 drivers/s390/net/qeth_l2.h        |   2 -
 drivers/s390/net/qeth_l2_main.c   |   4 +-
 drivers/s390/net/qeth_l2_sys.c    |  19 -----
 drivers/s390/net/qeth_l3.h        |   2 -
 drivers/s390/net/qeth_l3_main.c   |   4 +-
 drivers/s390/net/qeth_l3_sys.c    |  21 ------
 10 files changed, 92 insertions(+), 134 deletions(-)

-- 
2.17.1
