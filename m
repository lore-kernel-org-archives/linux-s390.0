Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49712 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2394097AbgLKKCV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 11 Dec 2020 05:02:21 -0500
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v3 0/8] s390x: Add SIE library and simple test
Date: Fri, 11 Dec 2020 05:00:31 -0500
Message-Id: <20201211100039.63597-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org

This is the absolute minimum needed to run VMs inside the KVM Unit
Tests. It's more of a base for other tests that I can't (yet) publish
than an addition of tests that check KVM functionality. However, I
wanted to decrease the number of WIP patches in my private
branch. Once the library is available maybe others will come and
extend the SIE test itself.

Yes, I have added VM management functionality like VM create/destroy,
etc but as it is not needed right now, I'd like to exclude it from
this patch set for now.

v3:
	* Rebased on re-license patches
	* Split assembly
	* Now using ICPT_* constants
	* Added read_info asserts
	* Fixed missing spin_lock() in smp.c lib
	* Replaced duplicated code in sie test with generic intercept test
	* Replaced uv-guest.x bit testing with test_bit_inv()
	* Some other minor cleanups

Gitlab:
https://gitlab.com/frankja/kvm-unit-tests/-/tree/sie

CI:
https://gitlab.com/frankja/kvm-unit-tests/-/pipelines/228396011

Janosch Frank (8):
  s390x: Add test_bit to library
  s390x: Consolidate sclp read info
  s390x: SCLP feature checking
  s390x: Split assembly and move to s390x/asm/
  s390x: sie: Add SIE to lib
  s390x: sie: Add first SIE test
  s390x: Add diag318 intercept test
  s390x: Fix sclp.h style issues

 lib/s390x/asm-offsets.c    |  13 +++
 lib/s390x/asm/arch_def.h   |   7 ++
 lib/s390x/asm/bitops.h     |  26 +++++
 lib/s390x/asm/facility.h   |   3 +-
 lib/s390x/interrupt.c      |   7 ++
 lib/s390x/io.c             |   2 +
 lib/s390x/sclp.c           |  52 ++++++++--
 lib/s390x/sclp.h           | 178 ++++++++++++++++++---------------
 lib/s390x/sie.h            | 197 +++++++++++++++++++++++++++++++++++++
 lib/s390x/smp.c            |  27 +++--
 s390x/Makefile             |   9 +-
 s390x/{ => asm}/cstart64.S | 119 +---------------------
 s390x/asm/lib.S            | 121 +++++++++++++++++++++++
 s390x/asm/macros.S         |  77 +++++++++++++++
 s390x/intercept.c          |  19 ++++
 s390x/sie.c                | 113 +++++++++++++++++++++
 s390x/unittests.cfg        |   3 +
 s390x/uv-guest.c           |   6 +-
 18 files changed, 754 insertions(+), 225 deletions(-)
 create mode 100644 lib/s390x/sie.h
 rename s390x/{ => asm}/cstart64.S (50%)
 create mode 100644 s390x/asm/lib.S
 create mode 100644 s390x/asm/macros.S
 create mode 100644 s390x/sie.c

-- 
2.25.1
