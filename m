Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15712 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727034AbgBTKkb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 20 Feb 2020 05:40:31 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v3 24/37] KVM: s390: protvirt: disallow one_reg
Date: Thu, 20 Feb 2020 05:40:07 -0500
Message-Id: <20200220104020.5343-25-borntraeger@de.ibm.com>
In-Reply-To: <20200220104020.5343-1-borntraeger@de.ibm.com>
References: <20200220104020.5343-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

From: Janosch Frank <frankja@linux.ibm.com>

A lot of the registers are controlled by the Ultravisor and never
visible to KVM. Some fields in the sie control block are overlayed, like
gbea. As no known userspace uses the ONE_REG interface on s390 if sync
regs are available, no functionality is lost if it is disabled for
protected guests.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
[borntraeger@de.ibm.com: patch merging, splitting, fixing]
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virt/kvm/api.rst | 6 ++++--
 arch/s390/kvm/kvm-s390.c       | 3 +++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 77e1edfe5d4c..58be7aba0db2 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -2117,7 +2117,8 @@ Errors:
 
   ======   ============================================================
   ENOENT   no such register
-  EINVAL   invalid register ID, or no such register
+  EINVAL   invalid register ID, or no such register or used with VMs in
+           protected virtualization mode on s390
   EPERM    (arm64) register access not allowed before vcpu finalization
   ======   ============================================================
 
@@ -2552,7 +2553,8 @@ Errors include:
 
   ======== ============================================================
   ENOENT   no such register
-  EINVAL   invalid register ID, or no such register
+  EINVAL   invalid register ID, or no such register or used with VMs in
+           protected virtualization mode on s390
   EPERM    (arm64) register access not allowed before vcpu finalization
   ======== ============================================================
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 4f7d70157b2c..436778d3dc14 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -4649,6 +4649,9 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	case KVM_SET_ONE_REG:
 	case KVM_GET_ONE_REG: {
 		struct kvm_one_reg reg;
+		r = -EINVAL;
+		if (kvm_s390_pv_cpu_is_protected(vcpu))
+			break;
 		r = -EFAULT;
 		if (copy_from_user(&reg, argp, sizeof(reg)))
 			break;
-- 
2.25.0
