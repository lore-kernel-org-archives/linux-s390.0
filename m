Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A025C42FCCF;
	Wed, 15 Jul 2026 19:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784142798; cv=none; b=ocMqU8xyGBVpB6RY2VrsNjShRZbiTN9guuS2jhttOf0n1t8odWRI6InJA3LOZ4wMOW94KV7DVEt+D+gOzfpJYeYkqQeevYZl+WSsj4WmsEoO1kVDHUmwzYm90GUSsbHVXfL3p0ohF5XaHVvjCn1EYhIOuQNKHPvFjOGIAKWwye8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784142798; c=relaxed/simple;
	bh=+e6WArOpGfBJmkNVtC1sEC4jNnxBzfLBaz71ANfRWX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=McAPqL2A/5nlGEPAYi1g7jYFMV1a/u3JP4v9CRBHAyBmq1ydmwJEkzOq0NswgIVCimnOKDU1f+QOhofotYPhLdzGrkGhePVZiChalzlIDFSQ3B8ntrbLsEBMR+xMOG5QddwkYOXg7+BsYGeaInzhE1/ONGQWUfT/ohVkKA/YSKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThkLp/3D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThkLp/3D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4925E1F00A3A;
	Wed, 15 Jul 2026 19:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784142776;
	bh=9oVCCdJZ6i0nGcuAu+X52AzRGPPFJc6TOHwzZS5ksvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ThkLp/3DbgYhs8eYeG60ITWsTanEfafHo4P1Dis5gx0XzPaUQWEsAbGIH6EDFvhR7
	 grngim+iQWZ9dA2fKdCAVHOz3HgAbhsBhk3FUeAKNF2EZszlUHcaJB5iyzZOpPHmCt
	 EM1HN13QrPkmdzcrubqrVzA5pcIma3IRaejhabRFP2r+ZLwRgS1efXtDaRW9RBOiru
	 lsLeoFn1sQP60GH72OpM33N+Yid61Z+hs9WQRVFdiMXqlEv7/tD2qxgvj17YS48kGN
	 jczXQJMF51moHrReRTbJQo0WxP5640NY0BqghhhmXOh0M1dKvOYR1b0f/YsuJ+ehtE
	 7Q4cFug10BGjA==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5E4A0F40068;
	Wed, 15 Jul 2026 15:12:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 15 Jul 2026 15:12:55 -0400
X-ME-Sender: <xms:t9tXai3LM5gP4pb83_8lwyGYjL8IxVLq3WnbEDrZ-vFeC6d08nxqxw>
    <xme:t9tXavz1wIh1_YEXExlr9yorUaDDeunVqrlPowmCryLHu4sipndSpEqJlrijTrS7M
    dE1qfH4rKjEoQCrKkg1E9eKydMiyYUF1cY_TQnHgq7HjkvSQUhDEQ>
X-ME-Received: <xmr:t9tXajnu-pDrundjT5KEYWuEGkA1Xn5jBr0Ieerz88EnoQNTnVqoKaeQnz26SLJlBmFNqcuCWV9EuecScL2e-ed7mD5JW5F9>
X-ME-Proxy-Cause: dmFkZTFravVrf3m1MWAOqu03Ewy0VcAX7ERyeMWoyOAJjzaLpK1CFtXM1o/PM+kYHNzt+v
    vXewgjU7nnGz+GB+//KkYeTgtn3zL8y5gaT5XMhmOldD2IStpkEHfXLfoSCYJ5gKoDMJtZ
    KTE2O0bgoAmCbrvWb96MCVZjml/MZFehGkTy6vMxRAzvgCXWz8W+pPQf2vNplzPYmlKDc6
    xy/LN3YuDOAcJjJWDhdla2Onqx55C6dgFJqjBuhfmgvpEBihLQf5XtA+gU2Pw2YvaARRPo
    aYDDJgcOmNA3x2PkLZceYJH7GslTjvvxpI4gNfu2bhk4Ew2u+cqUNTX+veexZ2gFx6WIkZ
    g+7P8n6OsMNsXJXghrZMkd4leU28/Jj2zM7eXOG6vrTskwzUtoCq7wpBBvyKwWDuGIyeSm
    ynEx4Oo6A9c6OcYZAq1dvBSp8Upw3YLC9f9jmBibRU1vx3U5CuXTlHbs3D3tClkzfGIEQB
    Fkn6EgjPhNU/tNjcjJaBXCkDo69gvxGj9qUmdgL0E+yUTBpf1SVcir3XyDnAWvnVtIKCqe
    rfmWBbFJRHv9QHKn+f/iVy251FNxMJV8j9N4zbwJ8mLApwsWfgrM5UFWIf8P0WqvS6xgVT
    Fnp0RucLfWas7dkzslbbVNJ/t3+Ci/97WamE1be3e42QMkqqwOW+0IfifaIg
X-ME-Proxy: <xmx:t9tXaq9GYPEmFEHwapYNE7ex01_yST_bkfvgTvMeF6h64fv9S9ZyXg>
    <xmx:t9tXamoRGHr0d3gZIbsy3Qvv70-joycrW1qT2cRdC-s5vOUBufH_Hw>
    <xmx:t9tXamJCfljY_2EO1CoIpkGpd1WX6mzG8EzaF7xTSYWvx76xNqogVg>
    <xmx:t9tXao0oZG6x2T5IoPH1yL-9Bl8jbZXOEkliAVsbib5BBUhc7KeBqQ>
    <xmx:t9tXatWkz7GQif861JbELg6lfoEW-9OdTFwGQyPqFPfVUJz3xcTq9yrf>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 15:12:54 -0400 (EDT)
