Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60546 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgIBJ0e (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 2 Sep 2020 05:26:34 -0400
Date: Wed, 2 Sep 2020 11:26:30 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v2 1/3] stacktrace: Remove reliable argument from
 arch_stack_walk() callback
In-Reply-To: <20200819124913.37261-2-broonie@kernel.org>
Message-ID: <alpine.LSU.2.21.2009021126070.23200@pobox.suse.cz>
References: <20200819124913.37261-1-broonie@kernel.org> <20200819124913.37261-2-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 19 Aug 2020, Mark Brown wrote:

> Currently the callback passed to arch_stack_walk() has an argument called
> reliable passed to it to indicate if the stack entry is reliable, a comment
> says that this is used by some printk() consumers. However in the current
> kernel none of the arch_stack_walk() implementations ever set this flag to
> true and the only callback implementation we have is in the generic
> stacktrace code which ignores the flag. It therefore appears that this
> flag is redundant so we can simplify and clarify things by removing it.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
