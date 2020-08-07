Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61440 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726398AbgHGLQH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 7 Aug 2020 07:16:07 -0400
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v2 2/3] s390x: skrf: Add exception new skey test and add test to unittests.cfg
Date: Fri,  7 Aug 2020 07:15:54 -0400
Message-Id: <20200807111555.11169-3-frankja@linux.ibm.com>
In-Reply-To: <20200807111555.11169-1-frankja@linux.ibm.com>
References: <20200807111555.11169-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com, imbrenda@linux.ibm.com

When an exception new psw with a storage key in its mask is loaded
from lowcore, a specification exception is raised. This differs from
the behavior when trying to execute skey related instructions, which
will result in special operation exceptions.

Also let's add the test to unittests.cfg so it is run more often.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 s390x/skrf.c        | 79 +++++++++++++++++++++++++++++++++++++++++++++
 s390x/unittests.cfg |  4 +++
 2 files changed, 83 insertions(+)

diff --git a/s390x/skrf.c b/s390x/skrf.c
index 9cae589..b19d0f4 100644
--- a/s390x/skrf.c
+++ b/s390x/skrf.c
@@ -11,12 +11,16 @@
  */
 #include <libcflat.h>
 #include <asm/asm-offsets.h>
+#include <asm-generic/barrier.h>
 #include <asm/interrupt.h>
 #include <asm/page.h>
 #include <asm/facility.h>
 #include <asm/mem.h>
+#include <asm/sigp.h>
+#include <smp.h>
 
 static uint8_t pagebuf[PAGE_SIZE * 2] __attribute__((aligned(PAGE_SIZE * 2)));
+static int testflag = 0;
 
 static void test_facilities(void)
 {
@@ -106,6 +110,80 @@ static void test_tprot(void)
 	report_prefix_pop();
 }
 
+static void wait_for_flag(void)
+{
+	while (!testflag)
+		mb();
+}
+
+static void set_flag(int val)
+{
+	mb();
+	testflag = val;
+	mb();
+}
+
+static void ecall_cleanup(void)
+{
+	struct lowcore *lc = (void *)0x0;
+
+	lc->ext_new_psw.mask = 0x0000000180000000UL;
+	lc->sw_int_crs[0] = 0x0000000000040000;
+
+	/*
+	 * PGM old contains the ext new PSW, we need to clean it up,
+	 * so we don't get a special operation exception on the lpswe
+	 * of pgm old.
+	 */
+	lc->pgm_old_psw.mask = 0x0000000180000000UL;
+
+	check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
+	set_flag(1);
+}
+
+/* Set a key into the external new psw mask and open external call masks */
+static void ecall_setup(void)
+{
+	struct lowcore *lc = (void *)0x0;
+	uint64_t mask;
+
+	register_pgm_cleanup_func(ecall_cleanup);
+	expect_pgm_int();
+	/* Put a skey into the ext new psw */
+	lc->ext_new_psw.mask = 0x00F0000180000000UL;
+	/* Open up ext masks */
+	ctl_set_bit(0, 13);
+	mask = extract_psw_mask();
+	mask |= PSW_MASK_EXT;
+	load_psw_mask(mask);
+	/* Tell cpu 0 that we're ready */
+	set_flag(1);
+}
+
+static void test_exception_ext_new(void)
+{
+	struct psw psw = {
+		.mask = extract_psw_mask(),
+		.addr = (unsigned long)ecall_setup
+	};
+
+	report_prefix_push("exception external new");
+	if (smp_query_num_cpus() < 2) {
+		report_skip("Need second cpu for exception external new test.");
+		report_prefix_pop();
+		return;
+	}
+
+	smp_cpu_setup(1, psw);
+	wait_for_flag();
+	set_flag(0);
+
+	sigp(1, SIGP_EXTERNAL_CALL, 0, NULL);
+	wait_for_flag();
+	smp_cpu_stop(1);
+	report_prefix_pop();
+}
+
 int main(void)
 {
 	report_prefix_push("skrf");
@@ -121,6 +199,7 @@ int main(void)
 	test_mvcos();
 	test_spka();
 	test_tprot();
+	test_exception_ext_new();
 
 done:
 	report_prefix_pop();
diff --git a/s390x/unittests.cfg b/s390x/unittests.cfg
index 0f156af..b35269b 100644
--- a/s390x/unittests.cfg
+++ b/s390x/unittests.cfg
@@ -88,3 +88,7 @@ extra_params = -m 3G
 [css]
 file = css.elf
 extra_params = -device virtio-net-ccw
+
+[skrf]
+file = skrf.elf
+smp = 2
-- 
2.25.1
