Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25874 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726925AbgG3JtF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Jul 2020 05:49:05 -0400
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/2] KVM: s390: feature for 5.9
Date: Thu, 30 Jul 2020 11:48:55 +0200
Message-Id: <20200730094857.175501-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Collin Walling <walling@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>

Paolo,

just one feature for the next merge window (diag318).
I have agreed with Heiko to carry the non-kvm pathc also via the kvm tree.

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-5.9-1

for you to fetch changes up to 23a60f834406c8e3805328b630d09d5546b460c1:

  s390/kvm: diagnose 0x318 sync and reset (2020-06-23 10:55:33 +0200)

----------------------------------------------------------------
KVM: s390: Enhancement for 5.9
- implement diagnose 318

----------------------------------------------------------------
Collin Walling (2):
      s390/setup: diag 318: refactor struct
      s390/kvm: diagnose 0x318 sync and reset

 arch/s390/include/asm/diag.h     |  6 ++----
 arch/s390/include/asm/kvm_host.h |  4 +++-
 arch/s390/include/uapi/asm/kvm.h |  7 +++++--
 arch/s390/kernel/setup.c         |  3 +--
 arch/s390/kvm/kvm-s390.c         | 11 ++++++++++-
 arch/s390/kvm/vsie.c             |  1 +
 include/uapi/linux/kvm.h         |  1 +
 7 files changed, 23 insertions(+), 10 deletions(-)
