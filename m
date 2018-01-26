From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 03/22] KVM: s390: vsie: store guest addresses of satellite blocks in vsie_page
Date: Fri, 26 Jan 2018 16:53:15 +0100
Message-ID: <20180126155334.52956-4-borntraeger@de.ibm.com>
References: <20180126155334.52956-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180126155334.52956-1-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <david@redhat.com>

This way, the values cannot change, even if another VCPU might try to
mess with the nested SCB currently getting executed by another VCPU.

We now always use the same gpa for pinning and unpinning a page (for
unpinning, it is only relevant to mark the guest page dirty for
migration).

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180116171526.12343-3-david@redhat.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/vsie.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index b2066fbb6341f..6090f4235cfc0 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -38,7 +38,13 @@ struct vsie_page {
 	struct gmap *gmap;			/* 0x0220 */
 	/* address of the last reported fault to guest2 */
 	unsigned long fault_addr;		/* 0x0228 */
-	__u8 reserved[0x0700 - 0x0230];		/* 0x0230 */
+	/* calculated guest addresses of satellite control blocks */
+	gpa_t sca_gpa;				/* 0x0230 */
+	gpa_t itdba_gpa;			/* 0x0238 */
+	gpa_t gvrd_gpa;				/* 0x0240 */
+	gpa_t riccbd_gpa;			/* 0x0248 */
+	gpa_t sdnx_gpa;				/* 0x0250 */
+	__u8 reserved[0x0700 - 0x0258];		/* 0x0258 */
 	struct kvm_s390_crypto_cb crycb;	/* 0x0700 */
 	__u8 fac[S390_ARCH_FAC_LIST_SIZE_BYTE];	/* 0x0800 */
 };
@@ -475,46 +481,42 @@ static void unpin_guest_page(struct kvm *kvm, gpa_t gpa, hpa_t hpa)
 /* unpin all blocks previously pinned by pin_blocks(), marking them dirty */
 static void unpin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 {
-	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
 	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
 	hpa_t hpa;
-	gpa_t gpa;
 
 	hpa = (u64) scb_s->scaoh << 32 | scb_s->scaol;
 	if (hpa) {
-		gpa = scb_o->scaol & ~0xfUL;
-		if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_64BSCAO))
-			gpa |= (u64) scb_o->scaoh << 32;
-		unpin_guest_page(vcpu->kvm, gpa, hpa);
+		unpin_guest_page(vcpu->kvm, vsie_page->sca_gpa, hpa);
+		vsie_page->sca_gpa = 0;
 		scb_s->scaol = 0;
 		scb_s->scaoh = 0;
 	}
 
 	hpa = scb_s->itdba;
 	if (hpa) {
-		gpa = scb_o->itdba & ~0xffUL;
-		unpin_guest_page(vcpu->kvm, gpa, hpa);
+		unpin_guest_page(vcpu->kvm, vsie_page->itdba_gpa, hpa);
+		vsie_page->itdba_gpa = 0;
 		scb_s->itdba = 0;
 	}
 
 	hpa = scb_s->gvrd;
 	if (hpa) {
-		gpa = scb_o->gvrd & ~0x1ffUL;
-		unpin_guest_page(vcpu->kvm, gpa, hpa);
+		unpin_guest_page(vcpu->kvm, vsie_page->gvrd_gpa, hpa);
+		vsie_page->gvrd_gpa = 0;
 		scb_s->gvrd = 0;
 	}
 
 	hpa = scb_s->riccbd;
 	if (hpa) {
-		gpa = scb_o->riccbd & ~0x3fUL;
-		unpin_guest_page(vcpu->kvm, gpa, hpa);
+		unpin_guest_page(vcpu->kvm, vsie_page->riccbd_gpa, hpa);
+		vsie_page->riccbd_gpa = 0;
 		scb_s->riccbd = 0;
 	}
 
 	hpa = scb_s->sdnxo;
 	if (hpa) {
-		gpa = scb_o->sdnxo;
-		unpin_guest_page(vcpu->kvm, gpa, hpa);
+		unpin_guest_page(vcpu->kvm, vsie_page->sdnx_gpa, hpa);
+		vsie_page->sdnx_gpa = 0;
 		scb_s->sdnxo = 0;
 	}
 }
@@ -559,6 +561,7 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		}
 		if (rc)
 			goto unpin;
+		vsie_page->sca_gpa = gpa;
 		scb_s->scaoh = (u32)((u64)hpa >> 32);
 		scb_s->scaol = (u32)(u64)hpa;
 	}
@@ -575,6 +578,7 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 			rc = set_validity_icpt(scb_s, 0x0080U);
 			goto unpin;
 		}
+		vsie_page->itdba_gpa = gpa;
 		scb_s->itdba = hpa;
 	}
 
@@ -593,6 +597,7 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 			rc = set_validity_icpt(scb_s, 0x1310U);
 			goto unpin;
 		}
+		vsie_page->gvrd_gpa = gpa;
 		scb_s->gvrd = hpa;
 	}
 
@@ -609,6 +614,7 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 			goto unpin;
 		}
 		/* Validity 0x0044 will be checked by SIE */
+		vsie_page->riccbd_gpa = gpa;
 		scb_s->riccbd = hpa;
 	}
 	if ((scb_s->ecb & ECB_GS) && !(scb_s->ecd & ECD_HOSTREGMGMT)) {
@@ -636,6 +642,7 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 			rc = set_validity_icpt(scb_s, 0x10b0U);
 			goto unpin;
 		}
+		vsie_page->sdnx_gpa = gpa;
 		scb_s->sdnxo = hpa | sdnxc;
 	}
 	return 0;
-- 
2.13.4
