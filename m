From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 30/51] KVM: s390: vsie: support setting the ibc
Date: Tue, 21 Jun 2016 15:13:08 +0200
Message-ID: <1466514809-146638-31-git-send-email-borntraeger@de.ibm.com>
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

As soon as we forward an ibc to guest 2 (indicated via
kvm->arch.model.ibc), he can also use it for guest 3. Let's properly round
the ibc up/down, so we avoid any potential validity icpts from the
underlying SIE, if it doesn't simply round the values.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/vsie.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 2839efc..1165baf 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -102,6 +102,26 @@ static int prepare_cpuflags(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	return 0;
 }
 
+/* shadow (round up/down) the ibc to avoid validity icpt */
+static void prepare_ibc(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
+{
+	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
+	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
+	__u64 min_ibc = (sclp.ibc >> 16) & 0x0fffU;
+
+	scb_s->ibc = 0;
+	/* ibc installed in g2 and requested for g3 */
+	if (vcpu->kvm->arch.model.ibc && (scb_o->ibc & 0x0fffU)) {
+		scb_s->ibc = scb_o->ibc & 0x0fffU;
+		/* takte care of the minimum ibc level of the machine */
+		if (scb_s->ibc < min_ibc)
+			scb_s->ibc = min_ibc;
+		/* take care of the maximum ibc level set for the guest */
+		if (scb_s->ibc > vcpu->kvm->arch.model.ibc)
+			scb_s->ibc = vcpu->kvm->arch.model.ibc;
+	}
+}
+
 /* unshadow the scb, copying parameters back to the real scb */
 static void unshadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 {
@@ -214,6 +234,7 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	/* MVPG and Protection Exception Interpretation are always available */
 	scb_s->eca |= scb_o->eca & 0x01002000U;
 
+	prepare_ibc(vcpu, vsie_page);
 out:
 	if (rc)
 		unshadow_scb(vcpu, vsie_page);
-- 
2.5.5
