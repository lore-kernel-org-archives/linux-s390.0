Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46010 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbfIDIwI (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 4 Sep 2019 04:52:08 -0400
From: Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 0/2] KVM: s390: Check for invalid bits in kvm_valid_regs and kvm_dirty_regs
Date: Wed,  4 Sep 2019 10:51:58 +0200
Message-Id: <20190904085200.29021-1-thuth@redhat.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

Avoid invalid bits in kvm_valid_regs and kvm_dirty_regs on s390x.

v2:
 - Split the single patch from v1 into two separate patches
   (I've kept the Reviewed-bys from v1, but if you don't agree with the
    patch description of the 2nd patch, please complain)

Thomas Huth (2):
  KVM: s390: Disallow invalid bits in kvm_valid_regs and kvm_dirty_regs
  KVM: selftests: Test invalid bits in kvm_valid_regs and kvm_dirty_regs
    on s390x

 arch/s390/include/uapi/asm/kvm.h              |  6 ++++
 arch/s390/kvm/kvm-s390.c                      |  4 +++
 .../selftests/kvm/s390x/sync_regs_test.c      | 30 +++++++++++++++++++
 3 files changed, 40 insertions(+)

-- 
2.18.1
