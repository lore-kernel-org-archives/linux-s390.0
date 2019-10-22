Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31756 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730345AbfJVKxO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 22 Oct 2019 06:53:14 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9MAlcj4126009
        for <linux-s390@vger.kernel.org>; Tue, 22 Oct 2019 06:53:13 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vswwxwnrw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 22 Oct 2019 06:53:12 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Tue, 22 Oct 2019 11:53:09 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v1 5/5] s390x: SCLP unit test
Date: Tue, 22 Oct 2019 12:53:04 +0200
In-Reply-To: <1571741584-17621-1-git-send-email-imbrenda@linux.ibm.com>
References: <1571741584-17621-1-git-send-email-imbrenda@linux.ibm.com>
Message-Id: <1571741584-17621-6-git-send-email-imbrenda@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com

SCLP unit test. Testing the following:

* Correctly ignoring instruction bits that should be ignored
* Privileged instruction check
* Check for addressing exceptions
* Specification exceptions:
  - SCCB size less than 8
  - SCCB unaligned
  - SCCB overlaps prefix or lowcore
  - SCCB address higher than 2GB
* Return codes for
  - Invalid command
  - SCCB too short (but at least 8)
  - SCCB page boundary violation

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 s390x/Makefile      |   1 +
 s390x/sclp.c        | 373 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 s390x/unittests.cfg |   3 +
 3 files changed, 377 insertions(+)
 create mode 100644 s390x/sclp.c

diff --git a/s390x/Makefile b/s390x/Makefile
index 3744372..ddb4b48 100644
--- a/s390x/Makefile
+++ b/s390x/Makefile
@@ -16,6 +16,7 @@ tests += $(TEST_DIR)/diag288.elf
 tests += $(TEST_DIR)/stsi.elf
 tests += $(TEST_DIR)/skrf.elf
 tests += $(TEST_DIR)/smp.elf
+tests += $(TEST_DIR)/sclp.elf
 tests_binary = $(patsubst %.elf,%.bin,$(tests))
 
 all: directories test_cases test_cases_binary
