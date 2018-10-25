Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Thu, 25 Oct 2018 16:05:43 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH] s390/fault: use wake_up_klogd() in bust_spinlocks()
Message-ID: <20181025070543.GB20702@jagdpanzerIV>
References: <20181024043048.21248-1-sergey.senozhatsky@gmail.com>
 <20181024043425.GA8862@jagdpanzerIV>
 <20181025062800.GB4037@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025062800.GB4037@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Peter Oberparleiter <oberpar@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On (10/25/18 08:28), Heiko Carstens wrote:
> 
> With your patch this looks nearly like the common code variant. I did
> some code archaeology and this function is unchanged since ~17 years.
> When it was introduced it was close to identical to the x86 variant.
> All other architectures use the common code variant in the
> meantime. So if we change this I'd prefer that we switch s390 to the
> common code variant as well.
> 
> Right now I can't see a reason for not doing that, but I might be
> wrong of course. So, could you please provide a new version which just
> removes this variant and makes s390 use the generic one too.
> 
> We'll see if there is any fallout...

Heiko, if this one works for you then I'll submit a format patch.
Let me know. Thanks.

====

From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH] arch/s390: use common bust_spinlocks()

s390 is the only architecture that is using own bust_spinlocks()
variant, while other arch-s seem to be OK with the common
implementation.

Heiko Carstens [1] said he would prefer s390 to use the common
bust_spinlocks() as well:
  I did some code archaeology and this function is unchanged since ~17
  years. When it was introduced it was close to identical to the x86
  variant. All other architectures use the common code variant in the
  meantime. So if we change this I'd prefer that we switch s390 to the
  common code variant as well. Right now I can't see a reason for not
  doing that

This patch removes s390 bust_spinlocks() and drops the weak attribute
from the common bust_spinlocks() version.

[1] lkml.kernel.org/r/20181025062800.GB4037@osiris
Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 arch/s390/mm/fault.c | 24 ------------------------
 lib/bust_spinlocks.c |  6 +++---
 2 files changed, 3 insertions(+), 27 deletions(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 2b8f32f56e0c..11613362c4e7 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -81,30 +81,6 @@ static inline int notify_page_fault(struct pt_regs *regs)
 	return ret;
 }
 
-
-/*
- * Unlock any spinlocks which will prevent us from getting the
- * message out.
- */
-void bust_spinlocks(int yes)
-{
-	if (yes) {
-		oops_in_progress = 1;
-	} else {
-		int loglevel_save = console_loglevel;
-		console_unblank();
-		oops_in_progress = 0;
-		/*
-		 * OK, the message is on the console.  Now we call printk()
-		 * without oops_in_progress set so that printk will give klogd
-		 * a poke.  Hold onto your hats...
-		 */
-		console_loglevel = 15;
-		printk(" ");
-		console_loglevel = loglevel_save;
-	}
-}
-
 /*
  * Find out which address space caused the exception.
  * Access register mode is impossible, ignore space == 3.
diff --git a/lib/bust_spinlocks.c b/lib/bust_spinlocks.c
index ab719495e2cb..8be59f84eaea 100644
--- a/lib/bust_spinlocks.c
+++ b/lib/bust_spinlocks.c
@@ -2,7 +2,8 @@
 /*
  * lib/bust_spinlocks.c
  *
- * Provides a minimal bust_spinlocks for architectures which don't have one of their own.
+ * Provides a minimal bust_spinlocks for architectures which don't
+ * have one of their own.
  *
  * bust_spinlocks() clears any spinlocks which would prevent oops, die(), BUG()
  * and panic() information from reaching the user.
@@ -16,8 +17,7 @@
 #include <linux/vt_kern.h>
 #include <linux/console.h>
 
-
-void __attribute__((weak)) bust_spinlocks(int yes)
+void bust_spinlocks(int yes)
 {
 	if (yes) {
 		++oops_in_progress;
-- 
2.19.1
