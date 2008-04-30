Return-Path: <linux-kernel-owner+w=401wt.eu-S1762628AbYD3MPs@vger.kernel.org>
Date: Wed, 30 Apr 2008 08:15:38 -0400
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [patch] s390: Remove self ptrace IEEE_IP hack.
Message-ID: <20080430121538.GC28831@infradead.org>
References: <1209546896.10954.28.camel@localhost> <20080430091900.GA13743@infradead.org> <1209555393.10954.32.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1209555393.10954.32.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, akpm@osd.org
List-ID: <linux-s390.vger.kernel.org>

And now that the last architecture (s390) has been converted to the
generic ptrace code the __ARCH_SYS_PTRACE ifdef can go away.  Once we've
also converted all architectures to compat_sys_ptrace some more code can
be made private to kernel/ptrace.c.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/kernel/ptrace.c	2008-04-30 14:04:33.000000000 +0200
+++ linux-2.6/kernel/ptrace.c	2008-04-30 14:10:46.000000000 +0200
@@ -543,7 +543,6 @@ struct task_struct *ptrace_get_task_stru
 #define arch_ptrace_attach(child)	do { } while (0)
 #endif
 
-#ifndef __ARCH_SYS_PTRACE
 asmlinkage long sys_ptrace(long request, long pid, long addr, long data)
 {
 	struct task_struct *child;
@@ -591,7 +590,6 @@ asmlinkage long sys_ptrace(long request,
 	unlock_kernel();
 	return ret;
 }
-#endif /* __ARCH_SYS_PTRACE */
 
 int generic_ptrace_peekdata(struct task_struct *tsk, long addr, long data)
 {
