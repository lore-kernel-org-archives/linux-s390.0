From: Eugene Syromyatnikov <evgsyr@gmail.com>
Date: Thu, 18 Jan 2018 06:16:51 +0000
Subject: [strace PATCH 06/12] Introduce s390_guarded_storage system call decoder
Message-Id: <20180118061651.GA29031@asgard.redhat.com>
To: linux-s390@vger.kernel.org, strace@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

* linux/s390/syscallent.h ([378]): Change decoder to s390_guarded_storage.
* linux/s390x/syscallent.h: Likewise.
* s390.c (struct guard_storage_control_block,
struct guard_storage_event_parameter_list): New structure type
definition.
(guard_storage_print_gsepl, guard_storage_print_gscb,
SYS_FUNC(s390_guarded_storage)): New function.
(DIV_ROUND_UP): New macro.
* xlat/s390_guarded_storage_commands.in: New file.
---
 linux/s390/syscallent.h               |   2 +-
 linux/s390x/syscallent.h              |   2 +-
 s390.c                                | 180 ++++++++++++++++++++++++++++++++++
 xlat/s390_guarded_storage_commands.in |   5 +
 4 files changed, 187 insertions(+), 2 deletions(-)
 create mode 100644 xlat/s390_guarded_storage_commands.in

diff --git a/linux/s390/syscallent.h b/linux/s390/syscallent.h
index dd1fbb1..522c641 100644
--- a/linux/s390/syscallent.h
+++ b/linux/s390/syscallent.h
@@ -407,7 +407,7 @@
 [375] = { 6,	TD,		SEN(copy_file_range),		"copy_file_range"	},
 [376] = { 6,	TD,		SEN(preadv2),			"preadv2"		},
 [377] = { 6,	TD,		SEN(pwritev2),			"pwritev2"		},
-[378] = { 2,	0,		SEN(printargs),			"s390_guarded_storage"	},
+[378] = { 2,	0,		SEN(s390_guarded_storage),	"s390_guarded_storage"	},
 [379] = { 5,	TD|TF|TSTA,	SEN(statx),			"statx"			},
 [380] = { 4,	0,		SEN(s390_sthyi),		"s390_sthyi"		},
 
diff --git a/linux/s390x/syscallent.h b/linux/s390x/syscallent.h
index fe5b252..8e068c9 100644
--- a/linux/s390x/syscallent.h
+++ b/linux/s390x/syscallent.h
@@ -391,7 +391,7 @@
 [375] = { 6,	TD,		SEN(copy_file_range),		"copy_file_range"	},
 [376] = { 6,	TD,		SEN(preadv2),			"preadv2"		},
 [377] = { 6,	TD,		SEN(pwritev2),			"pwritev2"		},
-[378] = { 2,	0,		SEN(printargs),			"s390_guarded_storage"	},
+[378] = { 2,	0,		SEN(s390_guarded_storage),	"s390_guarded_storage"	},
 [379] = { 5,	TD|TF|TSTA,	SEN(statx),			"statx"			},
 [380] = { 4,	0,		SEN(s390_sthyi),		"s390_sthyi"		},
 
diff --git a/s390.c b/s390.c
index daaf6a0..a7efd29 100644
--- a/s390.c
+++ b/s390.c
@@ -35,6 +35,7 @@
 
 #include "print_fields.h"
 
