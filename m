Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbgIRQRa (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 18 Sep 2020 12:17:30 -0400
From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 0/3] arm64: Convert to ARCH_STACKWALK
Date: Fri, 18 Sep 2020 17:17:14 +0100
Message-Id: <160043545717.3786361.8451395410243102783.b4-ty@kernel.org>
In-Reply-To: <20200914153409.25097-1-broonie@kernel.org>
References: <20200914153409.25097-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Mark Brown <broonie@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>
Cc: kernel-team@android.com, Will Deacon <will@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>, Thomas Gleixner <tglx@linutronix.de>, Jiri Slaby <jirislaby@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@kernel.org>

On Mon, 14 Sep 2020 16:34:06 +0100, Mark Brown wrote:
> This series updates the arm64 stacktrace code to use the newer and much
> simpler arch_stack_walk() interface, the main benefit being a single
> entry point to the arch code with no need for the arch code to worry
> about skipping frames. Along the way I noticed that the reliable
> parameter to the arch_stack_walk() callback appears to be redundant
> so there's also a patch here removing that from the existing code to
> simplify the interface.
> 
> [...]

Applied to arm64 (for-next/stacktrace), thanks!

[1/3] stacktrace: Remove reliable argument from arch_stack_walk() callback
      https://git.kernel.org/arm64/c/264c03a245de
[2/3] arm64: stacktrace: Make stack walk callback consistent with generic code
      https://git.kernel.org/arm64/c/baa2cd417053
[3/3] arm64: stacktrace: Convert to ARCH_STACKWALK
      https://git.kernel.org/arm64/c/5fc57df2f6fd

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
