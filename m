Return-Path: <linux-kernel-owner+w=401wt.eu-S932647AbYCEMBT@vger.kernel.org>
Message-Id: <20080305115714.926737514@de.ibm.com>
References: <20080305115432.691030908@de.ibm.com>
Date: Wed, 05 Mar 2008 12:54:41 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 09/10] Load disabled wait psw if reipl fails.
Content-Disposition: inline; filename=009-reipl-fail.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Michael Holzheu <holzheu@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Holzheu <holzheu@de.ibm.com>

Normally this should not happen, but it's cleaner to do it that way.

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/ipl.c |    1 +
 1 file changed, 1 insertion(+)

Index: quilt-2.6/arch/s390/kernel/ipl.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/ipl.c
+++ quilt-2.6/arch/s390/kernel/ipl.c
@@ -704,6 +704,7 @@ void reipl_run(struct shutdown_trigger *
 	default:
 		break;
 	}
+	disabled_wait((unsigned long) __builtin_return_address(0));
 }
 
 static void __init reipl_probe(void)

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
