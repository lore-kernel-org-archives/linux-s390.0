Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12862 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729595AbgBQRNy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 Feb 2020 12:13:54 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01HH8uEr035467
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 12:13:53 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y6adr2fk4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 12:13:53 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <gor@linux.ibm.com>;
        Mon, 17 Feb 2020 17:13:51 -0000
Date: Mon, 17 Feb 2020 18:13:44 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH] s390/kaslr: Fix casts in get_random
References: <20200208141052.48476-1-natechancellor@gmail.com>
 <ba371a74412c07c30eeb26fa25c94c25468599a9.camel@perches.com>
 <20200214064628.GA14336@ubuntu-m2-xlarge-x86>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200214064628.GA14336@ubuntu-m2-xlarge-x86>
Message-Id: <your-ad-here.call-01581959624-ext-8482@work.hours>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Joe Perches <joe@perches.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com

On Thu, Feb 13, 2020 at 11:46:28PM -0700, Nathan Chancellor wrote:
> On Sat, Feb 08, 2020 at 12:17:20PM -0800, Joe Perches wrote:
> > On Sat, 2020-02-08 at 07:10 -0700, Nathan Chancellor wrote:
> > > Clang warns:
> > > 
> > > ../arch/s390/boot/kaslr.c:78:25: warning: passing 'char *' to parameter
> > > of type 'const u8 *' (aka 'const unsigned char *') converts between
> > > pointers to integer
> > > types with different sign [-Wpointer-sign]
> > >                                   (char *) entropy, (char *) entropy,
> > >                                                     ^~~~~~~~~~~~~~~~
> > > ../arch/s390/include/asm/cpacf.h:280:28: note: passing argument to
> > > parameter 'src' here
> > >                             u8 *dest, const u8 *src, long src_len)
> > >                                                 ^
> > > 2 warnings generated.
> > > 
> > > Fix the cast to match what else is done in this function.
> > > 
> > > Fixes: b2d24b97b2a9 ("s390/kernel: add support for kernel address space layout randomization (KASLR)")
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/862
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > ---
> > >  arch/s390/boot/kaslr.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/s390/boot/kaslr.c b/arch/s390/boot/kaslr.c
> > > index 5d12352545c5..5591243d673e 100644
> > > --- a/arch/s390/boot/kaslr.c
> > > +++ b/arch/s390/boot/kaslr.c
> > > @@ -75,7 +75,7 @@ static unsigned long get_random(unsigned long limit)
> > >  		*(unsigned long *) prng.parm_block ^= seed;
> > >  		for (i = 0; i < 16; i++) {
> > >  			cpacf_kmc(CPACF_KMC_PRNG, prng.parm_block,
> > > -				  (char *) entropy, (char *) entropy,
> > > +				  (u8 *) entropy, (u8 *) entropy,
> > 
> > Why not change the function to take void *?
> > 
> > static inline int cpacf_kmc(unsigned long func, void *param,
> > 			    u8 *dest, const u8 *src, long src_len)
> > 
> > vs:
> > 
> > static inline int cpacf_kmc(unsigned long func, void *param,
> > 			    void *dest, const void *src, long src_len)
> > 
> > and remove the casts?
> 
> I can certainly do that if the maintainers prefer it.
> 
> Cheers,
> Nathan
KBUILD_CFLAGS contains -Wno-pointer-sign but special arch/s390/boot code
has a separate set of build flags. Anyhow the change makes sense as it is.
Applied to fixes, thanks
