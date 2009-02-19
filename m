From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [s390] next Feb 18: defconfig build break
Date: Thu, 19 Feb 2009 12:14:52 -0500
Message-ID: <8bd0f97a0902190914q65a2af6ag537269b563a4607d@mail.gmail.com>
References: <20090218191640.0b023029.sfr@canb.auug.org.au>
	 <200902190929.42044.rusty@rustcorp.com.au>
	 <8bd0f97a0902181755y5a5f6760s6e266c87906e6dca@mail.gmail.com>
	 <200902192210.10368.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <200902192210.10368.rusty@rustcorp.com.au>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, "Sachin P. Sant" <sachinp@in.ibm.com>, linux-s390@vger.kernel.org, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, Feb 19, 2009 at 06:40, Rusty Russell wrote:
> On Thursday 19 February 2009 12:25:13 Mike Frysinger wrote:
>> > +char *strncpy(char *dest, const char *src, size_t n);
>> >  #define strncpy __inline_strncpy
>> >  #include <asm/string.h>
>> >  #undef strncpy
>>
>> size_t is not a builtin type so there needs to be a linux/types.h
>> include right above these two prototypes.  then things build up fine
>> for me.
>
> OK, this time for sure!
>
>
> blackfin: allow usage of string functions in linux/string.h
>
> In introducing a trivial "strstarts()" function in linux/string.h, we
> hit the following error on blackfin:
>
> file included from include/linux/bitmap.h:9,
>                 from include/linux/nodemask.h:90,
>                 from include/linux/mmzone.h:17,
>                 from include/linux/gfp.h:5,
>                 from include/linux/kmod.h:23,
>                 from include/linux/module.h:14,
>                 from arch/blackfin/lib/strncmp.c:14:
> include/linux/string.h: In function 'strstarts':
> include/linux/string.h:124: error: implicit declaration of function 'strncmp'
>
> Because when including asm/string.h from arch/blackfin/lib/strncmp.c,
> we don't declare the string op we are about to define, and
> linux/string.h barfs.
>
> The fix is to declare the function whose definition we steal via the
> #define trick.  I do this for all of them, so this won't bite us in
> future.
>
> Reported-by: linux-next
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Tested-by: Mike Frysinger <vapier@gentoo.org>
-mike
