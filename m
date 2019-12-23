Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3122 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726763AbfLWOWf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 23 Dec 2019 09:22:35 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBNEK0pa012730
        for <linux-s390@vger.kernel.org>; Mon, 23 Dec 2019 09:22:33 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2x21wbe0nc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 23 Dec 2019 09:22:33 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Mon, 23 Dec 2019 14:22:32 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 0/3] s390/qeth: updates 2019-12-23
Date: Mon, 23 Dec 2019 15:22:24 +0100
Message-Id: <20191223142227.19500-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Hi Dave,

please apply the following patch series for qeth to your net-next tree.

This reworks the RX code to use napi_gro_frags() when building non-linear
skbs, along with some consolidation and cleanups.

Happy holidays - and many thanks for all the effort & support over the past
year, to both Jakub and you. It's much appreciated.

Thanks,
Julian

Julian Wiedmann (3):
  s390/qeth: consolidate RX code
  s390/qeth: use napi_gro_frags() for SG skbs
  s390/qeth: remove QETH_RX_PULL_LEN

 drivers/s390/net/qeth_core.h      |  17 ---
 drivers/s390/net/qeth_core_main.c | 239 +++++++++++++++++++++++++-----
 drivers/s390/net/qeth_l2_main.c   |  40 -----
 drivers/s390/net/qeth_l3_main.c   |  91 ------------
 4 files changed, 200 insertions(+), 187 deletions(-)

-- 
2.17.1
