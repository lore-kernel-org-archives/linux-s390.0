Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20100224084452.612856822@de.ibm.com>
Date: Wed, 24 Feb 2010 09:44:56 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 26/32] [PATCH] codepage conversion of kernel parameter line
References: <20100224084430.193562869@de.ibm.com>
Content-Disposition: inline; filename=125-kparm-ebcasc.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Move the ebcdic to ascii conversion of the kernel parameter line from
head.S to early.c and convert the assembler code to C.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/early.c |   13 ++++++++++++-
 arch/s390/kernel/head.S  |   18 +-----------------
 2 files changed, 13 insertions(+), 18 deletions(-)

Index: quilt-2.6/arch/s390/kernel/early.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/early.c	2010-02-24 09:44:25.000000000 +0100
+++ quilt-2.6/arch/s390/kernel/early.c	2010-02-24 09:44:28.000000000 +0100
@@ -405,8 +405,19 @@
 
 static void __init setup_boot_command_line(void)
 {
+	int i;
+
+	/* convert arch command line to ascii */
+	for (i = 0; i < ARCH_COMMAND_LINE_SIZE; i++)
+		if (COMMAND_LINE[i] & 0x80)
+			break;
+	if (i < ARCH_COMMAND_LINE_SIZE)
+		EBCASC(COMMAND_LINE, ARCH_COMMAND_LINE_SIZE);
+	COMMAND_LINE[ARCH_COMMAND_LINE_SIZE-1] = 0;
+
 	/* copy arch command line */
-	strlcpy(boot_command_line, COMMAND_LINE, ARCH_COMMAND_LINE_SIZE);
+	strlcpy(boot_command_line, strstrip(COMMAND_LINE),
+		ARCH_COMMAND_LINE_SIZE);
 
 	/* append IPL PARM data to the boot command line */
 	if (MACHINE_IS_VM)
Index: quilt-2.6/arch/s390/kernel/head.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/head.S	2010-02-24 09:44:26.000000000 +0100
+++ quilt-2.6/arch/s390/kernel/head.S	2010-02-24 09:44:28.000000000 +0100
@@ -287,19 +287,7 @@
 	bz	.Lagain1		# skip dateset trailer
 	la	%r5,0(%r4,%r2)
 	lr	%r3,%r2
-.Lidebc:
-	tm	0(%r5),0x80		# high order bit set ?
-	bo	.Ldocv			#  yes -> convert from EBCDIC
-	ahi	%r5,-1
-	bct	%r3,.Lidebc
-	b	.Lnocv
-.Ldocv:
-	l	%r3,.Lcvtab
-	tr	0(256,%r4),0(%r3)	# convert parameters to ascii
-	tr	256(256,%r4),0(%r3)
-	tr	512(256,%r4),0(%r3)
-	tr	768(122,%r4),0(%r3)
-.Lnocv: la	%r3,COMMAND_LINE-PARMAREA(%r12) # load adr. of command line
+	la	%r3,COMMAND_LINE-PARMAREA(%r12) # load adr. of command line
 	mvc	0(256,%r3),0(%r4)
 	mvc	256(256,%r3),256(%r4)
 	mvc	512(256,%r3),512(%r4)
@@ -383,7 +371,6 @@
 .Linitrd:.long _end + 0x400000		# default address of initrd
 .Lparm:	.long  PARMAREA
 .Lstartup: .long startup
-.Lcvtab:.long	_ebcasc 		# ebcdic to ascii table
 .Lreset:.byte	0xc3,0xc8,0xc1,0xd5,0xc7,0xc5,0x40,0xd9,0xc4,0xd9,0x40
 	.byte	0xc1,0xd3,0xd3,0x40,0xd2,0xc5,0xc5,0xd7,0x40,0xd5,0xd6
 	.byte	0xc8,0xd6,0xd3,0xc4	# "change rdr all keep nohold"
@@ -416,13 +403,10 @@
 .sk8x8:
 	mvc	0(240,%r8),0(%r9)	# copy iplparms into buffer
 .gotr:
-	l	%r10,.tbl		# EBCDIC to ASCII table
-	tr	0(240,%r8),0(%r10)
 	slr	%r0,%r0
 	st	%r0,INITRD_SIZE+ARCH_OFFSET-PARMAREA(%r11)
 	st	%r0,INITRD_START+ARCH_OFFSET-PARMAREA(%r11)
 	j	startup 		# continue with startup
-.tbl:	.long	_ebcasc			# translate table
 .cmd:	.long	COMMAND_LINE		# address of command line buffer
 .parm:	.long	PARMAREA
 .lowcase:
