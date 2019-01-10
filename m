From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 10 Jan 2019 15:41:45 +0000
Subject: [kvm-unit-tests PATCH v5 05/11] s390x: Add BSS clearing for non ELF boot
Message-Id: <20190110154151.24233-6-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

When doing an IPL normal the memory will not be zeroed and hence the
BSS section can have any value. We need to clear it by ourselves.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 s390x/cstart64.S | 22 ++++++++++++++++++++--
 s390x/flat.lds   |  2 ++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/s390x/cstart64.S b/s390x/cstart64.S
index 6622633..dedfe80 100644
--- a/s390x/cstart64.S
+++ b/s390x/cstart64.S
@@ -39,7 +39,22 @@ start:
 	/* setup initial PSW mask + control registers*/
 	larl	%r1, initial_psw
 	lpswe	0(%r1)
-init_psw_cont:
+clear_bss_start:
+	larl 	%r2, __bss_start
+	larl 	%r3, __bss_end
+	slgr 	%r3, %r2		# Get sizeof bss
+	aghi 	%r3,-1
+	srlg 	%r4,%r3,8		# Calc number of 256 byte chunks
+	ltgr 	%r4,%r4
+	lgr 	%r1,%r2
+	jz	clear_bss_remainder		# If none, clear remaining bytes
+clear_bss_loop:
+	xc	0(256,%r1), 0(%r1)	# Clear 256 byte chunks via xor
+	la	%r1, 256(%r1)
+	brctg 	%r4, clear_bss_loop
+clear_bss_remainder:
+	larl	%r2, memsetxc
+	ex 	%r3, 0(%r2)
 	/* setup pgm interrupt handler */
 	larl	%r1, pgm_int_psw
 	mvc	GEN_LC_PGM_NEW_PSW(16), 0(%r1)
@@ -71,6 +86,9 @@ init_psw_cont:
 	/* call exit() */
 	j exit
 
+memsetxc:
+	xc 0(1,%r1),0(%r1)
+
 	.macro SAVE_REGS
 	/* save grs 0-15 */
 	stmg	%r0, %r15, GEN_LC_SW_INT_GRS
@@ -159,7 +177,7 @@ svc_int:
 
 	.align	8
 initial_psw:
-	.quad	0x0000000180000000, init_psw_cont
+	.quad	0x0000000180000000, clear_bss_start
 pgm_int_psw:
 	.quad	0x0000000180000000, pgm_int
 ext_int_psw:
diff --git a/s390x/flat.lds b/s390x/flat.lds
index 977af7c..403d967 100644
--- a/s390x/flat.lds
+++ b/s390x/flat.lds
@@ -40,7 +40,9 @@ SECTIONS
 	. = ALIGN(16);
 	.rodata : { *(.rodata) *(.rodata.*) }
 	. = ALIGN(16);
+	__bss_start = .;
 	.bss : { *(.bss) }
+	__bss_end = .;
 	. = ALIGN(64K);
 	edata = .;
 	. += 64K;
-- 
2.14.3
