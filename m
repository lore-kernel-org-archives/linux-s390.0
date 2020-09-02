Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60722 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgIBJ05 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 2 Sep 2020 05:26:57 -0400
Date: Wed, 2 Sep 2020 11:26:55 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v2 2/3] arm64: stacktrace: Make stack walk callback
 consistent with generic code
In-Reply-To: <20200819124913.37261-3-broonie@kernel.org>
Message-ID: <alpine.LSU.2.21.2009021126360.23200@pobox.suse.cz>
References: <20200819124913.37261-1-broonie@kernel.org> <20200819124913.37261-3-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 19 Aug 2020, Mark Brown wrote:

> As with the generic arch_stack_walk() code the arm64 stack walk code takes
> a callback that is called per stack frame. Currently the arm64 code always
> passes a struct stackframe to the callback and the generic code just passes
> the pc, however none of the users ever reference anything in the struct
> other than the pc value. The arm64 code also uses a return type of int
> while the generic code uses a return type of bool though in both cases the
> return value is a boolean value.
> 
> In order to reduce code duplication when arm64 is converted to use
> arch_stack_walk() change the signature of the arm64 specific callback to
> match that of the generic code.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
