Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41196 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230260AbhBIOjY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 9 Feb 2021 09:39:24 -0500
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v1 4/4] s390x: edat test
Date: Tue,  9 Feb 2021 15:38:35 +0100
Message-Id: <20210209143835.1031617-5-imbrenda@linux.ibm.com>
In-Reply-To: <20210209143835.1031617-1-imbrenda@linux.ibm.com>
References: <20210209143835.1031617-1-imbrenda@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, frankja@linux.ibm.com, cohuck@redhat.com, pmorel@linux.ibm.com

Simple EDAT test.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 s390x/Makefile      |   1 +
 s390x/edat.c        | 238 ++++++++++++++++++++++++++++++++++++++++++++
 s390x/unittests.cfg |   3 +
 3 files changed, 242 insertions(+)
 create mode 100644 s390x/edat.c

diff --git a/s390x/Makefile b/s390x/Makefile
index 08d85c9f..fc885150 100644
--- a/s390x/Makefile
+++ b/s390x/Makefile
@@ -20,6 +20,7 @@ tests += $(TEST_DIR)/sclp.elf
 tests += $(TEST_DIR)/css.elf
 tests += $(TEST_DIR)/uv-guest.elf
 tests += $(TEST_DIR)/sie.elf
+tests += $(TEST_DIR)/edat.elf
 
 tests_binary = $(patsubst %.elf,%.bin,$(tests))
 ifneq ($(HOST_KEY_DOCUMENT),)
