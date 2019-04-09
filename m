Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Tue, 9 Apr 2019 15:43:16 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v3] ubsan: Avoid unnecessary 128-bit shifts
References: <201904050158.x351wr9f016512@sdf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201904050158.x351wr9f016512@sdf.org>
Message-Id: <20190409134316.GC4227@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: George Spelvin <lkml@sdf.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Apr 05, 2019 at 01:58:53AM +0000, George Spelvin wrote:
> If CONFIG_ARCH_SUPPORTS_INT128, s_max is 128 bits, and variable
> sign-extending shifts of such a double-word data type are a non-trivial
> amount of code and complexity.  Do a single-word sign-extension *before*
> the cast to (s_max), greatly simplifying the object code.
> 
> Rasmus Villemoes suggested using sign_extend* from <linux/bitops.h>.
> 
> On s390 (and perhaps some other arches), gcc implements variable
> 128-bit shifts using an __ashrti3 helper function which the kernel
> doesn't provide, causing a link error.  In that case, this patch is
> a prerequisite for enabling INT128 support.  Andrey Ryabinin has gven
> permission for any arch that needs it to cherry-pick it so they don't
> have to wait for ubsan to be merged into Linus' tree.

Still, this should go upstream via Andrew Morton.

As soon as this gets merged I'd like to select ARCH_SUPPORTS_INT128 on
s390 unconditionally.

However... ;)

> +static inline long sign_extend_long(unsigned long value, int index)
> +{
> +	if (sizeof(value) == 4)
> +		return sign_extend32(value);
> +	return sign_extend64(value);
> +}
> +

This doesn't compile:

In file included from ./include/linux/kernel.h:12,
                 from ./arch/s390/include/asm/bug.h:5,
                 from ./include/linux/bug.h:5,
                 from ./include/linux/page-flags.h:10,
                 from kernel/bounds.c:10:
./include/linux/bitops.h: In function 'sign_extend_long':
./include/linux/bitops.h:163:10: error: too few arguments to function 'sign_extend32'
   return sign_extend32(value);
          ^~~~~~~~~~~~~
./include/linux/bitops.h:143:21: note: declared here
 static inline __s32 sign_extend32(__u32 value, int index)
                     ^~~~~~~~~~~~~
./include/linux/bitops.h:164:9: error: too few arguments to function 'sign_extend64'
  return sign_extend64(value);
         ^~~~~~~~~~~~~
./include/linux/bitops.h:154:21: note: declared here
 static inline __s64 sign_extend64(__u64 value, int index)
                     ^~~~~~~~~~~~~
