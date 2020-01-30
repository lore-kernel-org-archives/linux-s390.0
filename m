Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34802 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727132AbgA3IzH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Jan 2020 03:55:07 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/FIXUP FOR STABLE BEFORE THIS SERIES] KVM: s390: do not clobber user space fpc during guest reset
Date: Thu, 30 Jan 2020 09:55:00 +0100
Message-Id: <1580374500-31247-1-git-send-email-borntraeger@de.ibm.com>
In-Reply-To: <20200129200312.3200-2-frankja@linux.ibm.com>
References: <20200129200312.3200-2-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: frankja@linux.ibm.com
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, stable@kernel.org

The initial CPU reset currently clobbers the userspace fpc. This was an
oversight during a fixup for the lazy fpu reloading rework.  The reset
calls are only done from userspace ioctls. No CPU context is loaded, so
we can (and must) act directly on the sync regs, not on the thread
context. Otherwise the fpu restore call will restore the zeroes fpc to
userspace.

Cc: stable@kernel.org
Fixes: 9abc2a08a7d6 ("KVM: s390: fix memory overwrites when vx is disabled")
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index c059b86..eb789cd 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2824,8 +2824,7 @@ static void kvm_s390_vcpu_initial_reset(struct kvm_vcpu *vcpu)
 	vcpu->arch.sie_block->gcr[14] = CR14_UNUSED_32 |
 					CR14_UNUSED_33 |
 					CR14_EXTERNAL_DAMAGE_SUBMASK;
-	/* make sure the new fpc will be lazily loaded */
-	save_fpu_regs();
+	vcpu->run->s.regs.fpc = 0;
 	current->thread.fpu.fpc = 0;
 	vcpu->arch.sie_block->gbea = 1;
 	vcpu->arch.sie_block->pp = 0;
-- 
1.8.3.1
