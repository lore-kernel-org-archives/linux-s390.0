Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36370 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729933AbgKPMUk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 16 Nov 2020 07:20:40 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/2] KVM: s390: pv: Mark mm as protected after the set secure parameters and improve cleanup
Date: Mon, 16 Nov 2020 13:20:32 +0100
Message-Id: <20201116122033.382372-2-borntraeger@de.ibm.com>
In-Reply-To: <20201116122033.382372-1-borntraeger@de.ibm.com>
References: <20201116122033.382372-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Collin Walling <walling@linux.ibm.com>

From: Janosch Frank <frankja@linux.ibm.com>

We can only have protected guest pages after a successful set secure
parameters call as only then the UV allows imports and unpacks.

By moving the test we can now also check for it in s390_reset_acc()
and do an early return if it is 0.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Fixes: 29b40f105ec8 ("KVM: s390: protvirt: Add initial vm and cpu lifecycle handling")
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 2 +-
 arch/s390/kvm/pv.c       | 3 ++-
 arch/s390/mm/gmap.c      | 2 ++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 6b74b92c1a58..08ea6c4735cd 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2312,7 +2312,7 @@ static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)
 		struct kvm_s390_pv_unp unp = {};
 
 		r = -EINVAL;
-		if (!kvm_s390_pv_is_protected(kvm))
+		if (!kvm_s390_pv_is_protected(kvm) || !mm_is_protected(kvm->mm))
 			break;
 
 		r = -EFAULT;
diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
index eb99e2f95ebe..f5847f9dec7c 100644
--- a/arch/s390/kvm/pv.c
+++ b/arch/s390/kvm/pv.c
@@ -208,7 +208,6 @@ int kvm_s390_pv_init_vm(struct kvm *kvm, u16 *rc, u16 *rrc)
 		return -EIO;
 	}
 	kvm->arch.gmap->guest_handle = uvcb.guest_handle;
-	atomic_set(&kvm->mm->context.is_protected, 1);
 	return 0;
 }
 
@@ -228,6 +227,8 @@ int kvm_s390_pv_set_sec_parms(struct kvm *kvm, void *hdr, u64 length, u16 *rc,
 	*rrc = uvcb.header.rrc;
 	KVM_UV_EVENT(kvm, 3, "PROTVIRT VM SET PARMS: rc %x rrc %x",
 		     *rc, *rrc);
+	if (!cc)
+		atomic_set(&kvm->mm->context.is_protected, 1);
 	return cc ? -EINVAL : 0;
 }
 
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index cfb0017f33a7..64795d034926 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2690,6 +2690,8 @@ static const struct mm_walk_ops reset_acc_walk_ops = {
 #include <linux/sched/mm.h>
 void s390_reset_acc(struct mm_struct *mm)
 {
+	if (!mm_is_protected(mm))
+		return;
 	/*
 	 * we might be called during
 	 * reset:                             we walk the pages and clear
-- 
2.28.0
