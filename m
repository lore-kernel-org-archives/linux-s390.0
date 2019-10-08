Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55392 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725795AbfJHQVQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Oct 2019 12:21:16 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x98GCkcP081757
        for <linux-s390@vger.kernel.org>; Tue, 8 Oct 2019 12:21:15 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vgw6s1qtv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 08 Oct 2019 12:21:14 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Tue, 8 Oct 2019 17:21:13 +0100
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 0/2] s390/qeth: fixes 2019-10-08
Date: Tue,  8 Oct 2019 18:21:05 +0200
Message-Id: <20191008162107.95259-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Hi Dave,

please apply the following two patches to your net tree.

Alexandra fixes two issues in the initialization code for vnicc cmds.
One is an uninitialized variable when a cmd fails, the other that we
wouldn't recover correctly if the device's supported features changed.

Thanks,
Julian


Alexandra Winter (2):
  s390/qeth: Fix error handling during VNICC initialization
  s390/qeth: Fix initialization of vnicc cmd masks during set online

 drivers/s390/net/qeth_l2_main.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

-- 
2.17.1
