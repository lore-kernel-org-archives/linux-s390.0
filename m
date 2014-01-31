From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH] KVM: async_pf: Add missing call for async page present
Date: Fri, 31 Jan 2014 14:32:46 +0100
Message-ID: <1391175166-47032-2-git-send-email-borntraeger@de.ibm.com>
References: <52EBA166.5060805@redhat.com>
 <1391175166-47032-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1391175166-47032-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Alexander Graf <agraf@suse.de>, Dominik Dingel <dingel@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Dominik Dingel <dingel@linux.vnet.ibm.com>

Commit KVM: async_pf: Provide additional direct page notification
missed the call from kvm_check_async_pf_completion to the new introduced function.

Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
---
 virt/kvm/async_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/async_pf.c b/virt/kvm/async_pf.c
index 889aad0..10df100 100644
--- a/virt/kvm/async_pf.c
+++ b/virt/kvm/async_pf.c
@@ -151,7 +151,7 @@ void kvm_check_async_pf_completion(struct kvm_vcpu *vcpu)
 		spin_unlock(&vcpu->async_pf.lock);
 
 		kvm_arch_async_page_ready(vcpu, work);
-		kvm_arch_async_page_present(vcpu, work);
+		kvm_async_page_present_async(vcpu, work);
 
 		list_del(&work->queue);
 		vcpu->async_pf.queued--;
-- 
1.8.4.2
