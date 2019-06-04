Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50220 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727181AbfFDIPX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 Jun 2019 04:15:23 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x548CIZo030887
        for <linux-s390@vger.kernel.org>; Tue, 4 Jun 2019 04:15:22 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2swhyh70sp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 04 Jun 2019 04:15:22 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Tue, 4 Jun 2019 09:15:20 +0100
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH v2 net 0/4] s390/qeth: fixes 2019-06-04
Date: Tue,  4 Jun 2019 10:15:05 +0200
Message-Id: <20190604081509.56160-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Hi Dave,

same patch series as yesterday, except that patch 2 has been adjusted
as per your review to use dst_check(). Please have another look.


From the v1 cover letter:

Please apply the following set of qeth fixes to -net.

- The first two patches fix issues in the L3 driver's cast type
  selection for transmitted skbs.
- Alexandra adds a sanity check when retrieving VLAN information from
  neighbour address events.
- The last patch adds some missing error handling for qeth's new
  multiqueue code.

Thanks,
Julian


Alexandra Winter (1):
  s390/qeth: fix VLAN attribute in bridge_hostnotify udev event

Julian Wiedmann (3):
  s390/qeth: handle limited IPv4 broadcast in L3 TX path
  s390/qeth: check dst entry before use
  s390/qeth: handle error when updating TX queue count

 drivers/s390/net/qeth_core_main.c | 22 ++++++++++++++++------
 drivers/s390/net/qeth_l2_main.c   |  2 +-
 drivers/s390/net/qeth_l3_main.c   | 20 +++++++++++++++++---
 3 files changed, 34 insertions(+), 10 deletions(-)

-- 
2.17.1
