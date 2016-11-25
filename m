Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 25 Nov 2016 10:05:49 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: next: s390 crash due to 's390: move sys_call_table and
 last_break from thread_info to thread_struct'
In-Reply-To: <a6c571e2-412a-b344-b20a-d813851a1419@roeck-us.net>
References: <20161115153554.GA22064@roeck-us.net>
        <20161115165416.00dbc85d@mschwide>
        <a6c571e2-412a-b344-b20a-d813851a1419@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Message-Id: <20161125100549.2ea9dda4@mschwide>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Guenter,

On Thu, 24 Nov 2016 12:53:52 -0800
Guenter Roeck <linux@roeck-us.net> wrote:

> > Thanks for the report. Builds for Z900 and Z990 are borked. This hunk
> >
> > @@ -287,7 +292,13 @@ ENTRY(system_call)
> >         mvc     __PT_INT_CODE(4,%r11),__LC_SVC_ILC
> >         stg     %r14,__PT_FLAGS(%r11)
> >  .Lsysc_do_svc:
> > -       lg      %r10,__TI_sysc_table(%r12)      # address of system call table
> > +       # load address of system call table
> > +#ifdef CONFIG_HAVE_MARCH_Z990_FEATURES
> > +       lg      %r10,__TASK_thread+__THREAD_sysc_table(%r12)
> > +#else
> > +       lghi    %r10,__TASK_thread
> > +       lg      %r10,__THREAD_sysc_table(%r10,%r12)
> > +#endif
> >         llgh    %r8,__PT_INT_CODE+2(%r11)
> >         slag    %r8,%r8,2                       # shift and test for svc 0
> >         jnz     .Lsysc_nr_ok
> >
> > makes ill use of %r10 in the #else part. Should be fixed now and tomorrows -next
> > tree will have the fix. Thanks again.
> >
> 
> This is still crashing in -next with exactly the same message.

Yes, it is (note to myself: don't do things in a hurry). The patch below
gets linux-next booting again for CONFIG_MARCH_Z900=y on my test system.
Sorry about the trouble.

--
From 2ec05f7c28963c12e9618e9f7f3b29edcec40482 Mon Sep 17 00:00:00 2001
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Fri, 25 Nov 2016 09:53:42 +0100
Subject: [PATCH] s390: fix kernel oops for CONFIG_MARCH_Z900=y builds

The LAST_BREAK macro in entry.S uses a different instruction sequence
for CONFIG_MARCH_Z900 builds. The branch target offset to skip the
store of the last breaking event address needs to take the different
length of the code block into account.

Fixes: f8fc82b47149e344 ("s390: move sys_call_table and last_break from thread_info to thread_struct")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/kernel/entry.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 1cc4578..e2e47f7 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -123,10 +123,11 @@ _PIF_WORK	= (_PIF_PER_TRAP)
 
 	.macro	LAST_BREAK scratch
 	srag	\scratch,%r10,23
-	jz	.+10
 #ifdef CONFIG_HAVE_MARCH_Z990_FEATURES
+	jz	.+10
 	stg	%r10,__TASK_thread+__THREAD_last_break(%r12)
 #else
+	jz	.+14
 	lghi	\scratch,__TASK_thread
 	stg	%r10,__THREAD_last_break(\scratch,%r12)
 #endif
-- 
2.8.4
-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
