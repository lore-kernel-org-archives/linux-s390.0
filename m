From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [s390] next Feb 18: defconfig build break
Date: Thu, 19 Feb 2009 09:13:26 +1030
Message-ID: <200902190913.27653.rusty@rustcorp.com.au>
References: <20090218191640.0b023029.sfr@canb.auug.org.au> <20090218224541.fe6e0355.sfr@canb.auug.org.au> <8bd0f97a0902180910wafd35ceo47aeb9f3cc6733f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <8bd0f97a0902180910wafd35ceo47aeb9f3cc6733f3@mail.gmail.com>
Content-Disposition: inline
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, "Sachin P. Sant" <sachinp@in.ibm.com>, linux-s390@vger.kernel.org, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Thursday 19 February 2009 03:40:59 Mike Frysinger wrote:
> On Wed, Feb 18, 2009 at 06:45, Stephen Rothwell wrote:
> > That would be a side effect of commit 43a47c6ca0e0b5479ae316e188a28b7e625d41e5 ("misc:strstarts") from the rr tree.  Rusty cc'd.
> 
> breaks all Blackfin ports as well:

My first reaction was WTF?  My second was, how did our string code become
such a catastrophe?

Sorry, I had no idea what a mess I was wading into.

Here's the s390 fix:

Subject: s390: allow usage of string functions in linux/string.h

In introducing a trivial "strstarts()" function in linux/string.h, we
hit the following error on s390:

In file included from include/linux/bitmap.h:8,
                 from include/linux/cpumask.h:142,
                 from include/linux/smp.h:12,
                 from /home/rusty/devel/kernel/patches/linux-2.6/arch/s390/include/asm/spinlock.h:14,
                 from include/linux/spinlock.h:88,
                 from include/linux/seqlock.h:29,
                 from include/linux/time.h:8,
                 from include/linux/stat.h:60,
                 from include/linux/module.h:10,
                 from arch/s390/lib/string.c:13:
include/linux/string.h: In function 'strstarts':
include/linux/string.h:124: error: implicit declaration of function 'strlen'
include/linux/string.h:124: warning: incompatible implicit declaration of built-in function 'strlen'

Because when including asm/string.h from arch/s390/lib/string.c we
don't declare the string ops we are about to define, and
linux/string.h barfs.

The fix is to declare them in this IN_ARCH_STRING_C case, but in
general I wonder if there's a neater fix.

Reported-by: linux-next
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff --git a/arch/s390/include/asm/string.h b/arch/s390/include/asm/string.h
--- a/arch/s390/include/asm/string.h
+++ b/arch/s390/include/asm/string.h
@@ -135,7 +135,13 @@ static inline size_t strnlen(const char 
 		: "+a" (end), "+a" (tmp) : "d" (r0)  : "cc");
 	return end - s;
 }
-
+#else /* IN_ARCH_STRING_C */
+void *memchr(const void * s, int c, size_t n);
+void *memscan(void *s, int c, size_t n);
+char *strcat(char *dst, const char *src);
+char *strcpy(char *dst, const char *src);
+size_t strlen(const char *s);
+size_t strnlen(const char * s, size_t n);
 #endif /* !IN_ARCH_STRING_C */
 
 #endif /* __KERNEL__ */
