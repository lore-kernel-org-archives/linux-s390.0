Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfILHDB (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Sep 2019 03:03:01 -0400
From: Thomas Huth <thuth@redhat.com>
Subject: [PATCH] KVM: s390: Remove unused parameter from __inject_sigp_restart()
Date: Thu, 12 Sep 2019 09:02:50 +0200
Message-Id: <20190912070250.15131-1-thuth@redhat.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

It's not required, so drop it to make it clear that this interrupt
does not have any extra parameters.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/s390/kvm/interrupt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index b5fd6e85657c..3e7efdd9228a 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1477,8 +1477,7 @@ static int __inject_sigp_stop(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 	return 0;
 }
 
-static int __inject_sigp_restart(struct kvm_vcpu *vcpu,
-				 struct kvm_s390_irq *irq)
+static int __inject_sigp_restart(struct kvm_vcpu *vcpu)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 
@@ -1997,7 +1996,7 @@ static int do_inject_vcpu(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 		rc = __inject_sigp_stop(vcpu, irq);
 		break;
 	case KVM_S390_RESTART:
-		rc = __inject_sigp_restart(vcpu, irq);
+		rc = __inject_sigp_restart(vcpu);
 		break;
 	case KVM_S390_INT_CLOCK_COMP:
 		rc = __inject_ckc(vcpu);
-- 
2.18.1
