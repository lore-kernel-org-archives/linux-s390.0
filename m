Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 1/1] livepatch: add support on s390
Date: Tue, 24 Mar 2015 15:51:30 +0100
Message-Id: <1427208690-30839-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: jkosina@suse.cz
Cc: jpoimboe@redhat.com, sjenning@redhat.com, vojtech@suse.cz, live-patching@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-ID: <linux-s390.vger.kernel.org>

This is a trivial port from kGraft. Module relocations are not
supported.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/s390/Kconfig                 |  3 +++
 arch/s390/include/asm/livepatch.h | 43 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 arch/s390/include/asm/livepatch.h

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 6df439c9e13c..e24523bf1b77 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -135,6 +135,7 @@ config S390
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
 	select HAVE_KVM
+	select HAVE_LIVEPATCH
 	select HAVE_MEMBLOCK
 	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_MEMBLOCK_PHYS_MAP
@@ -167,6 +168,8 @@ source "kernel/Kconfig.freezer"
 
 source "kernel/Kconfig.kgraft"
 
+source "kernel/livepatch/Kconfig"
+
 menu "Processor type and features"
 
 config HAVE_MARCH_Z900_FEATURES
diff --git a/arch/s390/include/asm/livepatch.h b/arch/s390/include/asm/livepatch.h
new file mode 100644
index 000000000000..0621d322ae0b
--- /dev/null
+++ b/arch/s390/include/asm/livepatch.h
@@ -0,0 +1,43 @@
+/*
+ * livepatch.h - s390-specific Kernel Live Patching Core
+ *
+ *  Copyright (c) 2013-2015 SUSE
+ *   Authors: Jiri Kosina
+ *	      Vojtech Pavlik
+ *	      Jiri Slaby
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ */
+
+#ifndef ASM_LIVEPATCH_H
+#define ASM_LIVEPATCH_H
+
+#include <linux/module.h>
+
+#ifdef CONFIG_LIVEPATCH
+static inline int klp_check_compiler_support(void)
+{
+	return 1;
+}
+
+static inline int klp_write_module_reloc(struct module *mod, unsigned long
+		type, unsigned long loc, unsigned long value)
+{
+	/* not supported yet */
+	return -EINVAL;
+}
+
+static inline void klp_arch_set_pc(struct pt_regs *regs, unsigned long ip)
+{
+	regs->psw.addr = ip;
+}
+#else
+#error Live patching support is disabled; check CONFIG_LIVEPATCH
+#endif
+
+#endif
-- 
2.3.3
