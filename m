Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:3732 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727075AbfH2KyG (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 29 Aug 2019 06:54:06 -0400
From: Thomas Huth <thuth@redhat.com>
Subject: [PATCH] KVM: s390: Test for bad access register at the start of S390_MEM_OP
Date: Thu, 29 Aug 2019 12:53:56 +0200
Message-Id: <20190829105356.27805-1-thuth@redhat.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

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

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/s390/kvm/kvm-s390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index f329dcb3f44c..725690853cbd 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -4255,7 +4255,7 @@ static long kvm_s390_guest_mem_op(struct kvm_vcpu *vcpu,
 	const u64 supported_flags = KVM_S390_MEMOP_F_INJECT_EXCEPTION
 				    | KVM_S390_MEMOP_F_CHECK_ONLY;
 
-	if (mop->flags & ~supported_flags)
+	if (mop->flags & ~supported_flags || mop->ar >= NUM_ACRS)
 		return -EINVAL;
 
 	if (mop->size > MEM_OP_MAX_SIZE)
-- 
2.18.1
