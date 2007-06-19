Return-Path: <linux-kernel-owner+w=401wt.eu-S1754657AbXFSIpo@vger.kernel.org>
Message-Id: <20070619084641.148707835@de.ibm.com>
References: <20070619084516.457715754@de.ibm.com>
Date: Tue, 19 Jun 2007 10:45:17 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 1/6] Missing blank when appending cio_ignore kernel parameter
Content-Disposition: inline; filename=001-dumper.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Michael Holzheu <holzheu@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Holzheu <holzheu@de.ibm.com>

When appending the 'cio_ignore' kernel parameter to the command line, a blank
has to be inserted in order to separate 'cio_ignore' from the preceding kernel
parameters.

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/setup.c |    1 +
 1 file changed, 1 insertion(+)

Index: quilt-2.6/arch/s390/kernel/setup.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/setup.c
+++ quilt-2.6/arch/s390/kernel/setup.c
@@ -300,6 +300,7 @@ static void __init setup_zfcpdump(unsign
 	else
 		sprintf(str, "cio_ignore=all,!0.0.%04x",
 			ipl_info.data.fcp.dev_id.devno);
+	strcat(COMMAND_LINE, " ");
 	strcat(COMMAND_LINE, str);
 	console_loglevel = 2;
 }

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
