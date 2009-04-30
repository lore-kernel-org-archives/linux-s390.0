Return-Path: <linux-kernel-owner+w=401wt.eu-S933385AbZEAA0E@vger.kernel.org>
From: Tim Abbott <tabbott@MIT.EDU>
Subject: [PATCH 2/6] s390: use NOSAVE_DATA macro for .data.nosave section.
Date: Thu, 30 Apr 2009 19:57:17 -0400
Message-Id: <1241135841-9619-3-git-send-email-tabbott@mit.edu>
In-Reply-To: <1241135841-9619-2-git-send-email-tabbott@mit.edu>
References: <1241135841-9619-1-git-send-email-tabbott@mit.edu>
 <1241135841-9619-2-git-send-email-tabbott@mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>, Anders Kaseorg <andersk@MIT.EDU>, Waseem Daher <wdaher@MIT.EDU>, Denys Vlasenko <vda.linux@googlemail.com>, Jeff Arnold <jbarnold@MIT.EDU>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Tim Abbott <tabbott@MIT.EDU>
List-ID: <linux-s390.vger.kernel.org>

.data.nosave should not need a separate output section; this change
moves it into the .data section.

Signed-off-by: Tim Abbott <tabbott@mit.edu>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
---
 arch/s390/kernel/vmlinux.lds.S |    9 +--------
 1 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index d552089..8900f98 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -60,18 +60,11 @@ SECTIONS
 
 	.data : {		/* Data */
 		PAGE_ALIGNED_DATA
+		NOSAVE_DATA
 		DATA_DATA
 		CONSTRUCTORS
 	}
 
-	. = ALIGN(PAGE_SIZE);
-	.data_nosave : {
-	__nosave_begin = .;
-		*(.data.nosave)
-	}
-	. = ALIGN(PAGE_SIZE);
-	__nosave_end = .;
-
 	. = ALIGN(0x100);
 	.data.cacheline_aligned : {
 		*(.data.cacheline_aligned)
-- 
1.6.2.1
