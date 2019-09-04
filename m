Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48998 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbfIDIwL (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 4 Sep 2019 04:52:11 -0400
From: Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 1/2] KVM: s390: Disallow invalid bits in kvm_valid_regs and kvm_dirty_regs
Date: Wed,  4 Sep 2019 10:51:59 +0200
Message-Id: <20190904085200.29021-2-thuth@redhat.com>
In-Reply-To: <20190904085200.29021-1-thuth@redhat.com>
References: <20190904085200.29021-1-thuth@redhat.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

If unknown bits are set in kvm_valid_regs or kvm_dirty_regs, this
clearly indicates that something went wrong in the KVM userspace
application. The x86 variant of KVM already contains a check for
bad bits, so let's do the same on s390x now, too.

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/s390/include/uapi/asm/kvm.h | 6 ++++++
 arch/s390/kvm/kvm-s390.c         | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index 47104e5b47fd..436ec7636927 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -231,6 +231,12 @@ struct kvm_guest_debug_arch {
 #define KVM_SYNC_GSCB   (1UL << 9)
 #define KVM_SYNC_BPBC   (1UL << 10)
 #define KVM_SYNC_ETOKEN (1UL << 11)
+
+#define KVM_SYNC_S390_VALID_FIELDS \
+	(KVM_SYNC_PREFIX | KVM_SYNC_GPRS | KVM_SYNC_ACRS | KVM_SYNC_CRS | \
+	 KVM_SYNC_ARCH0 | KVM_SYNC_PFAULT | KVM_SYNC_VRS | KVM_SYNC_RICCB | \
+	 KVM_SYNC_FPRS | KVM_SYNC_GSCB | KVM_SYNC_BPBC | KVM_SYNC_ETOKEN)
+
 /* length and alignment of the sdnx as a power of two */
 #define SDNXC 8
 #define SDNXL (1UL << SDNXC)
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 49d7722229ae..a7d7dedfe527 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3998,6 +3998,10 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 	if (kvm_run->immediate_exit)
 		return -EINTR;
 
+	if (kvm_run->kvm_valid_regs & ~KVM_SYNC_S390_VALID_FIELDS ||
+	    kvm_run->kvm_dirty_regs & ~KVM_SYNC_S390_VALID_FIELDS)
+		return -EINVAL;
+
 	vcpu_load(vcpu);
 
 	if (guestdbg_exit_pending(vcpu)) {
-- 
2.18.1
