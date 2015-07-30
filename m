From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/1] KVM: s390: Fix hang VCPU hang/loop regression
Date: Thu, 30 Jul 2015 13:22:46 +0200
Message-ID: <1438255366-25805-2-git-send-email-borntraeger@de.ibm.com>
References: <1438255366-25805-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1438255366-25805-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

commit 785dbef407d8 ("KVM: s390: optimize round trip time in request
handling") introduced a regression. This regression was seen with
CPU hotplug in the guest and switching between 1 or 2 CPUs. This will
set/reset the IBS control via synced request.

Whenever we make a synced request, we first set the vcpu->requests
bit and then block the vcpu. The handler, on the other hand, unblocks
itself, processes vcpu->requests (by clearing them) and unblocks itself
once again.

Now, if the requester sleeps between setting of vcpu->requests and
blocking, the handler will clear the vcpu->requests bit and try to
unblock itself (although no bit is set). When the requester wakes up,
it blocks the VCPU and we have a blocked VCPU without requests.

Solution is to always unset the block bit.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Fixes: 785dbef407d8 ("KVM: s390: optimize round trip time in request handling")
---
 arch/s390/kvm/kvm-s390.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 2078f92..f32f843 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1742,10 +1742,10 @@ static bool ibs_enabled(struct kvm_vcpu *vcpu)
 
 static int kvm_s390_handle_requests(struct kvm_vcpu *vcpu)
 {
-	if (!vcpu->requests)
-		return 0;
 retry:
 	kvm_s390_vcpu_request_handled(vcpu);
+	if (!vcpu->requests)
+		return 0;
 	/*
 	 * We use MMU_RELOAD just to re-arm the ipte notifier for the
 	 * guest prefix page. gmap_ipte_notify will wait on the ptl lock.
-- 
2.3.0
