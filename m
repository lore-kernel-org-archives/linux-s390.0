Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63332 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726575AbfKRIgL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 18 Nov 2019 03:36:11 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAI8WRB7047303
        for <linux-s390@vger.kernel.org>; Mon, 18 Nov 2019 03:36:10 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wayfmkp5g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 18 Nov 2019 03:36:10 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 18 Nov 2019 08:36:07 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/5] KVM: s390: fixes and enhancements for 5.5
Date: Mon, 18 Nov 2019 09:35:57 +0100
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20191118083602.15835-1-borntraeger@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>

Paolo, Radim,

everybody is busy on the ultravisor related things, so only a small
number of changes for s390 for 5.5.

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-5.5-1

for you to fetch changes up to c7b7de63124645089ccf9900b9e5ea08059ccae0:

  KVM: s390: Do not yield when target is already running (2019-10-10 13:18:40 +0200)

----------------------------------------------------------------
KVM: s390: small fixes and enhancements

- selftest improvements
- yield improvements
- cleanups

----------------------------------------------------------------
Christian Borntraeger (3):
      selftests: kvm: make syncregs more reliable on s390
      KVM: s390: count invalid yields
      KVM: s390: Do not yield when target is already running

Janosch Frank (1):
      KVM: s390: Cleanup kvm_arch_init error path

Thomas Huth (1):
      KVM: s390: Remove unused parameter from __inject_sigp_restart()

 arch/s390/include/asm/kvm_host.h                   |  1 +
 arch/s390/kvm/diag.c                               | 22 ++++++++++++++++++----
 arch/s390/kvm/interrupt.c                          |  5 ++---
 arch/s390/kvm/kvm-s390.c                           | 19 ++++++++-----------
 tools/testing/selftests/kvm/s390x/sync_regs_test.c | 15 +++++++++------
 5 files changed, 38 insertions(+), 24 deletions(-)
