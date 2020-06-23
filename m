Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1942 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731945AbgFWJbA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 23 Jun 2020 05:31:00 -0400
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [GIT PULL 0/1] KVM: s390: Fix for 5.8
Date: Tue, 23 Jun 2020 11:23:40 +0200
Message-Id: <20200623092341.10348-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, frankja@linux.vnet.ibm.com, david@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com

Hi Paolo,

please pull this fix reducing the number of (currently unused) iopins
for kvm/master.


The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/kvm-s390-master-5.8-3

for you to fetch changes up to 774911290c589e98e3638e73b24b0a4d4530e97c:

  KVM: s390: reduce number of IO pins to 1 (2020-06-18 09:48:19 +0200)

----------------------------------------------------------------
The current number of KVM_IRQCHIP_NUM_PINS results in an order 3
allocation (32kb) for each guest start/restart which can result in OOM
killer activity when kernel memory is fragmented enough.

This fix reduces the number of iopins as s390 doesn't use them, hence
reducing the memory footprint.

----------------------------------------------------------------

Christian Borntraeger (1):
  KVM: s390: reduce number of IO pins to 1

 arch/s390/include/asm/kvm_host.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.25.4
