Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55954 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726327AbgI1OXq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 28 Sep 2020 10:23:46 -0400
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v2 3/4] s390x: define UV compatible I/O allocation
Date: Mon, 28 Sep 2020 16:23:36 +0200
Message-Id: <1601303017-8176-4-git-send-email-pmorel@linux.ibm.com>
In-Reply-To: <1601303017-8176-1-git-send-email-pmorel@linux.ibm.com>
References: <1601303017-8176-1-git-send-email-pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com

To centralize the memory allocation for I/O we define
the alloc/free_io_page() functions which share the I/O
memory with the host in case the guest runs with
protected virtualization.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 lib/s390x/malloc_io.c | 49 +++++++++++++++++++++++++++++++++++++++++++
 lib/s390x/malloc_io.h | 18 ++++++++++++++++
 s390x/Makefile        |  1 +
 3 files changed, 68 insertions(+)
 create mode 100644 lib/s390x/malloc_io.c
 create mode 100644 lib/s390x/malloc_io.h

diff --git a/lib/s390x/malloc_io.c b/lib/s390x/malloc_io.c
new file mode 100644
index 0000000..388e568
--- /dev/null
+++ b/lib/s390x/malloc_io.c
@@ -0,0 +1,49 @@
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
+#include <libcflat.h>
+#include <alloc_dma_page.h>
+#include <asm/uv.h>
+#include <malloc_io.h>
+#include <asm/facility.h>
+
+void *alloc_io_page(int size)
+{
+	void *p;
+
+	assert(size <= PAGE_SIZE);
+
+	p = get_dma_page();
+	if (!p)
+		return NULL;
+	memset(p, 0, PAGE_SIZE);
+
+	if (!test_facility(158))
+		return p;
+
+	if (uv_set_shared((unsigned long)p) == 0)
+		return p;
+
+	put_dma_page(p);
+	return NULL;
+}
+
+void free_io_page(void *p)
+{
+	if (test_facility(158))
+		uv_remove_shared((unsigned long)p);
+	put_dma_page(p);
+}
diff --git a/lib/s390x/malloc_io.h b/lib/s390x/malloc_io.h
new file mode 100644
index 0000000..c6ed481
--- /dev/null
+++ b/lib/s390x/malloc_io.h
@@ -0,0 +1,18 @@
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
+#ifndef _S390X_MALLOC_IO_H_
+#define _S390X_MALLOC_IO_H_
+
+void *alloc_io_page(int size);
+void free_io_page(void *p);
+
+#endif /* _S390X_MALLOC_IO_H_ */
diff --git a/s390x/Makefile b/s390x/Makefile
index 109ef9f..1b1dc9f 100644
--- a/s390x/Makefile
+++ b/s390x/Makefile
@@ -63,6 +63,7 @@ cflatobjs += lib/s390x/smp.o
 cflatobjs += lib/s390x/vm.o
 cflatobjs += lib/s390x/css_dump.o
 cflatobjs += lib/s390x/css_lib.o
+cflatobjs += lib/s390x/malloc_io.o
 
 OBJDIRS += lib/s390x
 
-- 
2.25.1
