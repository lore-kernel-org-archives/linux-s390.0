Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23994 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725811AbfH0Ntx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 27 Aug 2019 09:49:53 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7RDm0vH146349
        for <linux-s390@vger.kernel.org>; Tue, 27 Aug 2019 09:49:52 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2un3qpe14v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 27 Aug 2019 09:49:52 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Tue, 27 Aug 2019 14:49:50 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH 0/3] s390x: Add skey removal facility test
Date: Tue, 27 Aug 2019 15:49:33 +0200
Message-Id: <20190827134936.1705-1-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com

The storage key removal facility (skrf) is an anti-facility, which
makes skey related instructions result in a special operation
exception when they handle storage keys. E.g. pfmf in clearing mode
does not result in an exception, but pfmf key setting does.

The skrf is always active in protected virtualization guests and can
be emulated by KVM (expected to be upstreamed with the remaining hpage
patches).

Janosch Frank (3):
  s390x: Move pfmf to lib and make address void
  s390x: Storage key library functions now take void ptr addresses
  s390x: Add storage key removal facility

 lib/s390x/asm/mem.h |  40 ++++++++++++--
 s390x/Makefile      |   1 +
 s390x/pfmf.c        |  77 +++++++++++---------------
 s390x/skey.c        |  29 +++++-----
 s390x/skrf.c        | 130 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 212 insertions(+), 65 deletions(-)
 create mode 100644 s390x/skrf.c

-- 
2.17.0
