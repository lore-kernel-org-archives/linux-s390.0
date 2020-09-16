Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44522 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbgIPQyM (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 16 Sep 2020 12:54:12 -0400
Date: Wed, 16 Sep 2020 15:13:42 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v3 0/3] arm64: Convert to ARCH_STACKWALK
In-Reply-To: <20200914153409.25097-1-broonie@kernel.org>
Message-ID: <alpine.LSU.2.21.2009161512540.16902@pobox.suse.cz>
References: <20200914153409.25097-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, "H . Peter Anvin" <hpa@zytor.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 14 Sep 2020, Mark Brown wrote:

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
> 
> v3:
>  - Rebase onto v5.9-rc3.
>  - Fix handling of task == current.
>  - Flip the sense of the walk_stackframe() callback.
> v2:
>  - Rebase onto v5.9-rc1.
> 
> Mark Brown (3):
>   stacktrace: Remove reliable argument from arch_stack_walk() callback
>   arm64: stacktrace: Make stack walk callback consistent with generic
>     code
>   arm64: stacktrace: Convert to ARCH_STACKWALK

The patches look good to me.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
