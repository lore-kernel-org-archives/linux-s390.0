From: Eugene Syromyatnikov <evgsyr@gmail.com>
Date: Thu, 18 Jan 2018 06:17:03 +0000
Subject: [strace PATCH 10/12] Introduce s390_pci_mmio_read, s390_pci_mmio_write system call decoders
Message-Id: <20180118061703.GA29235@asgard.redhat.com>
To: linux-s390@vger.kernel.org, strace@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

* linux/s390/syscallent.h ([352]): Change decoder to s390_pci_mmio_write.
([353]): Change decoder to s390_pci_mmio_read.
* linux/s390x/syscallent.h: Likewise.
* s390.c (SYS_FUNC(s390_pci_mmio_write), SYS_FUNC(s390_pci_mmio_read)):
New function.
---
 linux/s390/syscallent.h  |  4 ++--
 linux/s390x/syscallent.h |  4 ++--
 s390.c                   | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/linux/s390/syscallent.h b/linux/s390/syscallent.h
index a807c95..d34cd42 100644
--- a/linux/s390/syscallent.h
+++ b/linux/s390/syscallent.h
@@ -381,8 +381,8 @@
 [349] = { 3,	0,		SEN(getrandom),			"getrandom"		},
 [350] = { 2,	TD,		SEN(memfd_create),		"memfd_create"		},
 [351] = { 3,	TD,		SEN(bpf),			"bpf"			},
-[352] = { 3,	0,		SEN(printargs),			"s390_pci_mmio_write"	},
-[353] = { 3,	0,		SEN(printargs),			"s390_pci_mmio_read"	},
+[352] = { 3,	0,		SEN(s390_pci_mmio_write),	"s390_pci_mmio_write"	},
+[353] = { 3,	0,		SEN(s390_pci_mmio_read),	"s390_pci_mmio_read"	},
 [354] = { 5,	TD|TF|TP|SE|SI,	SEN(execveat),			"execveat"		},
 [355] = { 1,	TD,		SEN(userfaultfd),		"userfaultfd"		},
 [356] = { 2,	0,		SEN(membarrier),		"membarrier"		},
diff --git a/linux/s390x/syscallent.h b/linux/s390x/syscallent.h
index c4a770d..0c84274 100644
--- a/linux/s390x/syscallent.h
+++ b/linux/s390x/syscallent.h
@@ -365,8 +365,8 @@
 [349] = { 3,	0,		SEN(getrandom),			"getrandom"		},
 [350] = { 2,	TD,		SEN(memfd_create),		"memfd_create"		},
 [351] = { 3,	TD,		SEN(bpf),			"bpf"			},
-[352] = { 3,	0,		SEN(printargs),			"s390_pci_mmio_write"	},
-[353] = { 3,	0,		SEN(printargs),			"s390_pci_mmio_read"	},
+[352] = { 3,	0,		SEN(s390_pci_mmio_write),	"s390_pci_mmio_write"	},
+[353] = { 3,	0,		SEN(s390_pci_mmio_read),	"s390_pci_mmio_read"	},
 [354] = { 5,	TD|TF|TP|SE|SI,	SEN(execveat),			"execveat"		},
 [355] = { 1,	TD,		SEN(userfaultfd),		"userfaultfd"		},
 [356] = { 2,	0,		SEN(membarrier),		"membarrier"		},
diff --git a/s390.c b/s390.c
index dc7bf36..4b23e7a 100644
--- a/s390.c
+++ b/s390.c
@@ -1241,4 +1241,37 @@ SYS_FUNC(s390_runtime_instr)
 	return RVAL_DECODED;
 }
 
+SYS_FUNC(s390_pci_mmio_write)
+{
+	kernel_ulong_t mmio_addr = tcp->u_arg[0];
+	kernel_ulong_t user_buf  = tcp->u_arg[1];
+	kernel_ulong_t length    = tcp->u_arg[2];
+
+	tprintf("%#" PRI_klx ", ", mmio_addr);
+	printstr_ex(tcp, user_buf, length, QUOTE_FORCE_HEX);
+	tprintf(", %" PRI_klu, length);
+
+	return RVAL_DECODED;
+}
+
+SYS_FUNC(s390_pci_mmio_read)
+{
+	kernel_ulong_t mmio_addr = tcp->u_arg[0];
+	kernel_ulong_t user_buf  = tcp->u_arg[1];
+	kernel_ulong_t length    = tcp->u_arg[2];
+
+	if (entering(tcp)) {
+		tprintf("%#" PRI_klx ", ", mmio_addr);
+	} else {
+		if (!syserror(tcp))
+			printstr_ex(tcp, user_buf, length, QUOTE_FORCE_HEX);
+		else
+			printaddr(user_buf);
+
+		tprintf(", %" PRI_klu, length);
+	}
+
+	return 0;
+}
+
 #endif /* defined S390 || defined S390X */
-- 
2.1.4
