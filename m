From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 32/51] KVM: s390: vsie: support host-protection-interruption
Date: Tue, 21 Jun 2016 15:13:10 +0200
Message-ID: <1466514809-146638-33-git-send-email-borntraeger@de.ibm.com>
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

Introduced with ESOP, therefore available for the guest if it
is allowed to use ESOP.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/vsie.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 7c9835b..aaed63c 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -240,6 +240,9 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 
 	/* MVPG and Protection Exception Interpretation are always available */
 	scb_s->eca |= scb_o->eca & 0x01002000U;
+	/* Host-protection-interruption introduced with ESOP */
+	if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_ESOP))
+		scb_s->ecb |= scb_o->ecb & 0x02U;
 
 	prepare_ibc(vcpu, vsie_page);
 out:
-- 
2.5.5
