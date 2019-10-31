Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7606 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726735AbfJaMm4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 31 Oct 2019 08:42:56 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9VCeSBx052635
        for <linux-s390@vger.kernel.org>; Thu, 31 Oct 2019 08:42:55 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vxwmq9be0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 31 Oct 2019 08:42:50 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Thu, 31 Oct 2019 12:42:27 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 0/8] s390/qeth: updates 2019-10-31
Date: Thu, 31 Oct 2019 13:42:13 +0100
Message-Id: <20191031124221.34028-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Hi Dave,

please apply the following series of spooky qeth updates for net-next.

The first two patches add support for an enhanced TX doorbell, which
enables us to do more xmit_more-based bulking.
Note that this requires one patch for the s390/qdio base layer, which
has been graciously acked by Heiko to go through your tree.

The remaining patches are just the usual minor cleanups/improvements.

Thanks,
Julian


Julian Wiedmann (8):
  s390/qdio: implement IQD Multi-Write
  s390/qeth: use IQD Multi-Write
  s390/qeth: use QDIO_BUFNR()
  s390/qeth: keep IRQ disabled until NAPI is really done
  s390/qeth: consolidate some duplicated HW cmd code
  s390/qeth: don't set card state in qeth_qdio_clear_card()
  s390/qeth: use helpers for IP address hashing
  s390/qeth: don't cache MAC addresses for multicast IPs

 drivers/s390/cio/qdio.h           |   1 +
 drivers/s390/cio/qdio_main.c      |  31 +++++----
 drivers/s390/net/qeth_core.h      |   9 +++
 drivers/s390/net/qeth_core_main.c | 108 ++++++++++++++++++++----------
 drivers/s390/net/qeth_core_mpc.h  |   4 +-
 drivers/s390/net/qeth_l2_main.c   |  21 ------
 drivers/s390/net/qeth_l3.h        |  24 ++-----
 drivers/s390/net/qeth_l3_main.c   |  41 ++++--------
 8 files changed, 120 insertions(+), 119 deletions(-)

-- 
2.17.1
