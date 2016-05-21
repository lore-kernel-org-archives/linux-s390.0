From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 0249/1529] Fix typo
Date: Sat, 21 May 2016 14:08:55 +0200
Message-ID: <20160521120855.12988-1-andrea.gelmini@gelma.net>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, pbonzini@redhat.com, rkrcmar@redhat.com, borntraeger@de.ibm.com, cornelia.huck@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/s390/kvm/guestdbg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/guestdbg.c
index e8c6843..1e0849e 100644
--- a/arch/s390/kvm/guestdbg.c
+++ b/arch/s390/kvm/guestdbg.c
@@ -465,7 +465,7 @@ static void filter_guest_per_event(struct kvm_vcpu *vcpu)
 		guest_perc &= ~PER_EVENT_IFETCH;
 
 	/* All other PER events will be given to the guest */
-	/* TODO: Check alterated address/address space */
+	/* TODO: Check altered address/address space */
 
 	vcpu->arch.sie_block->perc = guest_perc >> 24;
 
-- 
2.8.2.534.g1f66975
