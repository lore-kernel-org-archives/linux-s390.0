From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 13/16] KVM: s390: improve debug feature usage
Date: Wed, 29 Jul 2015 11:06:03 +0200
Message-ID: <1438160766-108179-14-git-send-email-borntraeger@de.ibm.com>
References: <1438160766-108179-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1438160766-108179-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

We do not use the exception logger, so the 2nd area is unused.
Just have one area that is bigger (32 pages).
At the same time we can limit the debug feature size to 7
longs, as the largest user has 3 parameters + string + boiler
plate (vCPU, PSW mask, PSW addr)

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index b623267..4c1b5cb 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1057,7 +1057,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 	sprintf(debug_name, "kvm-%u", current->pid);
 
-	kvm->arch.dbf = debug_register(debug_name, 8, 2, 8 * sizeof(long));
+	kvm->arch.dbf = debug_register(debug_name, 32, 1, 7 * sizeof(long));
 	if (!kvm->arch.dbf)
 		goto out_err;
 
-- 
2.3.0
