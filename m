From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 12/47] KVM: s390: add architecture compliant guest access functions
Date: Tue, 15 Apr 2014 14:00:15 +0200
Message-ID: <1397563250-3089-13-git-send-email-borntraeger@de.ibm.com>
References: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

The new guest memory access function write_guest() and read_guest() can be
used to access guest memory in an architecture compliant way.
These functions will look at the vcpu's PSW and select the correct address
space for memory access and also perform correct address wrap around.
In case DAT is turned on, page tables will be walked otherwise access will
happen to real or absolute memory.

Any access exception will be recognized and exception data will be stored
in the vcpu's kvm_vcpu_arch.pgm member. Subsequently an exception can be
injected if necessary.

Missing are:
- key protection checks
- access register mode support
- program event recording support

This patch also adds write_guest_real(), read_guest_real(),
write_guest_absolute() and read_guest_absolute() guest functions which can
be used to access real and absolute storage. These functions currently do
not perform any access checks, since there is no use case (yet?).

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/Makefile  |   4 +-
 arch/s390/kvm/gaccess.c | 536 ++++++++++++++++++++++++++++++++++++++++++++++++
 arch/s390/kvm/gaccess.h | 170 +++++++++++++++
 3 files changed, 709 insertions(+), 1 deletion(-)
 create mode 100644 arch/s390/kvm/gaccess.c

diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/Makefile
index d3adb37..83a7a35 100644
--- a/arch/s390/kvm/Makefile
+++ b/arch/s390/kvm/Makefile
@@ -11,5 +11,7 @@ common-objs = $(KVM)/kvm_main.o $(KVM)/eventfd.o  $(KVM)/async_pf.o $(KVM)/irqch
 
 ccflags-y := -Ivirt/kvm -Iarch/s390/kvm
 
-kvm-objs := $(common-objs) kvm-s390.o intercept.o interrupt.o priv.o sigp.o diag.o
+kvm-objs := $(common-objs) kvm-s390.o intercept.o interrupt.o priv.o sigp.o
+kvm-objs += diag.o gaccess.o
+
 obj-$(CONFIG_KVM) += kvm.o
diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
new file mode 100644
index 0000000..916e1ee
--- /dev/null
+++ b/arch/s390/kvm/gaccess.c
@@ -0,0 +1,536 @@
+/*
+ * guest access functions
+ *
+ * Copyright IBM Corp. 2014
+ *
+ */
+
+#include <linux/vmalloc.h>
+#include <linux/err.h>
+#include <asm/pgtable.h>
+#include "kvm-s390.h"
+#include "gaccess.h"
+
+union asce {
+	unsigned long val;
+	struct {
+		unsigned long origin : 52; /* Region- or Segment-Table Origin */
+		unsigned long	 : 2;
+		unsigned long g  : 1; /* Subspace Group Control */
+		unsigned long p  : 1; /* Private Space Control */
+		unsigned long s  : 1; /* Storage-Alteration-Event Control */
+		unsigned long x  : 1; /* Space-Switch-Event Control */
+		unsigned long r  : 1; /* Real-Space Control */
+		unsigned long	 : 1;
+		unsigned long dt : 2; /* Designation-Type Control */
+		unsigned long tl : 2; /* Region- or Segment-Table Length */
+	};
+};
+
+enum {
+	ASCE_TYPE_SEGMENT = 0,
+	ASCE_TYPE_REGION3 = 1,
+	ASCE_TYPE_REGION2 = 2,
+	ASCE_TYPE_REGION1 = 3
+};
+
+union region1_table_entry {
+	unsigned long val;
+	struct {
+		unsigned long rto: 52;/* Region-Table Origin */
+		unsigned long	 : 2;
+		unsigned long p  : 1; /* DAT-Protection Bit */
+		unsigned long	 : 1;
+		unsigned long tf : 2; /* Region-Second-Table Offset */
+		unsigned long i  : 1; /* Region-Invalid Bit */
+		unsigned long	 : 1;
+		unsigned long tt : 2; /* Table-Type Bits */
+		unsigned long tl : 2; /* Region-Second-Table Length */
+	};
+};
+
+union region2_table_entry {
+	unsigned long val;
+	struct {
+		unsigned long rto: 52;/* Region-Table Origin */
+		unsigned long	 : 2;
+		unsigned long p  : 1; /* DAT-Protection Bit */
+		unsigned long	 : 1;
+		unsigned long tf : 2; /* Region-Third-Table Offset */
+		unsigned long i  : 1; /* Region-Invalid Bit */
+		unsigned long	 : 1;
+		unsigned long tt : 2; /* Table-Type Bits */
+		unsigned long tl : 2; /* Region-Third-Table Length */
+	};
+};
+
+struct region3_table_entry_fc0 {
+	unsigned long sto: 52;/* Segment-Table Origin */
+	unsigned long	 : 1;
+	unsigned long fc : 1; /* Format-Control */
+	unsigned long p  : 1; /* DAT-Protection Bit */
+	unsigned long	 : 1;
+	unsigned long tf : 2; /* Segment-Table Offset */
+	unsigned long i  : 1; /* Region-Invalid Bit */
+	unsigned long cr : 1; /* Common-Region Bit */
+	unsigned long tt : 2; /* Table-Type Bits */
+	unsigned long tl : 2; /* Segment-Table Length */
+};
+
+struct region3_table_entry_fc1 {
+	unsigned long rfaa : 33; /* Region-Frame Absolute Address */
+	unsigned long	 : 14;
+	unsigned long av : 1; /* ACCF-Validity Control */
+	unsigned long acc: 4; /* Access-Control Bits */
+	unsigned long f  : 1; /* Fetch-Protection Bit */
+	unsigned long fc : 1; /* Format-Control */
+	unsigned long p  : 1; /* DAT-Protection Bit */
+	unsigned long co : 1; /* Change-Recording Override */
+	unsigned long	 : 2;
+	unsigned long i  : 1; /* Region-Invalid Bit */
+	unsigned long cr : 1; /* Common-Region Bit */
+	unsigned long tt : 2; /* Table-Type Bits */
+	unsigned long	 : 2;
+};
+
+union region3_table_entry {
+	unsigned long val;
+	struct region3_table_entry_fc0 fc0;
+	struct region3_table_entry_fc1 fc1;
+	struct {
+		unsigned long	 : 53;
+		unsigned long fc : 1; /* Format-Control */
+		unsigned long	 : 4;
+		unsigned long i  : 1; /* Region-Invalid Bit */
+		unsigned long cr : 1; /* Common-Region Bit */
+		unsigned long tt : 2; /* Table-Type Bits */
+		unsigned long	 : 2;
+	};
+};
+
+struct segment_entry_fc0 {
+	unsigned long pto: 53;/* Page-Table Origin */
+	unsigned long fc : 1; /* Format-Control */
+	unsigned long p  : 1; /* DAT-Protection Bit */
+	unsigned long	 : 3;
+	unsigned long i  : 1; /* Segment-Invalid Bit */
+	unsigned long cs : 1; /* Common-Segment Bit */
+	unsigned long tt : 2; /* Table-Type Bits */
+	unsigned long	 : 2;
+};
+
+struct segment_entry_fc1 {
+	unsigned long sfaa : 44; /* Segment-Frame Absolute Address */
+	unsigned long	 : 3;
+	unsigned long av : 1; /* ACCF-Validity Control */
+	unsigned long acc: 4; /* Access-Control Bits */
+	unsigned long f  : 1; /* Fetch-Protection Bit */
+	unsigned long fc : 1; /* Format-Control */
+	unsigned long p  : 1; /* DAT-Protection Bit */
+	unsigned long co : 1; /* Change-Recording Override */
+	unsigned long	 : 2;
+	unsigned long i  : 1; /* Segment-Invalid Bit */
+	unsigned long cs : 1; /* Common-Segment Bit */
+	unsigned long tt : 2; /* Table-Type Bits */
+	unsigned long	 : 2;
+};
+
+union segment_table_entry {
+	unsigned long val;
+	struct segment_entry_fc0 fc0;
+	struct segment_entry_fc1 fc1;
+	struct {
+		unsigned long	 : 53;
+		unsigned long fc : 1; /* Format-Control */
+		unsigned long	 : 4;
+		unsigned long i  : 1; /* Segment-Invalid Bit */
+		unsigned long cs : 1; /* Common-Segment Bit */
+		unsigned long tt : 2; /* Table-Type Bits */
+		unsigned long	 : 2;
+	};
+};
+
+enum {
+	TABLE_TYPE_SEGMENT = 0,
+	TABLE_TYPE_REGION3 = 1,
+	TABLE_TYPE_REGION2 = 2,
+	TABLE_TYPE_REGION1 = 3
+};
+
+union page_table_entry {
+	unsigned long val;
+	struct {
+		unsigned long pfra : 52; /* Page-Frame Real Address */
+		unsigned long z  : 1; /* Zero Bit */
+		unsigned long i  : 1; /* Page-Invalid Bit */
+		unsigned long p  : 1; /* DAT-Protection Bit */
+		unsigned long co : 1; /* Change-Recording Override */
+		unsigned long	 : 8;
+	};
+};
+
+/*
+ * vaddress union in order to easily decode a virtual address into its
+ * region first index, region second index etc. parts.
+ */
+union vaddress {
+	unsigned long addr;
+	struct {
+		unsigned long rfx : 11;
+		unsigned long rsx : 11;
+		unsigned long rtx : 11;
+		unsigned long sx  : 11;
+		unsigned long px  : 8;
+		unsigned long bx  : 12;
+	};
+	struct {
+		unsigned long rfx01 : 2;
+		unsigned long	    : 9;
+		unsigned long rsx01 : 2;
+		unsigned long	    : 9;
+		unsigned long rtx01 : 2;
+		unsigned long	    : 9;
+		unsigned long sx01  : 2;
+		unsigned long	    : 29;
+	};
+};
+
+/*
+ * raddress union which will contain the result (real or absolute address)
+ * after a page table walk. The rfaa, sfaa and pfra members are used to
+ * simply assign them the value of a region, segment or page table entry.
+ */
+union raddress {
+	unsigned long addr;
+	unsigned long rfaa : 33; /* Region-Frame Absolute Address */
+	unsigned long sfaa : 44; /* Segment-Frame Absolute Address */
+	unsigned long pfra : 52; /* Page-Frame Real Address */
+};
+
+static unsigned long get_vcpu_asce(struct kvm_vcpu *vcpu)
+{
+	switch (psw_bits(vcpu->arch.sie_block->gpsw).as) {
+	case PSW_AS_PRIMARY:
+		return vcpu->arch.sie_block->gcr[1];
+	case PSW_AS_SECONDARY:
+		return vcpu->arch.sie_block->gcr[7];
+	case PSW_AS_HOME:
+		return vcpu->arch.sie_block->gcr[13];
+	}
+	return 0;
+}
+
+static int deref_table(struct kvm *kvm, unsigned long gpa, unsigned long *val)
+{
+	return kvm_read_guest(kvm, gpa, val, sizeof(*val));
+}
+
+/**
+ * guest_translate - translate a guest virtual into a guest absolute address
+ * @vcpu: virtual cpu
+ * @gva: guest virtual address
+ * @gpa: points to where guest physical (absolute) address should be stored
+ * @write: indicates if access is a write access
+ *
+ * Translate a guest virtual address into a guest absolute address by means
+ * of dynamic address translation as specified by the architecuture.
+ * If the resulting absolute address is not available in the configuration
+ * an addressing exception is indicated and @gpa will not be changed.
+ *
+ * Returns: - zero on success; @gpa contains the resulting absolute address
+ *	    - a negative value if guest access failed due to e.g. broken
+ *	      guest mapping
+ *	    - a positve value if an access exception happened. In this case
+ *	      the returned value is the program interruption code as defined
+ *	      by the architecture
+ */
+static unsigned long guest_translate(struct kvm_vcpu *vcpu, unsigned long gva,
+				     unsigned long *gpa, int write)
+{
+	union vaddress vaddr = {.addr = gva};
+	union raddress raddr = {.addr = gva};
+	union page_table_entry pte;
+	int dat_protection = 0;
+	union ctlreg0 ctlreg0;
+	unsigned long ptr;
+	int edat1, edat2;
+	union asce asce;
+
+	ctlreg0.val = vcpu->arch.sie_block->gcr[0];
+	edat1 = ctlreg0.edat && test_vfacility(8);
+	edat2 = edat1 && test_vfacility(78);
+	asce.val = get_vcpu_asce(vcpu);
+	if (asce.r)
+		goto real_address;
+	ptr = asce.origin * 4096;
+	switch (asce.dt) {
+	case ASCE_TYPE_REGION1:
+		if (vaddr.rfx01 > asce.tl)
+			return PGM_REGION_FIRST_TRANS;
+		ptr += vaddr.rfx * 8;
+		break;
+	case ASCE_TYPE_REGION2:
+		if (vaddr.rfx)
+			return PGM_ASCE_TYPE;
+		if (vaddr.rsx01 > asce.tl)
+			return PGM_REGION_SECOND_TRANS;
+		ptr += vaddr.rsx * 8;
+		break;
+	case ASCE_TYPE_REGION3:
+		if (vaddr.rfx || vaddr.rsx)
+			return PGM_ASCE_TYPE;
+		if (vaddr.rtx01 > asce.tl)
+			return PGM_REGION_THIRD_TRANS;
+		ptr += vaddr.rtx * 8;
+		break;
+	case ASCE_TYPE_SEGMENT:
+		if (vaddr.rfx || vaddr.rsx || vaddr.rtx)
+			return PGM_ASCE_TYPE;
+		if (vaddr.sx01 > asce.tl)
+			return PGM_SEGMENT_TRANSLATION;
+		ptr += vaddr.sx * 8;
+		break;
+	}
+	switch (asce.dt) {
+	case ASCE_TYPE_REGION1:	{
+		union region1_table_entry rfte;
+
+		if (kvm_is_error_gpa(vcpu->kvm, ptr))
+			return PGM_ADDRESSING;
+		if (deref_table(vcpu->kvm, ptr, &rfte.val))
+			return -EFAULT;
+		if (rfte.i)
+			return PGM_REGION_FIRST_TRANS;
+		if (rfte.tt != TABLE_TYPE_REGION1)
+			return PGM_TRANSLATION_SPEC;
+		if (vaddr.rsx01 < rfte.tf || vaddr.rsx01 > rfte.tl)
+			return PGM_REGION_SECOND_TRANS;
+		if (edat1)
+			dat_protection |= rfte.p;
+		ptr = rfte.rto * 4096 + vaddr.rsx * 8;
+	}
+		/* fallthrough */
+	case ASCE_TYPE_REGION2: {
+		union region2_table_entry rste;
+
+		if (kvm_is_error_gpa(vcpu->kvm, ptr))
+			return PGM_ADDRESSING;
+		if (deref_table(vcpu->kvm, ptr, &rste.val))
+			return -EFAULT;
+		if (rste.i)
+			return PGM_REGION_SECOND_TRANS;
+		if (rste.tt != TABLE_TYPE_REGION2)
+			return PGM_TRANSLATION_SPEC;
+		if (vaddr.rtx01 < rste.tf || vaddr.rtx01 > rste.tl)
+			return PGM_REGION_THIRD_TRANS;
+		if (edat1)
+			dat_protection |= rste.p;
+		ptr = rste.rto * 4096 + vaddr.rtx * 8;
+	}
+		/* fallthrough */
+	case ASCE_TYPE_REGION3: {
+		union region3_table_entry rtte;
+
+		if (kvm_is_error_gpa(vcpu->kvm, ptr))
+			return PGM_ADDRESSING;
+		if (deref_table(vcpu->kvm, ptr, &rtte.val))
+			return -EFAULT;
+		if (rtte.i)
+			return PGM_REGION_THIRD_TRANS;
+		if (rtte.tt != TABLE_TYPE_REGION3)
+			return PGM_TRANSLATION_SPEC;
+		if (rtte.cr && asce.p && edat2)
+			return PGM_TRANSLATION_SPEC;
+		if (rtte.fc && edat2) {
+			dat_protection |= rtte.fc1.p;
+			raddr.rfaa = rtte.fc1.rfaa;
+			goto absolute_address;
+		}
+		if (vaddr.sx01 < rtte.fc0.tf)
+			return PGM_SEGMENT_TRANSLATION;
+		if (vaddr.sx01 > rtte.fc0.tl)
+			return PGM_SEGMENT_TRANSLATION;
+		if (edat1)
+			dat_protection |= rtte.fc0.p;
+		ptr = rtte.fc0.sto * 4096 + vaddr.sx * 8;
+	}
+		/* fallthrough */
+	case ASCE_TYPE_SEGMENT: {
+		union segment_table_entry ste;
+
+		if (kvm_is_error_gpa(vcpu->kvm, ptr))
+			return PGM_ADDRESSING;
+		if (deref_table(vcpu->kvm, ptr, &ste.val))
+			return -EFAULT;
+		if (ste.i)
+			return PGM_SEGMENT_TRANSLATION;
+		if (ste.tt != TABLE_TYPE_SEGMENT)
+			return PGM_TRANSLATION_SPEC;
+		if (ste.cs && asce.p)
+			return PGM_TRANSLATION_SPEC;
+		if (ste.fc && edat1) {
+			dat_protection |= ste.fc1.p;
+			raddr.sfaa = ste.fc1.sfaa;
+			goto absolute_address;
+		}
+		dat_protection |= ste.fc0.p;
+		ptr = ste.fc0.pto * 2048 + vaddr.px * 8;
+	}
+	}
+	if (kvm_is_error_gpa(vcpu->kvm, ptr))
+		return PGM_ADDRESSING;
+	if (deref_table(vcpu->kvm, ptr, &pte.val))
+		return -EFAULT;
+	if (pte.i)
+		return PGM_PAGE_TRANSLATION;
+	if (pte.z)
+		return PGM_TRANSLATION_SPEC;
+	if (pte.co && !edat1)
+		return PGM_TRANSLATION_SPEC;
+	dat_protection |= pte.p;
+	raddr.pfra = pte.pfra;
+real_address:
+	raddr.addr = kvm_s390_real_to_abs(vcpu, raddr.addr);
+absolute_address:
+	if (write && dat_protection)
+		return PGM_PROTECTION;
+	if (kvm_is_error_gpa(vcpu->kvm, raddr.addr))
+		return PGM_ADDRESSING;
+	*gpa = raddr.addr;
+	return 0;
+}
+
+static inline int is_low_address(unsigned long ga)
+{
+	/* Check for address ranges 0..511 and 4096..4607 */
+	return (ga & ~0x11fful) == 0;
+}
+
+static int low_address_protection_enabled(struct kvm_vcpu *vcpu)
+{
+	union ctlreg0 ctlreg0 = {.val = vcpu->arch.sie_block->gcr[0]};
+	psw_t *psw = &vcpu->arch.sie_block->gpsw;
+	union asce asce;
+
+	if (!ctlreg0.lap)
+		return 0;
+	asce.val = get_vcpu_asce(vcpu);
+	if (psw_bits(*psw).t && asce.p)
+		return 0;
+	return 1;
+}
+
+struct trans_exc_code_bits {
+	unsigned long addr : 52; /* Translation-exception Address */
+	unsigned long fsi  : 2;  /* Access Exception Fetch/Store Indication */
+	unsigned long	   : 7;
+	unsigned long b61  : 1;
+	unsigned long as   : 2;  /* ASCE Identifier */
+};
+
+enum {
+	FSI_UNKNOWN = 0, /* Unknown wether fetch or store */
+	FSI_STORE   = 1, /* Exception was due to store operation */
+	FSI_FETCH   = 2  /* Exception was due to fetch operation */
+};
+
+static int guest_page_range(struct kvm_vcpu *vcpu, unsigned long ga,
+			    unsigned long *pages, unsigned long nr_pages,
+			    int write)
+{
+	struct kvm_s390_pgm_info *pgm = &vcpu->arch.pgm;
+	psw_t *psw = &vcpu->arch.sie_block->gpsw;
+	struct trans_exc_code_bits *tec_bits;
+	int lap_enabled, rc;
+
+	memset(pgm, 0, sizeof(*pgm));
+	tec_bits = (struct trans_exc_code_bits *)&pgm->trans_exc_code;
+	tec_bits->fsi = write ? FSI_STORE : FSI_FETCH;
+	tec_bits->as = psw_bits(*psw).as;
+	lap_enabled = low_address_protection_enabled(vcpu);
+	while (nr_pages) {
+		ga = kvm_s390_logical_to_effective(vcpu, ga);
+		tec_bits->addr = ga >> PAGE_SHIFT;
+		if (write && lap_enabled && is_low_address(ga)) {
+			pgm->code = PGM_PROTECTION;
+			return pgm->code;
+		}
+		ga &= PAGE_MASK;
+		if (psw_bits(*psw).t) {
+			rc = guest_translate(vcpu, ga, pages, write);
+			if (rc < 0)
+				return rc;
+			if (rc == PGM_PROTECTION)
+				tec_bits->b61 = 1;
+			if (rc)
+				pgm->code = rc;
+		} else {
+			*pages = kvm_s390_real_to_abs(vcpu, ga);
+			if (kvm_is_error_gpa(vcpu->kvm, *pages))
+				pgm->code = PGM_ADDRESSING;
+		}
+		if (pgm->code)
+			return pgm->code;
+		ga += PAGE_SIZE;
+		pages++;
+		nr_pages--;
+	}
+	return 0;
+}
+
+int access_guest(struct kvm_vcpu *vcpu, unsigned long ga, void *data,
+		 unsigned long len, int write)
+{
+	psw_t *psw = &vcpu->arch.sie_block->gpsw;
+	unsigned long _len, nr_pages, gpa, idx;
+	unsigned long pages_array[2];
+	unsigned long *pages;
+	int rc;
+
+	if (!len)
+		return 0;
+	/* Access register mode is not supported yet. */
+	if (psw_bits(*psw).t && psw_bits(*psw).as == PSW_AS_ACCREG)
+		return -EOPNOTSUPP;
+	nr_pages = (((ga & ~PAGE_MASK) + len - 1) >> PAGE_SHIFT) + 1;
+	pages = pages_array;
+	if (nr_pages > ARRAY_SIZE(pages_array))
+		pages = vmalloc(nr_pages * sizeof(unsigned long));
+	if (!pages)
+		return -ENOMEM;
+	rc = guest_page_range(vcpu, ga, pages, nr_pages, write);
+	for (idx = 0; idx < nr_pages && !rc; idx++) {
+		gpa = *(pages + idx) + (ga & ~PAGE_MASK);
+		_len = min(PAGE_SIZE - (gpa & ~PAGE_MASK), len);
+		if (write)
+			rc = kvm_write_guest(vcpu->kvm, gpa, data, _len);
+		else
+			rc = kvm_read_guest(vcpu->kvm, gpa, data, _len);
+		len -= _len;
+		ga += _len;
+		data += _len;
+	}
+	if (nr_pages > ARRAY_SIZE(pages_array))
+		vfree(pages);
+	return rc;
+}
+
+int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
+		      void *data, unsigned long len, int write)
+{
+	unsigned long _len, gpa;
+	int rc = 0;
+
+	while (len && !rc) {
+		gpa = kvm_s390_real_to_abs(vcpu, gra);
+		_len = min(PAGE_SIZE - (gpa & ~PAGE_MASK), len);
+		if (write)
+			rc = write_guest_abs(vcpu, gpa, data, _len);
+		else
+			rc = read_guest_abs(vcpu, gpa, data, _len);
+		len -= _len;
+		gra += _len;
+		data += _len;
+	}
+	return rc;
+}
diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
index 917aeaa..21ee62c 100644
--- a/arch/s390/kvm/gaccess.h
+++ b/arch/s390/kvm/gaccess.h
@@ -227,4 +227,174 @@ int read_guest_lc(struct kvm_vcpu *vcpu, unsigned long gra, void *data,
 
 	return kvm_read_guest(vcpu->kvm, gpa, data, len);
 }
