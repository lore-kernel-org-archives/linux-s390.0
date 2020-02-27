Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42334 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729375AbgB0RI2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 27 Feb 2020 12:08:28 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01RH6ovK012711
        for <linux-s390@vger.kernel.org>; Thu, 27 Feb 2020 12:08:27 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ydxre7fv3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 27 Feb 2020 12:08:26 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Thu, 27 Feb 2020 17:08:25 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 0/8] s390/qeth: updates 2020-02-27
Date: Thu, 27 Feb 2020 18:08:08 +0100
Message-Id: <20200227170816.101286-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Hi Dave,

please apply the following patch series for qeth to netdev's net-next
tree.

This adds support for ETHTOOL_RX_COPYBREAK, along with small cleanups
and fine-tuning.

Thanks,
Julian

Julian Wiedmann (8):
  s390/qeth: remove dead code in qeth_l3_iqd_read_initial_mac()
  s390/qeth: clean up CREATE_ADDR cmd code
  s390/qeth: validate device-provided MAC address
  s390/qeth: remove unused cmd definitions
  s390/qeth: reset seqnos on connection startup
  s390/qeth: don't re-start read cmd when IDX has terminated
  s390/qeth: don't check for IFF_UP when scheduling napi
  s390/qeth: support configurable RX copybreak

 drivers/s390/net/qeth_core.h      | 10 +++++----
 drivers/s390/net/qeth_core_main.c | 36 +++++++++++++++++--------------
 drivers/s390/net/qeth_core_mpc.h  | 10 +++------
 drivers/s390/net/qeth_ethtool.c   | 31 ++++++++++++++++++++++++++
 drivers/s390/net/qeth_l3_main.c   | 16 +++++---------
 5 files changed, 65 insertions(+), 38 deletions(-)

-- 
2.17.1
