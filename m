Return-Path: <linux-kernel-owner+w=401wt.eu-S1757654AbYK0Kyw@vger.kernel.org>
Message-Id: <20081127103134.526648779@de.ibm.com>
References: <20081127103020.528516828@de.ibm.com>
Date: Thu, 27 Nov 2008 11:30:44 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 24/60] remove ptrace warning on 31 bit.
Content-Disposition: inline; filename=123-ptrace-warnings.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

A kernel compile on 31 bit gives the following warnings in ptrace.c:

arch/s390/kernel/ptrace.c: In function 'peek_user':
arch/s390/kernel/ptrace.c:207: warning: unused variable 'dummy'
arch/s390/kernel/ptrace.c: In function 'poke_user':
arch/s390/kernel/ptrace.c:315: warning: unused variable 'dummy'

Getting rid of the dummy variables removes the warnings.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/ptrace.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

Index: quilt-2.6/arch/s390/kernel/ptrace.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/ptrace.c
+++ quilt-2.6/arch/s390/kernel/ptrace.c
@@ -204,7 +204,6 @@ static unsigned long __peek_user(struct 
 static int
 peek_user(struct task_struct *child, addr_t addr, addr_t data)
 {
-	struct user *dummy = NULL;
 	addr_t tmp, mask;
 
 	/*
@@ -213,8 +212,8 @@ peek_user(struct task_struct *child, add
 	 */
 	mask = __ADDR_MASK;
 #ifdef CONFIG_64BIT
-	if (addr >= (addr_t) &dummy->regs.acrs &&
-	    addr < (addr_t) &dummy->regs.orig_gpr2)
+	if (addr >= (addr_t) &((struct user *) NULL)->regs.acrs &&
+	    addr < (addr_t) &((struct user *) NULL)->regs.orig_gpr2)
 		mask = 3;
 #endif
 	if ((addr & mask) || addr > sizeof(struct user) - __ADDR_MASK)
@@ -312,7 +311,6 @@ static int __poke_user(struct task_struc
 static int
 poke_user(struct task_struct *child, addr_t addr, addr_t data)
 {
-	struct user *dummy = NULL;
 	addr_t mask;
 
 	/*
@@ -321,8 +319,8 @@ poke_user(struct task_struct *child, add
 	 */
 	mask = __ADDR_MASK;
 #ifdef CONFIG_64BIT
-	if (addr >= (addr_t) &dummy->regs.acrs &&
-	    addr < (addr_t) &dummy->regs.orig_gpr2)
+	if (addr >= (addr_t) &((struct user *) NULL)->regs.acrs &&
+	    addr < (addr_t) &((struct user *) NULL)->regs.orig_gpr2)
 		mask = 3;
 #endif
 	if ((addr & mask) || addr > sizeof(struct user) - __ADDR_MASK)

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
