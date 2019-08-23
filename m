Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10068 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390173AbfHWJtC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 23 Aug 2019 05:49:02 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7N9kc2k105073
        for <linux-s390@vger.kernel.org>; Fri, 23 Aug 2019 05:49:01 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ujchm2syg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 23 Aug 2019 05:49:00 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Fri, 23 Aug 2019 10:48:58 +0100
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 0/7] s390/qeth: updates 2019-08-23
Date: Fri, 23 Aug 2019 11:48:46 +0200
Message-Id: <20190823094853.63814-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Hi Dave,

please apply one more round of qeth patches. These implement support for
a bunch of TX-related features - namely TX NAPI, BQL and xmit_more.

Note that this includes two qdio patches which lay the necessary
groundwork, and have been acked by Vasily.

Thanks,
Julian

Julian Wiedmann (7):
  s390/qdio: enable drivers to poll for Output completions
  s390/qdio: let drivers opt-out from Output Queue scanning
  s390/qeth: collect accurate TX statistics
  s390/qeth: add TX NAPI support for IQD devices
  s390/qeth: when in TX NAPI mode, use napi_consume_skb()
  s390/qeth: add BQL support for IQD devices
  s390/qeth: add xmit_more support for IQD devices

 arch/s390/include/asm/qdio.h      |   6 +-
 drivers/s390/cio/qdio.h           |   3 +-
 drivers/s390/cio/qdio_main.c      |  75 ++++--
 drivers/s390/cio/qdio_setup.c     |   2 +-
 drivers/s390/net/qeth_core.h      |  52 ++++
 drivers/s390/net/qeth_core_main.c | 410 +++++++++++++++++++++---------
 drivers/s390/net/qeth_ethtool.c   |   2 +
 drivers/s390/net/qeth_l2_main.c   |  12 +-
 drivers/s390/net/qeth_l3_main.c   |   9 +-
 9 files changed, 414 insertions(+), 157 deletions(-)

-- 
2.17.1
