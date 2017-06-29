From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Thu, 29 Jun 2017 19:24:37 +0000
Subject: [CRIU][PATCH v2 09/17] s390:zdtm: Add test for tasks > 4TB
Message-Id: <20170629192445.55580-10-holzheu@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

If the kernel contains patch ee71d16d22 ("s390/mm: make TASK_SIZE
independent from the number of page table levels") we are able
to checkpoint tasks > 4TB.

Add a testcase to verify this.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 test/zdtm/static/Makefile             |  1 +
 test/zdtm/static/s390x_mmap_high.c    | 64 +++++++++++++++++++++++++++++++++++
 test/zdtm/static/s390x_mmap_high.desc |  1 +
 3 files changed, 66 insertions(+)
 create mode 100644 test/zdtm/static/s390x_mmap_high.c
 create mode 100644 test/zdtm/static/s390x_mmap_high.desc

diff --git a/test/zdtm/static/Makefile b/test/zdtm/static/Makefile
index 2c6353e..12aa4f1 100644
--- a/test/zdtm/static/Makefile
+++ b/test/zdtm/static/Makefile
@@ -185,6 +185,7 @@ TST_NOFILE	:=				\
 		pidns01				\
 		pidns02				\
 		pidns03				\
+		s390x_mmap_high			\
 #		jobctl00			\
 
 ifneq ($(SRCARCH),arm)
diff --git a/test/zdtm/static/s390x_mmap_high.c b/test/zdtm/static/s390x_mmap_high.c
new file mode 100644
index 0000000..5eb06e6
--- /dev/null
+++ b/test/zdtm/static/s390x_mmap_high.c
@@ -0,0 +1,64 @@
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <unistd.h>
+
+#include "zdtmtst.h"
+
+#define TASK_SIZE_LEVEL_4	0x20000000000000UL	/* 8 PB */
+#define MAP_SIZE	0x1000
+#define VAL		0x77
+
+const char *test_doc	= "Verify that tasks > 4TB can be checkpointed";
+const char *test_author	= "Michael Holzheu <holzheu@linux.vnet.ibm.com>";
+
+/*
+ * Map memory at the very end of the 8 PB address space
+ */
+int main(int argc, char **argv)
+{
+	void *addr = (void *) TASK_SIZE_LEVEL_4 - MAP_SIZE;
+	char *buf;
+	int i;
+
+
+	test_init(argc, argv);
+
+	/*
+	 * Skip test if kernel does not have the following fix:
+	 *
+	 * ee71d16d22 ("s390/mm: make TASK_SIZE independent from the number
+	 *              of page table levels")
+	 */
+	if (munmap(addr, MAP_SIZE) == -1) {
+		test_daemon();
+		test_waitsig();
+		skip("Detected kernel without 4 level TASK_SIZE fix");
+		pass();
+		return 0;
+	}
+
+	/* Map memory at the very end of the 8 PB address space */
+	buf = mmap(addr, MAP_SIZE, PROT_WRITE | PROT_READ,
+			MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	if (buf == MAP_FAILED) {
+		pr_perror("Could not create mapping");
+		exit(1);
+	}
+	/* Initialize buffer with data */
+	memset(buf, VAL, MAP_SIZE);
+
+	test_daemon();
+	test_waitsig();
+
+	/* Verify that we restored the data correctly */
+	for (i = 0; i < MAP_SIZE; i++) {
+		if (buf[i] == VAL)
+			continue;
+		fail("%d: %d != %d\n", i, buf[i], VAL);
+		goto out;
+	}
+	pass();
+out:
+	return 0;
+}
diff --git a/test/zdtm/static/s390x_mmap_high.desc b/test/zdtm/static/s390x_mmap_high.desc
new file mode 100644
index 0000000..8621263
--- /dev/null
+++ b/test/zdtm/static/s390x_mmap_high.desc
@@ -0,0 +1 @@
+{'arch': 's390x'}
-- 
2.7.4
