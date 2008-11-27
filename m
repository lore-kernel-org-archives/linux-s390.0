Return-Path: <linux-kernel-owner+w=401wt.eu-S1757548AbYK0KxH@vger.kernel.org>
Message-Id: <20081127103136.719281319@de.ibm.com>
References: <20081127103020.528516828@de.ibm.com>
Date: Thu, 27 Nov 2008 11:30:52 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 32/60] Remove initial kernel stack backchain initialization.
Content-Disposition: inline; filename=131-clear-backchain.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Early init code clears the backchain of the initial kernel stack frame.
This is not necessary since it is pre initialized with zeros. Plus it
was broken on 64 bit since it cleared only four of eight bytes.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/head31.S |    1 -
 arch/s390/kernel/head64.S |    1 -
 2 files changed, 2 deletions(-)

Index: quilt-2.6/arch/s390/kernel/head31.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/head31.S
+++ quilt-2.6/arch/s390/kernel/head31.S
@@ -29,7 +29,6 @@ startup_continue:
 	ahi	%r15,1<<(PAGE_SHIFT+THREAD_ORDER) # init_task_union+THREAD_SIZE
 	st	%r15,__LC_KERNEL_STACK	# set end of kernel stack
 	ahi	%r15,-96
-	xc	__SF_BACKCHAIN(4,%r15),__SF_BACKCHAIN(%r15) # clear backchain
 #
 # Save ipl parameters, clear bss memory, initialize storage key for kernel pages,
 # and create a kernel NSS if the SAVESYS= parm is defined
Index: quilt-2.6/arch/s390/kernel/head64.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/head64.S
+++ quilt-2.6/arch/s390/kernel/head64.S
@@ -96,7 +96,6 @@ startup_continue:
 	aghi	%r15,1<<(PAGE_SHIFT+THREAD_ORDER) # init_task_union + THREAD_SIZE
 	stg	%r15,__LC_KERNEL_STACK	# set end of kernel stack
 	aghi	%r15,-160
-	xc	__SF_BACKCHAIN(4,%r15),__SF_BACKCHAIN(%r15) # clear backchain
 #
 # Save ipl parameters, clear bss memory, initialize storage key for kernel pages,
 # and create a kernel NSS if the SAVESYS= parm is defined

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
