From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 36/51] KVM: s390: vsie: support vectory facility (SIMD)
Date: Tue, 21 Jun 2016 15:13:14 +0200
Message-ID: <1466514809-146638-37-git-send-email-borntraeger@de.ibm.com>
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

As soon as guest 2 is allowed to use the vector facility (indicated via
STFLE), it can also enable it for guest 3. We have to take care of the
sattellite block that might be used when not relying on lazy vector
copying (not the case for KVM).

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  2 +-
 arch/s390/kvm/vsie.c             | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 255609c..190ad63 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -229,7 +229,7 @@ struct kvm_s390_sie_block {
 	__u8	reserved1e6[2];		/* 0x01e6 */
 	__u64	itdba;			/* 0x01e8 */
 	__u64   riccbd;			/* 0x01f0 */
-	__u8    reserved1f8[8];		/* 0x01f8 */
+	__u64	gvrd;			/* 0x01f8 */
 } __attribute__((packed));
 
 struct kvm_s390_itdb {
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 4e2c71c..6d9f405 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -307,6 +307,11 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 			prefix_unmapped(vsie_page);
 		scb_s->ecb |= scb_o->ecb & 0x10U;
 	}
+	/* SIMD */
+	if (test_kvm_facility(vcpu->kvm, 129)) {
+		scb_s->eca |= scb_o->eca & 0x00020000U;
+		scb_s->ecd |= scb_o->ecd & 0x20000000U;
+	}
 
 	prepare_ibc(vcpu, vsie_page);
 	rc = shadow_crycb(vcpu, vsie_page);
@@ -452,6 +457,13 @@ static void unpin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		unpin_guest_page(vcpu->kvm, gpa, hpa);
 		scb_s->itdba = 0;
 	}
+
+	hpa = scb_s->gvrd;
+	if (hpa) {
+		gpa = scb_o->gvrd & ~0x1ffUL;
+		unpin_guest_page(vcpu->kvm, gpa, hpa);
+		scb_s->gvrd = 0;
+	}
 }
 
 /*
@@ -510,6 +522,25 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 			goto unpin;
 		scb_s->itdba = hpa;
 	}
+
+	gpa = scb_o->gvrd & ~0x1ffUL;
+	if (gpa && (scb_s->eca & 0x00020000U) &&
+	    !(scb_s->ecd & 0x20000000U)) {
+		if (!(gpa & ~0x1fffUL)) {
+			rc = set_validity_icpt(scb_s, 0x1310U);
+			goto unpin;
+		}
+		/*
+		 * 512 bytes vector registers cannot cross page boundaries
+		 * if this block gets bigger, we have to shadow it.
+		 */
+		rc = pin_guest_page(vcpu->kvm, gpa, &hpa);
+		if (rc == -EINVAL)
+			rc = set_validity_icpt(scb_s, 0x1310U);
+		if (rc)
+			goto unpin;
+		scb_s->gvrd = hpa;
+	}
 	return 0;
 unpin:
 	unpin_blocks(vcpu, vsie_page);
-- 
2.5.5
