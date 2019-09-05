Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10556 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732758AbfIEIkm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 Sep 2019 04:40:42 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x858baC2051714
        for <linux-s390@vger.kernel.org>; Thu, 5 Sep 2019 04:40:40 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2utx8r27uc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 05 Sep 2019 04:40:40 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 5 Sep 2019 09:40:38 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [GIT PULL 4/8] KVM: s390: Test for bad access register and size at the start of S390_MEM_OP
Date: Thu,  5 Sep 2019 10:40:05 +0200
In-Reply-To: <20190905084009.26106-1-frankja@linux.ibm.com>
References: <20190905084009.26106-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190905084009.26106-5-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: pbonzini@redhat.com, rkrcmar@redhat.com
Cc: kvm@vger.kernel.org, cohuck@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, frankja@linux.vnet.ibm.com, david@redhat.com, thuth@redhat.com

From: Thomas Huth <thuth@redhat.com>

If the KVM_S390_MEM_OP ioctl is called with an access register >= 16,
then there is certainly a bug in the calling userspace application.
We check for wrong access registers, but only if the vCPU was already
in the access register mode before (i.e. the SIE block has recorded
it). The check is also buried somewhere deep in the calling chain (in
the function ar_translation()), so this is somewhat hard to find.

It's better to always report an error to the userspace in case this
field is set wrong, and it's safer in the KVM code if we block wrong
values here early instead of relying on a check somewhere deep down
the calling chain, so let's add another check to kvm_s390_guest_mem_op()
directly.

We also should check that the "size" is non-zero here (thanks to Janosch
Frank for the hint!). If we do not check the size, we could call vmalloc()
with this 0 value, and this will cause a kernel warning.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Link: https://lkml.kernel.org/r/20190829122517.31042-1-thuth@redhat.com
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 3f520cd837fb..d41c091546b7 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -4265,7 +4265,7 @@ static long kvm_s390_guest_mem_op(struct kvm_vcpu *vcpu,
 	const u64 supported_flags = KVM_S390_MEMOP_F_INJECT_EXCEPTION
 				    | KVM_S390_MEMOP_F_CHECK_ONLY;
 
-	if (mop->flags & ~supported_flags)
+	if (mop->flags & ~supported_flags || mop->ar >= NUM_ACRS || !mop->size)
 		return -EINVAL;
 
 	if (mop->size > MEM_OP_MAX_SIZE)
-- 
2.20.1
