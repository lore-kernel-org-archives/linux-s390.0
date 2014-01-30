From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PULL 6/8] KVM: async_pf: Allow to wait for outstanding work
Date: Thu, 30 Jan 2014 13:53:47 +0100
Message-ID: <1391086429-43935-7-git-send-email-borntraeger@de.ibm.com>
References: <1391086429-43935-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1391086429-43935-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Alexander Graf <agraf@suse.de>, Dominik Dingel <dingel@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Dominik Dingel <dingel@linux.vnet.ibm.com>

On s390 we are not able to cancel work. Instead we will flush the work and wait for
completion.

Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 virt/kvm/async_pf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/virt/kvm/async_pf.c b/virt/kvm/async_pf.c
index 00980ab..889aad0 100644
--- a/virt/kvm/async_pf.c
+++ b/virt/kvm/async_pf.c
@@ -113,11 +113,16 @@ void kvm_clear_async_pf_completion_queue(struct kvm_vcpu *vcpu)
 			list_entry(vcpu->async_pf.queue.next,
 				   typeof(*work), queue);
 		list_del(&work->queue);
+
+#ifdef CONFIG_KVM_ASYNC_PF_SYNC
+		flush_work(&work->work);
+#else
 		if (cancel_work_sync(&work->work)) {
 			mmdrop(work->mm);
 			kvm_put_kvm(vcpu->kvm); /* == work->vcpu->kvm */
 			kmem_cache_free(async_pf_cache, work);
 		}
+#endif
 	}
 
 	spin_lock(&vcpu->async_pf.lock);
-- 
1.8.4.2
