Return-Path: <linux-kernel-owner+w=401wt.eu-S1761452AbXJDLiq@vger.kernel.org>
Message-Id: <20071004112834.521260994@de.ibm.com>
References: <20071004112706.574737175@de.ibm.com>
Date: Thu, 04 Oct 2007 13:27:40 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 34/34] vmwatchdog: fix broken inline assembly.
Content-Disposition: inline; filename=034-vmwatchdog.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Constraint for err is wrong since it is preinitialized and the code
relies on it in case of an exception.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/vmwatchdog.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: quilt-2.6/drivers/s390/char/vmwatchdog.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/vmwatchdog.c
+++ quilt-2.6/drivers/s390/char/vmwatchdog.c
@@ -66,8 +66,8 @@ static int __diag288(enum vmwdt_func fun
 		"0:	la	%0,0\n"
 		"1:\n"
 		EX_TABLE(0b,1b)
-		: "=d" (err) : "d"(__func), "d"(__timeout),
-		  "d"(__cmdp), "d"(__cmdl), "0" (-EINVAL) : "1", "cc");
+		: "+d" (err) : "d"(__func), "d"(__timeout),
+		  "d"(__cmdp), "d"(__cmdl) : "1", "cc");
 	return err;
 }
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
