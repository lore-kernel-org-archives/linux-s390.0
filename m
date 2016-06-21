From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 48/51] KVM: s390: vsie: speed up VCPU external calls
Date: Tue, 21 Jun 2016 15:13:26 +0200
Message-ID: <1466514809-146638-49-git-send-email-borntraeger@de.ibm.com>
References: <1466514809-146638-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1466514809-146638-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Whenever a SIGP external call is injected via the SIGP external call
interpretation facility, the VCPU is not kicked. When a VCPU is currently
in the VSIE, the external call might not be processed immediately.

Therefore we have to provoke partial execution exceptions, which leads to a
kick of the VCPU and therefore also kick out of VSIE. This is done by
simulating the WAIT state. This bit has no other side effects.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/vsie.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index c8c8763..90781ba 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -844,6 +844,11 @@ static void register_shadow_scb(struct kvm_vcpu *vcpu,
 				struct vsie_page *vsie_page)
 {
 	WRITE_ONCE(vcpu->arch.vsie_block, &vsie_page->scb_s);
+	/*
+	 * External calls have to lead to a kick of the vcpu and
+	 * therefore the vsie -> Simulate Wait state.
+	 */
+	atomic_or(CPUSTAT_WAIT, &vcpu->arch.sie_block->cpuflags);
 }
 
 /*
@@ -851,6 +856,7 @@ static void register_shadow_scb(struct kvm_vcpu *vcpu,
  */
 static void unregister_shadow_scb(struct kvm_vcpu *vcpu)
 {
+	atomic_andnot(CPUSTAT_WAIT, &vcpu->arch.sie_block->cpuflags);
 	WRITE_ONCE(vcpu->arch.vsie_block, NULL);
 }
 
-- 
2.5.5
