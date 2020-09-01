Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:44880 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731549AbgIAQGc (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 1 Sep 2020 12:06:32 -0400
Date: Tue, 1 Sep 2020 17:06:26 +0100
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 0/3] arm64: Convert to ARCH_STACKWALK
Message-ID: <20200901160626.GE95447@C02TD0UTHF1T.local>
References: <20200819124913.37261-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200819124913.37261-1-broonie@kernel.org>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>

Hi,

On Wed, Aug 19, 2020 at 01:49:10PM +0100, Mark Brown wrote:
> This series updates the arm64 stacktrace code to use the newer and much
> simpler arch_stack_walk() interface, the main benefit being a single
> entry point to the arch code with no need for the arch code to worry
> about skipping frames. Along the way I noticed that the reliable
> parameter to the arch_stack_walk() callback appears to be redundant
> so there's also a patch here removing that from the existing code to
> simplify the interface.
> 
> This is preparatory work for implementing reliable stack trace for
> arm64.

This all looks pretty nice!

Just to check, has the skipping logic been tested to work equivalently
to what we had before? By inspection I think it should, but since it
relies on function call boundaries it always strikes me as fragile.

If you could confirm that (e.g. with LKDTM perhaps?) that'd be great.
Assuming that looks right, for the series:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> 
> v2: Rebase onto v5.9-rc1.
> 
> Mark Brown (3):
>   stacktrace: Remove reliable argument from arch_stack_walk() callback
>   arm64: stacktrace: Make stack walk callback consistent with generic
>     code
>   arm64: stacktrace: Convert to ARCH_STACKWALK
> 
>  arch/arm64/Kconfig                  |  1 +
>  arch/arm64/include/asm/stacktrace.h |  2 +-
>  arch/arm64/kernel/perf_callchain.c  |  6 +--
>  arch/arm64/kernel/return_address.c  |  8 +--
>  arch/arm64/kernel/stacktrace.c      | 84 ++++-------------------------
>  arch/s390/kernel/stacktrace.c       |  4 +-
>  arch/x86/kernel/stacktrace.c        | 10 ++--
>  include/linux/stacktrace.h          |  5 +-
>  kernel/stacktrace.c                 |  8 ++-
>  9 files changed, 30 insertions(+), 98 deletions(-)
> 
> -- 
> 2.20.1
> 
