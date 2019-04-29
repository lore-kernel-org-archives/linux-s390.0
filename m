Return-Path: <SRS0=+MMY=S7=vger.kernel.org=kvm-owner@kernel.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 08/12] KVM: s390: enable MSA9 keywrapping functions depending on cpu model
Date: Mon, 29 Apr 2019 11:09:58 +0200
In-Reply-To: <20190429091002.71164-1-borntraeger@de.ibm.com>
References: <20190429091002.71164-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190429091002.71164-9-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Instead of adding a new machine option to disable/enable the keywrapping
options of pckmo (like for AES and DEA) we can now use the CPU model to
decide. As ECC is also wrapped with the AES key we need that to be
enabled.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/include/asm/kvm_host.h |  1 +
 arch/s390/kvm/kvm-s390.c         | 27 ++++++++++++++++++++++++++-
 arch/s390/kvm/vsie.c             |  5 ++++-
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index c47e22bba87f..e224246ff93c 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -278,6 +278,7 @@ struct kvm_s390_sie_block {
 #define ECD_HOSTREGMGMT	0x20000000
 #define ECD_MEF		0x08000000
 #define ECD_ETOKENF	0x02000000
+#define ECD_ECC		0x00200000
 	__u32	ecd;			/* 0x01c8 */
 	__u8	reserved1cc[18];	/* 0x01cc */
 	__u64	pp;			/* 0x01de */
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 38ca8324a91a..eb68ada1334b 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2890,6 +2890,25 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 	vcpu->arch.enabled_gmap = vcpu->arch.gmap;
 }
 
+static bool kvm_has_pckmo_subfunc(struct kvm *kvm, unsigned long nr)
+{
+	if (test_bit_inv(nr, (unsigned long *)&kvm->arch.model.subfuncs.pckmo) &&
+	    test_bit_inv(nr, (unsigned long *)&kvm_s390_available_subfunc.pckmo))
+		return true;
+	return false;
+}
+
+static bool kvm_has_pckmo_ecc(struct kvm *kvm)
+{
+	/* At least one ECC subfunction must be present */
+	return kvm_has_pckmo_subfunc(kvm, 32) ||
+	       kvm_has_pckmo_subfunc(kvm, 33) ||
+	       kvm_has_pckmo_subfunc(kvm, 34) ||
+	       kvm_has_pckmo_subfunc(kvm, 40) ||
+	       kvm_has_pckmo_subfunc(kvm, 41);
+
+}
+
 static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
 {
 	/*
@@ -2902,13 +2921,19 @@ static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
 	vcpu->arch.sie_block->crycbd = vcpu->kvm->arch.crypto.crycbd;
 	vcpu->arch.sie_block->ecb3 &= ~(ECB3_AES | ECB3_DEA);
 	vcpu->arch.sie_block->eca &= ~ECA_APIE;
+	vcpu->arch.sie_block->ecd &= ~ECD_ECC;
 
 	if (vcpu->kvm->arch.crypto.apie)
 		vcpu->arch.sie_block->eca |= ECA_APIE;
 
 	/* Set up protected key support */
-	if (vcpu->kvm->arch.crypto.aes_kw)
+	if (vcpu->kvm->arch.crypto.aes_kw) {
 		vcpu->arch.sie_block->ecb3 |= ECB3_AES;
+		/* ecc is also wrapped with AES key */
+		if (kvm_has_pckmo_ecc(vcpu->kvm))
+			vcpu->arch.sie_block->ecd |= ECD_ECC;
+	}
+
 	if (vcpu->kvm->arch.crypto.dea_kw)
 		vcpu->arch.sie_block->ecb3 |= ECB3_DEA;
 }
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index d62fa148558b..c6983d962abf 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -288,6 +288,7 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	const u32 crycb_addr = crycbd_o & 0x7ffffff8U;
 	unsigned long *b1, *b2;
 	u8 ecb3_flags;
+	u32 ecd_flags;
 	int apie_h;
 	int key_msk = test_kvm_facility(vcpu->kvm, 76);
 	int fmt_o = crycbd_o & CRYCB_FORMAT_MASK;
@@ -320,7 +321,8 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	/* we may only allow it if enabled for guest 2 */
 	ecb3_flags = scb_o->ecb3 & vcpu->arch.sie_block->ecb3 &
 		     (ECB3_AES | ECB3_DEA);
-	if (!ecb3_flags)
+	ecd_flags = scb_o->ecd & vcpu->arch.sie_block->ecd & ECD_ECC;
+	if (!ecb3_flags && !ecd_flags)
 		goto end;
 
 	/* copy only the wrapping keys */
@@ -329,6 +331,7 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		return set_validity_icpt(scb_s, 0x0035U);
 
 	scb_s->ecb3 |= ecb3_flags;
+	scb_s->ecd |= ecd_flags;
 
 	/* xor both blocks in one run */
 	b1 = (unsigned long *) vsie_page->crycb.dea_wrapping_key_mask;
-- 
2.19.1
