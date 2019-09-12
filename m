Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50806 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732085AbfILNjb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Sep 2019 09:39:31 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8CDWaeU137468
        for <linux-s390@vger.kernel.org>; Thu, 12 Sep 2019 09:39:29 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uyptmgq32-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 12 Sep 2019 09:39:29 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 12 Sep 2019 14:39:27 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 2/2] KVM: s390: Do not leak kernel stack data in the KVM_S390_INTERRUPT ioctl
Date: Thu, 12 Sep 2019 15:39:21 +0200
In-Reply-To: <20190912133921.6886-1-borntraeger@de.ibm.com>
References: <20190912133921.6886-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190912133921.6886-3-borntraeger@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>

From: Thomas Huth <thuth@redhat.com>

When the userspace program runs the KVM_S390_INTERRUPT ioctl to inject
an interrupt, we convert them from the legacy struct kvm_s390_interrupt
to the new struct kvm_s390_irq via the s390int_to_s390irq() function.
However, this function does not take care of all types of interrupts
that we can inject into the guest later (see do_inject_vcpu()). Since we
do not clear out the s390irq values before calling s390int_to_s390irq(),
there is a chance that we copy random data from the kernel stack which
could be leaked to the userspace later.

Specifically, the problem exists with the KVM_S390_INT_PFAULT_INIT
interrupt: s390int_to_s390irq() does not handle it, and the function
__inject_pfault_init() later copies irq->u.ext which contains the
random kernel stack data. This data can then be leaked either to
the guest memory in __deliver_pfault_init(), or the userspace might
retrieve it directly with the KVM_S390_GET_IRQ_STATE ioctl.

Fix it by handling that interrupt type in s390int_to_s390irq(), too,
and by making sure that the s390irq struct is properly pre-initialized.
And while we're at it, make sure that s390int_to_s390irq() now
directly returns -EINVAL for unknown interrupt types, so that we
immediately get a proper error code in case we add more interrupt
types to do_inject_vcpu() without updating s390int_to_s390irq()
sometime in the future.

Cc: stable@vger.kernel.org
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Link: https://lore.kernel.org/kvm/20190912115438.25761-1-thuth@redhat.com
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 10 ++++++++++
 arch/s390/kvm/kvm-s390.c  |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index b5fd6e85657c..d1ccc168c071 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1961,6 +1961,16 @@ int s390int_to_s390irq(struct kvm_s390_interrupt *s390int,
 	case KVM_S390_MCHK:
 		irq->u.mchk.mcic = s390int->parm64;
 		break;
+	case KVM_S390_INT_PFAULT_INIT:
+		irq->u.ext.ext_params = s390int->parm;
+		irq->u.ext.ext_params2 = s390int->parm64;
+		break;
+	case KVM_S390_RESTART:
+	case KVM_S390_INT_CLOCK_COMP:
+	case KVM_S390_INT_CPU_TIMER:
+		break;
+	default:
+		return -EINVAL;
 	}
 	return 0;
 }
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index b298fcc9ec56..0d697b436f2b 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -4335,7 +4335,7 @@ long kvm_arch_vcpu_async_ioctl(struct file *filp,
 	}
 	case KVM_S390_INTERRUPT: {
 		struct kvm_s390_interrupt s390int;
-		struct kvm_s390_irq s390irq;
+		struct kvm_s390_irq s390irq = {};
 
 		if (copy_from_user(&s390int, argp, sizeof(s390int)))
 			return -EFAULT;
-- 
2.21.0
