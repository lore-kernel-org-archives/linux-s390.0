Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33740 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730309AbgCJNBs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 10 Mar 2020 09:01:48 -0400
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/5] selftests: KVM: s390: Accumulated fixes and extensions
Date: Tue, 10 Mar 2020 09:01:39 -0400
Message-Id: <20200310130144.9921-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Andrew Jones <drjones@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

- do more and better testing for reset
- fix fprintf formats (thanks to Andrew Jones)

Paolo, I would schedule this for next and not for master. ok?

Christian Borntraeger (5):
  selftests: KVM: s390: fix early guest crash
  selftests: KVM: s390: test more register variants for the reset ioctl
  selftests: KVM: s390: check for registers to NOT change on reset
  selftests: KVM: s390: fixup fprintf format error in reset.c
  selftests: KVM: s390: fix format strings for access reg test

 tools/testing/selftests/kvm/s390x/resets.c    | 132 ++++++++++++++----
 .../selftests/kvm/s390x/sync_regs_test.c      |  11 +-
 2 files changed, 116 insertions(+), 27 deletions(-)

-- 
2.25.0
