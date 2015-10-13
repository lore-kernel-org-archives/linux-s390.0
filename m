From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 01/10] KVM: s390: remove unused variable in __inject_vm
Date: Tue, 13 Oct 2015 16:05:59 +0200
Message-ID: <1444745168-21479-2-git-send-email-borntraeger@de.ibm.com>
References: <1444745168-21479-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1444745168-21479-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

the float int structure is no longer used in __inject_vm.

Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 5c2c169..ab9f525 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1390,12 +1390,9 @@ static void __floating_irq_kick(struct kvm *kvm, u64 type)
 
 static int __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 {
-	struct kvm_s390_float_interrupt *fi;
 	u64 type = READ_ONCE(inti->type);
 	int rc;
 
-	fi = &kvm->arch.float_int;
-
 	switch (type) {
 	case KVM_S390_MCHK:
 		rc = __inject_float_mchk(kvm, inti);
-- 
2.4.3
