Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34788 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbgIBJcP (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 2 Sep 2020 05:32:15 -0400
Date: Wed, 2 Sep 2020 11:32:13 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v2 3/3] arm64: stacktrace: Convert to ARCH_STACKWALK
In-Reply-To: <20200819124913.37261-4-broonie@kernel.org>
Message-ID: <alpine.LSU.2.21.2009021128500.23200@pobox.suse.cz>
References: <20200819124913.37261-1-broonie@kernel.org> <20200819124913.37261-4-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

it could be a silly question, but better to ask...

> +	if (regs)
> +		start_backtrace(&frame, regs->regs[29], regs->pc);
> +	else
> +		start_backtrace(&frame, thread_saved_fp(task),
> +				thread_saved_pc(task));

Would this also work for task == current? Given that the original code had

> -		start_backtrace(&frame,
> -				(unsigned long)__builtin_frame_address(0),
> -				(unsigned long)__save_stack_trace);

for the case, which seems correct (but I don't know much about arm64 arch 
in the kernel).

Otherwise, I did not spot anything suspicious or wrong.

Regards
Miroslav
