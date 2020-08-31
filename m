Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33038 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726249AbgHaMFm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 31 Aug 2020 08:05:42 -0400
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v1 2/3] s390: define UV compatible I/O allocation
Date: Mon, 31 Aug 2020 14:05:32 +0200
Message-Id: <1598875533-19947-3-git-send-email-pmorel@linux.ibm.com>
In-Reply-To: <1598875533-19947-1-git-send-email-pmorel@linux.ibm.com>
References: <1598875533-19947-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, cohuck@redhat.com

To centralize the memory allocation for I/O we define
the alloc/free_io_page() functions which share the I/O
memory with the host in case the guest runs with
protected virtualization.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 lib/s390x/malloc_io.c | 53 +++++++++++++++++++++++++++++++++++++++++++
 lib/s390x/malloc_io.h | 14 ++++++++++++
 s390x/Makefile        |  1 +
 3 files changed, 68 insertions(+)
 create mode 100644 lib/s390x/malloc_io.c
 create mode 100644 lib/s390x/malloc_io.h

diff --git a/lib/s390x/malloc_io.c b/lib/s390x/malloc_io.c
new file mode 100644
index 0000000..0e67aab
--- /dev/null
+++ b/lib/s390x/malloc_io.c
@@ -0,0 +1,53 @@
+/*
+ * I/O page allocation
+ *
+ * Copyright (c) 2020 IBM Corp
+ *
+ * Authors:
+ *  Pierre Morel <pmorel@linux.ibm.com>
+ *
+ * This code is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2.
+ *
+ * Using this interface provide host access to the allocated pages in
+ * case the guest is a secure guest.
+ * This is needed for I/O buffers.
+ *
+ */
+
+#include <libcflat.h>
+#include <alloc_page.h>
+#include <asm/page.h>
+#include <asm/uv.h>
+#include <malloc_io.h>
+#include <asm/facility.h>
+
+
+void *alloc_io_page(int size)
+{
+	void *p;
+
+	assert(size <= PAGE_SIZE);
+	p = alloc_page();
+	if (!p) {
+		report(0, "Memory allocation");
+		return NULL;
+	}
+
+	if (!test_facility(158))
+		return p;
+
+	if (!uv_set_shared((unsigned long)p)) {
+		report(0, "Sharing memory");
+		return NULL;
+	}
+
+	return p;
+}
+
+void free_io_page(void *p)
+{
+	if (test_facility(158) && !uv_remove_shared((unsigned long)p))
+		report(0, "Unsharing memory");
+	free_page(p);
+}
diff --git a/lib/s390x/malloc_io.h b/lib/s390x/malloc_io.h
new file mode 100644
index 0000000..6916f55
--- /dev/null
+++ b/lib/s390x/malloc_io.h
@@ -0,0 +1,14 @@
+/*
+ * I/O allocations
+ *
+ * Copyright (c) 2020 IBM Corp
+ *
+ * Authors:
+ *  Pierre Morel <pmorel@linux.ibm.com>
+ *
+ * This code is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2.
+ */
+
+void *alloc_io_page(int size);
+void free_io_page(void *p);
diff --git a/s390x/Makefile b/s390x/Makefile
index 9144d57..f545597 100644
--- a/s390x/Makefile
+++ b/s390x/Makefile
@@ -62,6 +62,7 @@ cflatobjs += lib/s390x/smp.o
 cflatobjs += lib/s390x/vm.o
 cflatobjs += lib/s390x/css_dump.o
 cflatobjs += lib/s390x/css_lib.o
+cflatobjs += lib/s390x/malloc_io.o
 
 OBJDIRS += lib/s390x
 
-- 
2.25.1
