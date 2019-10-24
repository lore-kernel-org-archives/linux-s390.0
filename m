Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25590 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436576AbfJXLm1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 24 Oct 2019 07:42:27 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9OBb8bp137744
        for <linux-s390@vger.kernel.org>; Thu, 24 Oct 2019 07:42:27 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vub4qgeyc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 24 Oct 2019 07:42:25 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 24 Oct 2019 12:42:23 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [RFC 20/37] KVM: S390: protvirt: Introduce instruction data area bounce buffer
Date: Thu, 24 Oct 2019 07:40:42 -0400
In-Reply-To: <20191024114059.102802-1-frankja@linux.ibm.com>
References: <20191024114059.102802-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20191024114059.102802-21-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com, frankja@linux.ibm.com

Now that we can't access guest memory anymore, we have a dedicated
sattelite block that's a bounce buffer for instruction data.

We re-use the memop interface to copy the instruction data to / from
userspace. This lets us re-use a lot of QEMU code which used that
interface to make logical guest memory accesses which are not possible
anymore in protected mode anyway.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  5 ++++-
 arch/s390/kvm/kvm-s390.c         | 31 +++++++++++++++++++++++++++++++
 arch/s390/kvm/pv.c               |  9 +++++++++
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 5deabf9734d9..2a8a1e21e1c3 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -308,7 +308,10 @@ struct kvm_s390_sie_block {
 #define CRYCB_FORMAT2 0x00000003
 	__u32	crycbd;			/* 0x00fc */
 	__u64	gcr[16];		/* 0x0100 */
-	__u64	gbea;			/* 0x0180 */
+	union {
+		__u64	gbea;			/* 0x0180 */
+		__u64	sidad;
+	};
 	__u8    reserved188[8];		/* 0x0188 */
 	__u64   sdnxo;			/* 0x0190 */
 	__u8    reserved198[8];		/* 0x0198 */
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 97d3a81e5074..6747cb6cf062 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -4416,6 +4416,13 @@ static long kvm_s390_guest_mem_op(struct kvm_vcpu *vcpu,
 	if (mop->size > MEM_OP_MAX_SIZE)
 		return -E2BIG;
 
+	/* Protected guests move instruction data over the satellite
+	 * block which has its own size limit
+	 */
+	if (kvm_s390_pv_is_protected(vcpu->kvm) &&
+	    mop->size > ((vcpu->arch.sie_block->sidad & 0x0f) + 1) * PAGE_SIZE)
+		return -E2BIG;
+
 	if (!(mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY)) {
 		tmpbuf = vmalloc(mop->size);
 		if (!tmpbuf)
@@ -4427,10 +4434,22 @@ static long kvm_s390_guest_mem_op(struct kvm_vcpu *vcpu,
 	switch (mop->op) {
 	case KVM_S390_MEMOP_LOGICAL_READ:
 		if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
+			if (kvm_s390_pv_is_protected(vcpu->kvm)) {
+				r = 0;
+				break;
+			}
 			r = check_gva_range(vcpu, mop->gaddr, mop->ar,
 					    mop->size, GACC_FETCH);
 			break;
 		}
+		if (kvm_s390_pv_is_protected(vcpu->kvm)) {
+			r = 0;
+			if (copy_to_user(uaddr, (void *)vcpu->arch.sie_block->sidad +
+					 (mop->gaddr & ~PAGE_MASK),
+					 mop->size))
+				r = -EFAULT;
+			break;
+		}
 		r = read_guest(vcpu, mop->gaddr, mop->ar, tmpbuf, mop->size);
 		if (r == 0) {
 			if (copy_to_user(uaddr, tmpbuf, mop->size))
@@ -4439,10 +4458,22 @@ static long kvm_s390_guest_mem_op(struct kvm_vcpu *vcpu,
 		break;
 	case KVM_S390_MEMOP_LOGICAL_WRITE:
 		if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
+			if (kvm_s390_pv_is_protected(vcpu->kvm)) {
+				r = 0;
+				break;
+			}
 			r = check_gva_range(vcpu, mop->gaddr, mop->ar,
 					    mop->size, GACC_STORE);
 			break;
 		}
+		if (kvm_s390_pv_is_protected(vcpu->kvm)) {
+			r = 0;
+			if (copy_from_user((void *)vcpu->arch.sie_block->sidad +
+					   (mop->gaddr & ~PAGE_MASK), uaddr,
+					   mop->size))
+				r = -EFAULT;
+			break;
+		}
 		if (copy_from_user(tmpbuf, uaddr, mop->size)) {
 			r = -EFAULT;
 			break;
diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
index 383e660e2221..be7d558ab897 100644
--- a/arch/s390/kvm/pv.c
+++ b/arch/s390/kvm/pv.c
@@ -119,6 +119,7 @@ int kvm_s390_pv_destroy_cpu(struct kvm_vcpu *vcpu)
 
 	free_pages(vcpu->arch.pv.stor_base,
 		   get_order(uv_info.guest_cpu_stor_len));
+	free_page(vcpu->arch.sie_block->sidad);
 	/* Clear cpu and vm handle */
 	memset(&vcpu->arch.sie_block->reserved10, 0,
 	       sizeof(vcpu->arch.sie_block->reserved10));
@@ -150,6 +151,14 @@ int kvm_s390_pv_create_cpu(struct kvm_vcpu *vcpu)
 	uvcb.state_origin = (u64)vcpu->arch.sie_block;
 	uvcb.stor_origin = (u64)vcpu->arch.pv.stor_base;
 
+	/* Alloc Secure Instruction Data Area Designation */
+	vcpu->arch.sie_block->sidad = __get_free_page(GFP_KERNEL | __GFP_ZERO);
+	if (!vcpu->arch.sie_block->sidad) {
+		free_pages(vcpu->arch.pv.stor_base,
+			   get_order(uv_info.guest_cpu_stor_len));
+		return -ENOMEM;
+	}
+
 	rc = uv_call(0, (u64)&uvcb);
 	VCPU_EVENT(vcpu, 3, "PROTVIRT CREATE VCPU: cpu %d handle %llx rc %x rrc %x",
 		   vcpu->vcpu_id, uvcb.cpu_handle, uvcb.header.rc,
-- 
2.20.1
