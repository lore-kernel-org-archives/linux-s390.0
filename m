Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44036 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726360AbgC0KTr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 27 Mar 2020 06:19:47 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02RA2nnv009365
        for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2020 06:19:46 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ywf2mbrf8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2020 06:19:46 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Fri, 27 Mar 2020 10:19:44 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 0/3] s390/qeth: updates 2020-03-27
Date: Fri, 27 Mar 2020 11:19:31 +0100
Message-Id: <20200327101934.31040-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Hi Dave,

please apply the following patch series for qeth to netdev's net-next
tree.

Spring clean edition:
- remove one sysfs attribute that was never put in use,
- make support for OSN and OSX devices optional, and
- probe for removal of the obsolete OSN support.

Thanks,
Julian

Julian Wiedmann (3):
  s390/qeth: remove fake_broadcast attribute
  s390/qeth: make OSN / OSX support configurable
  s390/qeth: phase out OSN support

 drivers/s390/net/Kconfig          | 17 +++++++++++++++
 drivers/s390/net/qeth_core.h      |  1 -
 drivers/s390/net/qeth_core_main.c |  4 ++++
 drivers/s390/net/qeth_core_mpc.h  | 11 ++++++++++
 drivers/s390/net/qeth_l2_main.c   |  5 +++++
 drivers/s390/net/qeth_l3_sys.c    | 35 -------------------------------
 6 files changed, 37 insertions(+), 36 deletions(-)

-- 
2.17.1
