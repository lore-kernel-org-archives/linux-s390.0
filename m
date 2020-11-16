Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35202 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727027AbgKPMUk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 16 Nov 2020 07:20:40 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/2] KVM: s390: Fixes for 5.10
Date: Mon, 16 Nov 2020 13:20:31 +0100
Message-Id: <20201116122033.382372-1-borntraeger@de.ibm.com>
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Collin Walling <walling@linux.ibm.com>

Paolo,

2 fixes for KVM on s390 for 5.10.

The following changes since commit 6d6a18fdde8b86b919b740ad629153de432d12a8:

  KVM: selftests: allow two iterations of dirty_log_perf_test (2020-11-09 09:45:17 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-5.10-1

for you to fetch changes up to 6cbf1e960fa52e4c63a6dfa4cda8736375b34ccc:

  KVM: s390: remove diag318 reset code (2020-11-11 09:31:52 +0100)

----------------------------------------------------------------
KVM: s390: Fixes for 5.10

- do not reset the global diag318 data for per-cpu reset
- do not mark memory as protected too early

----------------------------------------------------------------
Collin Walling (1):
      KVM: s390: remove diag318 reset code

Janosch Frank (1):
      KVM: s390: pv: Mark mm as protected after the set secure parameters and improve cleanup

 arch/s390/kvm/kvm-s390.c | 4 +---
 arch/s390/kvm/pv.c       | 3 ++-
 arch/s390/mm/gmap.c      | 2 ++
 3 files changed, 5 insertions(+), 4 deletions(-)
