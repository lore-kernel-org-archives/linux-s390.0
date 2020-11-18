Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15314 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726298AbgKRRBY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Nov 2020 12:01:24 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/2] KVM: s390: Fix for destroy page ultravisor call
Date: Wed, 18 Nov 2020 18:01:14 +0100
Message-Id: <20201118170116.8239-1-borntraeger@de.ibm.com>
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>

Paolo,

one more fix for 5.10 in addition with an update of the MAINTAINERS
file. The uv.c file is mostly used by KVM and Heiko asked that we take
care of this patch.

The following changes since commit 6cbf1e960fa52e4c63a6dfa4cda8736375b34ccc:

  KVM: s390: remove diag318 reset code (2020-11-11 09:31:52 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-5.10-2

for you to fetch changes up to 735931f9a51ab09cf795721b37696b420484625f:

  MAINTAINERS: add uv.c also to KVM/s390 (2020-11-18 13:09:21 +0100)

----------------------------------------------------------------
KVM: s390: Fix for destroy page ultravisor call

- handle response code from older firmware
- add uv.c to KVM: s390/s390 maintainer list

----------------------------------------------------------------
Christian Borntraeger (2):
      s390/uv: handle destroy page legacy interface
      MAINTAINERS: add uv.c also to KVM/s390

 MAINTAINERS           | 1 +
 arch/s390/kernel/uv.c | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)
