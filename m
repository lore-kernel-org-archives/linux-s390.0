Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14560 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731592AbfIEIkk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 Sep 2019 04:40:40 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x858bhFU089163
        for <linux-s390@vger.kernel.org>; Thu, 5 Sep 2019 04:40:38 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2utxpyruv6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 05 Sep 2019 04:40:38 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 5 Sep 2019 09:40:36 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [GIT PULL 0/8] KVM: s390: extend selftests add more input checks
Date: Thu,  5 Sep 2019 10:40:01 +0200
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190905084009.26106-1-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: pbonzini@redhat.com, rkrcmar@redhat.com
Cc: kvm@vger.kernel.org, cohuck@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, frankja@linux.vnet.ibm.com, david@redhat.com, thuth@redhat.com

Paolo, Radim,

Thomas extended the selftests and added some input checks to KVM s390
ioctls. Cornelia contributed the documentation changes needed after
the added checks.

Please pull.

The following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b:

  Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/kvm-s390-next-5.4-1

for you to fetch changes up to 81cb736c0c928444e2f4707513c167d5d39844a4:

  KVM: selftests: Test invalid bits in kvm_valid_regs and kvm_dirty_regs on s390x (2019-09-04 15:38:05 +0200)

----------------------------------------------------------------
* More selftests
* Improved KVM_S390_MEM_OP ioctl input checking
* Add kvm_valid_regs and kvm_dirty_regs invalid bit checking
----------------------------------------------------------------
Cornelia Huck (1):
      KVM: s390: improve documentation for S390_MEM_OP

Thomas Huth (7):
      KVM: selftests: Split ucall.c into architecture specific files
      KVM: selftests: Implement ucall() for s390x
      KVM: selftests: Enable dirty_log_test on s390x
      KVM: s390: Test for bad access register and size at the start of S390_MEM_OP
      KVM: selftests: Add a test for the KVM_S390_MEM_OP ioctl
      KVM: s390: Disallow invalid bits in kvm_valid_regs and kvm_dirty_regs
      KVM: selftests: Test invalid bits in kvm_valid_regs and kvm_dirty_regs on s390x

 Documentation/virt/kvm/api.txt                     |  14 +-
 arch/s390/include/uapi/asm/kvm.h                   |   6 +
 arch/s390/kvm/kvm-s390.c                           |   6 +-
 tools/testing/selftests/kvm/Makefile               |  10 +-
 tools/testing/selftests/kvm/dirty_log_test.c       |  61 +++++++-
 tools/testing/selftests/kvm/include/kvm_util.h     |   8 +-
 tools/testing/selftests/kvm/lib/aarch64/ucall.c    | 112 ++++++++++++++
 tools/testing/selftests/kvm/lib/s390x/ucall.c      |  56 +++++++
 tools/testing/selftests/kvm/lib/ucall.c            | 157 -------------------
 tools/testing/selftests/kvm/lib/x86_64/ucall.c     |  56 +++++++
 tools/testing/selftests/kvm/s390x/memop.c          | 166 +++++++++++++++++++++
 tools/testing/selftests/kvm/s390x/sync_regs_test.c |  36 ++++-
 12 files changed, 503 insertions(+), 185 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/lib/aarch64/ucall.c
 create mode 100644 tools/testing/selftests/kvm/lib/s390x/ucall.c
 delete mode 100644 tools/testing/selftests/kvm/lib/ucall.c
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/ucall.c
 create mode 100644 tools/testing/selftests/kvm/s390x/memop.c
