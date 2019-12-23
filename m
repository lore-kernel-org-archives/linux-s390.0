Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43788 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726733AbfLWODu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 23 Dec 2019 09:03:50 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBNE3I1L151422
        for <linux-s390@vger.kernel.org>; Mon, 23 Dec 2019 09:03:49 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2x1f3c0wy7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 23 Dec 2019 09:03:46 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Mon, 23 Dec 2019 14:03:33 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 0/6] s390/qeth: fixes 2019-12-23
Date: Mon, 23 Dec 2019 15:03:20 +0100
Message-Id: <20191223140326.16488-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Hi Dave,

please apply the following patch series for qeth to your net tree.

This brings two fixes for errors during device initialization, deals with
several issues in the vnicc control code, and adds a missing lock.

Thanks,
Julian

Alexandra Winter (3):
  s390/qeth: fix false reporting of VNIC CHAR config failure
  s390/qeth: Fix vnicc_is_in_use if rx_bcast not set
  s390/qeth: vnicc Fix init to default

Julian Wiedmann (3):
  s390/qeth: fix qdio teardown after early init error
  s390/qeth: lock the card while changing its hsuid
  s390/qeth: fix initialization on old HW

 drivers/s390/net/qeth_core_main.c | 29 +++++++---------------
 drivers/s390/net/qeth_l2_main.c   | 10 ++++----
 drivers/s390/net/qeth_l3_main.c   |  2 +-
 drivers/s390/net/qeth_l3_sys.c    | 40 +++++++++++++++++++++----------
 4 files changed, 43 insertions(+), 38 deletions(-)

-- 
2.17.1
