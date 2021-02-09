Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30438 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232073AbhBIOjX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 9 Feb 2021 09:39:23 -0500
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v1 0/4] s390: Add support for large pages
Date: Tue,  9 Feb 2021 15:38:31 +0100
Message-Id: <20210209143835.1031617-1-imbrenda@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, frankja@linux.ibm.com, cohuck@redhat.com, pmorel@linux.ibm.com

Introduce support for large (1M) and huge (2G) pages.

Add a simple testcase for EDAT1 and EDAT2.

Claudio Imbrenda (4):
  libcflat: add SZ_1M and SZ_2G
  s390x: lib: fix and improve pgtable.h
  s390x: mmu: add support for large pages
  s390x: edat test

 s390x/Makefile          |   1 +
 lib/s390x/asm/pgtable.h |  38 ++++++-
 lib/libcflat.h          |   2 +
 lib/s390x/mmu.h         |  73 +++++++++++-
 lib/s390x/mmu.c         | 246 ++++++++++++++++++++++++++++++++++++----
 s390x/edat.c            | 238 ++++++++++++++++++++++++++++++++++++++
 s390x/unittests.cfg     |   3 +
 7 files changed, 572 insertions(+), 29 deletions(-)
 create mode 100644 s390x/edat.c

-- 
2.26.2
