Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60270 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728269AbgAaKCS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 31 Jan 2020 05:02:18 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00VA0gv9148604
        for <linux-s390@vger.kernel.org>; Fri, 31 Jan 2020 05:02:17 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xv09xt9tq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 31 Jan 2020 05:02:16 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Fri, 31 Jan 2020 10:02:15 -0000
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH v10 0/6] KVM: s390: Add new reset vcpu API
Date: Fri, 31 Jan 2020 05:01:59 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200131100205.74720-1-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, cohuck@redhat.com, linux-s390@vger.kernel.org

Let's implement the remaining resets, namely the normal and clear
reset to improve architectural compliance.

While we're at it, let's also start testing the new API.
Those tests are not yet complete, but will be extended in the future.

v10:
	* Cleared up the test patch and added strerror information
	* Removed capability checks from irq test
	* Fixed clobber patch

Christian Borntraeger (1):
  KVM: s390: do not clobber registers during guest reset/store status

Janosch Frank (4):
  KVM: s390: Cleanup initial cpu reset
  KVM: s390: Add new reset vcpu API
  selftests: KVM: Add fpu and one reg set/get library functions
  selftests: KVM: s390x: Add reset tests

Pierre Morel (1):
  selftests: KVM: testing the local IRQs resets

 Documentation/virt/kvm/api.txt                |  43 ++++
 arch/s390/include/asm/kvm_host.h              |   5 +
 arch/s390/kvm/kvm-s390.c                      |  92 +++++---
 include/uapi/linux/kvm.h                      |   5 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../testing/selftests/kvm/include/kvm_util.h  |   6 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  36 ++++
 tools/testing/selftests/kvm/s390x/resets.c    | 197 ++++++++++++++++++
 8 files changed, 351 insertions(+), 34 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/s390x/resets.c

-- 
2.20.1
