From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 05/18] KVM: s390: gaccess: introduce access modes
Date: Fri, 12 Feb 2016 14:22:49 +0100
Message-ID: <1455283382-62999-6-git-send-email-borntraeger@de.ibm.com>
References: <1455283382-62999-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1455283382-62999-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

We will need special handling when fetching instructions, so let's
introduce new guest access modes GACC_FETCH and GACC_STORE instead
of a write flag. An additional patch will then introduce GACC_IFETCH.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/gaccess.c   | 46 +++++++++++++++++++++++-----------------------
 arch/s390/kvm/gaccess.h   | 17 +++++++++++------
 arch/s390/kvm/intercept.c |  4 ++--
 arch/s390/kvm/kvm-s390.c  |  6 ++++--
 arch/s390/kvm/priv.c      |  5 +++--
 5 files changed, 43 insertions(+), 35 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index d30db40..c72ad91 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -373,7 +373,7 @@ void ipte_unlock(struct kvm_vcpu *vcpu)
 }
 
 static int ar_translation(struct kvm_vcpu *vcpu, union asce *asce, ar_t ar,
-			  int write)
+			  enum gacc_mode mode)
 {
 	union alet alet;
 	struct ale ale;
@@ -454,7 +454,7 @@ static int ar_translation(struct kvm_vcpu *vcpu, union asce *asce, ar_t ar,
 		}
 	}
 
-	if (ale.fo == 1 && write)
+	if (ale.fo == 1 && mode == GACC_STORE)
 		return PGM_PROTECTION;
 
 	asce->val = aste.asce;
