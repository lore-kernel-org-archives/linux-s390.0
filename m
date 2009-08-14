Return-Path: <linux-kernel-owner+w=401wt.eu-S1755969AbZHNLcG@vger.kernel.org>
Message-Id: <20090814112618.435817150@de.ibm.com>
References: <20090814112517.982007860@de.ibm.com>
Date: Fri, 14 Aug 2009 13:25:42 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 25/34] Use macros for .data.page_aligned.
Content-Disposition: inline; filename=124-vmlinux-lds-1.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Tim Abbott <tabbott@ksplice.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Cyrill Gorcunov <gorcunov@openvz.org>, Sam Ravnborg <sam@ravnborg.org>
List-ID: <linux-s390.vger.kernel.org>

From: Tim Abbott <tabbott@ksplice.com>

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

Signed-off-by: Tim Abbott <tabbott@ksplice.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Acked-by: Cyrill Gorcunov <gorcunov@openvz.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
---

 arch/s390/kernel/vmlinux.lds.S |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

Index: quilt-2.6/arch/s390/kernel/vmlinux.lds.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/vmlinux.lds.S
+++ quilt-2.6/arch/s390/kernel/vmlinux.lds.S
@@ -60,6 +60,7 @@ SECTIONS
 	} :data
 
 	.data : {		/* Data */
+		PAGE_ALIGNED_DATA(PAGE_SIZE)
 		DATA_DATA
 		CONSTRUCTORS
 	}
@@ -72,11 +73,6 @@ SECTIONS
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
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
