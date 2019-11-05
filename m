Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54034 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390137AbfKEQ3D (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Nov 2019 11:29:03 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA5GQIE4019766
        for <linux-s390@vger.kernel.org>; Tue, 5 Nov 2019 11:29:03 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w3awvw8xj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 05 Nov 2019 11:29:02 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Tue, 5 Nov 2019 16:29:01 -0000
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH 0/2] s390x: Improve architectural compliance for diag308
Date: Tue,  5 Nov 2019 11:28:26 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20191105162828.2490-1-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com

When testing diag308 subcodes 0/1 on lpar with virtual mem set up, I
experienced spec PGMs and addressing PGMs due to the tests not setting
short psw bit 12 and leaving the DAT bit on.

The problem was not found under KVM/QEMU, because Qemu just ignores
all cpu mask bits... I'm working on a fix for that too.

Janosch Frank (2):
  s390x: Add CR save area
  s390x: Remove DAT and add short indication psw bits on diag308 reset

 lib/s390x/asm-offsets.c  |  3 ++-
 lib/s390x/asm/arch_def.h |  5 +++--
 lib/s390x/interrupt.c    |  4 ++--
 lib/s390x/smp.c          |  2 +-
 s390x/cstart64.S         | 29 ++++++++++++++++++++---------
 5 files changed, 28 insertions(+), 15 deletions(-)

-- 
2.20.1
