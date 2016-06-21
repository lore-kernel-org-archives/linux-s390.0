From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 35/51] KVM: s390: vsie: support transactional execution
Date: Tue, 21 Jun 2016 15:13:13 +0200
Message-ID: <1466514809-146638-36-git-send-email-borntraeger@de.ibm.com>
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

As soon as guest 2 is allowed to use transactional execution (indicated via
STFLE), he can also enable it for guest 3.

Active transactional execution requires also the second prefix page to be
mapped. If that page cannot be mapped, a validity icpt has to be presented
to the guest.

We have to take care of tx being toggled on/off, otherwise we might get
wrong prefix validity icpt.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/vsie.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 6b26b0b..4e2c71c 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -239,6 +239,7 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 {
 	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
 	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
+	bool had_tx = scb_s->ecb & 0x10U;
 	unsigned long new_mso;
 	int rc;
 
@@ -299,6 +300,13 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	/* Host-protection-interruption introduced with ESOP */
 	if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_ESOP))
 		scb_s->ecb |= scb_o->ecb & 0x02U;
+	/* transactional execution */
+	if (test_kvm_facility(vcpu->kvm, 73)) {
+		/* remap the prefix is tx is toggled on */
+		if ((scb_o->ecb & 0x10U) && !had_tx)
+			prefix_unmapped(vsie_page);
+		scb_s->ecb |= scb_o->ecb & 0x10U;
+	}
 
 	prepare_ibc(vcpu, vsie_page);
 	rc = shadow_crycb(vcpu, vsie_page);
@@ -337,13 +345,13 @@ void kvm_s390_vsie_gmap_notifier(struct gmap *gmap, unsigned long start,
 		prefix = cur->scb_s.prefix << GUEST_PREFIX_SHIFT;
 		/* with mso/msl, the prefix lies at an offset */
 		prefix += cur->scb_s.mso;
-		if (prefix <= end && start <= prefix + PAGE_SIZE - 1)
+		if (prefix <= end && start <= prefix + 2 * PAGE_SIZE - 1)
 			prefix_unmapped_sync(cur);
 	}
 }
 
 /*
- * Map the first prefix page.
+ * Map the first prefix page and if tx is enabled also the second prefix page.
  *
  * The prefix will be protected, a gmap notifier will inform about unmaps.
  * The shadow scb must not be executed until the prefix is remapped, this is
@@ -370,6 +378,9 @@ static int map_prefix(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	prefix += scb_s->mso;
 
 	rc = kvm_s390_shadow_fault(vcpu, vsie_page->gmap, prefix);
+	if (!rc && (scb_s->ecb & 0x10U))
+		rc = kvm_s390_shadow_fault(vcpu, vsie_page->gmap,
+					   prefix + PAGE_SIZE);
 	/*
 	 * We don't have to mprotect, we will be called for all unshadows.
 	 * SIE will detect if protection applies and trigger a validity.
@@ -434,6 +445,13 @@ static void unpin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		scb_s->scaol = 0;
 		scb_s->scaoh = 0;
 	}
+
+	hpa = scb_s->itdba;
+	if (hpa) {
+		gpa = scb_o->itdba & ~0xffUL;
+		unpin_guest_page(vcpu->kvm, gpa, hpa);
+		scb_s->itdba = 0;
+	}
 }
 
 /*
@@ -477,6 +495,21 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		scb_s->scaoh = (u32)((u64)hpa >> 32);
 		scb_s->scaol = (u32)(u64)hpa;
 	}
+
+	gpa = scb_o->itdba & ~0xffUL;
+	if (gpa && (scb_s->ecb & 0x10U)) {
+		if (!(gpa & ~0x1fffU)) {
+			rc = set_validity_icpt(scb_s, 0x0080U);
+			goto unpin;
+		}
+		/* 256 bytes cannot cross page boundaries */
+		rc = pin_guest_page(vcpu->kvm, gpa, &hpa);
+		if (rc == -EINVAL)
+			rc = set_validity_icpt(scb_s, 0x0080U);
+		if (rc)
+			goto unpin;
+		scb_s->itdba = hpa;
+	}
 	return 0;
 unpin:
 	unpin_blocks(vcpu, vsie_page);
-- 
2.5.5