Date: Wed, 15 Jul 2026 12:12:53 -0700
From: Boqun Feng <boqun@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Lyude Paul <lyude@redhat.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Gary Guo <gary@garyguo.net>, Ilya Leoshkevich <iii@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [boqun:rust-rcu 14/27] rust/helpers/interrupt.c:17:9: warning:
 static function 'arch_local_save_flags' is used in an inline function with
 external linkage
Message-ID: <alfbtUKkXANyGyYf@tardis.local>
References: <202607131219.euJHPSJ5-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202607131219.euJHPSJ5-lkp@intel.com>

[Cc s390]

On Mon, Jul 13, 2026 at 12:45:07PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git rust-rcu
> head:   dcecd5f6e71e2437c8abe333ee2426fbe63e6398
> commit: 27e30521043c39ca18ea3e28f825f9c7bd30b580 [14/27] rust: Introduce interrupt module
> config: s390-randconfig-002-20260713 (https://download.01.org/0day-ci/archive/20260713/202607131219.euJHPSJ5-lkp@intel.com/config)
> compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
> rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260713/202607131219.euJHPSJ5-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202607131219.euJHPSJ5-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from rust/helpers/helpers.c:68:
> >> rust/helpers/interrupt.c:17:9: warning: static function 'arch_local_save_flags' is used in an inline function with external linkage [-Wstatic-in-inline]
>       17 |         return irqs_disabled();
>          |                ^
>    include/linux/irqflags.h:256:3: note: expanded from macro 'irqs_disabled'
>      256 |                 raw_local_save_flags(_flags);           \
>          |                 ^
>    include/linux/irqflags.h:184:11: note: expanded from macro 'raw_local_save_flags'
>      184 |                 flags = arch_local_save_flags();        \
>          |                         ^
>    rust/helpers/interrupt.c:15:1: note: use 'static' to give inline function 'rust_helper_irqs_disabled' internal linkage
>       15 | __rust_helper bool rust_helper_irqs_disabled(void)
>          | ^
>          | static 
>    rust/helpers/helpers.c:38:23: note: expanded from macro '__rust_helper'
>       38 | #define __rust_helper __always_inline
>          |                       ^
>    include/linux/compiler_attributes.h:55:41: note: expanded from macro '__always_inline'
>       55 | #define __always_inline                 inline __attribute__((__always_inline__))
>          |                                         ^
>    include/linux/compiler_types.h:235:16: note: expanded from macro 'inline'
>      235 | #define inline inline __gnu_inline __inline_maybe_unused notrace
>          |                ^
>    arch/s390/include/asm/irqflags.h:46:48: note: 'arch_local_save_flags' declared here
>       46 | static arch_local_irq_attributes unsigned long arch_local_save_flags(void)
>          |                                                ^
>    1 warning generated.
> --
>    In file included from rust/helpers/helpers.c:68:
> >> rust/helpers/interrupt.c:17:9: warning: static function 'arch_local_save_flags' is used in an inline function with external linkage [-Wstatic-in-inline]
>    17 |         return irqs_disabled();
>    |                ^
>    include/linux/irqflags.h:256:3: note: expanded from macro 'irqs_disabled'
>    256 |                 raw_local_save_flags(_flags);           \
>    |                 ^
>    include/linux/irqflags.h:184:11: note: expanded from macro 'raw_local_save_flags'
>    184 |                 flags = arch_local_save_flags();        \
>    |                         ^
>    rust/helpers/interrupt.c:15:1: note: use 'static' to give inline function 'rust_helper_irqs_disabled' internal linkage
>    15 | __rust_helper bool rust_helper_irqs_disabled(void)
>    | ^
>    | static
>    rust/helpers/helpers.c:38:23: note: expanded from macro '__rust_helper'
>    38 | #define __rust_helper __always_inline
>    |                       ^
>    include/linux/compiler_attributes.h:55:41: note: expanded from macro '__always_inline'
>    55 | #define __always_inline                 inline __attribute__((__always_inline__))
>    |                                         ^
>    include/linux/compiler_types.h:235:16: note: expanded from macro 'inline'
>    235 | #define inline inline __gnu_inline __inline_maybe_unused notrace
>    |                ^
>    arch/s390/include/asm/irqflags.h:46:48: note: 'arch_local_save_flags' declared here
>    46 | static arch_local_irq_attributes unsigned long arch_local_save_flags(void)
>    |                                                ^
>    1 warning generated.
>    warning: 1 warning emitted
> 

This seems not a Rust-only issue to me, basically you got the warning
whenever you have an inline function calling irqs_disabled(). I'm a bit
curious why 1b301f5f28ba ("s390/irqflags: do not instrument
arch_local_irq_*() with KMSAN") wanted to add noinline when KMSAN=y, all
you need is noinstr, no?

Regards,
Boqun

> 
> vim +/arch_local_save_flags +17 rust/helpers/interrupt.c
> 
>     14	
>     15	__rust_helper bool rust_helper_irqs_disabled(void)
>     16	{
>   > 17		return irqs_disabled();
> 
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