@@ -477,7 +477,7 @@ enum {
 };
 
 static int get_vcpu_asce(struct kvm_vcpu *vcpu, union asce *asce,
-			 ar_t ar, int write)
+			 ar_t ar, enum gacc_mode mode)
 {
 	int rc;
 	psw_t *psw = &vcpu->arch.sie_block->gpsw;
@@ -486,7 +486,7 @@ static int get_vcpu_asce(struct kvm_vcpu *vcpu, union asce *asce,
 
 	memset(pgm, 0, sizeof(*pgm));
 	tec_bits = (struct trans_exc_code_bits *)&pgm->trans_exc_code;
-	tec_bits->fsi = write ? FSI_STORE : FSI_FETCH;
+	tec_bits->fsi = mode == GACC_STORE ? FSI_STORE : FSI_FETCH;
 	tec_bits->as = psw_bits(*psw).as;
 
 	if (!psw_bits(*psw).t) {
@@ -506,7 +506,7 @@ static int get_vcpu_asce(struct kvm_vcpu *vcpu, union asce *asce,
 		asce->val = vcpu->arch.sie_block->gcr[13];
 		return 0;
 	case PSW_AS_ACCREG:
-		rc = ar_translation(vcpu, asce, ar, write);
+		rc = ar_translation(vcpu, asce, ar, mode);
 		switch (rc) {
 		case PGM_ALEN_TRANSLATION:
 		case PGM_ALE_SEQUENCE:
@@ -538,7 +538,7 @@ static int deref_table(struct kvm *kvm, unsigned long gpa, unsigned long *val)
  * @gva: guest virtual address
  * @gpa: points to where guest physical (absolute) address should be stored
  * @asce: effective asce
- * @write: indicates if access is a write access
+ * @mode: indicates the access mode to be used
  *
  * Translate a guest virtual address into a guest absolute address by means
  * of dynamic address translation as specified by the architecture.
@@ -554,7 +554,7 @@ static int deref_table(struct kvm *kvm, unsigned long gpa, unsigned long *val)
  */
 static unsigned long guest_translate(struct kvm_vcpu *vcpu, unsigned long gva,
 				     unsigned long *gpa, const union asce asce,
-				     int write)
+				     enum gacc_mode mode)
 {
 	union vaddress vaddr = {.addr = gva};
 	union raddress raddr = {.addr = gva};
@@ -699,7 +699,7 @@ static unsigned long guest_translate(struct kvm_vcpu *vcpu, unsigned long gva,
 real_address:
 	raddr.addr = kvm_s390_real_to_abs(vcpu, raddr.addr);
 absolute_address:
-	if (write && dat_protection)
+	if (mode == GACC_STORE && dat_protection)
 		return PGM_PROTECTION;
 	if (kvm_is_error_gpa(vcpu->kvm, raddr.addr))
 		return PGM_ADDRESSING;
@@ -728,7 +728,7 @@ static int low_address_protection_enabled(struct kvm_vcpu *vcpu,
 
 static int guest_page_range(struct kvm_vcpu *vcpu, unsigned long ga,
 			    unsigned long *pages, unsigned long nr_pages,
-			    const union asce asce, int write)
+			    const union asce asce, enum gacc_mode mode)
 {
 	struct kvm_s390_pgm_info *pgm = &vcpu->arch.pgm;
 	psw_t *psw = &vcpu->arch.sie_block->gpsw;
@@ -740,13 +740,13 @@ static int guest_page_range(struct kvm_vcpu *vcpu, unsigned long ga,
 	while (nr_pages) {
 		ga = kvm_s390_logical_to_effective(vcpu, ga);
 		tec_bits->addr = ga >> PAGE_SHIFT;
-		if (write && lap_enabled && is_low_address(ga)) {
+		if (mode == GACC_STORE && lap_enabled && is_low_address(ga)) {
 			pgm->code = PGM_PROTECTION;
 			return pgm->code;
 		}
 		ga &= PAGE_MASK;
 		if (psw_bits(*psw).t) {
-			rc = guest_translate(vcpu, ga, pages, asce, write);
+			rc = guest_translate(vcpu, ga, pages, asce, mode);
 			if (rc < 0)
 				return rc;
 			if (rc == PGM_PROTECTION)
@@ -768,7 +768,7 @@ static int guest_page_range(struct kvm_vcpu *vcpu, unsigned long ga,
 }
 
 int access_guest(struct kvm_vcpu *vcpu, unsigned long ga, ar_t ar, void *data,
-		 unsigned long len, int write)
+		 unsigned long len, enum gacc_mode mode)
 {
 	psw_t *psw = &vcpu->arch.sie_block->gpsw;
 	unsigned long _len, nr_pages, gpa, idx;
@@ -780,7 +780,7 @@ int access_guest(struct kvm_vcpu *vcpu, unsigned long ga, ar_t ar, void *data,
 
 	if (!len)
 		return 0;
-	rc = get_vcpu_asce(vcpu, &asce, ar, write);
+	rc = get_vcpu_asce(vcpu, &asce, ar, mode);
 	if (rc)
 		return rc;
 	nr_pages = (((ga & ~PAGE_MASK) + len - 1) >> PAGE_SHIFT) + 1;
@@ -792,11 +792,11 @@ int access_guest(struct kvm_vcpu *vcpu, unsigned long ga, ar_t ar, void *data,
 	need_ipte_lock = psw_bits(*psw).t && !asce.r;
 	if (need_ipte_lock)
 		ipte_lock(vcpu);
-	rc = guest_page_range(vcpu, ga, pages, nr_pages, asce, write);
+	rc = guest_page_range(vcpu, ga, pages, nr_pages, asce, mode);
 	for (idx = 0; idx < nr_pages && !rc; idx++) {
 		gpa = *(pages + idx) + (ga & ~PAGE_MASK);
 		_len = min(PAGE_SIZE - (gpa & ~PAGE_MASK), len);
-		if (write)
+		if (mode == GACC_STORE)
 			rc = kvm_write_guest(vcpu->kvm, gpa, data, _len);
 		else
 			rc = kvm_read_guest(vcpu->kvm, gpa, data, _len);
@@ -812,7 +812,7 @@ int access_guest(struct kvm_vcpu *vcpu, unsigned long ga, ar_t ar, void *data,
 }
 
 int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
-		      void *data, unsigned long len, int write)
+		      void *data, unsigned long len, enum gacc_mode mode)
 {
 	unsigned long _len, gpa;
 	int rc = 0;
@@ -820,7 +820,7 @@ int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
 	while (len && !rc) {
 		gpa = kvm_s390_real_to_abs(vcpu, gra);
 		_len = min(PAGE_SIZE - (gpa & ~PAGE_MASK), len);
-		if (write)
+		if (mode)
 			rc = write_guest_abs(vcpu, gpa, data, _len);
 		else
 			rc = read_guest_abs(vcpu, gpa, data, _len);
@@ -841,7 +841,7 @@ int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
  * has to take care of this.
  */
 int guest_translate_address(struct kvm_vcpu *vcpu, unsigned long gva, ar_t ar,
-			    unsigned long *gpa, int write)
+			    unsigned long *gpa, enum gacc_mode mode)
 {
 	struct kvm_s390_pgm_info *pgm = &vcpu->arch.pgm;
 	psw_t *psw = &vcpu->arch.sie_block->gpsw;
@@ -851,19 +851,19 @@ int guest_translate_address(struct kvm_vcpu *vcpu, unsigned long gva, ar_t ar,
 
 	gva = kvm_s390_logical_to_effective(vcpu, gva);
 	tec = (struct trans_exc_code_bits *)&pgm->trans_exc_code;
-	rc = get_vcpu_asce(vcpu, &asce, ar, write);
+	rc = get_vcpu_asce(vcpu, &asce, ar, mode);
 	tec->addr = gva >> PAGE_SHIFT;
 	if (rc)
 		return rc;
 	if (is_low_address(gva) && low_address_protection_enabled(vcpu, asce)) {
-		if (write) {
+		if (mode == GACC_STORE) {
 			rc = pgm->code = PGM_PROTECTION;
 			return rc;
 		}
 	}
 
 	if (psw_bits(*psw).t && !asce.r) {	/* Use DAT? */
-		rc = guest_translate(vcpu, gva, gpa, asce, write);
+		rc = guest_translate(vcpu, gva, gpa, asce, mode);
 		if (rc > 0) {
 			if (rc == PGM_PROTECTION)
 				tec->b61 = 1;
@@ -883,7 +883,7 @@ int guest_translate_address(struct kvm_vcpu *vcpu, unsigned long gva, ar_t ar,
  * check_gva_range - test a range of guest virtual addresses for accessibility
  */
 int check_gva_range(struct kvm_vcpu *vcpu, unsigned long gva, ar_t ar,
-		    unsigned long length, int is_write)
+		    unsigned long length, enum gacc_mode mode)
 {
 	unsigned long gpa;
 	unsigned long currlen;
@@ -892,7 +892,7 @@ int check_gva_range(struct kvm_vcpu *vcpu, unsigned long gva, ar_t ar,
 	ipte_lock(vcpu);
 	while (length > 0 && !rc) {
 		currlen = min(length, PAGE_SIZE - (gva % PAGE_SIZE));
-		rc = guest_translate_address(vcpu, gva, ar, &gpa, is_write);
+		rc = guest_translate_address(vcpu, gva, ar, &gpa, mode);
 		gva += currlen;
 		length -= currlen;
 	}
diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
index ef03726..2a6f8bf 100644
--- a/arch/s390/kvm/gaccess.h
+++ b/arch/s390/kvm/gaccess.h
@@ -155,16 +155,21 @@ int read_guest_lc(struct kvm_vcpu *vcpu, unsigned long gra, void *data,
 	return kvm_read_guest(vcpu->kvm, gpa, data, len);
 }
 
+enum gacc_mode {
+	GACC_FETCH,
+	GACC_STORE,
+};
+
 int guest_translate_address(struct kvm_vcpu *vcpu, unsigned long gva,
-			    ar_t ar, unsigned long *gpa, int write);
+			    ar_t ar, unsigned long *gpa, enum gacc_mode mode);
 int check_gva_range(struct kvm_vcpu *vcpu, unsigned long gva, ar_t ar,
-		    unsigned long length, int is_write);
+		    unsigned long length, enum gacc_mode mode);
 
 int access_guest(struct kvm_vcpu *vcpu, unsigned long ga, ar_t ar, void *data,
-		 unsigned long len, int write);
+		 unsigned long len, enum gacc_mode mode);
 
 int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
-		      void *data, unsigned long len, int write);
+		      void *data, unsigned long len, enum gacc_mode mode);
 
 /**
  * write_guest - copy data from kernel space to guest space
@@ -215,7 +220,7 @@ static inline __must_check
 int write_guest(struct kvm_vcpu *vcpu, unsigned long ga, ar_t ar, void *data,
 		unsigned long len)
 {
-	return access_guest(vcpu, ga, ar, data, len, 1);
+	return access_guest(vcpu, ga, ar, data, len, GACC_STORE);
 }
 
 /**
@@ -235,7 +240,7 @@ static inline __must_check
 int read_guest(struct kvm_vcpu *vcpu, unsigned long ga, ar_t ar, void *data,
 	       unsigned long len)
 {
-	return access_guest(vcpu, ga, ar, data, len, 0);
+	return access_guest(vcpu, ga, ar, data, len, GACC_FETCH);
 }
 
 /**
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 7f992e0..44bb923 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -317,7 +317,7 @@ static int handle_mvpg_pei(struct kvm_vcpu *vcpu)
 
 	/* Make sure that the source is paged-in */
 	rc = guest_translate_address(vcpu, vcpu->run->s.regs.gprs[reg2],
-				     reg2, &srcaddr, 0);
+				     reg2, &srcaddr, GACC_FETCH);
 	if (rc)
 		return kvm_s390_inject_prog_cond(vcpu, rc);
 	rc = kvm_arch_fault_in_page(vcpu, srcaddr, 0);
@@ -326,7 +326,7 @@ static int handle_mvpg_pei(struct kvm_vcpu *vcpu)
 
 	/* Make sure that the destination is paged-in */
 	rc = guest_translate_address(vcpu, vcpu->run->s.regs.gprs[reg1],
-				     reg1, &dstaddr, 1);
+				     reg1, &dstaddr, GACC_STORE);
 	if (rc)
 		return kvm_s390_inject_prog_cond(vcpu, rc);
 	rc = kvm_arch_fault_in_page(vcpu, dstaddr, 1);
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index cd84a3e..85e169b 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2610,7 +2610,8 @@ static long kvm_s390_guest_mem_op(struct kvm_vcpu *vcpu,
 	switch (mop->op) {
 	case KVM_S390_MEMOP_LOGICAL_READ:
 		if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
-			r = check_gva_range(vcpu, mop->gaddr, mop->ar, mop->size, false);
+			r = check_gva_range(vcpu, mop->gaddr, mop->ar,
+					    mop->size, GACC_FETCH);
 			break;
 		}
 		r = read_guest(vcpu, mop->gaddr, mop->ar, tmpbuf, mop->size);
@@ -2621,7 +2622,8 @@ static long kvm_s390_guest_mem_op(struct kvm_vcpu *vcpu,
 		break;
 	case KVM_S390_MEMOP_LOGICAL_WRITE:
 		if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
-			r = check_gva_range(vcpu, mop->gaddr, mop->ar, mop->size, true);
+			r = check_gva_range(vcpu, mop->gaddr, mop->ar,
+					    mop->size, GACC_STORE);
 			break;
 		}
 		if (copy_from_user(tmpbuf, uaddr, mop->size)) {
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index d58cbe9..add9909 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -981,11 +981,12 @@ static int handle_tprot(struct kvm_vcpu *vcpu)
 		return -EOPNOTSUPP;
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_DAT)
 		ipte_lock(vcpu);
-	ret = guest_translate_address(vcpu, address1, ar, &gpa, 1);
+	ret = guest_translate_address(vcpu, address1, ar, &gpa, GACC_STORE);
 	if (ret == PGM_PROTECTION) {
 		/* Write protected? Try again with read-only... */
 		cc = 1;
-		ret = guest_translate_address(vcpu, address1, ar, &gpa, 0);
+		ret = guest_translate_address(vcpu, address1, ar, &gpa,
+					      GACC_FETCH);
 	}
 	if (ret) {
 		if (ret == PGM_ADDRESSING || ret == PGM_TRANSLATION_SPEC) {
-- 
2.3.0
