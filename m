Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55366 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731981AbfIEKkI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 Sep 2019 06:40:08 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x85AbCTo094914
        for <linux-s390@vger.kernel.org>; Thu, 5 Sep 2019 06:40:07 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2usu18q0sc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 05 Sep 2019 06:40:06 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 5 Sep 2019 11:40:04 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v2 0/6] s390x: Add multiboot and smp
Date: Thu,  5 Sep 2019 12:39:45 +0200
Message-Id: <20190905103951.36522-1-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com

Cross testing emulated instructions has in the past brought up some
issues on all available IBM Z hypervisors. So let's upstream the last
part of multiboot: sclp interrupts and line mode console.

SMP tests are a great way to excercise external interruptions, cpu
resets and sigp. The smp library is always initialized and provides
very rudimentary CPU management for now.

v2:
* Fixed cr0 masks
* Replaced gotos with loops
* Addressed other review comments

Janosch Frank (6):
  s390x: Use interrupts in SCLP and add locking
  s390x: Add linemode console
  s390x: Add linemode buffer to fix newline on every print
  s390x: Add initial smp code
  s390x: Prepare for external calls
  s390x: SMP test

 lib/s390x/asm/arch_def.h  |  13 ++
 lib/s390x/asm/interrupt.h |   5 +
 lib/s390x/asm/sigp.h      |  28 +++-
 lib/s390x/interrupt.c     |  28 +++-
 lib/s390x/io.c            |   5 +-
 lib/s390x/sclp-console.c  | 243 ++++++++++++++++++++++++++++++---
 lib/s390x/sclp.c          |  55 +++++++-
 lib/s390x/sclp.h          |  59 +++++++-
 lib/s390x/smp.c           | 276 ++++++++++++++++++++++++++++++++++++++
 lib/s390x/smp.h           |  51 +++++++
 s390x/Makefile            |   2 +
 s390x/cstart64.S          |   7 +
 s390x/smp.c               | 242 +++++++++++++++++++++++++++++++++
 s390x/unittests.cfg       |   4 +
 14 files changed, 991 insertions(+), 27 deletions(-)
 create mode 100644 lib/s390x/smp.c
 create mode 100644 lib/s390x/smp.h
 create mode 100644 s390x/smp.c

-- 
2.17.0
