From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/2] KVM: s390: Fix memory leak on busy SIGP stop
Date: Thu, 31 Jul 2014 09:59:01 +0200
Message-ID: <1406793542-3043-2-git-send-email-borntraeger@de.ibm.com>
References: <1406793542-3043-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1406793542-3043-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Gleb Natapov <gleb@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

commit 7dfc63cf977447e09b1072911c22564f900fc578
(KVM: s390: allow only one SIGP STOP (AND STORE STATUS) at a time)
introduced a memory leak if a sigp stop is already pending. Free
the allocated inti structure.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
---
 arch/s390/kvm/sigp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index c6f1c2b..cf243ba 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -139,6 +139,7 @@ static int __inject_sigp_stop(struct kvm_vcpu *dst_vcpu, int action)
 	spin_lock(&li->lock);
 	if (li->action_bits & ACTION_STOP_ON_STOP) {
 		/* another SIGP STOP is pending */
+		kfree(inti);
 		rc = SIGP_CC_BUSY;
 		goto out;
 	}
-- 
1.8.4.2
