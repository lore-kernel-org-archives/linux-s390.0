Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57056 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404364AbfFKQiL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 11 Jun 2019 12:38:11 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5BGR874102550
        for <linux-s390@vger.kernel.org>; Tue, 11 Jun 2019 12:38:10 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t2eug3vn3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 11 Jun 2019 12:38:10 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Tue, 11 Jun 2019 17:38:08 +0100
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 00/13] s390/qeth: updates 2019-06-11
Date: Tue, 11 Jun 2019 18:37:47 +0200
Message-Id: <20190611163800.64730-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Hi Dave,

please apply the following patch series for qeth to net-next.
This brings all sorts of cleanups and minor improvements,
primarily for the control IO path.

Thanks,
Julian


Julian Wiedmann (13):
  s390/qeth: don't mask TX errors on IQD devices
  s390/qeth: use mm helpers
  s390/qeth: simplify DOWN state handling
  s390/qeth: restart pending READ cmd from callback
  s390/qeth: clean up setting of BLKT defaults
  s390/qeth: remove qeth_wait_for_buffer()
  s390/qeth: remove OSN-specific IO code
  s390/qeth: convert device-specific trace entries
  s390/qeth: remove 'channel' parameter from callbacks
  s390/qeth: add support for dynamically allocated cmds
  s390/qeth: convert RCD code to common IO infrastructure
  s390/qeth: command-chain the IDX sequence
  s390/qeth: allocate a single cmd on read channel

 drivers/s390/net/qeth_core.h      |  27 +-
 drivers/s390/net/qeth_core_main.c | 614 ++++++++++++++----------------
 drivers/s390/net/qeth_core_mpc.h  |   2 -
 drivers/s390/net/qeth_l2_main.c   |  83 ++--
 drivers/s390/net/qeth_l3_main.c   |  41 +-
 5 files changed, 351 insertions(+), 416 deletions(-)

-- 
2.17.1
