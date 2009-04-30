Return-Path: <linux-kernel-owner+w=401wt.eu-S933777AbZEAAbq@vger.kernel.org>
From: Tim Abbott <tabbott@MIT.EDU>
Subject: [PATCH 1/6] s390: Use macros for .data.page_aligned.
Date: Thu, 30 Apr 2009 19:57:16 -0400
Message-Id: <1241135841-9619-2-git-send-email-tabbott@mit.edu>
In-Reply-To: <1241135841-9619-1-git-send-email-tabbott@mit.edu>
References: <1241135841-9619-1-git-send-email-tabbott@mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>, Anders Kaseorg <andersk@MIT.EDU>, Waseem Daher <wdaher@MIT.EDU>, Denys Vlasenko <vda.linux@googlemail.com>, Jeff Arnold <jbarnold@MIT.EDU>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Tim Abbott <tabbott@MIT.EDU>, Cyrill Gorcunov <gorcunov@openvz.org>
List-ID: <linux-s390.vger.kernel.org>

.data.page_aligned should not need a separate output section, so as
part of this cleanup I moved into the .data output section in the
linker scripts in order to eliminate unnecessary references to the
section name.

Remove the reference to .data.idt, since nothing is put into the
.data.idt section on the s390 architecture.  It looks like Cyrill
Gorcunov posted a patch to remove the .data.idt code on s390
previously:

<http://lkml.indiana.edu/hypermail/linux/kernel/0802.2/2536.html>

CCing him and the people who acked that patch in case there's a reason
it wasn't applied.

Signed-off-by: Tim Abbott <tabbott@mit.edu>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Cyrill Gorcunov <gorcunov@openvz.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 arch/s390/kernel/vdso.c                  |    2 +-
 arch/s390/kernel/vdso32/vdso32_wrapper.S |    3 ++-
 arch/s390/kernel/vdso64/vdso64_wrapper.S |    3 ++-
 arch/s390/kernel/vmlinux.lds.S           |    6 +-----
 4 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index 89b2e7f..5d7e703 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -64,7 +64,7 @@ __setup("vdso=", vdso_setup);
 static union {
 	struct vdso_data	data;
 	u8			page[PAGE_SIZE];
-} vdso_data_store __attribute__((__section__(".data.page_aligned")));
+} vdso_data_store __page_aligned_data;
 struct vdso_data *vdso_data = &vdso_data_store.data;
 
 /*
diff --git a/arch/s390/kernel/vdso32/vdso32_wrapper.S b/arch/s390/kernel/vdso32/vdso32_wrapper.S
index 61639a8..ae42f8c 100644
--- a/arch/s390/kernel/vdso32/vdso32_wrapper.S
+++ b/arch/s390/kernel/vdso32/vdso32_wrapper.S
@@ -1,7 +1,8 @@
 #include <linux/init.h>
+#include <linux/linkage.h>
 #include <asm/page.h>
 
-	.section ".data.page_aligned"
+	__PAGE_ALIGNED_DATA
 
 	.globl vdso32_start, vdso32_end
 	.balign PAGE_SIZE
diff --git a/arch/s390/kernel/vdso64/vdso64_wrapper.S b/arch/s390/kernel/vdso64/vdso64_wrapper.S
index d8e2ac1..c245842 100644
--- a/arch/s390/kernel/vdso64/vdso64_wrapper.S
+++ b/arch/s390/kernel/vdso64/vdso64_wrapper.S
@@ -1,7 +1,8 @@
 #include <linux/init.h>
+#include <linux/linkage.h>
 #include <asm/page.h>
 
-	.section ".data.page_aligned"
+	__PAGE_ALIGNED_DATA
 
 	.globl vdso64_start, vdso64_end
 	.balign PAGE_SIZE
diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index 89399b8..d552089 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -59,6 +59,7 @@ SECTIONS
 	} :data
 
 	.data : {		/* Data */
+		PAGE_ALIGNED_DATA
 		DATA_DATA
 		CONSTRUCTORS
 	}
@@ -71,11 +72,6 @@ SECTIONS
 	. = ALIGN(PAGE_SIZE);
 	__nosave_end = .;
 
-	. = ALIGN(PAGE_SIZE);
-	.data.page_aligned : {
-		*(.data.idt)
-	}
-
 	. = ALIGN(0x100);
 	.data.cacheline_aligned : {
 		*(.data.cacheline_aligned)
-- 
1.6.2.1
