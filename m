Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42778 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726474AbfKNQXL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Nov 2019 11:23:11 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAEGLDB6071877
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 11:23:09 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w92jm6nwe-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 11:23:05 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 14 Nov 2019 16:22:03 -0000
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH] Fixup sida bouncing
Date: Thu, 14 Nov 2019 11:21:53 -0500
In-Reply-To: <ad0f9b90-3ce4-c2d2-b661-635fe439f7e2@redhat.com>
References: <ad0f9b90-3ce4-c2d2-b661-635fe439f7e2@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20191114162153.25349-1-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 0fa7c6d9ed0e..9820fde04887 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -4432,13 +4432,21 @@ static long kvm_s390_guest_mem_op(struct kvm_vcpu *vcpu,
 	if (mop->size > MEM_OP_MAX_SIZE)
 		return -E2BIG;
 
-	/* Protected guests move instruction data over the satellite
+	/*
+	 * Protected guests move instruction data over the satellite
 	 * block which has its own size limit
 	 */
 	if (kvm_s390_pv_is_protected(vcpu->kvm) &&
-	    mop->size > ((vcpu->arch.sie_block->sidad & 0x0f) + 1) * PAGE_SIZE)
+	    mop->size > ((vcpu->arch.sie_block->sidad & 0xff) + 1) * PAGE_SIZE)
 		return -E2BIG;
 
+	/* We can currently only offset into the one SIDA page. */
+	if (kvm_s390_pv_is_protected(vcpu->kvm)) {
+		mop->gaddr &= ~PAGE_MASK;
+		if (mop->gaddr + mop->size > PAGE_SIZE)
+			return -EINVAL;
+	}
+
 	if (!(mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY)) {
 		tmpbuf = vmalloc(mop->size);
 		if (!tmpbuf)
@@ -4451,6 +4459,7 @@ static long kvm_s390_guest_mem_op(struct kvm_vcpu *vcpu,
 	case KVM_S390_MEMOP_LOGICAL_READ:
 		if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
 			if (kvm_s390_pv_is_protected(vcpu->kvm)) {
+				/* We can always copy into the SIDA */
 				r = 0;
 				break;
 			}
@@ -4461,8 +4470,7 @@ static long kvm_s390_guest_mem_op(struct kvm_vcpu *vcpu,
 		if (kvm_s390_pv_is_protected(vcpu->kvm)) {
 			r = 0;
 			if (copy_to_user(uaddr, (void *)vcpu->arch.sie_block->sidad +
-					 (mop->gaddr & ~PAGE_MASK),
-					 mop->size))
+					 mop->gaddr, mop->size))
 				r = -EFAULT;
 			break;
 		}
@@ -4485,8 +4493,7 @@ static long kvm_s390_guest_mem_op(struct kvm_vcpu *vcpu,
 		if (kvm_s390_pv_is_protected(vcpu->kvm)) {
 			r = 0;
 			if (copy_from_user((void *)vcpu->arch.sie_block->sidad +
-					   (mop->gaddr & ~PAGE_MASK), uaddr,
-					   mop->size))
+					   mop->gaddr, uaddr, mop->size))
 				r = -EFAULT;
 			break;
 		}
-- 
2.20.1
