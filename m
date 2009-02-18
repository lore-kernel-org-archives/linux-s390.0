From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [s390] next Feb 18: defconfig build break
Date: Thu, 19 Feb 2009 09:29:41 +1030
Message-ID: <200902190929.42044.rusty@rustcorp.com.au>
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
> breaks all Blackfin ports as well:
> In file included from include/linux/bitmap.h:9,
>                  from include/linux/nodemask.h:90,
>                  from include/linux/mmzone.h:17,
>                  from include/linux/gfp.h:5,
>                  from include/linux/kmod.h:23,
>                  from include/linux/module.h:14,
>                  from arch/blackfin/lib/strncmp.c:14:
> include/linux/string.h: In function 'strstarts':
> include/linux/string.h:124: error: implicit declaration of function 'strncmp'
> make[1]: *** [arch/blackfin/lib/strncmp.o] Error 1
> make: *** [arch/blackfin/lib] Error 2
> -mike

Hi Mike,

   I don't have a blackfin cross compiler, but I think this is the right
fix:

Subject: blackfin: allow usage of string functions in linux/string.h

In introducing a trivial "strstarts()" function in linux/string.h, we
hit the following error on blackfin:

file included from include/linux/bitmap.h:9,
                 from include/linux/nodemask.h:90,
                 from include/linux/mmzone.h:17,
                 from include/linux/gfp.h:5,
                 from include/linux/kmod.h:23,
                 from include/linux/module.h:14,
                 from arch/blackfin/lib/strncmp.c:14:
include/linux/string.h: In function 'strstarts':
include/linux/string.h:124: error: implicit declaration of function 'strncmp'

Because when including asm/string.h from arch/blackfin/lib/strncmp.c,
we don't declare the string op we are about to define, and
linux/string.h barfs.

The fix is to declare the function whose definition we steal via the
#define trick.  I do this for all of them, so this won't bite us in
future.

Reported-by: linux-next
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff --git a/arch/blackfin/lib/strcmp.c b/arch/blackfin/lib/strcmp.c
--- a/arch/blackfin/lib/strcmp.c
+++ b/arch/blackfin/lib/strcmp.c
@@ -6,6 +6,7 @@
  * Licensed under the GPL-2 or later.
  */
 
+int strcmp(const char *dest, const char *src);
 #define strcmp __inline_strcmp
 #include <asm/string.h>
 #undef strcmp
diff --git a/arch/blackfin/lib/strcpy.c b/arch/blackfin/lib/strcpy.c
--- a/arch/blackfin/lib/strcpy.c
+++ b/arch/blackfin/lib/strcpy.c
@@ -6,6 +6,7 @@
  * Licensed under the GPL-2 or later.
  */
 
+char *strcpy(char *dest, const char *src);
 #define strcpy __inline_strcpy
 #include <asm/string.h>
 #undef strcpy
diff --git a/arch/blackfin/lib/strncmp.c b/arch/blackfin/lib/strncmp.c
--- a/arch/blackfin/lib/strncmp.c
+++ b/arch/blackfin/lib/strncmp.c
@@ -6,6 +6,7 @@
  * Licensed under the GPL-2 or later.
  */
 
+int strncmp(const char *cs, const char *ct, size_t count);
 #define strncmp __inline_strncmp
 #include <asm/string.h>
 #undef strncmp
diff --git a/arch/blackfin/lib/strncpy.c b/arch/blackfin/lib/strncpy.c
--- a/arch/blackfin/lib/strncpy.c
+++ b/arch/blackfin/lib/strncpy.c
@@ -6,6 +6,7 @@
  * Licensed under the GPL-2 or later.
  */
 
+char *strncpy(char *dest, const char *src, size_t n);
 #define strncpy __inline_strncpy
 #include <asm/string.h>
 #undef strncpy
