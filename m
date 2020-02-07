Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30522 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727121AbgBGLkI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 7 Feb 2020 06:40:08 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 24/35] KVM: s390: protvirt: disallow one_reg
Date: Fri,  7 Feb 2020 06:39:47 -0500
Message-Id: <20200207113958.7320-25-borntraeger@de.ibm.com>
In-Reply-To: <20200207113958.7320-1-borntraeger@de.ibm.com>
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

From: Janosch Frank <frankja@linux.ibm.com>

A lot of the registers are controlled by the Ultravisor and never
visible to KVM. Some fields in the sie control block are overlayed,
like gbea. As no userspace uses the ONE_REG interface on s390 it is safe
to disable this for protected guests.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
[borntraeger@de.ibm.com: patch merging, splitting, fixing]
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virt/kvm/api.txt | 6 ++++--
 arch/s390/kvm/kvm-s390.c       | 3 +++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/virt/kvm/api.txt b/Documentation/virt/kvm/api.txt
index 4874d42286ca..4bee7c023426 100644
--- a/Documentation/virt/kvm/api.txt
+++ b/Documentation/virt/kvm/api.txt
@@ -1918,7 +1918,8 @@ Parameters: struct kvm_one_reg (in)
 Returns: 0 on success, negative value on failure
 Errors:
   ENOENT:   no such register
-  EINVAL:   invalid register ID, or no such register
+  EINVAL:   invalid register ID, or no such register, ONE_REG forbidden
+            for protected guests (s390).
   EPERM:    (arm64) register access not allowed before vcpu finalization
 (These error codes are indicative only: do not rely on a specific error
 code being returned in a specific situation.)
@@ -2311,7 +2312,8 @@ Parameters: struct kvm_one_reg (in and out)
 Returns: 0 on success, negative value on failure
 Errors include:
   ENOENT:   no such register
-  EINVAL:   invalid register ID, or no such register
+  EINVAL:   invalid register ID, or no such register, ONE_REG forbidden
+            for protected guests (s390)
   EPERM:    (arm64) register access not allowed before vcpu finalization
 (These error codes are indicative only: do not rely on a specific error
 code being returned in a specific situation.)
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 63d158149936..f995040102ea 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -4649,6 +4649,9 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	case KVM_SET_ONE_REG:
 	case KVM_GET_ONE_REG: {
 		struct kvm_one_reg reg;
+		r = -EINVAL;
+		if (kvm_s390_pv_is_protected(vcpu->kvm))
+			break;
 		r = -EFAULT;
 		if (copy_from_user(&reg, argp, sizeof(reg)))
 			break;
-- 
2.24.0
