From: Eugene Syromyatnikov <evgsyr@gmail.com>
Date: Thu, 18 Jan 2018 06:16:57 +0000
Subject: [strace PATCH 08/12] Introduce s390_runtime_instr system call decoder
Message-Id: <20180118061657.GA29123@asgard.redhat.com>
To: linux-s390@vger.kernel.org, strace@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

* linux/s390/syscallent.h ([342]): Change decoder to s390_runtime_instr.
* linux/s390x/syscallent.h: Likewise.
* s390.c (SYS_FUNC(s390_runtime_instr)): New function.
* xlat/s390_runtime_instr_commands.in: New file.
---
 linux/s390/syscallent.h             |  2 +-
 linux/s390x/syscallent.h            |  2 +-
 s390.c                              | 31 +++++++++++++++++++++++++++++++
 xlat/s390_runtime_instr_commands.in |  2 ++
 4 files changed, 35 insertions(+), 2 deletions(-)
 create mode 100644 xlat/s390_runtime_instr_commands.in

diff --git a/linux/s390/syscallent.h b/linux/s390/syscallent.h
index 522c641..a807c95 100644
--- a/linux/s390/syscallent.h
+++ b/linux/s390/syscallent.h
@@ -371,7 +371,7 @@
 [339] = { 2,	TD,		SEN(setns),			"setns"			},
 [340] = { 6,	0,		SEN(process_vm_readv),		"process_vm_readv"	},
 [341] = { 6,	0,		SEN(process_vm_writev),		"process_vm_writev"	},
-[342] = { 2,	0,		SEN(printargs),			"s390_runtime_instr"	},
+[342] = { 2,	0,		SEN(s390_runtime_instr),	"s390_runtime_instr"	},
 [343] = { 5,	0,		SEN(kcmp),			"kcmp"			},
 [344] = { 3,	TD,		SEN(finit_module),		"finit_module"		},
 [345] = { 3,	0,		SEN(sched_setattr),		"sched_setattr"		},
diff --git a/linux/s390x/syscallent.h b/linux/s390x/syscallent.h
index 8e068c9..c4a770d 100644
--- a/linux/s390x/syscallent.h
+++ b/linux/s390x/syscallent.h
@@ -355,7 +355,7 @@
 [339] = { 2,	TD,		SEN(setns),			"setns"			},
 [340] = { 6,	0,		SEN(process_vm_readv),		"process_vm_readv"	},
 [341] = { 6,	0,		SEN(process_vm_writev),		"process_vm_writev"	},
-[342] = { 2,	0,		SEN(printargs),			"s390_runtime_instr"	},
+[342] = { 2,	0,		SEN(s390_runtime_instr),	"s390_runtime_instr"	},
 [343] = { 5,	0,		SEN(kcmp),			"kcmp"			},
 [344] = { 3,	TD,		SEN(finit_module),		"finit_module"		},
 [345] = { 3,	0,		SEN(sched_setattr),		"sched_setattr"		},
diff --git a/s390.c b/s390.c
index a7efd29..dc7bf36 100644
--- a/s390.c
+++ b/s390.c
@@ -36,6 +36,7 @@
 #include "print_fields.h"
 
 #include "xlat/s390_guarded_storage_commands.h"
+#include "xlat/s390_runtime_instr_commands.h"
 #include "xlat/s390_sthyi_function_codes.h"
 
 /*
@@ -1210,4 +1211,34 @@ SYS_FUNC(s390_guarded_storage)
 	return RVAL_DECODED;
 }
 
+SYS_FUNC(s390_runtime_instr)
+{
+	int command = (int) tcp->u_arg[0];
+	int signum = (int) tcp->u_arg[1];
+
+	const char *command_descr =
+		xlookup(s390_runtime_instr_commands, command);
+
+	tprintf("%d", command);
+	tprints_comment(command_descr ? command_descr :
+			"S390_RUNTIME_INSTR_???");
+
+	/*
+	 * signum is ignored since Linux 4.4, but let's print it for start
+	 * command anyway.
+	 */
+	switch (command) {
+	case S390_RUNTIME_INSTR_START:
+		tprints(", ");
+		tprints(signame(signum));
+		break;
+
+	case S390_RUNTIME_INSTR_STOP:
+	default:
+		break;
+	}
+
+	return RVAL_DECODED;
+}
+
 #endif /* defined S390 || defined S390X */
diff --git a/xlat/s390_runtime_instr_commands.in b/xlat/s390_runtime_instr_commands.in
new file mode 100644
index 0000000..395afc4
--- /dev/null
+++ b/xlat/s390_runtime_instr_commands.in
@@ -0,0 +1,2 @@
+S390_RUNTIME_INSTR_START	0x1
+S390_RUNTIME_INSTR_STOP		0x2
-- 
2.1.4
