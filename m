Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44805 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgBNGqb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 14 Feb 2020 01:46:31 -0500
Date: Thu, 13 Feb 2020 23:46:28 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH] s390/kaslr: Fix casts in get_random
Message-ID: <20200214064628.GA14336@ubuntu-m2-xlarge-x86>
References: <20200208141052.48476-1-natechancellor@gmail.com>
 <ba371a74412c07c30eeb26fa25c94c25468599a9.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba371a74412c07c30eeb26fa25c94c25468599a9.camel@perches.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com

On Sat, Feb 08, 2020 at 12:17:20PM -0800, Joe Perches wrote:
> On Sat, 2020-02-08 at 07:10 -0700, Nathan Chancellor wrote:
> > Clang warns:
> > 
> > ../arch/s390/boot/kaslr.c:78:25: warning: passing 'char *' to parameter
> > of type 'const u8 *' (aka 'const unsigned char *') converts between
> > pointers to integer
> > types with different sign [-Wpointer-sign]
> >                                   (char *) entropy, (char *) entropy,
> >                                                     ^~~~~~~~~~~~~~~~
> > ../arch/s390/include/asm/cpacf.h:280:28: note: passing argument to
> > parameter 'src' here
> >                             u8 *dest, const u8 *src, long src_len)
> >                                                 ^
> > 2 warnings generated.
> > 
> > Fix the cast to match what else is done in this function.
> > 
> > Fixes: b2d24b97b2a9 ("s390/kernel: add support for kernel address space layout randomization (KASLR)")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/862
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  arch/s390/boot/kaslr.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/s390/boot/kaslr.c b/arch/s390/boot/kaslr.c
> > index 5d12352545c5..5591243d673e 100644
> > --- a/arch/s390/boot/kaslr.c
> > +++ b/arch/s390/boot/kaslr.c
> > @@ -75,7 +75,7 @@ static unsigned long get_random(unsigned long limit)
> >  		*(unsigned long *) prng.parm_block ^= seed;
> >  		for (i = 0; i < 16; i++) {
> >  			cpacf_kmc(CPACF_KMC_PRNG, prng.parm_block,
> > -				  (char *) entropy, (char *) entropy,
> > +				  (u8 *) entropy, (u8 *) entropy,
> 
> Why not change the function to take void *?
> 
> static inline int cpacf_kmc(unsigned long func, void *param,
> 			    u8 *dest, const u8 *src, long src_len)
> 
> vs:
> 
> static inline int cpacf_kmc(unsigned long func, void *param,
> 			    void *dest, const void *src, long src_len)
> 
> and remove the casts?

I can certainly do that if the maintainers prefer it.

Cheers,
Nathan
