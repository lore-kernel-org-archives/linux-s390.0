Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8970 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729246AbfHTK4M (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 20 Aug 2019 06:56:12 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7KArsrJ110055
        for <linux-s390@vger.kernel.org>; Tue, 20 Aug 2019 06:56:11 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ugeb9kj83-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 20 Aug 2019 06:56:11 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Tue, 20 Aug 2019 11:56:09 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH 0/3] s390x: More emulation tests
Date: Tue, 20 Aug 2019 12:55:47 +0200
Message-Id: <20190820105550.4991-1-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com

The first patch allows for CECSIM booting via PSW restart.
The other ones add diag288 and STSI tests.

I chose to start with these since they are low controversy. My queue
still contains the sclp patches and a simple smp library with
tests. They will follow later.

Janosch Frank (3):
  s390x: Support PSW restart boot
  s390x: Diag288 test
  s390x: STSI tests

 s390x/Makefile      |   2 +
 s390x/diag288.c     | 111 +++++++++++++++++++++++++++++++++++++++
 s390x/flat.lds      |  14 +++--
 s390x/stsi.c        | 123 ++++++++++++++++++++++++++++++++++++++++++++
 s390x/unittests.cfg |   7 +++
 5 files changed, 252 insertions(+), 5 deletions(-)
 create mode 100644 s390x/diag288.c
 create mode 100644 s390x/stsi.c

-- 
2.17.0
