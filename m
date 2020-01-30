Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22460 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726873AbgA3Lml (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Jan 2020 06:42:41 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v2] KVM: s390: do not clobber user space registers during guest reset/store status
Date: Thu, 30 Jan 2020 12:42:32 +0100
Message-Id: <1580384552-7964-1-git-send-email-borntraeger@de.ibm.com>
In-Reply-To: <7d031d9c-e2f6-73bf-c4d6-6e2753d9102f@de.ibm.com>
References: <7d031d9c-e2f6-73bf-c4d6-6e2753d9102f@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: borntraeger@de.ibm.com
Cc: cohuck@redhat.com, david@redhat.com, frankja@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, stable@kernel.org, thuth@redhat.com

The two ioctls for initial CPU reset and store status currently clobber
the userspace fpc and potentially access registers. This was an
oversight during a fixup for the lazy fpu reloading rework.  The reset
calls are only done from userspace ioctls.  No CPU context is loaded, so
we can (and must) act directly on the sync regs, not on the thread
context. Otherwise the fpu restore call will restore the zeroes fpc to
userspace.

Cc: stable@kernel.org
Fixes: e1788bb995be ("KVM: s390: handle floating point registers in the run ioctl not in vcpu_put/load")
Fixes: 31d8b8d41a7e ("KVM: s390: handle access registers in the run ioctl not in vcpu_put/load")
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index c059b86..936415b 100644
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
@@ -4343,7 +4342,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	switch (ioctl) {
 	case KVM_S390_STORE_STATUS:
 		idx = srcu_read_lock(&vcpu->kvm->srcu);
-		r = kvm_s390_vcpu_store_status(vcpu, arg);
+		r = kvm_s390_vcpu_store_status_unloaded(vcpu, arg);
 		srcu_read_unlock(&vcpu->kvm->srcu, idx);
 		break;
 	case KVM_S390_SET_INITIAL_PSW: {
-- 
1.8.3.1
