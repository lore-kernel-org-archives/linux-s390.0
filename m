Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60736 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728578AbgC3PeN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 30 Mar 2020 11:34:13 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02UFXnVw006484
        for <linux-s390@vger.kernel.org>; Mon, 30 Mar 2020 11:34:12 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3022nmemnu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 30 Mar 2020 11:34:11 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Mon, 30 Mar 2020 16:34:03 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v2] s390x: Add stsi 3.2.2 tests
Date: Mon, 30 Mar 2020 11:33:59 -0400
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200330153359.2386-1-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com

Subcode 3.2.2 is handled by KVM/QEMU and should therefore be tested
a bit more thorough.

In this test we set a custom name and uuid through the QEMU command
line. Both parameters will be passed to the guest on a stsi subcode
3.2.2 call and will then be checked.

We also compare the configured cpu numbers against the smp reported
numbers and if the reserved + configured add up to the total number
reported.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 s390x/stsi.c        | 72 +++++++++++++++++++++++++++++++++++++++++++++
 s390x/unittests.cfg |  1 +
 2 files changed, 73 insertions(+)

diff --git a/s390x/stsi.c b/s390x/stsi.c
index e9206bca137d2edb..a291fd828347018a 100644
--- a/s390x/stsi.c
+++ b/s390x/stsi.c
@@ -14,7 +14,28 @@
 #include <asm/page.h>
 #include <asm/asm-offsets.h>
 #include <asm/interrupt.h>
+#include <smp.h>
 
+struct stsi_322 {
+    uint8_t reserved[31];
+    uint8_t count;
+    struct {
+        uint8_t reserved2[4];
+        uint16_t total_cpus;
+        uint16_t conf_cpus;
+        uint16_t standby_cpus;
+        uint16_t reserved_cpus;
+        uint8_t name[8];
+        uint32_t caf;
+        uint8_t cpi[16];
+        uint8_t reserved5[3];
+        uint8_t ext_name_encoding;
+        uint32_t reserved3;
+        uint8_t uuid[16];
+    } vm[8];
+    uint8_t reserved4[1504];
+    uint8_t ext_names[8][256];
+};
 static uint8_t pagebuf[PAGE_SIZE * 2] __attribute__((aligned(PAGE_SIZE * 2)));
 
 static void test_specs(void)
@@ -76,11 +97,62 @@ static void test_fc(void)
 	report(stsi_get_fc(pagebuf) >= 2, "query fc >= 2");
 }
 
+static void test_3_2_2(void)
+{
+	int rc;
+	/* EBCDIC for "kvm-unit" */
+	const uint8_t vm_name[] = { 0x92, 0xa5, 0x94, 0x60, 0xa4, 0x95, 0x89,
+				    0xa3 };
+	const uint8_t uuid[] = { 0x0f, 0xb8, 0x4a, 0x86, 0x72, 0x7c,
+				 0x11, 0xea, 0xbc, 0x55, 0x02, 0x42, 0xac, 0x13,
+				 0x00, 0x03 };
+	/* EBCDIC for "KVM/" */
+	const uint8_t cpi_kvm[] = { 0xd2, 0xe5, 0xd4, 0x61 };
+	const char *vm_name_ext = "kvm-unit-test";
+	struct stsi_322 *data = (void *)pagebuf;
+
+	/* Is the function code available at all? */
+	if (stsi_get_fc(pagebuf) < 3) {
+		report_skip("Running under lpar, no level 3 to test.");
+		return;
+	}
+
+	report_prefix_push("3.2.2");
+	rc = stsi(pagebuf, 3, 2, 2);
+	report(!rc, "call");
+
+	/* For now we concentrate on KVM/QEMU */
+	if (memcmp(&data->vm[0].cpi, cpi_kvm, sizeof(cpi_kvm))) {
+		report_skip("Not running under KVM/QEMU.");
+		goto out;
+	}
+
+	report(!memcmp(data->vm[0].uuid, uuid, sizeof(uuid)), "uuid");
+	report(data->vm[0].conf_cpus == smp_query_num_cpus(), "cpu # configured");
+	report(data->vm[0].total_cpus ==
+	       data->vm[0].reserved_cpus + data->vm[0].conf_cpus,
+	       "cpu # total == conf + reserved");
+	report(data->vm[0].standby_cpus == 0, "cpu # standby");
+	report(!memcmp(data->vm[0].name, vm_name, sizeof(data->vm[0].name)),
+	       "VM name == kvm-unit-test");
+
+	if (data->vm[0].ext_name_encoding != 2) {
+		report_skip("Extended VM names are not UTF-8.");
+		return;
+	}
+	report(!memcmp(data->ext_names[0], vm_name_ext, sizeof(vm_name_ext)),
+		       "ext VM name == kvm-unit-test");
+
+out:
+	report_prefix_pop();
+}
+
 int main(void)
 {
 	report_prefix_push("stsi");
 	test_priv();
 	test_specs();
 	test_fc();
+	test_3_2_2();
 	return report_summary();
 }
diff --git a/s390x/unittests.cfg b/s390x/unittests.cfg
index 12d46c5b402328bb..06e556836c102a14 100644
--- a/s390x/unittests.cfg
+++ b/s390x/unittests.cfg
@@ -71,6 +71,7 @@ extra_params=-device diag288,id=watchdog0 --watchdog-action inject-nmi
 
 [stsi]
 file = stsi.elf
+extra_params=-name kvm-unit-test --uuid 0fb84a86-727c-11ea-bc55-0242ac130003 -smp 1,maxcpus=8
 
 [smp]
 file = smp.elf
-- 
2.25.1
