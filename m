From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: linux-next: 20090925 - build breaks with !CONFIG_AIO
Date: Sat, 26 Sep 2009 13:37:02 +0200
Message-ID: <20090926133702.44f315f7@mschwide.boeblingen.de.ibm.com>
References: <20090925133830.1ba29584.sfr@canb.auug.org.au>
	<20090925131958.GC6831@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20090925131958.GC6831@linux.vnet.ibm.com>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, adobriyan@gmail.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, 25 Sep 2009 18:49:58 +0530
Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> wrote:

> Hi Stephen,
> 
> 	next-20090925 randconfig build breaks on s390x, with CONFIG_AIO=n.
> 
> arch/s390/mm/pgtable.c: In function 's390_enable_sie':
> arch/s390/mm/pgtable.c:282: error: 'struct mm_struct' has no member named 'ioctx_list'
> arch/s390/mm/pgtable.c:298: error: 'struct mm_struct' has no member named 'ioctx_list'
> make[1]: *** [arch/s390/mm/pgtable.o] Error 1
> 
> Reverting the below commit helps
> 
> commit 858f09930b32c11b40fd0c5c467982ba09b10894
> Author: Alexey Dobriyan <adobriyan@gmail.com>
> Date:   Wed Sep 23 15:57:32 2009 -0700
> 
>     aio: ifdef fields in mm_struct
> 
> 	->ioctx_lock and ->ioctx_list are used only under CONFIG_AIO.

That should be fixed in the s390 pgtable.c code:

--
Subject: [PATCH] fix build breakage with CONFIG_AIO=n

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

next-20090925 randconfig build breaks on s390x, with CONFIG_AIO=n.

arch/s390/mm/pgtable.c: In function 's390_enable_sie':
arch/s390/mm/pgtable.c:282: error: 'struct mm_struct' has no member named 'ioctx_list'
arch/s390/mm/pgtable.c:298: error: 'struct mm_struct' has no member named 'ioctx_list'
make[1]: *** [arch/s390/mm/pgtable.o] Error 1

Reported-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/mm/pgtable.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/arch/s390/mm/pgtable.c linux-2.6-patched/arch/s390/mm/pgtable.c
--- linux-2.6/arch/s390/mm/pgtable.c	2009-09-26 13:35:36.000000000 +0200
+++ linux-2.6-patched/arch/s390/mm/pgtable.c	2009-09-26 13:35:47.000000000 +0200
@@ -279,7 +279,10 @@ int s390_enable_sie(void)
 	/* lets check if we are allowed to replace the mm */
 	task_lock(tsk);
 	if (!tsk->mm || atomic_read(&tsk->mm->mm_users) > 1 ||
-	    tsk->mm != tsk->active_mm || !hlist_empty(&tsk->mm->ioctx_list)) {
+#ifdef CONFIG_AIO
+	    !hlist_empty(&tsk->mm->ioctx_list) ||
+#endif
+	    tsk->mm != tsk->active_mm) {
 		task_unlock(tsk);
 		return -EINVAL;
 	}
@@ -295,7 +298,10 @@ int s390_enable_sie(void)
 	/* Now lets check again if something happened */
 	task_lock(tsk);
 	if (!tsk->mm || atomic_read(&tsk->mm->mm_users) > 1 ||
-	    tsk->mm != tsk->active_mm || !hlist_empty(&tsk->mm->ioctx_list)) {
+#ifdef CONFIG_AIO
+	    !hlist_empty(&tsk->mm->ioctx_list) ||
+#endif
+	    tsk->mm != tsk->active_mm) {
 		mmput(mm);
 		task_unlock(tsk);
 		return -EINVAL;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
