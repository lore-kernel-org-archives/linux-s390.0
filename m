From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 5/7] KVM: s390: get rid of constant condition in ipte_unlock_simple
Date: Wed, 10 Sep 2014 15:53:52 +0200
Message-ID: <1410357234-8937-6-git-send-email-borntraeger@de.ibm.com>
References: <1410357234-8937-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1410357234-8937-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Due to the earlier check we know that ipte_lock_count must be 0.
No need to add a useless if. Let's make clear that we are going
to always wakeup when we execute that code.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 arch/s390/kvm/gaccess.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 4653ac6..0f961a1 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -254,8 +254,7 @@ static void ipte_unlock_simple(struct kvm_vcpu *vcpu)
 		new = old = ACCESS_ONCE(*ic);
 		new.k = 0;
 	} while (cmpxchg(&ic->val, old.val, new.val) != old.val);
-	if (!ipte_lock_count)
-		wake_up(&vcpu->kvm->arch.ipte_wq);
+	wake_up(&vcpu->kvm->arch.ipte_wq);
 out:
 	mutex_unlock(&ipte_mutex);
 }
-- 
1.8.4.2
