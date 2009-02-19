From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [s390] next Feb 18: defconfig build break
Date: Thu, 19 Feb 2009 09:51:50 +0000
Message-ID: <20090219095150.GA5808@flint.arm.linux.org.uk>
References: <20090218191640.0b023029.sfr@canb.auug.org.au> <20090218224541.fe6e0355.sfr@canb.auug.org.au> <8bd0f97a0902180910wafd35ceo47aeb9f3cc6733f3@mail.gmail.com> <200902191045.25878.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200902191045.25878.rusty@rustcorp.com.au>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Mike Frysinger <vapier.adi@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, "Sachin P. Sant" <sachinp@in.ibm.com>, linux-s390@vger.kernel.org, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, Feb 19, 2009 at 10:45:25AM +1030, Rusty Russell wrote:
> Subject: arm: allow usage of string functions in linux/string.h
> 
> In introducing a trivial "strstarts()" function in linux/string.h, we
> hit:
> 
> 	arch/arm/boot/compressed/misc.o: In function `strstarts':
> 	misc.c:(.text+0x368): undefined reference to `strlen'
> 	misc.c:(.text+0x378): undefined reference to `strncmp'
> 
> This is because of "CFLAGS_misc.o := -Dstatic=" in the Makefile.
> "static inline strstarts(...)" becomes non-inline, and refers to the
> other string ops.
> 
> The simplest workaround is to include asm/string.h.  This makes sense
> anyway, since lib/string.c won't be linked against this so we can't
> use those functions anyway.
> 
> Compile tested here.
> 
> Reported-by: linux-next
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

I guess this should go in with the change which caused the breakage.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
