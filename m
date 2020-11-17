Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34256 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725767AbgKQPm7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 17 Nov 2020 10:42:59 -0500
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH 0/5] s390x: Add SIE library and simple test
Date: Tue, 17 Nov 2020 10:42:10 -0500
Message-Id: <20201117154215.45855-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com

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
https://gitlab.com/frankja/kvm-unit-tests/-/pipelines/217336822

Janosch Frank (5):
  s390x: Add test_bit to library
  s390x: Consolidate sclp read info
  s390x: SCLP feature checking
  s390x: sie: Add SIE to lib
  s390x: sie: Add first SIE test

 lib/s390x/asm-offsets.c  |  13 +++
 lib/s390x/asm/arch_def.h |   7 ++
 lib/s390x/asm/bitops.h   |  16 ++++
 lib/s390x/asm/facility.h |   3 +-
 lib/s390x/interrupt.c    |   7 ++
 lib/s390x/io.c           |   2 +
 lib/s390x/sclp.c         |  48 ++++++++--
 lib/s390x/sclp.h         |  18 ++++
 lib/s390x/sie.h          | 197 +++++++++++++++++++++++++++++++++++++++
 lib/s390x/smp.c          |  23 ++---
 s390x/Makefile           |   1 +
 s390x/cstart64.S         |  56 +++++++++++
 s390x/sie.c              | 125 +++++++++++++++++++++++++
 13 files changed, 495 insertions(+), 21 deletions(-)
 create mode 100644 lib/s390x/sie.h
 create mode 100644 s390x/sie.c

-- 
2.25.1
