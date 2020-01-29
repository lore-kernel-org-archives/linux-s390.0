Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47008 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726332AbgA2UD2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 29 Jan 2020 15:03:28 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00TJrlaU132428
        for <linux-s390@vger.kernel.org>; Wed, 29 Jan 2020 15:03:27 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xuagn5fxn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 29 Jan 2020 15:03:27 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 29 Jan 2020 20:03:25 -0000
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH v8 0/4] KVM: s390: Add new reset vcpu API
Date: Wed, 29 Jan 2020 15:03:08 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200129200312.3200-1-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, cohuck@redhat.com, linux-s390@vger.kernel.org

Let's implement the remaining resets, namely the normal and clear
reset to improve architectural compliance. 

While we're at it, let's also start testing the new API.
Those tests are not yet complete, but will be extended in the future.

Janosch Frank (3):
  KVM: s390: Add new reset vcpu API
  selftests: KVM: Add fpu and one reg set/get library functions
  selftests: KVM: s390x: Add reset tests

Pierre Morel (1):
  selftests: KVM: testing the local IRQs resets

 Documentation/virt/kvm/api.txt                |  43 ++++
 arch/s390/kvm/kvm-s390.c                      | 103 +++++---
 include/uapi/linux/kvm.h                      |   5 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../testing/selftests/kvm/include/kvm_util.h  |   6 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  48 ++++
 tools/testing/selftests/kvm/s390x/resets.c    | 222 ++++++++++++++++++
 7 files changed, 399 insertions(+), 29 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/s390x/resets.c

-- 
2.20.1
