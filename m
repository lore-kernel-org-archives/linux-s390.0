Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23184 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729101AbgFHINM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 8 Jun 2020 04:13:12 -0400
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v8 08/12] s390x: retrieve decimal and hexadecimal kernel parameters
Date: Mon,  8 Jun 2020 10:12:57 +0200
Message-Id: <1591603981-16879-9-git-send-email-pmorel@linux.ibm.com>
In-Reply-To: <1591603981-16879-1-git-send-email-pmorel@linux.ibm.com>
References: <1591603981-16879-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, cohuck@redhat.com

We often need to retrieve hexadecimal kernel parameters.
Let's implement a shared utility to do it.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 lib/s390x/kernel-args.c | 60 +++++++++++++++++++++++++++++++++++++++++
 lib/s390x/kernel-args.h | 18 +++++++++++++
 s390x/Makefile          |  1 +
 3 files changed, 79 insertions(+)
 create mode 100644 lib/s390x/kernel-args.c
 create mode 100644 lib/s390x/kernel-args.h

diff --git a/lib/s390x/kernel-args.c b/lib/s390x/kernel-args.c
new file mode 100644
index 0000000..3335fbf
--- /dev/null
+++ b/lib/s390x/kernel-args.c
@@ -0,0 +1,60 @@
+/*
+ * Retrieving kernel arguments
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
+#include <libcflat.h>
+#include <string.h>
+#include <asm/arch_def.h>
+#include <kernel-args.h>
+
+static const char *hex_digit = "0123456789abcdef";
+
+static unsigned long htol(char *s)
+{
+	unsigned long v = 0, shift = 0, value = 0;
+	int i, digit, len = strlen(s);
+
+	for (shift = 0, i = len - 1; i >= 0; i--, shift += 4) {
+		digit = s[i] | 0x20;	/* Set lowercase */
+		if (!strchr(hex_digit, digit))
+			return 0;	/* this is not a digit ! */
+
+		if (digit <= '9')
+			v = digit - '0';
+		else
+			v = digit - 'a' + 10;
+		value += (v << shift);
+	}
+
+	return value;
+}
+
+int kernel_arg(int argc, char *argv[], const char *str, unsigned long *val)
+{
+	int i, ret;
+	char *p;
+
+	for (i = 0; i < argc; i++) {
+		ret = strncmp(argv[i], str, strlen(str));
+		if (ret)
+			continue;
+		p = strchr(argv[i], '=');
+		if (!p)
+			return -1;
+		p = strchr(p, 'x');
+		if (!p)
+			*val = atol(p + 1);
+		else
+			*val = htol(p + 1);
+		return 0;
+	}
+	return -2;
+}
diff --git a/lib/s390x/kernel-args.h b/lib/s390x/kernel-args.h
new file mode 100644
index 0000000..a88e34e
--- /dev/null
+++ b/lib/s390x/kernel-args.h
@@ -0,0 +1,18 @@
+/*
+ * Kernel argument
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
+#ifndef KERNEL_ARGS_H
+#define KERNEL_ARGS_H
+
+int kernel_arg(int argc, char *argv[], const char *str, unsigned long *val);
+
+#endif
diff --git a/s390x/Makefile b/s390x/Makefile
index ddb4b48..47a94cc 100644
--- a/s390x/Makefile
+++ b/s390x/Makefile
@@ -51,6 +51,7 @@ cflatobjs += lib/s390x/sclp-console.o
 cflatobjs += lib/s390x/interrupt.o
 cflatobjs += lib/s390x/mmu.o
 cflatobjs += lib/s390x/smp.o
+cflatobjs += lib/s390x/kernel-args.o
 
 OBJDIRS += lib/s390x
 
-- 
2.25.1
