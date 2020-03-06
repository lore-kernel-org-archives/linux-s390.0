Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54944 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726047AbgCFINY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 6 Mar 2020 03:13:24 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02689r2M003242
        for <linux-s390@vger.kernel.org>; Fri, 6 Mar 2020 03:13:23 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yk8hmh6rh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 06 Mar 2020 03:13:23 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Fri, 6 Mar 2020 08:13:21 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 0/2] s390/qeth: updates 2020-03-06
Date: Fri,  6 Mar 2020 09:13:09 +0100
Message-Id: <20200306081311.50635-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Hi Dave,

please apply the following patch series for qeth to netdev's net-next
tree.

Just a small update to take care of a regression wrt to IRQ handling in
net-next, reported by Qian Cai. The fix needs some qdio layer changes,
so you will find Vasily's Acked-by in that patch.

Thanks,
Julian

Julian Wiedmann (2):
  s390/qdio: add tighter controls for IRQ polling
  s390/qeth: remove VNICC callback parameter struct

 drivers/s390/cio/qdio_setup.c     | 11 +++++++++--
 drivers/s390/net/qeth_core_main.c |  5 ++---
 drivers/s390/net/qeth_l2_main.c   | 29 ++++-------------------------
 3 files changed, 15 insertions(+), 30 deletions(-)

-- 
2.17.1
