Return-Path: <linux-kernel-owner+w=401wt.eu-S1758184AbYBEPmI@vger.kernel.org>
Message-Id: <20080205153912.155035312@de.ibm.com>
References: <20080205153835.337897404@de.ibm.com>
Date: Tue, 05 Feb 2008 16:38:41 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 06/18] Fix linker script.
Content-Disposition: inline; filename=006-ld-script.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Fixes this warning:
vmlinux: warning: allocated section `.text' not in segment

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/vmlinux.lds.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: quilt-2.6/arch/s390/kernel/vmlinux.lds.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/vmlinux.lds.S
+++ quilt-2.6/arch/s390/kernel/vmlinux.lds.S
@@ -35,7 +35,7 @@ SECTIONS
 		KPROBES_TEXT
 		*(.fixup)
 		*(.gnu.warning)
-	} = 0x0700
+	} :text = 0x0700
 
 	_etext = .;		/* End of text section */
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
