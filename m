From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/2] KVM: s390: call exit_sie() directly on vcpu block/request
Date: Tue,  2 Jun 2015 10:14:09 +0200
Message-ID: <1433232850-9578-2-git-send-email-borntraeger@de.ibm.com>
References: <1433232850-9578-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1433232850-9578-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Thinking about it, I can't find a real use case where we want
to block a VCPU and not kick it out of SIE. (except if we want
to do the same in batch for multiple VCPUs - but that's a micro
optimization)

So let's simply perform the exit_sie() calls directly when setting
the other magic block bits in the SIE.

Otherwise e.g. kvm_s390_set_tod_low() still has other VCPUs running
after that call, working with a wrong epoch.

Fixes: 27406cd50c ("KVM: s390: provide functions for blocking all CPUs")
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 6bc69ab..f37557b 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1417,6 +1417,7 @@ int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu)
 void kvm_s390_vcpu_block(struct kvm_vcpu *vcpu)
 {
 	atomic_set_mask(PROG_BLOCK_SIE, &vcpu->arch.sie_block->prog20);
+	exit_sie(vcpu);
 }
 
 void kvm_s390_vcpu_unblock(struct kvm_vcpu *vcpu)
@@ -1427,6 +1428,7 @@ void kvm_s390_vcpu_unblock(struct kvm_vcpu *vcpu)
 static void kvm_s390_vcpu_request(struct kvm_vcpu *vcpu)
 {
 	atomic_set_mask(PROG_REQUEST, &vcpu->arch.sie_block->prog20);
+	exit_sie(vcpu);
 }
 
 static void kvm_s390_vcpu_request_handled(struct kvm_vcpu *vcpu)
@@ -1450,7 +1452,6 @@ void kvm_s390_sync_request(int req, struct kvm_vcpu *vcpu)
 {
 	kvm_make_request(req, vcpu);
 	kvm_s390_vcpu_request(vcpu);
-	exit_sie(vcpu);
 }
 
 static void kvm_gmap_notifier(struct gmap *gmap, unsigned long address)
-- 
2.3.0
