From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 05/11] KVM: s390: Optimize paths where get_vcpu_asce() is invoked
Date: Wed, 18 Mar 2015 12:44:03 +0100
Message-ID: <1426679049-37696-6-git-send-email-borntraeger@de.ibm.com>
References: <1426679049-37696-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1426679049-37696-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Alexander Yarygin <yarygin@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Alexander Yarygin <yarygin@linux.vnet.ibm.com>

During dynamic address translation the get_vcpu_asce()
function can be invoked several times. It's ok for usual modes, but will
be slow if CPUs are in AR mode. Let's call the get_vcpu_asce() once and
pass the result to the called functions.

Signed-off-by: Alexander Yarygin <yarygin@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/gaccess.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 494131e..c74462a 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -330,6 +330,7 @@ static int deref_table(struct kvm *kvm, unsigned long gpa, unsigned long *val)
  * @vcpu: virtual cpu
  * @gva: guest virtual address
  * @gpa: points to where guest physical (absolute) address should be stored
+ * @asce: effective asce
  * @write: indicates if access is a write access
  *
  * Translate a guest virtual address into a guest absolute address by means
@@ -345,7 +346,8 @@ static int deref_table(struct kvm *kvm, unsigned long gpa, unsigned long *val)
  *	      by the architecture
  */
 static unsigned long guest_translate(struct kvm_vcpu *vcpu, unsigned long gva,
-				     unsigned long *gpa, int write)
+				     unsigned long *gpa, const union asce asce,
+				     int write)
 {
 	union vaddress vaddr = {.addr = gva};
 	union raddress raddr = {.addr = gva};
@@ -354,12 +356,10 @@ static unsigned long guest_translate(struct kvm_vcpu *vcpu, unsigned long gva,
 	union ctlreg0 ctlreg0;
 	unsigned long ptr;
 	int edat1, edat2;
-	union asce asce;
 
 	ctlreg0.val = vcpu->arch.sie_block->gcr[0];
 	edat1 = ctlreg0.edat && test_kvm_facility(vcpu->kvm, 8);
 	edat2 = edat1 && test_kvm_facility(vcpu->kvm, 78);
-	asce.val = get_vcpu_asce(vcpu);
 	if (asce.r)
 		goto real_address;
 	ptr = asce.origin * 4096;
@@ -506,15 +506,14 @@ static inline int is_low_address(unsigned long ga)
 	return (ga & ~0x11fful) == 0;
 }
 
-static int low_address_protection_enabled(struct kvm_vcpu *vcpu)
+static int low_address_protection_enabled(struct kvm_vcpu *vcpu,
+					  const union asce asce)
 {
 	union ctlreg0 ctlreg0 = {.val = vcpu->arch.sie_block->gcr[0]};
 	psw_t *psw = &vcpu->arch.sie_block->gpsw;
-	union asce asce;
 
 	if (!ctlreg0.lap)
 		return 0;
-	asce.val = get_vcpu_asce(vcpu);
 	if (psw_bits(*psw).t && asce.p)
 		return 0;
 	return 1;
@@ -536,7 +535,7 @@ enum {
 
 static int guest_page_range(struct kvm_vcpu *vcpu, unsigned long ga,
 			    unsigned long *pages, unsigned long nr_pages,
-			    int write)
+			    const union asce asce, int write)
 {
 	struct kvm_s390_pgm_info *pgm = &vcpu->arch.pgm;
 	psw_t *psw = &vcpu->arch.sie_block->gpsw;
@@ -547,7 +546,7 @@ static int guest_page_range(struct kvm_vcpu *vcpu, unsigned long ga,
 	tec_bits = (struct trans_exc_code_bits *)&pgm->trans_exc_code;
 	tec_bits->fsi = write ? FSI_STORE : FSI_FETCH;
 	tec_bits->as = psw_bits(*psw).as;
-	lap_enabled = low_address_protection_enabled(vcpu);
+	lap_enabled = low_address_protection_enabled(vcpu, asce);
 	while (nr_pages) {
 		ga = kvm_s390_logical_to_effective(vcpu, ga);
 		tec_bits->addr = ga >> PAGE_SHIFT;
@@ -557,7 +556,7 @@ static int guest_page_range(struct kvm_vcpu *vcpu, unsigned long ga,
 		}
 		ga &= PAGE_MASK;
 		if (psw_bits(*psw).t) {
-			rc = guest_translate(vcpu, ga, pages, write);
+			rc = guest_translate(vcpu, ga, pages, asce, write);
 			if (rc < 0)
 				return rc;
 			if (rc == PGM_PROTECTION)
@@ -604,7 +603,7 @@ int access_guest(struct kvm_vcpu *vcpu, unsigned long ga, ar_t ar, void *data,
 	need_ipte_lock = psw_bits(*psw).t && !asce.r;
 	if (need_ipte_lock)
 		ipte_lock(vcpu);
-	rc = guest_page_range(vcpu, ga, pages, nr_pages, write);
+	rc = guest_page_range(vcpu, ga, pages, nr_pages, asce, write);
 	for (idx = 0; idx < nr_pages && !rc; idx++) {
 		gpa = *(pages + idx) + (ga & ~PAGE_MASK);
 		_len = min(PAGE_SIZE - (gpa & ~PAGE_MASK), len);
@@ -671,16 +670,16 @@ int guest_translate_address(struct kvm_vcpu *vcpu, unsigned long gva, ar_t ar,
 	tec->as = psw_bits(*psw).as;
 	tec->fsi = write ? FSI_STORE : FSI_FETCH;
 	tec->addr = gva >> PAGE_SHIFT;
-	if (is_low_address(gva) && low_address_protection_enabled(vcpu)) {
+	asce.val = get_vcpu_asce(vcpu);
+	if (is_low_address(gva) && low_address_protection_enabled(vcpu, asce)) {
 		if (write) {
 			rc = pgm->code = PGM_PROTECTION;
 			return rc;
 		}
 	}
 
-	asce.val = get_vcpu_asce(vcpu);
 	if (psw_bits(*psw).t && !asce.r) {	/* Use DAT? */
-		rc = guest_translate(vcpu, gva, gpa, write);
+		rc = guest_translate(vcpu, gva, gpa, asce, write);
 		if (rc > 0) {
 			if (rc == PGM_PROTECTION)
 				tec->b61 = 1;
-- 
2.3.0
