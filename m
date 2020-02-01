Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29604 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726677AbgBAP3E (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 1 Feb 2020 10:29:04 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 011FF3Fk099827
        for <linux-s390@vger.kernel.org>; Sat, 1 Feb 2020 10:29:04 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xw5h9rknq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Sat, 01 Feb 2020 10:29:03 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Sat, 1 Feb 2020 15:29:01 -0000
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v5 0/7] s390x: smp: Improve smp code and reset checks
Date: Sat,  1 Feb 2020 10:28:44 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200201152851.82867-1-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com

Let's cleanup the smp library and smp tests.

GIT: https://github.com/frankjaa/kvm-unit-tests/tree/smp_cleanup

v5:
	* Split up series into three parts to make review easier
	* Greetings from FOSDEM :-)

V4:
	* Introduce set_flag() for manipulating testflag
	* Cleanup of stray braces and mb()s

v3:
	* Added patch to introduce cpu loop in cpu setup
	* Added patch that removes cpu loops in favor of the previously introduced one
	* Fixed inline assembly for fpc dirtying
	* Moved cpu stop hunk from first into the second patch
	* Reworked patch #4 commit message and added a comment when waiting for PU

v2:
	* Added cpu stop to test_store_status()
	* Added smp_cpu_destroy() to the end of smp.c main()
	* New patch that prints cpu id on interrupt errors
	* New patch that reworks cpu start in the smp library (needed for lpar)
	* nullp is now an array

Janosch Frank (7):
  s390x: smp: Cleanup smp.c
  s390x: smp: Fix ecall and emcall report strings
  s390x: Stop the cpu that is executing exit()
  s390x: Add cpu id to interrupt error prints
  s390x: smp: Only use smp_cpu_setup once
  s390x: smp: Rework cpu start and active tracking
  s390x: smp: Wait for cpu setup to finish

 lib/s390x/interrupt.c | 20 +++++------
 lib/s390x/io.c        |  2 +-
 lib/s390x/smp.c       | 59 +++++++++++++++++++------------
 s390x/cstart64.S      |  2 ++
 s390x/smp.c           | 80 ++++++++++++++++++++++++++-----------------
 5 files changed, 100 insertions(+), 63 deletions(-)

-- 
2.20.1
