Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48090 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726491AbgANPbK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 14 Jan 2020 10:31:10 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00EFRNeP046160
        for <linux-s390@vger.kernel.org>; Tue, 14 Jan 2020 10:31:09 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xhbvfaduu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 14 Jan 2020 10:31:09 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Tue, 14 Jan 2020 15:31:07 -0000
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH 0/4] s390x: smp: Improve smp code and reset checks
Date: Tue, 14 Jan 2020 10:30:49 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200114153054.77082-1-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com

The first two patches are badly needed cleanup for smp.c.
The last two improve initial reset testing.

Janosch Frank (4):
  s390x: smp: Cleanup smp.c
  s390x: smp: Only use smp_cpu_setup once
  s390x: smp: Test all CRs on initial reset
  s390x: smp: Dirty fpc before initial reset test

 s390x/smp.c | 84 ++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 58 insertions(+), 26 deletions(-)

-- 
2.20.1
