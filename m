Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43160 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726607AbgATSnF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 20 Jan 2020 13:43:05 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00KIctED145260
        for <linux-s390@vger.kernel.org>; Mon, 20 Jan 2020 13:43:04 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xmgcnkkyf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 20 Jan 2020 13:43:04 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Mon, 20 Jan 2020 18:43:01 -0000
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v8 0/6] s390x: SCLP Unit test
Date: Mon, 20 Jan 2020 19:42:50 +0100
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200120184256.188698-1-imbrenda@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com

This patchset contains some minor cleanup, some preparatory work and
then the SCLP unit test itself.

The unit test checks the following:
    
    * Correctly ignoring instruction bits that should be ignored
    * Privileged instruction check
    * Check for addressing exceptions
    * Specification exceptions:
      - SCCB size less than 8
      - SCCB unaligned
      - SCCB overlaps prefix or lowcore
      - SCCB address higher than 2GB
    * Return codes for
      - Invalid command
      - SCCB too short (but at least 8)
      - SCCB page boundary violation

v7 -> v8
* fixed existing stfl asm wrapper
* now using stfl asm wrapper in intercept.c
* patched the program interrupt handler to clear the sclp_busy bit
* removed now unnecessary expect_pgm_int from the unit test
v6 -> v7
* renamed spx() and stpx() wrappers to set_prefix and get_prefix
* set_prefix now takes a value and get_prefix now returns a value
* put back some inline assembly for spx and stpx as a consequence
* used LC_SIZE instead of 2 * PAGE_SIZE everywhere in the unit test
v5 -> v6
* fixed a bug in test_addressing
* improved comments in test_sccb_prefix
* replaced all inline assembly usages of spx and stpx with the wrappers
* added one more wrapper for test_one_sccb for read-only tests
v4 -> v5
* updated usage of report()
* added SPX and STPX wrappers to the library
* improved readability
* addressed some more comments
v3 -> v4
* export sclp_setup_int instead of copying it
* add more comments
* rename some more variables to improve readability
* improve the prefix test
* improved the invalid address test
* addressed further comments received during review
v2 -> v3
* generally improved the naming of variables
* added and fixed comments
* renamed test_one_run to test_one_simple
* added some const where needed
* addresed many more small comments received during review
v1 -> v2
* fix many small issues that came up during the first round of reviews
* add comments to each function
* use a static buffer for the SCCP template when used

Claudio Imbrenda (6):
  s390x: export sclp_setup_int
  s390x: sclp: add service call instruction wrapper
  s390x: lib: fix stfl wrapper asm
  s390x: lib: add SPX and STPX instruction wrapper
  s390x: lib: fix program interrupt handler if sclp_busy was set
  s390x: SCLP unit test

 s390x/Makefile           |   1 +
 lib/s390x/asm/arch_def.h |  26 +++
 lib/s390x/asm/facility.h |   2 +-
 lib/s390x/sclp.h         |   1 +
 lib/s390x/interrupt.c    |   5 +-
 lib/s390x/sclp.c         |   9 +-
 s390x/intercept.c        |  24 +-
 s390x/sclp.c             | 474 +++++++++++++++++++++++++++++++++++++++
 s390x/unittests.cfg      |   8 +
 9 files changed, 526 insertions(+), 24 deletions(-)
 create mode 100644 s390x/sclp.c

-- 
2.24.1
