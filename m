Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14712 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729913AbgK0NGj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 27 Nov 2020 08:06:39 -0500
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v2 0/7] s390x: Add SIE library and simple test
Date: Fri, 27 Nov 2020 08:06:22 -0500
Message-Id: <20201127130629.120469-1-frankja@linux.ibm.com>
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

Gitlab:
https://gitlab.com/frankja/kvm-unit-tests/-/tree/sie

CI:
https://gitlab.com/frankja/kvm-unit-tests/-/pipelines/222217716

v2:
	* Added license and source identifiers to test_bit patch
	* Changed the way I test for sclp feature bits
	* Removed the cpu info page itself and all references
	* Added the diag318 and a sclp.h style fix patch

Janosch Frank (7):
  s390x: Add test_bit to library
  s390x: Consolidate sclp read info
  s390x: SCLP feature checking
  s390x: sie: Add SIE to lib
  s390x: sie: Add first SIE test
  s390x: Add diag318 intercept test
  s390x: Fix sclp.h style issues

 lib/s390x/asm-offsets.c  |  13 +++
 lib/s390x/asm/arch_def.h |   7 ++
 lib/s390x/asm/bitops.h   |  26 ++++++
 lib/s390x/asm/facility.h |   3 +-
 lib/s390x/interrupt.c    |   7 ++
 lib/s390x/io.c           |   2 +
 lib/s390x/sclp.c         |  50 ++++++++--
 lib/s390x/sclp.h         | 178 +++++++++++++++++++----------------
 lib/s390x/sie.h          | 197 +++++++++++++++++++++++++++++++++++++++
 lib/s390x/smp.c          |  28 +++---
 s390x/Makefile           |   1 +
 s390x/cstart64.S         |  56 +++++++++++
 s390x/intercept.c        |  19 ++++
 s390x/sie.c              | 125 +++++++++++++++++++++++++
 s390x/unittests.cfg      |   3 +
 15 files changed, 611 insertions(+), 104 deletions(-)
 create mode 100644 lib/s390x/sie.h
 create mode 100644 s390x/sie.c

-- 
2.25.1
