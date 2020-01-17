Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41092 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726982AbgAQKqy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 17 Jan 2020 05:46:54 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00HAcs07078575
        for <linux-s390@vger.kernel.org>; Fri, 17 Jan 2020 05:46:53 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xk0qu0hb0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 17 Jan 2020 05:46:53 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Fri, 17 Jan 2020 10:46:51 -0000
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v3 0/9] s390x: smp: Improve smp code and reset checks
Date: Fri, 17 Jan 2020 05:46:31 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200117104640.1983-1-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com

Let's extend sigp reset testing and clean up the smp library as well.

GIT: https://github.com/frankjaa/kvm-unit-tests/tree/smp_cleanup

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

Janosch Frank (9):
  s390x: smp: Cleanup smp.c
  s390x: smp: Only use smp_cpu_setup once
  s390x: Add cpu id to interrupt error prints
  s390x: smp: Rework cpu start and active tracking
  s390x: smp: Wait for cpu setup to finish
  s390x: smp: Loop if secondary cpu returns into cpu setup again
  s390x: smp: Remove unneeded cpu loops
  s390x: smp: Test all CRs on initial reset
  s390x: smp: Dirty fpc before initial reset test

 lib/s390x/interrupt.c | 20 +++++------
 lib/s390x/smp.c       | 52 ++++++++++++++++-----------
 s390x/cstart64.S      |  4 +++
 s390x/smp.c           | 82 +++++++++++++++++++++++++++----------------
 4 files changed, 97 insertions(+), 61 deletions(-)

-- 
2.20.1
