From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 37/51] KVM: s390: vsie: support run-time-instrumentation
Date: Tue, 21 Jun 2016 15:13:15 +0200
Message-ID: <1466514809-146638-38-git-send-email-borntraeger@de.ibm.com>
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

As soon as guest 2 is allowed to use run-time-instrumentation (indicated
via via STFLE), it can also enable it for guest 3.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/vsie.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 6d9f405..ebc988f 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -312,6 +312,9 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		scb_s->eca |= scb_o->eca & 0x00020000U;
 		scb_s->ecd |= scb_o->ecd & 0x20000000U;
 	}
+	/* Run-time-Instrumentation */
+	if (test_kvm_facility(vcpu->kvm, 64))
+		scb_s->ecb3 |= scb_o->ecb3 & 0x01U;
 
 	prepare_ibc(vcpu, vsie_page);
 	rc = shadow_crycb(vcpu, vsie_page);
@@ -464,6 +467,13 @@ static void unpin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		unpin_guest_page(vcpu->kvm, gpa, hpa);
 		scb_s->gvrd = 0;
 	}
+
+	hpa = scb_s->riccbd;
+	if (hpa) {
+		gpa = scb_o->riccbd & ~0x3fUL;
+		unpin_guest_page(vcpu->kvm, gpa, hpa);
+		scb_s->riccbd = 0;
+	}
 }
 
 /*
@@ -541,6 +551,22 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 			goto unpin;
 		scb_s->gvrd = hpa;
 	}
+
+	gpa = scb_o->riccbd & ~0x3fUL;
+	if (gpa && (scb_s->ecb3 & 0x01U)) {
+		if (!(gpa & ~0x1fffUL)) {
+			rc = set_validity_icpt(scb_s, 0x0043U);
+			goto unpin;
+		}
+		/* 64 bytes cannot cross page boundaries */
+		rc = pin_guest_page(vcpu->kvm, gpa, &hpa);
+		if (rc == -EINVAL)
+			rc = set_validity_icpt(scb_s, 0x0043U);
+		/* Validity 0x0044 will be checked by SIE */
+		if (rc)
+			goto unpin;
+		scb_s->gvrd = hpa;
+	}
 	return 0;
 unpin:
 	unpin_blocks(vcpu, vsie_page);
-- 
2.5.5
