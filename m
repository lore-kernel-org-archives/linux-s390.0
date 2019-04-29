Return-Path: <SRS0=+MMY=S7=vger.kernel.org=kvm-owner@kernel.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 11/12] KVM: s390: vsie: Do not shadow CRYCB when no AP and no keys
Date: Mon, 29 Apr 2019 11:10:01 +0200
In-Reply-To: <20190429091002.71164-1-borntraeger@de.ibm.com>
References: <20190429091002.71164-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190429091002.71164-12-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Pierre Morel <pmorel@linux.ibm.com>

When the guest do not have AP instructions nor Key management
we should return without shadowing the CRYCB.

We did not check correctly in the past.

Fixes: b10bd9a256ae ("s390: vsie: Use effective CRYCBD.31 to check CRYCBD validity")
Fixes: 6ee74098201b ("KVM: s390: vsie: allow CRYCB FORMAT-0")

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <1556269010-22258-1-git-send-email-pmorel@linux.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/vsie.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index c6983d962abf..ac411e9e2bd3 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -290,6 +290,7 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	u8 ecb3_flags;
 	u32 ecd_flags;
 	int apie_h;
+	int apie_s;
 	int key_msk = test_kvm_facility(vcpu->kvm, 76);
 	int fmt_o = crycbd_o & CRYCB_FORMAT_MASK;
 	int fmt_h = vcpu->arch.sie_block->crycbd & CRYCB_FORMAT_MASK;
@@ -298,7 +299,8 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	scb_s->crycbd = 0;
 
 	apie_h = vcpu->arch.sie_block->eca & ECA_APIE;
-	if (!apie_h && (!key_msk || fmt_o == CRYCB_FORMAT0))
+	apie_s = apie_h & scb_o->eca;
+	if (!apie_s && (!key_msk || (fmt_o == CRYCB_FORMAT0)))
 		return 0;
 
 	if (!crycb_addr)
@@ -309,7 +311,7 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		    ((crycb_addr + 128) & PAGE_MASK))
 			return set_validity_icpt(scb_s, 0x003CU);
 
-	if (apie_h && (scb_o->eca & ECA_APIE)) {
+	if (apie_s) {
 		ret = setup_apcb(vcpu, &vsie_page->crycb, crycb_addr,
 				 vcpu->kvm->arch.crypto.crycb,
 				 fmt_o, fmt_h);
-- 
2.19.1