+
+int access_guest(struct kvm_vcpu *vcpu, unsigned long ga, void *data,
+		 unsigned long len, int write);
+
+int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
+		      void *data, unsigned long len, int write);
+
+/**
+ * write_guest - copy data from kernel space to guest space
+ * @vcpu: virtual cpu
+ * @ga: guest address
+ * @data: source address in kernel space
+ * @len: number of bytes to copy
+ *
+ * Copy @len bytes from @data (kernel space) to @ga (guest address).
+ * In order to copy data to guest space the PSW of the vcpu is inspected:
+ * If DAT is off data will be copied to guest real or absolute memory.
+ * If DAT is on data will be copied to the address space as specified by
+ * the address space bits of the PSW:
+ * Primary, secondory or home space (access register mode is currently not
+ * implemented).
+ * The addressing mode of the PSW is also inspected, so that address wrap
+ * around is taken into account for 24-, 31- and 64-bit addressing mode,
+ * if the to be copied data crosses page boundaries in guest address space.
+ * In addition also low address and DAT protection are inspected before
+ * copying any data (key protection is currently not implemented).
+ *
+ * This function modifies the 'struct kvm_s390_pgm_info pgm' member of @vcpu.
+ * In case of an access exception (e.g. protection exception) pgm will contain
+ * all data necessary so that a subsequent call to 'kvm_s390_inject_prog_vcpu()'
+ * will inject a correct exception into the guest.
+ * If no access exception happened, the contents of pgm are undefined when
+ * this function returns.
+ *
+ * Returns:  - zero on success
+ *	     - a negative value if e.g. the guest mapping is broken or in
+ *	       case of out-of-memory. In this case the contents of pgm are
+ *	       undefined. Also parts of @data may have been copied to guest
+ *	       space.
+ *	     - a positive value if an access exception happened. In this case
+ *	       the returned value is the program interruption code and the
+ *	       contents of pgm may be used to inject an exception into the
+ *	       guest. No data has been copied to guest space.
+ *
+ * Note: in case an access exception is recognized no data has been copied to
+ *	 guest space (this is also true, if the to be copied data would cross
+ *	 one or more page boundaries in guest space).
+ *	 Therefore this function may be used for nullifying and suppressing
+ *	 instruction emulation.
+ *	 It may also be used for terminating instructions, if it is undefined
+ *	 if data has been changed in guest space in case of an exception.
+ */
+static inline __must_check
+int write_guest(struct kvm_vcpu *vcpu, unsigned long ga, void *data,
+		unsigned long len)
+{
+	return access_guest(vcpu, ga, data, len, 1);
+}
+
+/**
+ * read_guest - copy data from guest space to kernel space
+ * @vcpu: virtual cpu
+ * @ga: guest address
+ * @data: destination address in kernel space
+ * @len: number of bytes to copy
+ *
+ * Copy @len bytes from @ga (guest address) to @data (kernel space).
+ *
+ * The behaviour of read_guest is identical to write_guest, except that
+ * data will be copied from guest space to kernel space.
+ */
+static inline __must_check
+int read_guest(struct kvm_vcpu *vcpu, unsigned long ga, void *data,
+	       unsigned long len)
+{
+	return access_guest(vcpu, ga, data, len, 0);
+}
+
+/**
+ * write_guest_abs - copy data from kernel space to guest space absolute
+ * @vcpu: virtual cpu
+ * @gpa: guest physical (absolute) address
+ * @data: source address in kernel space
+ * @len: number of bytes to copy
+ *
+ * Copy @len bytes from @data (kernel space) to @gpa (guest absolute address).
+ * It is up to the caller to ensure that the entire guest memory range is
+ * valid memory before calling this function.
+ * Guest low address and key protection are not checked.
+ *
+ * Returns zero on success or -EFAULT on error.
+ *
+ * If an error occurs data may have been copied partially to guest memory.
+ */
+static inline __must_check
+int write_guest_abs(struct kvm_vcpu *vcpu, unsigned long gpa, void *data,
+		    unsigned long len)
+{
+	return kvm_write_guest(vcpu->kvm, gpa, data, len);
+}
+
+/**
+ * read_guest_abs - copy data from guest space absolute to kernel space
+ * @vcpu: virtual cpu
+ * @gpa: guest physical (absolute) address
+ * @data: destination address in kernel space
+ * @len: number of bytes to copy
+ *
+ * Copy @len bytes from @gpa (guest absolute address) to @data (kernel space).
+ * It is up to the caller to ensure that the entire guest memory range is
+ * valid memory before calling this function.
+ * Guest key protection is not checked.
+ *
+ * Returns zero on success or -EFAULT on error.
+ *
+ * If an error occurs data may have been copied partially to kernel space.
+ */
+static inline __must_check
+int read_guest_abs(struct kvm_vcpu *vcpu, unsigned long gpa, void *data,
+		   unsigned long len)
+{
+	return kvm_read_guest(vcpu->kvm, gpa, data, len);
+}
+
+/**
+ * write_guest_real - copy data from kernel space to guest space real
+ * @vcpu: virtual cpu
+ * @gra: guest real address
+ * @data: source address in kernel space
+ * @len: number of bytes to copy
+ *
+ * Copy @len bytes from @data (kernel space) to @gra (guest real address).
+ * It is up to the caller to ensure that the entire guest memory range is
+ * valid memory before calling this function.
+ * Guest low address and key protection are not checked.
+ *
+ * Returns zero on success or -EFAULT on error.
+ *
+ * If an error occurs data may have been copied partially to guest memory.
+ */
+static inline __must_check
+int write_guest_real(struct kvm_vcpu *vcpu, unsigned long gra, void *data,
+		     unsigned long len)
+{
+	return access_guest_real(vcpu, gra, data, len, 1);
+}
+
+/**
+ * read_guest_real - copy data from guest space real to kernel space
+ * @vcpu: virtual cpu
+ * @gra: guest real address
+ * @data: destination address in kernel space
+ * @len: number of bytes to copy
+ *
+ * Copy @len bytes from @gra (guest real address) to @data (kernel space).
+ * It is up to the caller to ensure that the entire guest memory range is
+ * valid memory before calling this function.
+ * Guest key protection is not checked.
+ *
+ * Returns zero on success or -EFAULT on error.
+ *
+ * If an error occurs data may have been copied partially to kernel space.
+ */
+static inline __must_check
+int read_guest_real(struct kvm_vcpu *vcpu, unsigned long gra, void *data,
+		    unsigned long len)
+{
+	return access_guest_real(vcpu, gra, data, len, 0);
+}
+
 #endif /* __KVM_S390_GACCESS_H */
-- 
1.8.4.2
