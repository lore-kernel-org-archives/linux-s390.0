Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43852 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728419AbfHZQfU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 26 Aug 2019 12:35:20 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7QGOjc1096446
        for <linux-s390@vger.kernel.org>; Mon, 26 Aug 2019 12:35:19 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2umjwxrcpj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 26 Aug 2019 12:35:19 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Mon, 26 Aug 2019 17:35:17 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v3 0/5] s390x: More emulation tests
Date: Mon, 26 Aug 2019 18:34:57 +0200
Message-Id: <20190826163502.1298-1-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com

The first patch allows for CECSIM booting via PSW restart.
The other ones add diag288 and STSI tests, as well as diag308 subcode 0.

v3:
* Addressed review
* Added review-bys

v2:

* Tested under TCG
* Split out stsi into library
* Addressed review

Janosch Frank (5):
  s390x: Support PSW restart boot
  s390x: Diag288 test
  s390x: Move stsi to library
  s390x: STSI tests
  s390x: Add diag308 subcode 0 testing

 lib/s390x/asm/arch_def.h |  17 +++++
 s390x/Makefile           |   2 +
 s390x/cstart64.S         |  27 ++++++++
 s390x/diag288.c          | 130 +++++++++++++++++++++++++++++++++++++++
 s390x/diag308.c          |  31 +++-------
 s390x/flat.lds           |  14 +++--
 s390x/skey.c             |  18 ------
 s390x/stsi.c             |  84 +++++++++++++++++++++++++
 s390x/unittests.cfg      |   7 +++
 9 files changed, 286 insertions(+), 44 deletions(-)
 create mode 100644 s390x/diag288.c
 create mode 100644 s390x/stsi.c

-- 
2.17.0
