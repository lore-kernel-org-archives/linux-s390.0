Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46024 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729058AbfLKL7f (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 11 Dec 2019 06:59:35 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBBBqHiJ135782
        for <linux-s390@vger.kernel.org>; Wed, 11 Dec 2019 06:59:34 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wtfbxag8d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 11 Dec 2019 06:59:34 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 11 Dec 2019 11:59:31 -0000
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH 0/2] s390x: smp: Improve setup of additional cpus
Date: Wed, 11 Dec 2019 06:59:21 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20191211115923.9191-1-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, david@redhat.com, linux-s390@vger.kernel.org

Let's not use constants for the PSW mask and CRs, but set them from
input data or cpu 0.

Later on we could add functions that take a ptr for setting up CRs of
additional cpus, but for now using the CRs 0,1,7,13 from cpu 0 will at
least result in a working DAT environment.

Janosch Frank (2):
  s390x: smp: Use full PSW to bringup new cpu
  s390x: smp: Setup CRs from cpu 0

 lib/s390x/smp.c  | 7 ++++++-
 s390x/cstart64.S | 4 ++--
 2 files changed, 8 insertions(+), 3 deletions(-)

-- 
2.20.1
