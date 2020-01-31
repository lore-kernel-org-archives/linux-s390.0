Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57578 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728350AbgAaKCU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 31 Jan 2020 05:02:20 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00V9s1wu100994
        for <linux-s390@vger.kernel.org>; Fri, 31 Jan 2020 05:02:19 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xv7e2k2nr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 31 Jan 2020 05:02:19 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Fri, 31 Jan 2020 10:02:17 -0000
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH v10 1/6] KVM: s390: do not clobber registers during guest reset/store status
Date: Fri, 31 Jan 2020 05:02:00 -0500
In-Reply-To: <20200131100205.74720-1-frankja@linux.ibm.com>
References: <20200131100205.74720-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200131100205.74720-2-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, cohuck@redhat.com, linux-s390@vger.kernel.org

From: Christian Borntraeger <borntraeger@de.ibm.com>

The initial CPU reset clobbers the userspace fpc and the store status
ioctl clobbers the guest acrs + fpr.  As these calls are only done via
ioctl (and not via vcpu_run), no CPU context is loaded, so we can (and
must) act directly on the sync regs, not on the thread context.

Cc: stable@kernel.org
Fixes: e1788bb995be ("KVM: s390: handle floating point registers in the run ioctl not in vcpu_put/load")
Fixes: 31d8b8d41a7e ("KVM: s390: handle access registers in the run ioctl not in vcpu_put/load")
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index d9e6bf3d54f0..876802894b35 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2860,9 +2860,7 @@ static void kvm_s390_vcpu_initial_reset(struct kvm_vcpu *vcpu)
 	vcpu->arch.sie_block->gcr[14] = CR14_UNUSED_32 |
 					CR14_UNUSED_33 |
 					CR14_EXTERNAL_DAMAGE_SUBMASK;
-	/* make sure the new fpc will be lazily loaded */
-	save_fpu_regs();
-	current->thread.fpu.fpc = 0;
+	vcpu->run->s.regs.fpc = 0;
 	vcpu->arch.sie_block->gbea = 1;
 	vcpu->arch.sie_block->pp = 0;
 	vcpu->arch.sie_block->fpf &= ~FPF_BPBC;
@@ -4351,7 +4349,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	switch (ioctl) {
 	case KVM_S390_STORE_STATUS:
 		idx = srcu_read_lock(&vcpu->kvm->srcu);
-		r = kvm_s390_vcpu_store_status(vcpu, arg);
+		r = kvm_s390_store_status_unloaded(vcpu, arg);
 		srcu_read_unlock(&vcpu->kvm->srcu, idx);
 		break;
 	case KVM_S390_SET_INITIAL_PSW: {
-- 
2.20.1