+#include "xlat/s390_guarded_storage_commands.h"
 #include "xlat/s390_sthyi_function_codes.h"
 
 /*
@@ -1030,4 +1031,183 @@ SYS_FUNC(s390_sthyi)
 	return 0;
 }
 
+
+/*
+ * Structures are written based on
+ * https://www-304.ibm.com/support/docview.wss?uid=isg29c69415c1e82603c852576700058075a&aid=1#page=85
+ */
+
+struct guard_storage_control_block {
+	uint64_t reserved;
+	/**
+	 * Guard Storage Designation
+	 *  - Bits 0..J, J == 64-GSC - Guard Storage Origin (GSO)
+	 *  - Bits 53..55 - Guard Load Shift (GLS)
+	 *  - Bits 58..63 - Guard Storage Characteristic (GSC), this is J from
+	 *                  the first item, valud values are 25..56.
+	 */
+	uint64_t gsd;
+	uint64_t gssm;   /**< Guard Storage Section Mask */
+	uint64_t gs_epl_a; /**< Guard Storage Event Parameter List Address */
+};
+
+struct guard_storage_event_parameter_list {
+	uint8_t  pad1;
+	/**
+	 * Guard Storage Event Addressing Mode
+	 *  - 0x40 - Extended addressing mode (E)
+	 *  - 0x80 - Basic addressing mode (B)
+	 */
+	uint8_t  gs_eam;
+	/**
+	 * Guard Storage Event Cause indication
+	 *  - 0x01 - CPU was in transaction execution mode (TX)
+	 *  - 0x02 - CPU was in constrained transaction execution mode (CX)
+	 *  - 0x80 - Instruction causing the event: 0 - LGG, 1 - LLGFGS
+	 */
+	uint8_t  gs_eci;
+	/**
+	 * Guard Storage Event Access Information
+	 *  - 0x01 - DAT mode
+	 *  - Bits 1..2 - Address space indication
+	 *  - Bits 4..7 - AR number
+	 */
+	uint8_t  gs_eai;
+	uint32_t pad2;
+	uint64_t gs_eha; /**< Guard Storage Event Handler Address */
+	uint64_t gs_eia; /**< Guard Storage Event Instruction Address */
+	uint64_t gs_eoa; /**< Guard Storage Event Operation Address */
+	uint64_t gs_eir; /**< Guard Storage Event Intermediate Result */
+	uint64_t gs_era; /**< Guard Storage Event Return Address */
+};
+
+static void
+guard_storage_print_gsepl(struct tcb *tcp, uint64_t addr)
+{
+	struct guard_storage_event_parameter_list gsepl;
+
+	/* Since it is 64-bit even on 31-bit s390... */
+	if (sizeof(addr) > current_klongsize &&
+	    addr >= (1ULL << (current_klongsize * 8))) {
+		tprintf("%#" PRIx64, addr);
+
+		return;
+	}
+
+	if (umove_or_printaddr(tcp, addr, &gsepl))
+		return;
+
+	tprints("[{");
+
+	if (!abbrev(tcp)) {
+		if (gsepl.pad1) {
+			PRINT_FIELD_0X("", gsepl, pad1);
+			tprints(", ");
+		}
+
+		PRINT_FIELD_0X("",   gsepl, gs_eam);
+		tprintf_comment("extended addressing mode: %u, "
+				"basic addressing mode: %u",
+				!!(gsepl.gs_eam & 0x2), !!(gsepl.gs_eam & 0x1));
+
+		PRINT_FIELD_0X(", ", gsepl, gs_eci);
+		tprintf_comment("CPU in TX: %u, CPU in CX: %u, instruction: %s",
+				!!(gsepl.gs_eci & 0x80),
+				!!(gsepl.gs_eci & 0x40),
+				gsepl.gs_eci & 0x01 ? "LLGFGS" : "LGG");
+
+		PRINT_FIELD_0X(", ", gsepl, gs_eai);
+		tprintf_comment("DAT: %u, address space indication: %u, "
+				"AR number: %u",
+				!!(gsepl.gs_eai & 0x40),
+				(gsepl.gs_eai >> 4) & 0x3,
+				gsepl.gs_eai & 0xF);
+
+		if (gsepl.pad2)
+			PRINT_FIELD_0X(", ", gsepl, pad2);
+
+		tprints(", ");
+	}
+
+	PRINT_FIELD_X("", gsepl, gs_eha);
+
+	if (!abbrev(tcp)) {
+		PRINT_FIELD_X(", ", gsepl, gs_eia);
+		PRINT_FIELD_X(", ", gsepl, gs_eoa);
+		PRINT_FIELD_X(", ", gsepl, gs_eir);
+		PRINT_FIELD_X(", ", gsepl, gs_era);
+	} else {
+		tprints(", ...");
+	}
+
+	tprints("}]");
+}
+
+# define DIV_ROUND_UP(x,y) (((x) + ((y) - 1)) / (y))
+
+static void
+guard_storage_print_gscb(struct tcb *tcp, kernel_ulong_t addr)
+{
+	struct guard_storage_control_block gscb;
+
+	if (umove_or_printaddr(tcp, addr, &gscb))
+		return;
+
+	tprints("{");
+
+	if (gscb.reserved) {
+		PRINT_FIELD_0X("", gscb, reserved);
+		tprints(", ");
+	}
+
+	PRINT_FIELD_0X("", gscb, gsd);
+
+	if (!abbrev(tcp)) {
+		unsigned int gsc = gscb.gsd & 0x3F;
+		bool gsc_valid = gsc >= 25 && gsc <= 56;
+		tprintf_comment("GS origin: %#*.*" PRIx64 "%s, "
+				"guard load shift: %" PRIu64 ", "
+				"GS characteristic: %u",
+				gsc_valid ? 2 + DIV_ROUND_UP(64 - gsc, 4) : 0,
+				gsc_valid ? DIV_ROUND_UP(64 - gsc, 4) : 0,
+				gsc_valid ? gscb.gsd >> gsc : 0,
+				gsc_valid ? "" : "[invalid]",
+				(gscb.gsd >> 8) & 0x7, gsc);
+	}
+
+	PRINT_FIELD_0X(", ", gscb, gssm);
+
+	tprints(", gs_epl_a=");
+	guard_storage_print_gsepl(tcp, gscb.gs_epl_a);
+
+	tprints("}");
+}
+
+SYS_FUNC(s390_guarded_storage)
+{
+	int command = (int) tcp->u_arg[0];
+	kernel_ulong_t gs_cb = tcp->u_arg[1];
+
+	printxval(s390_guarded_storage_commands, command, "GS_???");
+
+	switch (command) {
+	case GS_ENABLE:
+	case GS_DISABLE:
+	case GS_CLEAR_BC_CB:
+	case GS_BROADCAST:
+		break;
+
+	case GS_SET_BC_CB:
+		tprints(", ");
+		guard_storage_print_gscb(tcp, gs_cb);
+		break;
+
+	default:
+		tprints(", ");
+		printaddr(gs_cb);
+	}
+
+	return RVAL_DECODED;
+}
+
 #endif /* defined S390 || defined S390X */
diff --git a/xlat/s390_guarded_storage_commands.in b/xlat/s390_guarded_storage_commands.in
new file mode 100644
index 0000000..410e33e
--- /dev/null
+++ b/xlat/s390_guarded_storage_commands.in
@@ -0,0 +1,5 @@
+GS_ENABLE	0
+GS_DISABLE	1
+GS_SET_BC_CB	2
+GS_CLEAR_BC_CB	3
+GS_BROADCAST	4
-- 
2.1.4
