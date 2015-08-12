From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 2/2] KVM: s390: Fix assumption that kvm_set_irq_routing is always run successfully
Date: Wed, 12 Aug 2015 20:49:29 +0200
Message-ID: <1439405369-60552-3-git-send-email-borntraeger@de.ibm.com>
References: <1439405369-60552-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1439405369-60552-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Nicholas Krause <xerofoify@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Nicholas Krause <xerofoify@gmail.com>

This fixes the assumption that kvm_set_irq_routing is always run
successfully by instead making it equal to the variable r which
we use for returning in the function kvm_arch_vm_ioctl instead
of making r equal to zero when calling this particular function
and incorrectly making the caller of kvm_arch_vm_ioctl think
the function has run successfully.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
Message-Id: <1438880754-27149-1-git-send-email-xerofoify@gmail.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 4bdb860..397b88d 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -962,8 +962,7 @@ long kvm_arch_vm_ioctl(struct file *filp,
 		if (kvm->arch.use_irqchip) {
 			/* Set up dummy routing. */
 			memset(&routing, 0, sizeof(routing));
-			kvm_set_irq_routing(kvm, &routing, 0, 0);
-			r = 0;
+			r = kvm_set_irq_routing(kvm, &routing, 0, 0);
 		}
 		break;
 	}
-- 
2.3.0
