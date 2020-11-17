Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33712 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726196AbgKQPnA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 17 Nov 2020 10:43:00 -0500
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH 2/5] s390x: Consolidate sclp read info
Date: Tue, 17 Nov 2020 10:42:12 -0500
Message-Id: <20201117154215.45855-3-frankja@linux.ibm.com>
In-Reply-To: <20201117154215.45855-1-frankja@linux.ibm.com>
References: <20201117154215.45855-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com

Let's only read the information once and pass a pointer to it instead
of calling sclp multiple times.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/io.c   |  1 +
 lib/s390x/sclp.c | 29 +++++++++++++++++++++++------
 lib/s390x/sclp.h |  3 +++
 lib/s390x/smp.c  | 23 +++++++++--------------
 4 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/lib/s390x/io.c b/lib/s390x/io.c
index c0f0bf7..e19a1f3 100644
--- a/lib/s390x/io.c
+++ b/lib/s390x/io.c
@@ -36,6 +36,7 @@ void setup(void)
 {
 	setup_args_progname(ipl_args);
 	setup_facilities();
+	sclp_read_info();
 	sclp_console_setup();
 	sclp_memory_setup();
 	smp_setup();
diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
index 4054d0e..ea6324e 100644
--- a/lib/s390x/sclp.c
+++ b/lib/s390x/sclp.c
@@ -25,6 +25,8 @@ extern unsigned long stacktop;
 static uint64_t storage_increment_size;
 static uint64_t max_ram_size;
 static uint64_t ram_size;
+char _read_info[PAGE_SIZE] __attribute__((__aligned__(4096)));
+static ReadInfo *read_info;
 
 char _sccb[PAGE_SIZE] __attribute__((__aligned__(4096)));
 static volatile bool sclp_busy;
@@ -110,6 +112,22 @@ static void sclp_read_scp_info(ReadInfo *ri, int length)
 	report_abort("READ_SCP_INFO failed");
 }
 
+void sclp_read_info(void)
+{
+	sclp_read_scp_info((void *)_read_info, SCCB_SIZE);
+	read_info = (ReadInfo *)_read_info;
+}
+
+int sclp_get_cpu_num(void)
+{
+	return read_info->entries_cpu;
+}
+
+CPUEntry *sclp_get_cpu_entries(void)
+{
+	return (void *)read_info + read_info->offset_cpu;
+}
+
 /* Perform service call. Return 0 on success, non-zero otherwise. */
 int sclp_service_call(unsigned int command, void *sccb)
 {
@@ -127,23 +145,22 @@ int sclp_service_call(unsigned int command, void *sccb)
 
 void sclp_memory_setup(void)
 {
-	ReadInfo *ri = (void *)_sccb;
 	uint64_t rnmax, rnsize;
 	int cc;
 
-	sclp_read_scp_info(ri, SCCB_SIZE);
+	assert(read_info);
 
 	/* calculate the storage increment size */
-	rnsize = ri->rnsize;
+	rnsize = read_info->rnsize;
 	if (!rnsize) {
-		rnsize = ri->rnsize2;
+		rnsize = read_info->rnsize2;
 	}
 	storage_increment_size = rnsize << 20;
 
 	/* calculate the maximum memory size */
-	rnmax = ri->rnmax;
+	rnmax = read_info->rnmax;
 	if (!rnmax) {
-		rnmax = ri->rnmax2;
+		rnmax = read_info->rnmax2;
 	}
 	max_ram_size = rnmax * storage_increment_size;
 
diff --git a/lib/s390x/sclp.h b/lib/s390x/sclp.h
index 675f07e..6620531 100644
--- a/lib/s390x/sclp.h
+++ b/lib/s390x/sclp.h
@@ -271,6 +271,9 @@ void sclp_wait_busy(void);
 void sclp_mark_busy(void);
 void sclp_console_setup(void);
 void sclp_print(const char *str);
+void sclp_read_info(void);
+int sclp_get_cpu_num(void);
+CPUEntry *sclp_get_cpu_entries(void);
 int sclp_service_call(unsigned int command, void *sccb);
 void sclp_memory_setup(void);
 uint64_t get_ram_size(void);
diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
index 2860e9c..6754061 100644
--- a/lib/s390x/smp.c
+++ b/lib/s390x/smp.c
@@ -34,8 +34,7 @@ extern void smp_cpu_setup_state(void);
 
 int smp_query_num_cpus(void)
 {
-	struct ReadCpuInfo *info = (void *)cpu_info_buffer;
-	return info->nr_configured;
+	return sclp_get_cpu_num();
 }
 
 struct cpu *smp_cpu_from_addr(uint16_t addr)
@@ -245,22 +244,18 @@ extern uint64_t *stackptr;
 void smp_setup(void)
 {
 	int i = 0;
+	int num = smp_query_num_cpus();
 	unsigned short cpu0_addr = stap();
-	struct ReadCpuInfo *info = (void *)cpu_info_buffer;
+	struct CPUEntry *entry = sclp_get_cpu_entries();
 
-	spin_lock(&lock);
-	sclp_mark_busy();
-	info->h.length = PAGE_SIZE;
-	sclp_service_call(SCLP_READ_CPU_INFO, cpu_info_buffer);
+	if (num > 1)
+		printf("SMP: Initializing, found %d cpus\n", num);
 
-	if (smp_query_num_cpus() > 1)
-		printf("SMP: Initializing, found %d cpus\n", info->nr_configured);
-
-	cpus = calloc(info->nr_configured, sizeof(cpus));
-	for (i = 0; i < info->nr_configured; i++) {
-		cpus[i].addr = info->entries[i].address;
+	cpus = calloc(num, sizeof(cpus));
+	for (i = 0; i < num; i++) {
+		cpus[i].addr = entry[i].address;
 		cpus[i].active = false;
-		if (info->entries[i].address == cpu0_addr) {
+		if (entry[i].address == cpu0_addr) {
 			cpu0 = &cpus[i];
 			cpu0->stack = stackptr;
 			cpu0->lowcore = (void *)0;
-- 
2.25.1