diff --git a/s390x/sclp.c b/s390x/sclp.c
new file mode 100644
index 0000000..d7a9212
--- /dev/null
+++ b/s390x/sclp.c
@@ -0,0 +1,373 @@
+/*
+ * Store System Information tests
+ *
+ * Copyright (c) 2019 IBM Corp
+ *
+ * Authors:
+ *  Claudio Imbrenda <imbrenda@linux.ibm.com>
+ *
+ * This code is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2.
+ */
+
+#include <libcflat.h>
+#include <asm/page.h>
+#include <asm/asm-offsets.h>
+#include <asm/interrupt.h>
+#include <sclp.h>
+
+static uint8_t pagebuf[PAGE_SIZE * 2] __attribute__((aligned(PAGE_SIZE * 2)));
+static uint8_t prefix_buf[PAGE_SIZE * 2] __attribute__((aligned(PAGE_SIZE * 2)));
+static uint32_t valid_sclp_code;
+static struct lowcore *lc;
+
+static void sclp_setup_int_test(void)
+{
+	uint64_t mask;
+
+	ctl_set_bit(0, 9);
+
+	mask = extract_psw_mask();
+	mask |= PSW_MASK_EXT;
+	load_psw_mask(mask);
+}
+
+static int sclp_service_call_test(unsigned int command, void *sccb)
+{
+	int cc;
+
+	sclp_mark_busy();
+	sclp_setup_int_test();
+	lc->pgm_int_code = 0;
+	cc = servc(command, __pa(sccb));
+	if (lc->pgm_int_code) {
+		sclp_handle_ext();
+		return 0;
+	}
+	if (!cc)
+		sclp_wait_busy();
+	return cc;
+}
+
+static int test_one_sccb(uint32_t cmd, uint64_t addr, uint16_t len,
+			void *data, uint64_t exp_pgm, uint16_t exp_rc)
+{
+	SCCBHeader *h = (SCCBHeader *)addr;
+	int res, pgm;
+
+	if (data && len)
+		memcpy((void *)addr, data, len);
+	if (!exp_pgm)
+		exp_pgm = 1;
+	expect_pgm_int();
+	res = sclp_service_call_test(cmd, h);
+	if (res) {
+		report_info("SCLP not ready (command %#x, address %#lx, cc %d)",
+			cmd, addr, res);
+		return 0;
+	}
+	pgm = lc->pgm_int_code;
+	if (!((1ULL << pgm) & exp_pgm)) {
+		report_info("First failure at addr %#lx, size %d, cmd %#x, pgm code %d",
+				addr, len, cmd, pgm);
+		return 0;
+	}
+	if (exp_rc && (exp_rc != h->response_code)) {
+		report_info("First failure at addr %#lx, size %d, cmd %#x, resp code %#x",
+				addr, len, cmd, h->response_code);
+		return 0;
+	}
+	return 1;
+}
+
+static int test_one_run(uint32_t cmd, uint64_t addr, uint16_t len,
+			uint16_t clear, uint64_t exp_pgm, uint16_t exp_rc)
+{
+	char sccb[4096];
+	void *p = sccb;
+
+	if (!len && !clear)
+		p = NULL;
+	else
+		memset(sccb, 0, sizeof(sccb));
+	((SCCBHeader *)sccb)->length = len;
+	if (clear && (clear < 8))
+		clear = 8;
+	return test_one_sccb(cmd, addr, clear, p, exp_pgm, exp_rc);
+}
+
+#define PGM_BIT_SPEC	(1ULL << PGM_INT_CODE_SPECIFICATION)
+#define PGM_BIT_ADDR	(1ULL << PGM_INT_CODE_ADDRESSING)
+#define PGM_BIT_PRIV	(1ULL << PGM_INT_CODE_PRIVILEGED_OPERATION)
+
+#define PGBUF	((uintptr_t)pagebuf)
+#define VALID	(valid_sclp_code)
+
+static void test_sccb_too_short(void)
+{
+	int cx;
+
+	for (cx = 0; cx < 8; cx++)
+		if (!test_one_run(VALID, PGBUF, cx, 8, PGM_BIT_SPEC, 0))
+			break;
+
+	report("SCCB too short", cx == 8);
+}
+
+static void test_sccb_unaligned(void)
+{
+	int cx;
+
+	for (cx = 1; cx < 8; cx++)
+		if (!test_one_run(VALID, cx + PGBUF, 8, 8, PGM_BIT_SPEC, 0))
+			break;
+	report("SCCB unaligned", cx == 8);
+}
+
+static void test_sccb_prefix(void)
+{
+	uint32_t prefix, new_prefix;
+	int cx;
+
+	for (cx = 0; cx < 8192; cx += 8)
+		if (!test_one_run(VALID, cx, 0, 0, PGM_BIT_SPEC, 0))
+			break;
+	report("SCCB low pages", cx == 8192);
+
+	new_prefix = (uint32_t)(intptr_t)prefix_buf;
+	memcpy(prefix_buf, 0, 8192);
+	asm volatile("stpx %0": "+Q"(prefix));
+	asm volatile("spx %0": "+Q"(new_prefix));
+
+	for (cx = 0; cx < 8192; cx += 8)
+		if (!test_one_run(VALID, new_prefix + cx, 8, 8, PGM_BIT_SPEC, 0))
+			break;
+	report("SCCB prefix pages", cx == 8192);
+
+	memcpy(prefix_buf, 0, 8192);
+	asm volatile("spx %0": "+Q"(prefix));
+}
+
+static void test_sccb_high(void)
+{
+	SCCBHeader *h = (SCCBHeader *)pagebuf;
+	uintptr_t a[33 * 4 * 2 + 2];
+	uint64_t maxram;
+	int cx, i, pgm;
+
+	h->length = 8;
+
+	i = 0;
+	for (cx = 0; cx < 33; cx++)
+		a[i++] = 1UL << (cx + 31);
+	for (cx = 0; cx < 33; cx++)
+		a[i++] = 3UL << (cx + 31);
+	for (cx = 0; cx < 33; cx++)
+		a[i++] = 0xffffffff80000000UL << cx;
+	a[i++] = 0x80000000;
+	for (cx = 1; cx < 33; cx++, i++)
+		a[i] = a[i - 1] | (1UL << (cx + 31));
+	for (cx = 0; cx < i; cx++)
+		a[i + cx] = a[cx] + (intptr_t)pagebuf;
+	i += cx;
+	a[i++] = 0xdeadbeef00000000;
+	a[i++] = 0xdeaddeadbeef0000;
+
+	maxram = get_ram_size();
+	for (cx = 0; cx < i; cx++) {
+		pgm = PGM_BIT_SPEC | (a[cx] >= maxram ? PGM_BIT_ADDR : 0);
+		if (!test_one_run(VALID, a[cx], 0, 0, pgm, 0))
+			break;
+	}
+	report("SCCB high addresses", cx == i);
+}
+
+static void test_spec(void)
+{
+	test_sccb_too_short();
+	test_sccb_unaligned();
+	test_sccb_prefix();
+	test_sccb_high();
+}
+
+static void test_inval(void)
+{
+	uint32_t cmd;
+	int cx;
+
+	report_prefix_push("Invalid command");
+	for (cx = 0; cx < 65536; cx++) {
+		cmd = (0xdead0000) | cx;
+		if (cmd == VALID)
+			continue;
+		if (!test_one_run(cmd, PGBUF, 4096, 0, 0, SCLP_RC_INVALID_SCLP_COMMAND))
+			break;
+	}
+	report("Command detail code", cx == 65536);
+
+	for (cx = 0; cx < 256; cx++) {
+		cmd = (VALID & ~0xff) | cx;
+		if (cmd == VALID)
+			continue;
+		if (!test_one_run(cmd, PGBUF, 4096, 4096, 0, SCLP_RC_INVALID_SCLP_COMMAND))
+			break;
+	}
+	report("Command class code", cx == 256);
+	report_prefix_pop();
+}
+
+static void test_short(void)
+{
+	uint16_t res = SCLP_RC_INSUFFICIENT_SCCB_LENGTH;
+	int cx;
+
+	for (cx = 8; cx < 144; cx++)
+		if (!test_one_run(VALID, PGBUF, cx, cx, 0, res))
+			break;
+	report("Insufficient SCCB length (Read SCP info)", cx == 144);
+
+	for (cx = 8; cx < 40; cx++)
+		if (!test_one_run(SCLP_READ_CPU_INFO, PGBUF, cx, cx, 0, res))
+			break;
+	report("Insufficient SCCB length (Read CPU info)", cx == 40);
+}
+
+static void test_boundary(void)
+{
+	uint32_t cmd = SCLP_CMD_WRITE_EVENT_DATA;
+	uint16_t res = SCLP_RC_SCCB_BOUNDARY_VIOLATION;
+	char sccb_static[4096] = {0};
+	WriteEventData *sccb = (WriteEventData *)sccb_static;
+	int len, cx;
+
+	sccb->h.function_code = SCLP_FC_NORMAL_WRITE;
+	for (len = 32; len <= 4096; len++) {
+		cx = len & 7 ? len & ~7 : len - 8;
+		for (cx = 4096 - cx; cx < 4096; cx += 8) {
+			sccb->h.length = len;
+			if (!test_one_sccb(cmd, cx + PGBUF, len, sccb, 0, res))
+				goto out;
+		}
+	}
+out:
+	report("SCCB page boundary violation", len > 4096 && cx == 4096);
+}
+
+static void test_toolong(void)
+{
+	uint32_t cmd = SCLP_CMD_WRITE_EVENT_DATA;
+	uint16_t res = SCLP_RC_SCCB_BOUNDARY_VIOLATION;
+	char sccb_static[8192] = {0};
+	WriteEventData *sccb = (WriteEventData *)sccb_static;
+	int cx;
+
+	sccb->h.function_code = SCLP_FC_NORMAL_WRITE;
+	for (cx = 4097; cx < 8192; cx++) {
+		sccb->h.length = cx;
+		if (!test_one_sccb(cmd, PGBUF, cx, sccb, 0, res))
+			break;
+	}
+	report("SCCB bigger than 4k", cx == 8192);
+}
+
+static void test_resp(void)
+{
+	test_inval();
+	test_short();
+	test_boundary();
+	test_toolong();
+}
+
+static void test_priv(void)
+{
+	pagebuf[0] = 0;
+	pagebuf[1] = 8;
+	expect_pgm_int();
+	enter_pstate();
+	servc(valid_sclp_code, __pa(pagebuf));
+	report_prefix_push("Priv check");
+	check_pgm_int_code(PGM_INT_CODE_PRIVILEGED_OPERATION);
+	report_prefix_pop();
+}
+
+static void test_addressing(void)
+{
+	unsigned long cx, maxram = get_ram_size();
+
+	if (maxram >= 0x80000000) {
+		report_skip("Invalid SCCB address");
+		return;
+	}
+	for (cx = maxram; cx < MIN(maxram + 65536, 0x80000000); cx += 8)
+		if (!test_one_run(VALID, cx, 0, 0, PGM_BIT_ADDR, 0))
+			goto out;
+	for (; cx < MIN((maxram + 0x7fffff) & ~0xfffff, 0x80000000); cx += 4096)
+		if (!test_one_run(VALID, cx, 0, 0, PGM_BIT_ADDR, 0))
+			goto out;
+	for (; cx < 0x80000000; cx += 1048576)
+		if (!test_one_run(VALID, cx, 0, 0, PGM_BIT_ADDR, 0))
+			goto out;
+out:
+	report("Invalid SCCB address", cx == 0x80000000);
+}
+
+static void test_instbits(void)
+{
+	SCCBHeader *h = (SCCBHeader *)pagebuf;
+	unsigned long mask;
+	int cc;
+
+	sclp_mark_busy();
+	h->length = 8;
+
+	ctl_set_bit(0, 9);
+	mask = extract_psw_mask();
+	mask |= PSW_MASK_EXT;
+	load_psw_mask(mask);
+
+	asm volatile(
+		"       .insn   rre,0xb2204200,%1,%2\n"  /* servc %1,%2 */
+		"       ipm     %0\n"
+		"       srl     %0,28"
+		: "=&d" (cc) : "d" (valid_sclp_code), "a" (__pa(pagebuf))
+		: "cc", "memory");
+	sclp_wait_busy();
+	report("Instruction format ignored bits", cc == 0);
+}
+
+static void find_valid_sclp_code(void)
+{
+	unsigned int commands[] = { SCLP_CMDW_READ_SCP_INFO_FORCED,
+				    SCLP_CMDW_READ_SCP_INFO };
+	SCCBHeader *h = (SCCBHeader *)pagebuf;
+	int i, cc;
+
+	for (i = 0; i < ARRAY_SIZE(commands); i++) {
+		sclp_mark_busy();
+		memset(h, 0, sizeof(pagebuf));
+		h->length = 4096;
+
+		valid_sclp_code = commands[i];
+		cc = sclp_service_call(commands[i], h);
+		if (cc)
+			break;
+		if (h->response_code == SCLP_RC_NORMAL_READ_COMPLETION)
+			return;
+		if (h->response_code != SCLP_RC_INVALID_SCLP_COMMAND)
+			break;
+	}
+	valid_sclp_code = 0;
+	report_abort("READ_SCP_INFO failed");
+}
+
+int main(void)
+{
+	report_prefix_push("sclp");
+	find_valid_sclp_code();
+	test_instbits();
+	test_priv();
+	test_addressing();
+	test_spec();
+	test_resp();
+	return report_summary();
+}
diff --git a/s390x/unittests.cfg b/s390x/unittests.cfg
index f1b07cd..75e3d37 100644
--- a/s390x/unittests.cfg
+++ b/s390x/unittests.cfg
@@ -75,3 +75,6 @@ file = stsi.elf
 [smp]
 file = smp.elf
 extra_params =-smp 2
+
+[sclp]
+file = sclp.elf
-- 
2.7.4