diff --git a/s390x/edat.c b/s390x/edat.c
new file mode 100644
index 00000000..504a1501
--- /dev/null
+++ b/s390x/edat.c
@@ -0,0 +1,238 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * EDAT test.
+ *
+ * Copyright (c) 2021 IBM Corp
+ *
+ * Authors:
+ *	Claudio Imbrenda <imbrenda@linux.ibm.com>
+ */
+#include <libcflat.h>
+#include <vmalloc.h>
+#include <asm/facility.h>
+#include <asm/interrupt.h>
+#include <mmu.h>
+#include <asm/pgtable.h>
+#include <asm-generic/barrier.h>
+
+#define TEID_ADDR	PAGE_MASK
+#define TEID_AI		0x003
+#define TEID_M		0x004
+#define TEID_A		0x008
+#define TEID_FS		0xc00
+
+#define LC_SIZE	(2 * PAGE_SIZE)
+#define VIRT(x)	((void *)((unsigned long)(x) + (unsigned long)mem))
+
+static uint8_t prefix_buf[LC_SIZE] __attribute__((aligned(LC_SIZE)));
+static unsigned int tmp[1024] __attribute__((aligned(PAGE_SIZE)));
+static void *root, *mem, *m;
+static struct lowcore *lc;
+volatile unsigned int *p;
+
+/* Expect a program interrupt, and clear the TEID */
+static void expect_dat_fault(void)
+{
+	expect_pgm_int();
+	lc->trans_exc_id = 0;
+}
+
+/* Check if a protection exception happened for the given address */
+static bool check_pgm_prot(void *ptr)
+{
+	unsigned long teid = lc->trans_exc_id;
+
+	if (lc->pgm_int_code != PGM_INT_CODE_PROTECTION)
+		return 0;
+	if (~teid & TEID_M)
+		return 1;
+	return (~teid & TEID_A) &&
+		((teid & TEID_ADDR) == ((uint64_t)ptr & PAGE_MASK)) &&
+		!(teid & TEID_AI);
+}
+
+static void test_dat(void)
+{
+	report_prefix_push("edat off");
+	/* disable EDAT */
+	ctl_clear_bit(0, 23);
+
+	/* Check some basics */
+	p[0] = 42;
+	report(p[0] == 42, "pte, r/w");
+	p[0] = 0;
+
+	protect_page(m, PAGE_ENTRY_P);
+	expect_dat_fault();
+	p[0] = 42;
+	unprotect_page(m, PAGE_ENTRY_P);
+	report(!p[0] && check_pgm_prot(m), "pte, ro");
+
+	/* The FC bit should be ignored because EDAT is off */
+	p[0] = 42;
+	protect_dat_entry(m, SEGMENT_ENTRY_FC, 4);
+	report(p[0] == 42, "pmd, fc=1, r/w");
+	unprotect_dat_entry(m, SEGMENT_ENTRY_FC, 4);
+	p[0] = 0;
+
+	/* Segment protection should work even with EDAT off */
+	protect_dat_entry(m, SEGMENT_ENTRY_P, 4);
+	expect_dat_fault();
+	p[0] = 42;
+	report(!p[0] && check_pgm_prot(m), "pmd, ro");
+	unprotect_dat_entry(m, SEGMENT_ENTRY_P, 4);
+
+	/* The FC bit should be ignored because EDAT is off*/
+	protect_dat_entry(m, REGION3_ENTRY_FC, 3);
+	p[0] = 42;
+	report(p[0] == 42, "pud, fc=1, r/w");
+	unprotect_dat_entry(m, REGION3_ENTRY_FC, 3);
+	p[0] = 0;
+
+	/* Region1/2/3 protection should not work, because EDAT is off */
+	protect_dat_entry(m, REGION_ENTRY_P, 3);
+	p[0] = 42;
+	report(p[0] == 42, "pud, ro");
+	unprotect_dat_entry(m, REGION_ENTRY_P, 3);
+	p[0] = 0;
+
+	protect_dat_entry(m, REGION_ENTRY_P, 2);
+	p[0] = 42;
+	report(p[0] == 42, "p4d, ro");
+	unprotect_dat_entry(m, REGION_ENTRY_P, 2);
+	p[0] = 0;
+
+	protect_dat_entry(m, REGION_ENTRY_P, 1);
+	p[0] = 42;
+	report(p[0] == 42, "pgd, ro");
+	unprotect_dat_entry(m, REGION_ENTRY_P, 1);
+	p[0] = 0;
+
+	report_prefix_pop();
+}
+
+static void test_edat1(void)
+{
+	report_prefix_push("edat1");
+	/* Enable EDAT */
+	ctl_set_bit(0, 23);
+	p[0] = 0;
+
+	/* Segment protection should work */
+	expect_dat_fault();
+	protect_dat_entry(m, SEGMENT_ENTRY_P, 4);
+	p[0] = 42;
+	report(!p[0] && check_pgm_prot(m), "pmd, ro");
+	unprotect_dat_entry(m, SEGMENT_ENTRY_P, 4);
+
+	/* Region1/2/3 protection should work now */
+	expect_dat_fault();
+	protect_dat_entry(m, REGION_ENTRY_P, 3);
+	p[0] = 42;
+	report(!p[0] && check_pgm_prot(m), "pud, ro");
+	unprotect_dat_entry(m, REGION_ENTRY_P, 3);
+
+	expect_dat_fault();
+	protect_dat_entry(m, REGION_ENTRY_P, 2);
+	p[0] = 42;
+	report(!p[0] && check_pgm_prot(m), "p4d, ro");
+	unprotect_dat_entry(m, REGION_ENTRY_P, 2);
+
+	expect_dat_fault();
+	protect_dat_entry(m, REGION_ENTRY_P, 1);
+	p[0] = 42;
+	report(!p[0] && check_pgm_prot(m), "pgd, ro");
+	unprotect_dat_entry(m, REGION_ENTRY_P, 1);
+
+	/* Large pages should work */
+	p[0] = 42;
+	install_large_page(root, 0, mem);
+	report(p[0] == 42, "pmd, large");
+
+	/* Prefixing should not work with large pages */
+	report(!memcmp(0, VIRT(prefix_buf), LC_SIZE) &&
+		!memcmp(prefix_buf, mem, LC_SIZE),
+		"pmd, large, prefixing");
+
+	report_prefix_pop();
+}
+
+static void test_edat2(void)
+{
+	report_prefix_push("edat2");
+	p[0] = 42;
+
+	/* Huge pages should work */
+	install_huge_page(root, 0, mem);
+	report(p[0] == 42, "pud, huge");
+
+	/* Prefixing should not work with huge pages */
+	report(!memcmp(0, VIRT(prefix_buf), LC_SIZE) &&
+		!memcmp(prefix_buf, mem, LC_SIZE),
+		"pmd, large, prefixing");
+
+	report_prefix_pop();
+}
+
+static unsigned int setup(void)
+{
+	bool has_edat1 = test_facility(8);
+	bool has_edat2 = test_facility(78);
+	unsigned long pa, va;
+
+	if (has_edat2 && !has_edat1)
+		report_abort("EDAT2 available, but EDAT1 not available");
+
+	/* Setup DAT 1:1 mapping and memory management */
+	setup_vm();
+	root = (void *)(stctg(1) & PAGE_MASK);
+
+	/*
+	 * Get a pgd worth of virtual memory, so we can test things later
+	 * without interfering with the test code or the interrupt handler
+	 */
+	mem = alloc_vpages_aligned(BIT_ULL(41), 41);
+	assert(mem);
+	va = (unsigned long)mem;
+
+	/* Map the first 1GB of real memory */
+	for (pa = 0; pa < SZ_1G; pa += PAGE_SIZE, va += PAGE_SIZE)
+		install_page(root, pa, (void *)va);
+
+	/* Move the lowcore to a known non-zero location */
+	assert((unsigned long)&prefix_buf < SZ_2G);
+	memcpy(prefix_buf, 0, LC_SIZE);
+	set_prefix((uint32_t)(intptr_t)prefix_buf);
+	/* Clear the old copy */
+	memset(prefix_buf, 0, LC_SIZE);
+
+	/* m will point to tmp through the new virtual mapping */
+	m = VIRT(&tmp);
+	/* p is the same as m but volatile */
+	p = (volatile unsigned int *)m;
+
+	return has_edat1 + has_edat2;
+}
+
+int main(void)
+{
+	unsigned int edat;
+
+	report_prefix_push("edat");
+	edat = setup();
+
+	test_dat();
+
+	if (edat)
+		test_edat1();
+	else
+		report_skip("EDAT not available");
+
+	if (edat >= 2)
+		test_edat2();
+	else
+		report_skip("EDAT2 not available");
+
+	report_prefix_pop();
+	return report_summary();
+}
diff --git a/s390x/unittests.cfg b/s390x/unittests.cfg
index 2298be6c..8da4a0a3 100644
--- a/s390x/unittests.cfg
+++ b/s390x/unittests.cfg
@@ -99,3 +99,6 @@ file = uv-guest.elf
 
 [sie]
 file = sie.elf
+
+[edat]
+file = edat.elf
-- 
2.26.2
