Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61880 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729224AbgAaPJA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 31 Jan 2020 10:09:00 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00VF7D7Q123357
        for <linux-s390@vger.kernel.org>; Fri, 31 Jan 2020 10:08:59 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xvkrfftpd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 31 Jan 2020 10:08:58 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 31 Jan 2020 15:03:54 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/7] KVM: s390: Fixes and cleanups for 5.6
Date: Fri, 31 Jan 2020 16:03:41 +0100
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200131150348.73360-1-borntraeger@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>

Paolo,
mostly fixes and cleanups for 5.6.
Patch 2 has cc stable.

The following changes since commit d1eef1c619749b2a57e514a3fa67d9a516ffa919:

  Linux 5.5-rc2 (2019-12-15 15:16:08 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-5.6-1

for you to fetch changes up to b2ff728bae9b04b533fbc8de66f1719c4dc889de:

  selftests: KVM: testing the local IRQs resets (2020-01-31 13:17:21 +0100)

----------------------------------------------------------------
KVM: s390: Fixes and cleanups for 5.6
- fix register corruption
- ENOTSUPP/EOPNOTSUPP mixed
- reset cleanups/fixes
- selftests

----------------------------------------------------------------
Christian Borntraeger (2):
      KVM: s390: ENOTSUPP -> EOPNOTSUPP fixups
      KVM: s390: do not clobber registers during guest reset/store status

Janosch Frank (4):
      KVM: s390: Cleanup initial cpu reset
      KVM: s390: Add new reset vcpu API
      selftests: KVM: Add fpu and one reg set/get library functions
      selftests: KVM: s390x: Add reset tests

Pierre Morel (1):
      selftests: KVM: testing the local IRQs resets

 Documentation/virt/kvm/api.txt                 |  43 ++++++
 arch/s390/include/asm/kvm_host.h               |   5 +
 arch/s390/kvm/interrupt.c                      |   6 +-
 arch/s390/kvm/kvm-s390.c                       |  92 +++++++-----
 include/uapi/linux/kvm.h                       |   5 +
 tools/testing/selftests/kvm/Makefile           |   1 +
 tools/testing/selftests/kvm/include/kvm_util.h |   6 +
 tools/testing/selftests/kvm/lib/kvm_util.c     |  36 +++++
 tools/testing/selftests/kvm/s390x/resets.c     | 197 +++++++++++++++++++++++++
 9 files changed, 354 insertions(+), 37 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/s390x/resets.c
