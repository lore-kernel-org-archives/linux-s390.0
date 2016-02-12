From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 06/18] KVM: s390: gaccess: implement instruction fetching mode
Date: Fri, 12 Feb 2016 14:22:50 +0100
Message-ID: <1455283382-62999-7-git-send-email-borntraeger@de.ibm.com>
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

When an instruction is to be fetched, special handling applies to
secondary-space mode and access-register mode. The instruction is to be
fetched from primary space.

We can easily support this by selecting the right asce for translation.
Access registers will never be used during translation, so don't
include them in the interface. As we only want to read from the current
PSW address for now, let's also hide that detail.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/gaccess.c | 11 +++++++----
 arch/s390/kvm/gaccess.h | 21 +++++++++++++++++++++
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index c72ad91..66938d2 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -480,22 +480,25 @@ static int get_vcpu_asce(struct kvm_vcpu *vcpu, union asce *asce,
 			 ar_t ar, enum gacc_mode mode)
 {
 	int rc;
-	psw_t *psw = &vcpu->arch.sie_block->gpsw;
+	struct psw_bits psw = psw_bits(vcpu->arch.sie_block->gpsw);
 	struct kvm_s390_pgm_info *pgm = &vcpu->arch.pgm;
 	struct trans_exc_code_bits *tec_bits;
 
 	memset(pgm, 0, sizeof(*pgm));
 	tec_bits = (struct trans_exc_code_bits *)&pgm->trans_exc_code;
 	tec_bits->fsi = mode == GACC_STORE ? FSI_STORE : FSI_FETCH;
-	tec_bits->as = psw_bits(*psw).as;
+	tec_bits->as = psw.as;
 
-	if (!psw_bits(*psw).t) {
+	if (!psw.t) {
 		asce->val = 0;
 		asce->r = 1;
 		return 0;
 	}
 
-	switch (psw_bits(vcpu->arch.sie_block->gpsw).as) {
+	if (mode == GACC_IFETCH)
+		psw.as = psw.as == PSW_AS_HOME ? PSW_AS_HOME : PSW_AS_PRIMARY;
+
+	switch (psw.as) {
 	case PSW_AS_PRIMARY:
 		asce->val = vcpu->arch.sie_block->gcr[1];
 		return 0;
diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
index 2a6f8bf..df0a79d 100644
--- a/arch/s390/kvm/gaccess.h
+++ b/arch/s390/kvm/gaccess.h
@@ -158,6 +158,7 @@ int read_guest_lc(struct kvm_vcpu *vcpu, unsigned long gra, void *data,
 enum gacc_mode {
 	GACC_FETCH,
 	GACC_STORE,
+	GACC_IFETCH,
 };
 
 int guest_translate_address(struct kvm_vcpu *vcpu, unsigned long gva,
@@ -244,6 +245,26 @@ int read_guest(struct kvm_vcpu *vcpu, unsigned long ga, ar_t ar, void *data,
 }
 
 /**
+ * read_guest_instr - copy instruction data from guest space to kernel space
+ * @vcpu: virtual cpu
+ * @data: destination address in kernel space
+ * @len: number of bytes to copy
+ *
+ * Copy @len bytes from the current psw address (guest space) to @data (kernel
+ * space).
+ *
+ * The behaviour of read_guest_instr is identical to read_guest, except that
+ * instruction data will be read from primary space when in home-space or
+ * address-space mode.
+ */
+static inline __must_check
+int read_guest_instr(struct kvm_vcpu *vcpu, void *data, unsigned long len)
+{
+	return access_guest(vcpu, vcpu->arch.sie_block->gpsw.addr, 0, data, len,
+			    GACC_IFETCH);
+}
+
+/**
  * write_guest_abs - copy data from kernel space to guest space absolute
  * @vcpu: virtual cpu
  * @gpa: guest physical (absolute) address
-- 
2.3.0
